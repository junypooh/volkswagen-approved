package kr.co.vwa.services;

import kr.co.vwa.domain.EventVo;
import kr.co.vwa.domain.User;

import java.util.List;
import java.util.Map;

/**
 * Created by hyeongju on 2018-01-15.
 * 이벤트 Interface
 */
public interface IEventService {

    /**
     * 이벤트 관리/목록 GET방식
     * @param searchParam
     * @return
     */
    List<EventVo> eventList(Map searchParam);

    /**
     * 이벤트 관리/전체 갯수
     * @param searchParam
     * @return
     */
    int eventTotalCount(Map searchParam);

    /**
     * 이벤트 관리/목록 노출여부
     * @param eventVo
     * @return
     */
    int eventExpsYnUpdate(EventVo eventVo);

    /**
     * 이벤트 관리/목록 등록이동
     * @return
     */
    EventVo eventFormVo();

    /**
     * 이벤트 관리/등록 POST방식
     * @param eventVo
     * @return
     */
    EventVo eventRegiste(EventVo eventVo);

    /**
     * 이벤트 관리/등록 이동 GET방식
     * @param eventVo
     * @return
     */
    EventVo eventDetailVo(EventVo eventVo);

    /**
     * 이벤트 관리/상세 POST방식
     * @param eventVo
     * @return
     */
    int updateEvent(EventVo eventVo);

    /**
     * 이벤트 관리/삭제
     * @param eventVo
     * @return
     */
    int eventDelete(EventVo eventVo);

    /**
     * 이벤트 목록/FRONT
     * @return
     */
    List<EventVo> eventFrontList();

    /**
     * 이벤트 목록/FRONT 메인페이지
     * @return
     */
    List<EventVo> eventFrontMainList();
}
