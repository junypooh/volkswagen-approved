package kr.co.vwa.web.controller;

import eu.bitwalker.useragentutils.DeviceType;
import eu.bitwalker.useragentutils.UserAgent;
import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.domain.EventVo;
import kr.co.vwa.services.EventService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.StringEscapeUtils;
/**
 * 이벤트/FRONT Controller
 */
@Controller
@Slf4j
@RequestMapping("event")
public class EventController {

    @Autowired
    private EventService eventService;

    @Value("${s3.url}")
    private String fileUrlPath;

    /**
     * 이벤트 목록/FRONT
     * @param model
     * @param searchParam
     * @param request
     */
    @GetMapping(value = "/list")
    @WebLogInfo(menuPath = "이벤트")
    public void eventList(Model model, @RequestParam Map<String, Object> searchParam, HttpServletRequest request) {
        List<EventVo> list=eventService.eventFrontList();
        searchParam.put("fileUrlPath", fileUrlPath);

        String userAgentAsString = request.getHeader("User-Agent");
        UserAgent userAgent = UserAgent.parseUserAgentString(userAgentAsString);

        DeviceType deviceType = userAgent.getOperatingSystem().getDeviceType();

        if(DeviceType.MOBILE.equals(deviceType) || DeviceType.TABLET.equals(deviceType)) {
            searchParam.put("check", "mobile");
        } else {
            searchParam.put("check", "pc");
        }

        model.addAttribute("searchParam",searchParam);
        model.addAttribute("list",list);
    }

    /**
     * 이벤트 상세/FRONT
     * @param model
     * @param eventVo
     * @return
     */
    @GetMapping(value = "/detail/{eventSeq}")
    @WebLogInfo(menuPath = "이벤트 > 상세")
    public String eventDetail(Model model,EventVo eventVo) {

        EventVo eventVo1=eventService.eventDetailVo(eventVo);
        String originCont = StringEscapeUtils.unescapeHtml3(eventVo1.getCtntPc());
        String originCont2 = StringEscapeUtils.unescapeHtml3(eventVo1.getCtntMo());
        eventVo1.setCtntPc(originCont);
        eventVo1.setCtntMo(originCont2);
        model.addAttribute("eventVo",eventVo1);
        return "event/detail";
    }

}
