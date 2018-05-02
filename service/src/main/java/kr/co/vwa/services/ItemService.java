package kr.co.vwa.services;

import kr.co.vwa.common.enums.VWACode;
import kr.co.vwa.common.util.JsonUtils;
import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.*;
import kr.co.vwa.repository.FileRepository;
import kr.co.vwa.repository.HierarchyRepository;
import kr.co.vwa.repository.ItemRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by DaDa on 2018-01-18.
 * <pre>
 * kr.co.vwa.services
 *
 * 매물관리 Service.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-18 오후 1:25
 */
@Service
@Slf4j
public class ItemService implements IItemService {

    @Autowired
    private ICarService iCarService;

    @Autowired
    private ItemRepository itemRepository;

    @Autowired
    private HierarchyRepository hierarchyRepository;

    @Autowired
    private FileRepository fileRepository;

    @Value("${s3.url}")
    private String fileUrlPath;

    /**
     * 차량 기본정보 저장
     * @param carInfoVo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED)
    public String insertCarDefaultInfo(CarInfoVo carInfoVo) {

        String rtnStr = itemRepository.insertCarDefaultInfo(carInfoVo) > 0 ? "SUCC" : "FAIL";

        return rtnStr;
    }

    /**
     * 차량 기본정보 수정
     * @param carInfoVo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED)
    public String updateCarDefaultInfo(CarInfoVo carInfoVo) {

        String rtnStr = itemRepository.updateCarDefaultInfo(carInfoVo) > 0 ? "SUCC" : "FAIL";

        return rtnStr;
    }

    /**
     * 차량 기본 정보 조회
     * @param sellCarSeq
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectDefaultCarInfo(Long sellCarSeq) {

        SellCarModelVo sellCarModelVo = itemRepository.selectCarDefaultInfo(sellCarSeq);

        if(sellCarModelVo == null) {
            throw new RuntimeException(String.format("조회된 차량 기본 정보가 존재하지 않습니다. [sellCarSeq : \"%d\"]", sellCarSeq));
        }

        Map<String, Object> resultMap = new HashMap<>();

        //  차량 기본 정보
        resultMap.put("sellCarModelVo", sellCarModelVo);

        if("폭스바겐".equals(sellCarModelVo.getMak())) {
            resultMap.put("vwa", "Y");
            resultMap.put("models", iCarService.selectCarModelList());

            CarMngVo carMngVo = new CarMngVo();
            carMngVo.setMak(sellCarModelVo.getMak());
            carMngVo.setModel(sellCarModelVo.getModel());
            carMngVo.setDetailModel(sellCarModelVo.getDetailModel());
            carMngVo.setRating(sellCarModelVo.getRating());

            // 폭스바겐 모델별 세부모델 조회
            resultMap.put("detailModels", iCarService.selectCarDetailModelList(carMngVo));

            // 폭스바겐 세부모델별 등급 조회
            resultMap.put("ratings", iCarService.selectCarRatingList(carMngVo));

            // 폭스바겐 등급별 세부등급 조회
            resultMap.put("detailRatings", iCarService.selectCarDetailRatingList(carMngVo));

        } else {
            resultMap.put("vwa", "N");
        }

        return resultMap;
    }

    /**
     * 해당 매장의 권한 조회
     * @param sellCarSeq
     * @return
     */
    @Override
    public String selectUserExhHallAuth(Long sellCarSeq) {
        String rtnStr = "VW";
        if (!SessionUtils.hasRole("ROLE_VW")) {
            rtnStr = itemRepository.selectUserExhHallAuth(sellCarSeq, SessionUtils.getUser().getAdmSeq());
        }
        return rtnStr;
    }

    /**
     * TAB 임시저장 완료 여부
     * @param sellCarSeq
     * @return
     */
    private Map<String, String> selectTabSaveYn(Long sellCarSeq) {
        Map<String, String> resultMap = new HashMap<>();

        String result = itemRepository.selectTabSaveYn(sellCarSeq);

        if (StringUtils.isNotBlank(result)) {
            String[] resultArr = result.split("\\|");

            resultMap.put("price", resultArr[0]);
            resultMap.put("option", resultArr[1]);
            resultMap.put("perform", resultArr[2]);
            resultMap.put("disc", resultArr[3]);
            resultMap.put("photo", resultArr[4]);
        }

        return resultMap;
    }

