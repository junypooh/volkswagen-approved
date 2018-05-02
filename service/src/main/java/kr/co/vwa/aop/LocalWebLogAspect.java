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

import javax.servlet.http.HttpServletRequest;
import java.lang.annotation.Annotation;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;

/**
 * Created by junypooh on 2018-02-27.
 * <pre>
 * kr.co.vwa.aop
 *
 * 개발 환경 로그 설정 Class
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
@Profile("local")
public class LocalWebLogAspect {

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private IWebLogService iWebLogService;

    @Before(value = "execution(* kr.co.vwa.web.controller..*.*(..))")
    public void setWebLogData(JoinPoint joinPoint) {

        // ajax 처리는 로그를 남기지 않는다.
        // excel 다운로드는 남기지 않는다.
        /*String ajaxCall = request.getHeader("X-Ajax-call");
        if(ajaxCall != null && Boolean.parseBoolean(ajaxCall)) {
            return;
        }*/

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
        String URL = request.getRequestURL().toString();

        if (URL != null && URL.indexOf("base-layout.jsp") > -1) {
            return;
        }

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
