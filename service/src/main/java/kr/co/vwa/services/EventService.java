package kr.co.vwa.services;

import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.EventVo;
import kr.co.vwa.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 이벤트관리 서비스
 */
@Service
public class EventService implements IEventService {

    @Autowired
    private EventRepository eventRepository;

    @Value("${s3.url}")
    private String fileUrlPath;

    /**
     * 이벤트 관리/목록 GET방식
     * @param searchParam
     * @return
     */
    @Override
    public List<EventVo> eventList(Map searchParam){
        searchParam.put("fileUrlPath", fileUrlPath);
        List<EventVo> list =eventRepository.eventList(searchParam);
        return list;
    }

    /**
     * 이벤트 관리/전체 갯수
     * @param searchParam
     * @return
     */
    @Override
    public int eventTotalCount(Map searchParam){
        return eventRepository.eventTotalCount(searchParam);
    }

    /**
     * 이벤트 관리/목록 노출여부
     * @param eventVo
     * @return
     */
    @Override
    public int eventExpsYnUpdate(EventVo eventVo){
        eventVo.setUpdUser(SessionUtils.getUser().getUsername());
        return eventRepository.eventExpsYnUpdate(eventVo);
    }

    /**
     * 이벤트 관리/목록 등록이동
     * @return
     */
    @Override
    public EventVo eventFormVo(){
        EventVo eventVo=new EventVo();
        eventVo.setFormFlag(0);
        return eventVo;
    }

    /**
     * 이벤트 관리/등록 POST방식
     * @param eventVo
     * @return
     */
    @Override
    public EventVo eventRegiste(EventVo eventVo){
        eventVo.setUpdUser(SessionUtils.getUser().getUsername());
        eventRepository.eventRegiste(eventVo);
        return eventVo;
    }

    /**
     * 이벤트 관리/등록 이동 GET방식
     * @param eventVo
     * @return
     */
    @Override
    public EventVo eventDetailVo(EventVo eventVo){
        EventVo eventVo1=eventRepository.eventDetailVo(eventVo);
        if(eventVo1 == null) {
            throw new RuntimeException(String.format("조회된 이벤트 정보가 존재하지 않습니다. [eventSeq : \"%d\"]", eventVo.getEventSeq()));
        }
        String filePath=eventVo1.getFile().getFilePath();
        String fileNm=eventVo1.getFile().getFileNm();
        String fileUrl=fileUrlPath+filePath+fileNm;
        eventVo1.setFileUrl(fileUrl);
        if (eventVo1.getMainImgFile() != null){
            filePath = eventVo1.getMainImgFile().getFilePath();
            fileNm=eventVo1.getMainImgFile().getFileNm();
            fileUrl=fileUrlPath+filePath+fileNm;
            eventVo1.setMainFileUrl(fileUrl);
        }
        eventVo1.setFormFlag(1);
        return eventVo1;
    }

    /**
     * 이벤트 관리/상세 POST방식
     * @param eventVo
     * @return
     */
    @Override
    public int updateEvent(EventVo eventVo){
        eventVo.setUpdUser(SessionUtils.getUser().getUsername());
        return eventRepository.updateEvent(eventVo);
    }

    /**
     * 이벤트 관리/삭제
     * @param eventVo
     * @return
     */
    @Override
    public int eventDelete(EventVo eventVo){
        eventVo.setUpdUser(SessionUtils.getUser().getUsername());
        return eventRepository.eventDelete(eventVo);
    }

    /**
     * 이벤트 목록/FRONT
     * @return
     */
    public List<EventVo> eventFrontList(){
        return eventRepository.eventFrontList();

    }

    /**
     * 이벤트 목록/FRONT 메인페이지
     * @return
     */
    public List<EventVo> eventFrontMainList(){

        List<EventVo> eventVos = eventRepository.eventFrontMainList();

        // 메인 페이지에는 1개만 표시
        List<EventVo> list = new ArrayList<>();
        if (!CollectionUtils.isEmpty(eventVos)) {
            list.add(eventVos.get(0));
        }

        return list;

    }
}