    /**
     * 가격/사고이력 조회
     * @param sellCarSeq
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectPriceTroubleHistory(Long sellCarSeq) {

        SellCarModelVo sellCarModelVo = itemRepository.selectCarDefaultInfo(sellCarSeq);

        if(sellCarModelVo == null) {
            throw new RuntimeException(String.format("조회된 차량 기본 정보가 존재하지 않습니다. [sellCarSeq : \"%d\"]", sellCarSeq));
        }

        Map<String, Object> resultMap = new HashMap<>();

        PriceTroubleHistoryVo priceTroubleHistoryVo = itemRepository.selectPriceHistory(sellCarSeq);

        // 최종 임시저장 여부
        resultMap.put("tempSaveYn", itemRepository.selectTempSaveYn(sellCarSeq));

        // 탭별 임시저장 완료 여부
        resultMap.put("saveYn", selectTabSaveYn(sellCarSeq));

        // 차량기본정보 조회
        resultMap.put("carInfo", sellCarModelVo);
        // 가격/사고이력 조회
        resultMap.put("info", priceTroubleHistoryVo);

        // 88가지 품질 점검 정비내역서 조회
        resultMap.put("quality1", itemRepository.selectQualityChkList(sellCarSeq, "J1100"));    // 기본점검
        resultMap.put("quality2", itemRepository.selectQualityChkList(sellCarSeq, "J1200"));    // 실내운전석에서 점검
        resultMap.put("quality3", itemRepository.selectQualityChkList(sellCarSeq, "J1300"));    // 진단기 점검
        resultMap.put("quality4", itemRepository.selectQualityChkList(sellCarSeq, "J1400"));    // 등화류 점검
        resultMap.put("quality5", itemRepository.selectQualityChkList(sellCarSeq, "J1500"));    // 차량 전방 및 엔진룸 점검
        resultMap.put("quality6", itemRepository.selectQualityChkList(sellCarSeq, "J1600"));    // 소모품 점검
        resultMap.put("quality7", itemRepository.selectQualityChkList(sellCarSeq, "J1700"));    // 시운전 점검
        resultMap.put("quality8", itemRepository.selectQualityChkList(sellCarSeq, "J1800"));    // 베이/리프팅 점검


        // Service Plus 계층 데이터
        resultMap.put("jsonData", JsonUtils.toJson(hierarchyRepository.selectSvcPlusData(sellCarSeq, "E1000")));

        return resultMap;
    }

    /**
     * 가격/사고이력 등록
     * @param priceTroubleHistoryVo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED)
    public String insertPriceTroubleHistory(PriceTroubleHistoryVo priceTroubleHistoryVo) {

        priceTroubleHistoryVo.setCreUser(SessionUtils.getUser().getUsername());

        // 인증차량 품질보증 데이터 삭제
        itemRepository.deleteSvcPlusData(priceTroubleHistoryVo.getSellCarSeq());
        // 인증차량 품질보증 데이터 등록
        if (!CollectionUtils.isEmpty(priceTroubleHistoryVo.getDetailCds())) {
            itemRepository.insertSvcPlusData(priceTroubleHistoryVo);
        }
        // 88가지 품질 점검 정비내역 등록
        if (!CollectionUtils.isEmpty(priceTroubleHistoryVo.getQualityList())) {
            itemRepository.insertQualityChkList(priceTroubleHistoryVo);
        }


        // 가격/ 사고이력 등록
        String rtnStr = itemRepository.insertPriceHistory(priceTroubleHistoryVo)> 0 ? "SUCC" : "FAIL";

        return rtnStr;
    }

    /**
     * 옵션/전차주 조회
     * @param sellCarSeq
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectOption(Long sellCarSeq) {

        SellCarModelVo sellCarModelVo = itemRepository.selectCarDefaultInfo(sellCarSeq);

        if(sellCarModelVo == null) {
            throw new RuntimeException(String.format("조회된 차량 기본 정보가 존재하지 않습니다. [sellCarSeq : \"%d\"]", sellCarSeq));
        }

        Map<String, Object> resultMap = new HashMap<>();

        // 최종 임시저장 여부
        resultMap.put("tempSaveYn", itemRepository.selectTempSaveYn(sellCarSeq));

        // 탭별 임시저장 완료 여부
        resultMap.put("saveYn", selectTabSaveYn(sellCarSeq));

        // 차량기본정보 조회
        resultMap.put("carInfo", sellCarModelVo);

        // 폭스바겐차량여부
        String vwYn = ("폭스바겐".equals(sellCarModelVo.getMak()) ? "Y" : "N");

        // 외장
        resultMap.put("trim", itemRepository.selectOptionMng(VWACode.trim.getCode(), sellCarSeq, vwYn));
        // 내장
        resultMap.put("viscus", itemRepository.selectOptionMng(VWACode.viscus.getCode(), sellCarSeq, vwYn));
        // 안전
        resultMap.put("safety", itemRepository.selectOptionMng(VWACode.safety.getCode(), sellCarSeq, vwYn));
        // 편의
        resultMap.put("convenience", itemRepository.selectOptionMng(VWACode.convenience.getCode(), sellCarSeq, vwYn));
        // 멀티미디어
        resultMap.put("multimedia", itemRepository.selectOptionMng(VWACode.multimedia.getCode(), sellCarSeq, vwYn));


        // 전차주정보
        resultMap.put("BfCarOwner", itemRepository.selectBeforeCarOwnerInfo(sellCarSeq));

        return resultMap;
    }

    /**
     * 옵션/전차주 등록
     * @param optionVo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED)
    public String insertOption(OptionVo optionVo) {

        optionVo.setCreUser(SessionUtils.getUser().getUsername());

        // 기존 차량/옵션 매핑 삭제
        itemRepository.deleteCarOptMap(optionVo.getSellCarSeq());

        if(!CollectionUtils.isEmpty(optionVo.getOptions())) {
            // 차량/옵션 매핑 등록
            itemRepository.insertCarOptMap(optionVo);
        }
        // 전차주정보 등록
        String rtnStr = itemRepository.insertBeforeCarOwnerInfo(optionVo)> 0 ? "SUCC" : "FAIL";

        return rtnStr;
    }

    /**
     * 제시/성능점검 조회
     * @param sellCarSeq
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectPerformanceCheck(Long sellCarSeq) {

        SellCarModelVo sellCarModelVo = itemRepository.selectCarDefaultInfo(sellCarSeq);

        if(sellCarModelVo == null) {
            throw new RuntimeException(String.format("조회된 차량 기본 정보가 존재하지 않습니다. [sellCarSeq : \"%d\"]", sellCarSeq));
        }

        Map<String, Object> resultMap = new HashMap<>();

        // 최종 임시저장 여부
        resultMap.put("tempSaveYn", itemRepository.selectTempSaveYn(sellCarSeq));

        // 탭별 임시저장 완료 여부
        resultMap.put("saveYn", selectTabSaveYn(sellCarSeq));

        // 차량기본정보 조회
        resultMap.put("carInfo", sellCarModelVo);

        // 제시/성능점검 조회
        resultMap.put("info", itemRepository.selectPerformanceCheck(sellCarSeq));


        // 자동차 상태표시 조회
        resultMap.put("coverPanel", itemRepository.selectCarStatus(sellCarSeq, VWACode.coverPanel.getCode()));
        resultMap.put("majorFrame", itemRepository.selectCarStatus(sellCarSeq, VWACode.majorFrame.getCode()));


        // Service Plus 계층 데이터
        resultMap.put("jsonData", JsonUtils.toJson(hierarchyRepository.selectMajorDeviceData(sellCarSeq, "G1000")));

        return resultMap;
    }

    /**
     * 제시/ 성능점검 등록
     * @param performanceVo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED)
    public String insertPerformanceCheck(PerformanceVo performanceVo) {

        performanceVo.setCreUser(SessionUtils.getUser().getUsername());

        // 자동차 상태표시 등록
        itemRepository.insertCarStatus(performanceVo);

        // 주요장치 등록
        performanceVo.getDetailCds().forEach(detailCd -> {
            PerformanceVo vo = new PerformanceVo();
            vo.setSellCarSeq(performanceVo.getSellCarSeq());
            vo.setDetailCd(detailCd);
            if ("G18111".equals(detailCd)) {
                vo.setOpinion(performanceVo.getOpinion());
            }
            itemRepository.insertMajorDevice(vo);
        });

        // 제시/성능 점검 등록
        String rtnStr = itemRepository.insertPerformanceCheck(performanceVo)> 0 ? "SUCC" : "FAIL";

        return rtnStr;
    }

    /**
     * 설명 조회
     * @param sellCarSeq
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectDisc(Long sellCarSeq) {

        SellCarModelVo sellCarModelVo = itemRepository.selectCarDefaultInfo(sellCarSeq);

        if(sellCarModelVo == null) {
            throw new RuntimeException(String.format("조회된 차량 기본 정보가 존재하지 않습니다. [sellCarSeq : \"%d\"]", sellCarSeq));
        }

        Map<String, Object> resultMap = new HashMap<>();

        // 최종 임시저장 여부
        resultMap.put("tempSaveYn", itemRepository.selectTempSaveYn(sellCarSeq));

        // 탭별 임시저장 완료 여부
        resultMap.put("saveYn", selectTabSaveYn(sellCarSeq));

        // 차량기본정보 조회
        resultMap.put("carInfo", sellCarModelVo);

        // 설명 조회
        DiscriptionVo discVo = itemRepository.selectDiscription(sellCarSeq);

        // 전시장 리스트 조회
        List<ExhibitionHallVo> hallList = new ArrayList<>();
        if ("VW".equals(SessionUtils.getUser().getAuthType())) {    // 슈퍼관리자
            hallList = itemRepository.selectExhHallVw(null);
        } else {    // 그룸관리자, 그룸운영자
            hallList = itemRepository.selectExhHallBranch(sellCarSeq, SessionUtils.getUser().getAdmSeq(), null, itemRepository.selectUserExhHallAuth(sellCarSeq, SessionUtils.getUser().getAdmSeq()));
        }

        ExhibitionHallVo hallVo = new ExhibitionHallVo();

        if (!CollectionUtils.isEmpty(hallList)) {
            if (discVo != null) {
                for (ExhibitionHallVo exhibitionHallVo : hallList) {
                    if (exhibitionHallVo.getExhHallSeq() == discVo.getExhHallSeq()) {
                        BeanUtils.copyProperties(exhibitionHallVo, hallVo);
                    }
                }
            } else {
                hallVo = hallList.get(0);
            }
        }

        resultMap.put("discVo", discVo);
        resultMap.put("hallList", hallList);
        resultMap.put("hallVo", hallVo);

        // 매물태그 조회
        resultMap.put("tagList", itemRepository.selectTagMng(sellCarSeq));

        // 내 설명글 관리 조회
        resultMap.put("myDiscList",itemRepository.selectMyDiscMng(SessionUtils.getUser().getAdmSeq(), null));

       return resultMap;
    }

    /**
     * 매장정보(전시장) 조회
     * @param exhHallSeq
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectExhibitionHall(Long exhHallSeq, Long sellCarSeq) {
        Map<String, Object> resultMap = new HashMap<>();

        // 전시장 리스트 조회
        List<ExhibitionHallVo> hallList;
        List<ExhibitionHallVo> hallVoList;

        if ("VW".equals(SessionUtils.getUser().getAuthType())) {    // 슈퍼관리자
            hallList = itemRepository.selectExhHallVw(null);
            hallVoList = itemRepository.selectExhHallVw(exhHallSeq);
        } else {    // 그룸관리자, 그룸운영자
            hallList = itemRepository.selectExhHallBranch(sellCarSeq, SessionUtils.getUser().getAdmSeq(), null, itemRepository.selectUserExhHallAuth(sellCarSeq, SessionUtils.getUser().getAdmSeq()));
            hallVoList = itemRepository.selectExhHallBranch(sellCarSeq, SessionUtils.getUser().getAdmSeq(), exhHallSeq, itemRepository.selectUserExhHallAuth(sellCarSeq, SessionUtils.getUser().getAdmSeq()));
        }

        ExhibitionHallVo hallVo = new ExhibitionHallVo();
        if (!CollectionUtils.isEmpty(hallVoList)) {
            hallVo = hallVoList.get(0);
        }

        resultMap.put("hallList", hallList);
        resultMap.put("hallVo", hallVo);

        return resultMap;
    }

    /**
     * 내 설명글 조회
     * @param discSeq
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public String selectMyDiscMng(Long discSeq) {
        String rtnStr = "";
        List<MyDiscMngVo> myDiscMngList = itemRepository.selectMyDiscMng(SessionUtils.getUser().getAdmSeq(), discSeq);
        if (!CollectionUtils.isEmpty(myDiscMngList)) {
            rtnStr = myDiscMngList.get(0).getDiscCtnt();
        }

        if(discSeq != null) {
            return rtnStr;
        } else {
            return "";
        }
    }

    /**
     * 설명 등록
     * @param discriptionVo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED)
    public String insertDisc(DiscriptionVo discriptionVo) {

        discriptionVo.setCreUser(SessionUtils.getUser().getUsername());

        // 태그 삭제
        itemRepository.deleteCarTagMap(discriptionVo);
        if(!CollectionUtils.isEmpty(discriptionVo.getTagSeqs())) {
            // 태그 등록
            itemRepository.insertCarTagMap(discriptionVo);
        }

        // 설명 삭제
        itemRepository.deleteDiscription(discriptionVo);
        // 설명 등록
        String rtnStr = itemRepository.insertDiscription(discriptionVo) > 0 ? "SUCC" : "FAIL";

        return rtnStr;
    }

    /**
     * 사진조회
     * @param sellCarSeq
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectPhoto(Long sellCarSeq) {

        SellCarModelVo sellCarModelVo = itemRepository.selectCarDefaultInfo(sellCarSeq);

        if(sellCarModelVo == null) {
            throw new RuntimeException(String.format("조회된 차량 기본 정보가 존재하지 않습니다. [sellCarSeq : \"%d\"]", sellCarSeq));
        }

        Map<String, Object> resultMap = new HashMap<>();

        // 최종 임시저장 여부
        resultMap.put("tempSaveYn", itemRepository.selectTempSaveYn(sellCarSeq));

        // 탭별 임시저장 완료 여부
        resultMap.put("saveYn", selectTabSaveYn(sellCarSeq));

        // 차량기본정보 조회
        resultMap.put("carInfo", sellCarModelVo);


        List<CarPhotoVo> list = itemRepository.selectCarPhoto(sellCarSeq, fileUrlPath);
        resultMap.put("info", list);
        resultMap.put("jsonData", JsonUtils.toJson(list));

        return resultMap;
    }

    /**
     * 사진 등록
     * @param carPhotoVo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED)
    public String insertCarPhoto(CarPhotoVo carPhotoVo) {

        carPhotoVo.setCreUser(SessionUtils.getUser().getUsername());
        // 차량사진 삭제
        itemRepository.deleteCarPhoto(carPhotoVo.getSellCarSeq());
        String rtnStr = "SUCC";
        if(!CollectionUtils.isEmpty(carPhotoVo.getCarPhotoVos())) {
            // 차량사진 등록
            rtnStr = itemRepository.insertCarPhoto(carPhotoVo) > 0 ? "SUCC" : "FAIL";
        }

        return rtnStr;
    }

    /**
     * 임시저장 가능여부 조회
     * @param sellCarSeq
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public String selectTempSaveYn(Long sellCarSeq) {
        return itemRepository.selectTempSaveYn(sellCarSeq);
    }

    /**
     * 차량매물상태 변경
     * @param carSellStatHisVo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED)
    public String insertCarSellStatHis(CarSellStatHisVo carSellStatHisVo) {
        String rtnStr = "";
        carSellStatHisVo.setCreUser(SessionUtils.getUser().getUsername());

        Boolean insBool = true;
        // 차량매물 최신 이력
        String newestHis = itemRepository.selectNewestCarSellStatHis(carSellStatHisVo.getSellCarSeq());

        // 차량매물상태이력 체크, 중복 등록 막기위해
        if ("requestApply".equals(carSellStatHisVo.getType())) {
            if (VWACode.applyStandby.getCode().equals(newestHis)) {
                insBool = false;
            }
        } else if ("returnApply".equals(carSellStatHisVo.getType())) {
            if (VWACode.returnStatus.getCode().equals(newestHis)) {
                insBool = false;
            }
        } else {
            if (VWACode.sellStatus.getCode().equals(newestHis)) {
                insBool = false;
            }
        }

        if (insBool) {
            // 차량매물상태이력 상태 변경
            itemRepository.updateCarSellStatHis(carSellStatHisVo.getSellCarSeq());

            // 차량매물상태이력 등록
            if ("requestApply".equals(carSellStatHisVo.getType())) {
                carSellStatHisVo.setCarStatCd(VWACode.applyStandby.getCode());
            } else if ("returnApply".equals(carSellStatHisVo.getType())) {
                carSellStatHisVo.setCarStatCd(VWACode.returnStatus.getCode());
            } else { // 판매중

                carSellStatHisVo.setCarStatCd(VWACode.sellStatus.getCode());

                // 판매기간 등록
                insertSellDateInfo(carSellStatHisVo);

            }
            rtnStr = itemRepository.insertCarSellStatHis(carSellStatHisVo) > 0 ? "SUCC" : "FAIL";
        } else {
            rtnStr = "OVERLAP";
        }

        return rtnStr;
    }

    /**
     * 판매관리 조회
     * @param sellCarSeq
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> selectSellMng(Long sellCarSeq) {

        SellCarModelVo sellCarModelVo = itemRepository.selectCarDefaultInfo(sellCarSeq);

        if(sellCarModelVo == null) {
            throw new RuntimeException(String.format("조회된 차량 기본 정보가 존재하지 않습니다. [sellCarSeq : \"%d\"]", sellCarSeq));
        }

        Map<String, Object> resultMap = new HashMap<>();
        // 차량기본정보 조회
        resultMap.put("carInfo", sellCarModelVo);
        // 탭별 임시저장 완료 여부
        resultMap.put("saveYn", selectTabSaveYn(sellCarSeq));
        // 판매관리 조회
        resultMap.put("info", itemRepository.selectSellMng(sellCarSeq));
        // 판매기간 조회
        resultMap.put("dateInfo", itemRepository.selectSellDateInfo(sellCarSeq));

        return resultMap;
    }

    /**
     * 판매관리 등록
     * @param sellMngVo
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED)
    public String insertSellMng(SellMngVo sellMngVo) {
        // 매물상태 이력 변경
        itemRepository.updateCarSellStatHis(sellMngVo.getSellCarSeq());
        // 매물상태 이력 등록
        CarSellStatHisVo carSellStatHisVo = new CarSellStatHisVo();
        carSellStatHisVo.setSellCarSeq(sellMngVo.getSellCarSeq());
        carSellStatHisVo.setCarStatCd(sellMngVo.getSellStat());
        carSellStatHisVo.setCreUser(SessionUtils.getUser().getUsername());
        itemRepository.insertCarSellStatHis(carSellStatHisVo);

        sellMngVo.setCreUser(SessionUtils.getUser().getUsername());


        // 판매기간 등록
        // 매물판매기간 최신 이력 조회
        SellDateInfoVo newestSellDateVo = itemRepository.selectNewestSellDateInfo(sellMngVo.getSellCarSeq());

        SellDateInfoVo sellDateVo = new SellDateInfoVo();
        sellDateVo.setSellDateSeq(newestSellDateVo.getSellDateSeq());
        sellDateVo.setSellCarSeq(sellMngVo.getSellCarSeq());
        sellDateVo.setCarStatCd(sellMngVo.getSellStat());
        sellDateVo.setSellEndDate(sellMngVo.getStatDate());
        sellDateVo.setReason(sellMngVo.getReason());
        sellDateVo.setUpdUser(SessionUtils.getUser().getUsername());

        // 판매기간 등록
       itemRepository.updateSellDateInfo(sellDateVo);

        return itemRepository.insertSellMng(sellMngVo) > 0 ? "SUCC" : "FAIL";
    }

    /**
     * 판매관리 노출여부 변경
     * @param carSellStatHisVo
     * @return
     */
    @Override
    public String insertSellMngViewChange(CarSellStatHisVo carSellStatHisVo) {
        carSellStatHisVo.setCreUser(SessionUtils.getUser().getUsername());

        // 매물상태 이력 변경
        itemRepository.updateCarSellStatHis(carSellStatHisVo.getSellCarSeq());
        // 매물상태 이력쌓기
        String rtnStr = itemRepository.insertCarSellStatHis(carSellStatHisVo) > 0 ? "SUCC" : "FAIL";
        // 판매완료 데이터 삭제
        itemRepository.deleteSellMng(carSellStatHisVo.getSellCarSeq());

        // 노출 ON
        if (VWACode.sellStatus.getCode().equals(carSellStatHisVo.getCarStatCd())) {
            // 판매기간 등록
            insertSellDateInfo(carSellStatHisVo);
        }

        return rtnStr;
    }


