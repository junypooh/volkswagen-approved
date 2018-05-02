package kr.co.vwa.web.controller;

import eu.bitwalker.useragentutils.UserAgent;
import kr.co.vwa.domain.ShareVo;
import kr.co.vwa.services.IShareService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by junypooh on 2018-03-02.
 * <pre>
 * kr.co.vwa.web.controller
 *
 * 공유 이력 Controller
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-03-02 오후 1:09
 */
@Controller
@Slf4j
@RequestMapping("share")
public class ShareController {

    @Autowired
    private IShareService iShareService;

    /**
     * 공유 이력 생성
     * @param shareVo
     * @param request
     * @return
     */
    @PostMapping(value = "history")
    @ResponseBody
    public Object history(ShareVo shareVo, HttpServletRequest request) {

        String userAgentAsString = request.getHeader("User-Agent");
        UserAgent userAgent = UserAgent.parseUserAgentString(userAgentAsString);

        shareVo.setDevice(userAgent.getOperatingSystem().getDeviceType().getName());
        shareVo.setOs(userAgent.getOperatingSystem().getName());
        shareVo.setOsGroup(userAgent.getOperatingSystem().getGroup().getName());
        shareVo.setBrowser(userAgent.getBrowser().getName());
        shareVo.setBrowserGroup(userAgent.getBrowser().getGroup().getName());

        iShareService.insertShareHistory(shareVo);

        return "";

    }
}
