package kr.co.vwa.services;

import kr.co.vwa.domain.CarInfoVo;
import kr.co.vwa.domain.FrontItemVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by DaDa on 2018-02-13.
 * <pre>
 * kr.co.vwa.services
 *
 * 매물관리/Front Interface
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-02-13 오후 5:58
 */
public interface IFrontItemService {

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
    Map<String, Object> selectItemList(FrontItemVo itemVo);

    /**
     * 매물차량 상세 조회
     * @param sellCarSeq
     * @return
     */
    Map<String, Object> selectItemDetail(Long sellCarSeq);

    /**
     * 매물차량 상세 조회(미리보기 용)
     * @param sellCarSeq
     * @param previewYn
     * @return
     */
    Map<String, Object> selectItemDetail(Long sellCarSeq, String previewYn);

    /**
     * 매물 차량 메일 공유
     * @param itemVo
     * @param httpServletRequest
     * @return
     */
    void shareContents(FrontItemVo itemVo, HttpServletRequest httpServletRequest);

    /**
     * 매물 차량 문의하기
     * @param itemVo
     * @param httpServletRequest
     * @return
     */
    void qnaContents(FrontItemVo itemVo, HttpServletRequest httpServletRequest);


}