    /**
     * 판매기간 등록
     * @param carSellStatHisVo
     */
    private void insertSellDateInfo(CarSellStatHisVo carSellStatHisVo) {

        // 판매기간 최신 이력 조회
        SellDateInfoVo newestSellInfoVo = itemRepository.selectNewestSellDateInfo(carSellStatHisVo.getSellCarSeq());
        Boolean sellDateBool = true;
        if (newestSellInfoVo != null) {

            // 최신이력이 판매중일경우
            if (VWACode.sellStatus.getCode().equals(newestSellInfoVo.getCarStatCd())) {
                sellDateBool = false;
            } else {    // 판매중이 아닐 경우
                // 등록하기전 기존 매물기간 상태이력 변경
                itemRepository.updateAllSellDateInfoStat(carSellStatHisVo.getSellCarSeq());
            }
        }


        if (sellDateBool) {
            // 판매기간 등록
            SellDateInfoVo sellDateVo = new SellDateInfoVo();
            sellDateVo.setSellCarSeq(carSellStatHisVo.getSellCarSeq());
            sellDateVo.setCarStatCd(VWACode.sellStatus.getCode());
            sellDateVo.setCreUser(carSellStatHisVo.getCreUser());
            itemRepository.insertSellDateInfo(sellDateVo);
        }

    }

