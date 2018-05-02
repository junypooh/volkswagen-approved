package kr.co.vwa.manager.controller;

import kr.co.vwa.common.util.PageUtil;
import kr.co.vwa.domain.EventVo;
import kr.co.vwa.services.IEventService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 이벤트관리 컨트롤러
 */
@Controller
@Slf4j
@RequestMapping("event")
public class EventController {

    @Autowired
    private PageUtil pageUtil;

    @Autowired
    private IEventService eventService;

    /**
     * 이벤트 관리/목록 GET방식
     * @param model
     * @param searchParam
     */
    @RequestMapping("/list")
    public void eventList(Model model,@RequestParam Map<String, Object> searchParam) {
        //limit 설정을 위한 로직
        int currPage = searchParam.get("currPage") == null ? 1 : Integer.parseInt((String)searchParam.get("currPage"));
        int limitRow = (currPage - 1) * pageUtil.getDefaultContentsCount();
        searchParam.put("currPage", currPage);
        searchParam.put("limitRow", limitRow);
        searchParam.put("defaultContentsCount", pageUtil.getDefaultContentsCount());

        List<EventVo> list=eventService.eventList(searchParam);
        int totalCount = eventService.eventTotalCount(searchParam);
        String pageHtml = pageUtil.makePageHtml(totalCount, currPage);

        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageHtml", pageHtml);
        model.addAttribute("searchParam",searchParam);
        model.addAttribute("list",list);
    }

    /**
     * 이벤트 관리/목록 노출여부
     * @param model
     * @param eventVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/eventExpsYnUpdate")
    public int eventExpsYnUpdate(Model model,EventVo eventVo) {
        return eventService.eventExpsYnUpdate(eventVo);
    }

    /**
     * 이벤트 관리/목록 등록이동
     * @param model
     * @return
     */
    @GetMapping(value = "/registeForm")
    public String registeForm(Model model) {
        EventVo eventVo=eventService.eventFormVo();
        model.addAttribute("eventVo",eventVo);
        return "event/detail";
    }

    /**
     * 이벤트 관리/등록 POST방식
     * @param model
     * @param eventVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/eventRegiste")
    public int eventRegiste(Model model,EventVo eventVo) {
        EventVo eventVo1=eventService.eventRegiste(eventVo);
        return eventVo1.getEventSeq();
    }

    /**
     * 이벤트 관리/등록 이동 GET방식
     * @param model
     * @param eventVo
     * @return
     */
    @GetMapping(value = "/detail/{eventSeq}")
    public String eventDetail(Model model,EventVo eventVo) {
        EventVo eventVo1=eventService.eventDetailVo(eventVo);
        model.addAttribute("eventVo",eventVo1);
        return "event/detail";
    }

    /**
     * 이벤트 관리/상세 POST방식
     * @param model
     * @param eventVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/updateEvent")
    public int updateEvent(Model model,EventVo eventVo) {
        eventService.updateEvent(eventVo);
        return eventVo.getEventSeq();
    }

    /**
     * 이벤트 관리/삭제
     * @param model
     * @param eventVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/eventDelete")
    public int eventDelete(Model model,EventVo eventVo) {
        return eventService.eventDelete(eventVo);
    }
}
