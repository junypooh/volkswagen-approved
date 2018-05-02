package kr.co.vwa.services;

import kr.co.vwa.common.enums.EmailTypeEnum;
import kr.co.vwa.common.enums.VWACode;
import kr.co.vwa.common.util.EmailContentUtil;
import kr.co.vwa.common.util.JsonUtils;
import kr.co.vwa.domain.*;
import kr.co.vwa.repository.FrontItemRepository;
import kr.co.vwa.repository.HierarchyRepository;
import kr.co.vwa.repository.ItemRepository;
import kr.co.vwa.repository.MajorOptionRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.velocity.tools.generic.NumberTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by DaDa on 2018-02-13.
 * <pre>
 * kr.co.vwa.services
 *
 * 매물관리/Front Service
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-02-13 오후 5:59
 */
@Service
@Slf4j
public class FrontItemService implements IFrontItemService {

    @Autowired
    private IOptionService iOptionService;

    @Autowired
    private IBranchService iBranchService;

    @Autowired
    private IEmailService iEmailService;

    @Autowired
    private FrontItemRepository frontItemRepository;

    @Autowired
    private ItemRepository itemRepository;

    @Autowired
    private HierarchyRepository hierarchyRepository;

    @Autowired
    private MajorOptionRepository majorOptionRepository;

    @Value("${s3.url}")
    private String fileUrlPath;

    @Value("${vwa.front.url}")
    private String vwaFrontUrl;

    /**
     * 프론트 비폭스바겐 제조사 리스트
     * @return
     */
    @Override
    public List<CarInfoVo> selectNonVwaCarMakList() {
        return frontItemRepository.selectNonVwaCarMakList();
    }

    /**
     * 프론트 비폭스바겐 모델 리스트
     * @param carInfoVo
     * @return
     */
    @Override
    public List<CarInfoVo> selectNonVwaCarModelList(CarInfoVo carInfoVo) {
        return frontItemRepository.selectNonVwaCarModelList(carInfoVo);
    }

    /**
     * 프론트 비폭스바겐 상세모델 리스트
     * @param carInfoVo
     * @return
     */
    @Override
    public List<CarInfoVo> selectNonVwaCarDetailModelList(CarInfoVo carInfoVo) {
        return frontItemRepository.selectNonVwaCarDetailModelList(carInfoVo);
    }

    /**
     * 현재 판매진행 중이 차량수(메인페이지용)
     * @param carInfoVo
     * @return
     */
    @Override
    public Integer selectNowSellingItemCount(CarInfoVo carInfoVo) {
        return frontItemRepository.selectNowSellingItemCount(carInfoVo);
    }

    /**
     * 매물 차량 리스트
     * @param itemVo
     * @return
     */
    @Override
    public Map<String, Object> selectItemList(FrontItemVo itemVo) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("sigunList", frontItemRepository.selectExhHallSigun());

        itemVo.setFileUrlPath(fileUrlPath);
        if (StringUtils.isBlank(itemVo.getCertYn())) {
            itemVo.setCertYn("ALL");
        }

        if (StringUtils.isBlank(itemVo.getOrderType())) {
            itemVo.setOrderType("AA.CRE_DATE DESC");
        }