    /**
     * 매물관리 리스트 조회
     * @param itemVo
     * @return
     */
    @Override
    public Map<String, Object> selectItem(ItemVo itemVo) {
        Map<String, Object> resultMap = new HashMap<>();

        itemVo.setAuthType(SessionUtils.getUser().getAuthType());
        itemVo.setAdmSeq(SessionUtils.getUser().getAdmSeq());
        itemVo.setFileUrlPath(fileUrlPath);

        if (StringUtils.isBlank(itemVo.getOrderColumn())) {
            itemVo.setOrderColumn("CAR_SELL_NO");
            itemVo.setOrderType("DESC");
        }


        if (StringUtils.isBlank(itemVo.getCheckType())) {
            if (CollectionUtils.isEmpty(itemVo.getCarStatCds())) {
                List<String> carStatCds = new ArrayList<>();
                if (SessionUtils.hasRole("ROLE_VW") || SessionUtils.hasRole("ROLE_ADMIN")) {
                    carStatCds.add(VWACode.applyStandby.getCode());
                    carStatCds.add(VWACode.sellStatus.getCode());
                } else if (SessionUtils.hasRole("ROLE_OPERATOR")) {
                    carStatCds.add("D1006"); // 임시저장
                    carStatCds.add(VWACode.applyStandby.getCode());
                    carStatCds.add(VWACode.sellStatus.getCode());
                    carStatCds.add(VWACode.returnStatus.getCode());
                }
                itemVo.setCarStatCds(carStatCds);
            }
        }

        // 전시장구분조회
        resultMap.put("hallTypeList", itemRepository.selectItemExhType(itemVo));

        // 전시장조회
        resultMap.put("hallList", itemRepository.selectItemExhHall(itemVo));

        // 등록자 조회
        resultMap.put("userList", itemRepository.selectItemCreUser(itemVo));

        // 매물리스트 총 갯수
        resultMap.put("infoTotCnt", itemRepository.selectItemListCount(itemVo));

        // 매물리스트
        resultMap.put("info", itemRepository.selectItemList(itemVo));

        // 상태 리스트
        resultMap.put("statList", JsonUtils.toJson(itemVo.getCarStatCds()));


        // 매물 등록 가능 여부
        if (SessionUtils.hasRole("ROLE_VW")) {
            resultMap.put("regPossibleYn", "Y");
        } else {
            resultMap.put("regPossibleYn", itemRepository.selectSellRegisterYn(SessionUtils.getUser().getAdmSeq()));
        }


        return resultMap;
    }

