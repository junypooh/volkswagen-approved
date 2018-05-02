package kr.co.vwa.services;

import kr.co.vwa.domain.*;

import java.util.List;
import java.util.Map;

/**
 * Created by DaDa on 2018-01-18.
 * <pre>
 * kr.co.vwa.services
 *
 * 매물관리 Service Interface.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-18 오후 1:25
 */
public interface IItemService {

    /**
     * 차량 기본정보 저장
     * @param carInfoVo
     * @return
     */
    String insertCarDefaultInfo(CarInfoVo carInfoVo);

    /**
     * 차량 기본정보 수정
     * @param carInfoVo
     * @return
     */
    String updateCarDefaultInfo(CarInfoVo carInfoVo);

    /**
     * 차량 기본 정보 조회
     * @param sellCarSeq
     * @return
     */
    Map<String, Object> selectDefaultCarInfo(Long sellCarSeq);

    /**
     * ##################################################
     * 해당 매장의 권한
     * @param sellCarSeq
     * @return
     */
    String selectUserExhHallAuth(Long sellCarSeq);

    /**
     * ##################################################
     * 가격/사고이력 조회
     * @param sellCarSeq
     * @return
     */
    Map<String, Object> selectPriceTroubleHistory(Long sellCarSeq);

    /**
     * 가격/사고이력 등록
     * @param priceTroubleHistoryVo
     * @return
     */
    String insertPriceTroubleHistory(PriceTroubleHistoryVo priceTroubleHistoryVo);


    /**
     * ##################################################
     * 옵션/전차주 조회
     * @param sellCarSeq
     * @return
     */
    Map<String, Object> selectOption(Long sellCarSeq);

    /**
     * 옵션/전차주 등록
     * @param optionVo
     * @return
     */
    String insertOption(OptionVo optionVo);

    /**
     * ##################################################
     * 제시/성능점검 조회
     * @param sellCarSeq
     * @return
     */
    Map<String, Object> selectPerformanceCheck(Long sellCarSeq);

    /**
     * 제시/성능점검 등록
     * @param performanceVo
     * @return
     */
    String insertPerformanceCheck(PerformanceVo performanceVo);


    /**
     * ##################################################
     * 설명 조회
     * @param sellCarSeq
     * @return
     */
    Map<String, Object> selectDisc(Long sellCarSeq);

    /**
     * 매장정보 조회
     * @param exhHallSeq
     * @param sellCarSeq
     * @return
     */
    Map<String, Object> selectExhibitionHall(Long exhHallSeq, Long sellCarSeq);

    /**
     * 내 설명글 조회
     * @param discSeq
     * @return
     */
    String selectMyDiscMng(Long discSeq);

    /**
     * 설명 등록
     * @param discriptionVo
     * @return
     */
    String insertDisc(DiscriptionVo discriptionVo);


    /**
     * ##################################################
     * 사진 조회
     * @param sellCarSeq
     * @return
     */
    Map<String, Object> selectPhoto(Long sellCarSeq);

    /**
     * 사진 등록
     * @param carPhotoVo
     * @return
     */
    String insertCarPhoto(CarPhotoVo carPhotoVo);


    /**
     * ##################################################
     *
     * 임시저장 가능 여부 조회
     * @param sellCarSeq
     * @return
     */
    String selectTempSaveYn(Long sellCarSeq);

    /**
     * 차량 매물 상태 등록
     * @param carSellStatHisVo
     * @return
     */
    String insertCarSellStatHis(CarSellStatHisVo carSellStatHisVo);


    /**
     * ##################################################
     *
     * 판매관리 조회
     * @param sellCarSeq
     * @return
     */
    Map<String, Object> selectSellMng(Long sellCarSeq);

    /**
     * 판매관리 등록
     * @param sellMngVo
     * @return
     */
    String insertSellMng(SellMngVo sellMngVo);

    /**
     * 판매관리 노출여부
     * @param carSellStatHisVo
     * @return
     */
    String insertSellMngViewChange(CarSellStatHisVo carSellStatHisVo);

    /**
     * ##################################################
     * 매물관리 - 리스트
     * @param itemVo
     * @return
     */
    Map<String, Object> selectItem(ItemVo itemVo);

    /**
     * 매물관리 - 리스트 조회 (Excel)
     * @param itemVo
     * @return
     */
    List<ItemVo> selectItemListExcel(ItemVo itemVo);


    /**
     * 매물관리 - 이력조회
     * @param itemVo
     * @return
     */
    List<ItemVo> selectSellStatHis(ItemVo itemVo);

    /**
     * 매물관리 - 내 설명글 관리
     * @param discSeq
     * @return
     */
    Map<String, Object> selectSellMyDiscMng(Long discSeq);

    /**
     * 매물관리 - 내 설명글 등록
     * @return
     */
    String insertMyDiscMng(MyDiscMngVo myDiscMngVo);

    /**
     * 매물관리 - 내 설명글 수정
     * @return
     */
    String updateMyDiscMng(MyDiscMngVo myDiscMngVo);

    /**
     * 매물관리 - 내 설명글 삭제
     * @return
     */
    String deleteMyDiscMng(MyDiscMngVo myDiscMngVo);




}
