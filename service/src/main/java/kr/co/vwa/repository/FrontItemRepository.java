package kr.co.vwa.repository;

import kr.co.vwa.domain.CarInfoVo;
import kr.co.vwa.domain.ExhibitionHallVo;
import kr.co.vwa.domain.FrontItemVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by DaDa on 2018-02-13.
 * <pre>
 * kr.co.vwa.repository
 *
 * 매물관리/Front Repository
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-02-13 오후 5:57
 */
@Repository
public interface FrontItemRepository {

    /**
     * 프론트 비폭스바겐 제조사 리스트
     * @return
     */
    List<CarInfoVo> selectNonVwaCarMakList();

    /**
     * 프론트 비폭스바겐 모델 리스트
     * @param carInfoVo
     * @return
     */
    List<CarInfoVo> selectNonVwaCarModelList(CarInfoVo carInfoVo);

    /**
     * 프론트 비폭스바겐 상세모델 리스트
     * @param carInfoVo
     * @return
     */
    List<CarInfoVo> selectNonVwaCarDetailModelList(CarInfoVo carInfoVo);

    /**
     * 현재 판매진행 중이 차량수(메인페이지용)
     * @param carInfoVo
     * @return
     */
    Integer selectNowSellingItemCount(CarInfoVo carInfoVo);


    /**
     * 매물차량 조회
     * @param itemVo
     * @return
     */
    List<FrontItemVo> selectItemList(FrontItemVo itemVo);

    /**
     * 매물차량 갯수 조회
     * @param itemVo
     * @return
     */
    Integer selectItemListCount(FrontItemVo itemVo);

    /**
     * 전시장 지역 조회
     * @return
     */
    List<ExhibitionHallVo> selectExhHallSigun();

    /**
     * 매물 조회 수 증가
     * @param sellCarSeq
     */
    void updateSellCarModelHits(@Param("sellCarSeq") Long sellCarSeq);

    /**
     * 매물상세 - 88가지 품질점검표 레이어 여부 조회
     * @param sellCarSeq
     * @return
     */
    String selectQualityChkYn(@Param("sellCarSeq") Long sellCarSeq);

}