    /**
     * 매물관리 리스트조회 (Excel)
     * @param itemVo
     * @return
     */
    @Override
    public List<ItemVo> selectItemListExcel(ItemVo itemVo) {
        itemVo.setAuthType(SessionUtils.getUser().getAuthType());
        itemVo.setAdmSeq(SessionUtils.getUser().getAdmSeq());
        itemVo.setFileUrlPath(fileUrlPath);

        if (StringUtils.isBlank(itemVo.getOrderColumn())) {
            itemVo.setOrderColumn("CAR_SELL_NO");
            itemVo.setOrderType("DESC");
        }


        if (StringUtils.isBlank(itemVo.getCheckType())) {
            if (CollectionUtils.isEmpty(itemVo.getCarStatCds())) {
                List<String> carStatCds = new ArrayList<>();
                if (SessionUtils.hasRole("ROLE_VW") || SessionUtils.hasRole("ROLE_ADMIN")) {
                    carStatCds.add(VWACode.applyStandby.getCode());
                    carStatCds.add(VWACode.sellStatus.getCode());
                } else if (SessionUtils.hasRole("ROLE_OPERATOR")) {
                    carStatCds.add("D1006"); // 임시저장
                    carStatCds.add(VWACode.applyStandby.getCode());
                    carStatCds.add(VWACode.sellStatus.getCode());
                    carStatCds.add(VWACode.returnStatus.getCode());
                }
                itemVo.setCarStatCds(carStatCds);
            }
        }

        return itemRepository.selectItemListExcel(itemVo);
    }

