package kr.co.vwa.repository;

import kr.co.vwa.domain.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by DaDa on 2018-01-18.
 * <pre>
 * kr.co.vwa.repository
 *
 * 매물관리/Back Repository
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-18 오후 1:21
 */
@Repository
public interface ItemRepository {

    /**
     * 차량 기본정보 저장
     * @param carInfoVo
     */
    Integer insertCarDefaultInfo(CarInfoVo carInfoVo);

    /**
     * 차량 기본정보 수정
     * @param carInfoVo
     */
    Integer updateCarDefaultInfo(CarInfoVo carInfoVo);

    /**
     * 최종 임시 저장 여부
     * @param sellCarSeq
     * @return
     */
    String selectTempSaveYn(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * TAB 임시저장 완료 여부
     * @param sellCarSeq
     * @return
     */
    String selectTabSaveYn(@Param("sellCarSeq") Long sellCarSeq);


    /**
     * 차량 기본 정보 조회
     * @param sellCarSeq
     * @return
     */
    SellCarModelVo selectCarDefaultInfo(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 차량 매물 상태 이력 상태 변경
     * @param sellCarSeq
     */
    void updateCarSellStatHis(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 차량 매물 상태 최신 이력 조회
     * @param sellCarSeq
     * @return
     */
    String selectNewestCarSellStatHis(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 차량 매물상태이력 등록
     * @param carSellStatHisVo
     * @return
     */
    Integer insertCarSellStatHis(CarSellStatHisVo carSellStatHisVo);

    /**
     * 매물기간 최신 이력 조회
     * @param sellCarSeq
     * @return
     */
    SellDateInfoVo selectNewestSellDateInfo(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 기존 매물기간 상태이력 변경
     * @param sellCarSeq
     */
    void updateAllSellDateInfoStat(@Param("sellCarSeq") Long sellCarSeq);


    /**
     * 매물기간 판매중 등록
     * @param sellDateInfoVo
     * @return
     */
    Integer insertSellDateInfo(SellDateInfoVo sellDateInfoVo);

    /**
     * 매물기간 판매종료/취소 변경
     * @param sellDateInfoVo
     * @return
     */
    Integer updateSellDateInfo(SellDateInfoVo sellDateInfoVo);

    /**
     * 해당 매장의 권한 조회
     * @param sellCarSeq
     * @param admSeq
     * @return
     */
    String selectUserExhHallAuth(@Param("sellCarSeq") Long sellCarSeq, @Param("admSeq") Long admSeq);

    /**
     * ################################################
     * 가격/사고이력 조회
     * @param sellCarSeq
     * @return
     */
    PriceTroubleHistoryVo selectPriceHistory(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 88가지 품질 점검 정비내역서 조회
     * @param sellCarSeq
     * @param uppCd
     * @return
     */
    List<PriceTroubleHistoryVo> selectQualityChkList(@Param("sellCarSeq") Long sellCarSeq, @Param("uppCd") String uppCd);

    /**
     * 가격/사고이력 등록
     * @param priceTroubleHistoryVo
     */
    Integer insertPriceHistory(PriceTroubleHistoryVo priceTroubleHistoryVo);

    /**
     * 88가지 품질 점검 정비내역서 등록
     * @param priceTroubleHistoryVo
     * @return
     */
    Integer insertQualityChkList(PriceTroubleHistoryVo priceTroubleHistoryVo);

    /**
     * 인증차량 품질보증 데이터 삭제
     * @param sellCarSeq
     */
    void deleteSvcPlusData(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 인증차량 품질보증 데이터 등록
     * @param priceTroubleHistoryVo
     */
    void insertSvcPlusData(PriceTroubleHistoryVo priceTroubleHistoryVo);


    /**
     * ################################################
     * 옵션 조회
     * @param categoryCd
     * @param sellCarSeq
     * @return
     */
    List<OptionVo> selectOptionMng(@Param("categoryCd") String categoryCd, @Param("sellCarSeq") Long sellCarSeq, @Param("vwYn") String vwYn);

    /**
     * 전차주정보 조회
     * @param sellCarSeq
     * @return
     */
    OptionVo selectBeforeCarOwnerInfo(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 차량/옵션 매핑 삭제
     * @param sellCarSeq
     */
    void deleteCarOptMap(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 차량/옵션 매핑 등록
     * @param optionVo
     */
    void insertCarOptMap(OptionVo optionVo);

    /**
     * 전차주정보 등록
     * @param optionVo
     * @return
     */
    Integer insertBeforeCarOwnerInfo(OptionVo optionVo);

    /**
     * ################################################
     * 제시/성능 점검 조회
     * @param sellCarSeq
     * @return
     */
    PerformanceVo selectPerformanceCheck(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 자동차 상태표시 조회
     * @param sellCarSeq
     * @param uppCd
     * @return
     */
    List<CarStatusVo> selectCarStatus(@Param("sellCarSeq") Long sellCarSeq, @Param("uppCd") String uppCd);

    /**
     * 제시/성능 점검 등록
     * @param performanceVo
     */
    Integer insertPerformanceCheck(PerformanceVo performanceVo);

    /**
     * 자동차 상태표시 등록
     * @param performanceVo
     */
    void insertCarStatus(PerformanceVo performanceVo);

    /**
     * 주요장치 데이터 등록
     * @param performanceVo
     */
    void insertMajorDevice(PerformanceVo performanceVo);

    /**
     * ################################################
     * 매장정보 조회 - [VW] 슈퍼관리자
     * @param exhHallSeq
     * @return
     */
    List<ExhibitionHallVo> selectExhHallVw(@Param("exhHallSeq") Long exhHallSeq);

    /**
     * 매장정보 조회 - [Branch] 그룸관리자(admin), 그룸운영자(operator)
     * @param sellCarSeq
     * @param admSeq
     * @param exhHallSeq
     * @param auth
     * @return
     */
    List<ExhibitionHallVo> selectExhHallBranch(@Param("sellCarSeq") Long sellCarSeq, @Param("admSeq") Long admSeq, @Param("exhHallSeq") Long exhHallSeq, @Param("auth") String auth);

    /**
     * 태그 조회
     * @param sellCarSeq
     * @return
     */
    List<TagVo> selectTagMng(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * ################################################
     * 설명글 조회
     * @param sellCarSeq
     * @return
     */
    DiscriptionVo selectDiscription(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 내 설명글 관리 조회
     * @param admSeq
     * @param discSeq
     * @return
     */
    List<MyDiscMngVo> selectMyDiscMng(@Param("admSeq") Long admSeq, @Param("discSeq") Long discSeq);


    /**
     * 차량 태그 매핑 삭제
     * @param discriptionVo
     */
    void deleteCarTagMap(DiscriptionVo discriptionVo);

    /**
     * 차량 태그 매핑 등록
     * @param discriptionVo
     */
    void insertCarTagMap(DiscriptionVo discriptionVo);

    /**
     * 설명 삭제
     * @param discriptionVo
     */
    void deleteDiscription(DiscriptionVo discriptionVo);

    /**
     * 설명 등록
     * @param discriptionVo
     * @return
     */
    Integer insertDiscription(DiscriptionVo discriptionVo);

    /**
     * ################################################
     * 차량 사진 조회
     * @param sellCarSeq
     * @param fileUrlPath
     * @return
     */
    List<CarPhotoVo> selectCarPhoto(@Param("sellCarSeq") Long sellCarSeq, @Param("fileUrlPath") String fileUrlPath);

    /**
     * 차량 사진 삭제
     * @param sellCarSeq
     */
    void deleteCarPhoto(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 차량 사진 등록
     * @param carPhotoVo
     * @return
     */
    Integer insertCarPhoto(CarPhotoVo carPhotoVo);

    /**
     * ################################################
     * 판매관리
     * @param sellCarSeq
     * @return
     */
    SellMngVo selectSellMng(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 판매기간 조회
     * @param sellCarSeq
     * @return
     */
    List<SellMngVo> selectSellDateInfo(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 판매관리 등록
     * @param sellMngVo
     * @return
     */
    Integer insertSellMng(SellMngVo sellMngVo);

    /**
     * 판매관리 삭제
     * @param sellCarSeq
     */
    void deleteSellMng(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * ################################################
     * 매물관리 리스트 - 전시장 구분 조회
     * @return
     */
    List<ItemVo> selectItemExhType(ItemVo itemVo);

    /**
     * 매물관리 리스트 - 전시장조회
     * @param itemVo
     * @return
     */
    List<ItemVo> selectItemExhHall(ItemVo itemVo);

    /**
     * 매물관리 리스트 - 등록자 조회
     * @param itemVo
     * @return
     */
    List<ItemVo> selectItemCreUser(ItemVo itemVo);

    /**
     * 매물 등록 가능 여부
     * @param admSeq
     * @return
     */
    String selectSellRegisterYn(@Param("admSeq") Long admSeq);

    /**
     * 매물관리 리스트 총 개수 조회
     * @param itemVo
     * @return
     */
    Integer selectItemListCount(ItemVo itemVo);

    /**
     * 매물관리 리스트 조회
     * @param itemVo
     * @return
     */
    List<ItemVo> selectItemList(ItemVo itemVo);

    /**
     * 매물관리 리스트 조회 (Excel)
     * @param itemVo
     * @return
     */
    List<ItemVo> selectItemListExcel(ItemVo itemVo);

    /**
     * 매물관리 이력보기 조회
     * @param itemVo
     * @return
     */
    List<ItemVo> selectSellStatHis(ItemVo itemVo);

    /**
     * 매물관리 - 내 설명글 등록
     * @param myDiscMngVo
     * @return
     */
    Integer insertMyDiscMng(MyDiscMngVo myDiscMngVo);

    /**
     * 매물관리 - 내 설명글 수정
     * @param myDiscMngVo
     * @return
     */
    Integer updateMyDiscMng(MyDiscMngVo myDiscMngVo);

    /**
     * 매물관리 - 내 설명글 삭제
     * @param myDiscMngVo
     * @return
     */
    Integer deleteMyDiscMng(MyDiscMngVo myDiscMngVo);



}
