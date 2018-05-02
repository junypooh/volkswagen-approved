package kr.co.vwa.aop;

import eu.bitwalker.useragentutils.UserAgent;
import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.WebLogVo;
import kr.co.vwa.services.IWebLogService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.PredicateUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;

/**
 * Created by junypooh on 2018-02-27.
 * <pre>
 * kr.co.vwa.aop
 *
 * 서버 로그 설정 Class
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-27 오후 2:30
 */
@Slf4j
@Aspect
@Component
@Profile("production")
public class WebLogAspect {

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private IWebLogService iWebLogService;

    /**
     * url Redirect
     * @param url
     */
    private void redirect(String url) {

        HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
        try {
            response.sendRedirect(url);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    /**
     * http 경우 https 로 변경
     * @param url
     */
    private void secureRedirect(String url) {

        String xForwardedProto = request.getHeader("X-Forwarded-Proto");
        if(xForwardedProto != null && "http".equals(xForwardedProto)) {
            this.redirect(url.replace("http", "https"));
        }

    }

    /**
     * www 가 없을 경우 www 를 붙혀서 redirect
     * @param url
     */
    private void wwwRedirect(String url) {
        boolean isChangeUrl = false;
        String xForwardedProto = request.getHeader("X-Forwarded-Proto");
        if(xForwardedProto != null && "http".equals(xForwardedProto)) {
            isChangeUrl = true;
            url = url.replace("http", "https");
        }
        String redirectUrl = url;
		if(url.indexOf("www") < 0) {
            isChangeUrl = true;
            redirectUrl = url.substring(0, url.indexOf(":")) + "://www." + url.substring(url.indexOf(":") + 3);
        }
        if(isChangeUrl) {
            this.redirect(redirectUrl);
        }
    }

    @Before(value = "execution(* kr.co.vwa.manager.controller..*.*(..))")
    public void setManagerHttpsRedirect(JoinPoint joinPoint) {

        this.secureRedirect(request.getRequestURL().toString().replace("http", "https"));
    }

    @Before(value = "execution(* kr.co.vwa.web.controller..*.*(..))")
    public void setWebLogData(JoinPoint joinPoint) {

        String URL = request.getRequestURL().toString();
        // 정상적인 URL 접근이 아닌 특정 IP 및 http://load-balancer-*****.amazonaws.com/ 은 제외처리
        if (URL.indexOf(".co.kr") < 0) {
            return;
        }

        if (URL != null && URL.indexOf("base-layout.jsp") > -1) {
            return;
        }

        this.wwwRedirect(URL);
        //this.secureRedirect(URL);

/*
	요청 시간 : 로그 생성 시간(접속 시간)
	URL : 현재 URL
	REFERER : REFERER 전문
	REFERER_SITE : REFERER 도메인
	MENU : 현재 접속한 메뉴명
	PAGE : 젤 하위 메뉴 URL
	디바이스 : ? 접속한 장치(PC/mobile)의 어떤 정보인지???
	OS : 접속한 장치(PC/mobile)의 OS
	BROWSER : 접속한 brower 정보 (몇가지만 선정해서 저장 나머지는 unknown 처리)
	IP_ADDRESS : 접속자 IP 정보
	USER_AGENT : request user agent 값
*/

        Annotation[] annotations = ((MethodSignature) joinPoint.getSignature()).getMethod().getDeclaredAnnotations();

        WebLogInfo webLogInfo = (WebLogInfo) CollectionUtils.find(Arrays.asList(annotations), PredicateUtils.instanceofPredicate(WebLogInfo.class));

        if(webLogInfo == null) {
            return;
        }

        String domain = "";
        if(request.getServerPort() != 80 && request.getServerPort() != 443) {
            domain = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
        } else {
            domain = request.getScheme() + "://" + request.getServerName() + request.getContextPath();
        }

        String reqDtm = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String reqYear = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy"));
        String reqMonth = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
        String reqDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String reqTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("HHmmss"));

        String URI = request.getRequestURI();
        String REFERER = request.getHeader("referer");
        String userAgentAsString = request.getHeader("User-Agent");

        // HealthChecker 는 무시
        if(userAgentAsString != null && userAgentAsString.indexOf("HealthChecker") > -1) {
            return;
        }

        UserAgent userAgent = UserAgent.parseUserAgentString(userAgentAsString);

        WebLogVo webLogVo = new WebLogVo();
        webLogVo.setReqDtm(reqDtm);
        webLogVo.setReqYear(reqYear);
        webLogVo.setReqMonth(reqMonth);
        webLogVo.setReqDate(reqDate);
        webLogVo.setReqTime(reqTime);
        webLogVo.setUrl(URL);
        webLogVo.setReferer(REFERER);
        if (REFERER != null) {
            if(REFERER.indexOf("/", 8) == -1) {
                webLogVo.setRefererSite(REFERER);
            } else {
                webLogVo.setRefererSite(REFERER.substring(0, REFERER.indexOf("/", 8)+1));
            }
        }
        webLogVo.setMenu(webLogInfo.menuPath());
        webLogVo.setPage(URI);
        webLogVo.setDevice(userAgent.getOperatingSystem().getDeviceType().getName());
        webLogVo.setOs(userAgent.getOperatingSystem().getName());
        webLogVo.setOsGroup(userAgent.getOperatingSystem().getGroup().getName());
        webLogVo.setBrowser(userAgent.getBrowser().getName());
        webLogVo.setBrowserGroup(userAgent.getBrowser().getGroup().getName());
        webLogVo.setIpAddress(SessionUtils.getClientIpAddr(request));
        webLogVo.setUserAgent(userAgentAsString);

        iWebLogService.insertWebLog(webLogVo);

    }
}