    /**
     * 매물관리 이력조회
     * @param itemVo
     * @return
     */
    @Override
    public List<ItemVo> selectSellStatHis(ItemVo itemVo) {
        return itemRepository.selectSellStatHis(itemVo);
    }

    /**
     * 매물관리 내 설명글 관리
     * @param discSeq
     * @return
     */
    @Override
    public Map<String, Object> selectSellMyDiscMng(Long discSeq) {

        Map<String, Object> resultMap = new HashMap<>();

        List<MyDiscMngVo> list = itemRepository.selectMyDiscMng(SessionUtils.getUser().getAdmSeq(), discSeq);
        resultMap.put("myDiscMngList", list);

        if (discSeq != null) {
            if (!CollectionUtils.isEmpty(list)) {
                resultMap.put("myDisc", list.get(0));
            }
        }

        return resultMap;
    }

    /**
     * 매물관리 - 내 설명글 등록
     * @param myDiscMngVo
     * @return
     */
    @Override
    public String insertMyDiscMng(MyDiscMngVo myDiscMngVo) {
        myDiscMngVo.setAdmSeq(SessionUtils.getUser().getAdmSeq());
        myDiscMngVo.setCreUser(SessionUtils.getUser().getUsername());
        return itemRepository.insertMyDiscMng(myDiscMngVo) > 0 ? "SUCC" : "FAIL";
    }

    /**
     * 매물관리 - 내 설명글 수정
     * @param myDiscMngVo
     * @return
     */
    @Override
    public String updateMyDiscMng(MyDiscMngVo myDiscMngVo) {
        myDiscMngVo.setAdmSeq(SessionUtils.getUser().getAdmSeq());
        myDiscMngVo.setUpdUser(SessionUtils.getUser().getUsername());
        return itemRepository.updateMyDiscMng(myDiscMngVo) > 0 ? "SUCC" : "FAIL";
    }

    /**
     * 매물관리 - 내 설명글 삭제
     * @param myDiscMngVo
     * @return
     */
    @Override
    public String deleteMyDiscMng(MyDiscMngVo myDiscMngVo) {
        return itemRepository.deleteMyDiscMng(myDiscMngVo) > 0 ? "SUCC" : "FAIL";
    }

}