        resultMap.put("info", frontItemRepository.selectItemList(itemVo));
        resultMap.put("infoTotCnt", frontItemRepository.selectItemListCount(itemVo));
        return resultMap;
    }

    /**
     * 매물차량 상세 조회
     * @param sellCarSeq
     * @return
     */
    @Override
    public Map<String, Object> selectItemDetail(Long sellCarSeq) {
        return this.selectItemDetail(sellCarSeq, "N");
    }


    /**
     * 매물차량 상세 조회
     * @param sellCarSeq
     * @param previewYn 미리보기 여부
     * @return
     */
    @Override
    public Map<String, Object> selectItemDetail(Long sellCarSeq, String previewYn) {

        SellCarModelVo sellCarModelVo = itemRepository.selectCarDefaultInfo(sellCarSeq);

        if(sellCarModelVo == null) {
            throw new RuntimeException(String.format("조회된 차량 기본 정보가 존재하지 않습니다. [sellCarSeq : \"%d\"]", sellCarSeq));
        }

        PriceTroubleHistoryVo priceTroubleHistoryVo = itemRepository.selectPriceHistory(sellCarSeq);

        Map<String, Object> resultMap = new HashMap<>();

        // 차량정보(리스트에서 사용하는 쿼리)
        FrontItemVo itemVo = new FrontItemVo();
        itemVo.setCurrPage(1);
        itemVo.setContentsCount(1);
        itemVo.setOrderType("CRE_DATE");
        itemVo.setFileUrlPath(fileUrlPath);
        itemVo.setCertYn("ALL");
        itemVo.setPreviewYn(previewYn);

        List<Long> longs = Arrays.asList(sellCarSeq);
        itemVo.setSellCarSeqs(longs);

        FrontItemVo frontItemVo = frontItemRepository.selectItemList(itemVo).get(0);
        resultMap.put("info", frontItemVo);

        // 추천매물
        itemVo.setContentsCount(3);
        itemVo.setSellCarSeqs(null);
        itemVo.setSelectType("recommend");
        itemVo.setSellPrice(frontItemVo.getSellPrice());
        itemVo.setSellCarSeq(sellCarSeq);
        itemVo.setOrderType("DISTANCE ASC");
        resultMap.put("recommends", frontItemRepository.selectItemList(itemVo));

        // 차량기본정보 조회
        resultMap.put("carInfo", sellCarModelVo);
        // 가격/사고이력 조회
        resultMap.put("priceInfo", priceTroubleHistoryVo);
        // 88가지 품질점검표 레이어 여부 조회
        resultMap.put("priceQualityYn", frontItemRepository.selectQualityChkYn(sellCarSeq));
        // 88가지 품질 점검 정비내역서 조회
        resultMap.put("quality1", itemRepository.selectQualityChkList(sellCarSeq, "J1100"));    // 기본점검
        resultMap.put("quality2", itemRepository.selectQualityChkList(sellCarSeq, "J1200"));    // 실내운전석에서 점검
        resultMap.put("quality3", itemRepository.selectQualityChkList(sellCarSeq, "J1300"));    // 진단기 점검
        resultMap.put("quality4", itemRepository.selectQualityChkList(sellCarSeq, "J1400"));    // 등화류 점검
        resultMap.put("quality5", itemRepository.selectQualityChkList(sellCarSeq, "J1500"));    // 차량 전방 및 엔진룸 점검
        resultMap.put("quality6", itemRepository.selectQualityChkList(sellCarSeq, "J1600"));    // 소모품 점검
        resultMap.put("quality7", itemRepository.selectQualityChkList(sellCarSeq, "J1700"));    // 시운전 점검
        resultMap.put("quality8", itemRepository.selectQualityChkList(sellCarSeq, "J1800"));    // 베이/리프팅 점검

        // 전차주정보
        resultMap.put("BfCarOwner", itemRepository.selectBeforeCarOwnerInfo(sellCarSeq));

        List<HierarckyVo> hierarckyVos = hierarchyRepository.selectSvcPlusData(sellCarSeq, "E1000");

        Map<String, String> servicePlus = new HashMap<>();
        hierarckyVos.forEach(hierarckyVo -> {
            hierarckyVo.getState().stream().filter(hierarckySubVo -> "checked".equals(hierarckySubVo.getChecked())).forEach(hierarckySubVo -> servicePlus.put(hierarckyVo.getCd(), hierarckySubVo.getText()));
        });
        /*for (HierarckyVo hierarckyVo : hierarckyVos) {
            for(HierarckySubVo hierarckySubVo : hierarckyVo.getState()) {
                if("checked".equals(hierarckySubVo.getChecked())) {
                    servicePlus.put(hierarckyVo.getCd(), hierarckySubVo.getText());
                }
            }
        }*/
        // Service Plus 데이터
        resultMap.put("servicePlus", servicePlus);

        // 차량 사진
        resultMap.put("photos", itemRepository.selectCarPhoto(sellCarSeq, fileUrlPath));

        // 폭스바겐차량여부
        String vwYn = ("폭스바겐".equals(sellCarModelVo.getMak()) ? "Y" : "N");

        // 주요옵션 정보
        OptionVo optionVo = new OptionVo();
        optionVo.setSellCarSeq(sellCarSeq);
        optionVo.setVwYn(vwYn);
        resultMap.put("majorOptions", majorOptionRepository.selectMajorOptionListByCar(optionVo));

        // 옵션 정보
        resultMap.put("options", iOptionService.optMngList(sellCarSeq, vwYn));

        // 성능 점검표
        List<CarStatusVo> h1100 = itemRepository.selectCarStatus(sellCarSeq, "H1100");// 외판
        List<CarStatusVo> h1200 = itemRepository.selectCarStatus(sellCarSeq, "H1200");// 주요골격
        resultMap.put("panels", h1100);
        resultMap.put("frames", h1200);

        // 매물 조회 수 증가
        frontItemRepository.updateSellCarModelHits(sellCarSeq);

        // 설명 정보
        DiscriptionVo discVo = itemRepository.selectDiscription(sellCarSeq);
        resultMap.put("discVo", discVo);

        // 전시장 정보
        resultMap.put("branchVo", iBranchService.selectOneBranch((int)(long)discVo.getExhHallSeq()));


        // 제시/성능점검 조회
        resultMap.put("performance", itemRepository.selectPerformanceCheck(sellCarSeq));


        // 자동차 상태표시 조회
        resultMap.put("coverPanel", itemRepository.selectCarStatus(sellCarSeq, VWACode.coverPanel.getCode()));
        resultMap.put("majorFrame", itemRepository.selectCarStatus(sellCarSeq, VWACode.majorFrame.getCode()));


        // Service Plus 계층 데이터
        resultMap.put("jsonData", JsonUtils.toJson(hierarchyRepository.selectMajorDeviceData(sellCarSeq, "G1000")));

        return resultMap;
    }

    @Override
    public void shareContents(FrontItemVo itemVo, HttpServletRequest httpServletRequest) {


        List<Long> longs = Arrays.asList(itemVo.getSellCarSeq());
        itemVo.setSellCarSeqs(longs);
        itemVo.setCurrPage(1);
        itemVo.setContentsCount(1);
        itemVo.setOrderType("CRE_DATE");
        itemVo.setFileUrlPath(fileUrlPath);
        itemVo.setCertYn("ALL");

        Map<String, Object> data = new HashMap<>();
        // 차량정보(리스트에서 사용하는 쿼리)
        FrontItemVo frontItemVo = frontItemRepository.selectItemList(itemVo).get(0);
        data.put("info", frontItemVo);
        // 차량기본정보 조회
        data.put("carInfo", itemRepository.selectCarDefaultInfo(itemVo.getSellCarSeq()));
        // 가격/사고이력 조회
        data.put("priceInfo", itemRepository.selectPriceHistory(itemVo.getSellCarSeq()));
        // 전차주정보
        data.put("BfCarOwner", itemRepository.selectBeforeCarOwnerInfo(itemVo.getSellCarSeq()));
        data.put("number", new NumberTool());

        // 설명 정보
        DiscriptionVo discVo = itemRepository.selectDiscription(itemVo.getSellCarSeq());

        // 전시장 정보
        BranchVo branch = (BranchVo) iBranchService.selectOneBranch((int) (long) discVo.getExhHallSeq()).get("branch");
        data.put("branch", branch);

        data.put("domainUrl", httpServletRequest.getScheme() + "://" + httpServletRequest.getServerName() + ":" + httpServletRequest.getServerPort() + httpServletRequest.getContextPath());
        data.put("linkUrl", httpServletRequest.getScheme() + "://" + httpServletRequest.getServerName() + ":" + httpServletRequest.getServerPort() + httpServletRequest.getContextPath() + "/item/" + itemVo.getSellCarSeq());

        String emailContents = EmailContentUtil.getStaticEmailContents(EmailTypeEnum.SHARE, data);

        iEmailService.sendEmailMimeMessage(itemVo.getMailAddr(), itemVo.getMailUserNm(), "[폭스바겐 인증중고차] " + frontItemVo.getMak() + " " + frontItemVo.getDetailModel() + " 차량정보입니다.", emailContents);
    }

    @Override
    public void qnaContents(FrontItemVo itemVo, HttpServletRequest httpServletRequest) {

        // 설명 정보
        DiscriptionVo discVo = itemRepository.selectDiscription(itemVo.getSellCarSeq());

        // 전시장 정보
        BranchVo branch = (BranchVo) iBranchService.selectOneBranch((int) (long) discVo.getExhHallSeq()).get("branch");
        String toEmail = branch.getEmailList().get(0).getEmail();

        // 차량 정보
        List<Long> longs = Arrays.asList(itemVo.getSellCarSeq());
        itemVo.setSellCarSeqs(longs);
        itemVo.setCurrPage(1);
        itemVo.setContentsCount(1);
        itemVo.setOrderType("CRE_DATE");
        itemVo.setFileUrlPath(fileUrlPath);
        itemVo.setCertYn("ALL");
        // 차량기본정보 조회
        FrontItemVo vo = frontItemRepository.selectItemList(itemVo).get(0);

        // 차량기본정보 조회
        SellCarModelVo sellCarModelVo = itemRepository.selectCarDefaultInfo(itemVo.getSellCarSeq());

        if(sellCarModelVo == null) {
            throw new RuntimeException(String.format("조회된 차량 기본 정보가 존재하지 않습니다. [sellCarSeq : \"%d\"]", itemVo.getSellCarSeq()));
        }

        String contents = "[차량정보]" + "\n";
        contents += "매물 번호 : " + vo.getCarSellNo() + "\n";
        contents += "제조사 : " + vo.getMak() + "\n";
        contents += "모델 : " + vo.getModel() + " " + vo.getDetailModel() + "\n";
        contents += "매물 경로 : " + vwaFrontUrl + "/item/" + itemVo.getSellCarSeq() + "\n\n";
        contents += "[고객정보]" + "\n";
        contents += "고객 이름 : " + itemVo.getMailUserNm() + "\n";
        contents += "이메일 주소 : " + itemVo.getMailAddr() + "\n";
        contents += "추가내용 : " + itemVo.getMailContents() + "\n";

        iEmailService.sendEmailMessage(toEmail, "[매물문의] " + vo.getMak() + " " + vo.getDetailModel() + " 매물 문의 입니다.", contents);

    }
}
