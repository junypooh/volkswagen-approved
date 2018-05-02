package kr.co.vwa.services;

import kr.co.vwa.domain.PopupVo;
import kr.co.vwa.domain.User;

import java.util.List;
import java.util.Map;

/**
 * Created by hyeongju on 2018-01-15.
 * 팝업관리 Interface
 */
public interface IPopupService {

    /**
     * 팝업 관리/목록 GET방식
     * @param searchParam
     * @return
     */
    List<PopupVo> popupList(Map searchParam);

    /**
     * 팝업 관리/전체 갯수
     * @param searchParam
     * @return
     */
    int popupTotalCount(Map searchParam);

    /**
     * 팝업 관리/목록 노출여부
     * @param popupVo
     * @return
     */
    int popupExpsYnUpdate(PopupVo popupVo);

    /**
     * 팝업 관리/목록 등록폼이동
     * @return
     */
    PopupVo popupFormVo();

    /**
     * 팝업 관리/등록 POST방식
     * @param popupVo
     * @return
     */
    PopupVo popupRegiste(PopupVo popupVo);

    /**
     * 팝업 관리/편집 GET방식
     * @param popupVo
     * @return
     */
    PopupVo popupDetailVo(PopupVo popupVo);

    /**
     * 팝업 관리/편집저장
     * @param popupVo
     * @return
     */
    int updatePopup(PopupVo popupVo);

    /**
     * 팝업 관리/삭제
     * @param popupVo
     * @return
     */
    int popupDelete(PopupVo popupVo);

    /**
     * 팝업 전체 조회(프론트용)
     * @param popupVo
     * @return
     */
    List<PopupVo> selectFrontPopupList(PopupVo popupVo);

    /**
     * 팝업관리/목록, 상세 노출여부 Y인 팝업개수
     * @param popupSeq
     * @return
     */
    int popupExpsYCount(Integer popupSeq);
}
