package kr.co.vwa.manager.security;

import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.User;
import kr.co.vwa.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by junypooh on 2018-01-23.
 * <pre>
 * kr.co.vwa.manager.security
 *
 * 로그인 성공 handler
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-23 오전 10:36
 */
@Slf4j
public class LoginAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserRepository userRepository;

    private RequestCache requestCache = new HttpSessionRequestCache();

    private String targetUrlParameter;
    private String defaultTargetUrl;
    private boolean useReferer;
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    public LoginAuthenticationSuccessHandler() {
        targetUrlParameter = "";
        defaultTargetUrl = "/";
        useReferer = false;
    }

    public void setTargetUrlParameter(String targetUrlParameter) {
        this.targetUrlParameter = targetUrlParameter;
    }

    public void setDefaultTargetUrl(String defaultTargetUrl) {
        this.defaultTargetUrl = defaultTargetUrl;
    }
    public void setUseReferer(boolean useReferer) {
        this.useReferer = useReferer;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        clearAuthenticationAttributes(request);

        User user = (User) authentication.getPrincipal();

        log.debug(" LOGIN SUCCESS [" + user.toString() + "]");

//        로그인 성공 이력 생성
        userRepository.updateUserVisitDay(user.getUsername());

        int intRedirectStrategy = decideRedirectStrategy(request, response);
        log.debug("intRedirectStrategy : {}", intRedirectStrategy);
        switch (intRedirectStrategy) {
            case 1:
                useTargetUrl(request, response);
                break;

            case 2:
                useSessionUrl(request, response);
                break;

            case 3:
                useRefererUrl(request, response);
                break;

            default:
                useDefaultUrl(request, response);
                break;
        }

    }

    /**
     * Removes temporary authentication-related data which may have been stored in the session
     * during the authentication process.
     */
    private void clearAuthenticationAttributes(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (session == null) {
            return;
        }

        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }

    private void useTargetUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {

        SavedRequest savedRequest = requestCache.getRequest(request, response);

        if (savedRequest != null) {
            requestCache.removeRequest(request, response);
        }

        String targetUrl = request.getParameter(targetUrlParameter);
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    private void useSessionUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {

        SavedRequest savedRequest = requestCache.getRequest(request, response);
        String targetUrl = savedRequest.getRedirectUrl();
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    private void useRefererUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String targetUrl = request.getHeader("REFERER");
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    private void useDefaultUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {

        redirectStrategy.sendRedirect(request, response, defaultTargetUrl);
    }

    /**
     * 인증 성공후 어떤 URL로 redirect 할지를 경정한다.
     * 판단 기준은 targetUrlParameter 값을 읽은 URL이 존재할 경우 그것을 1순위
     * 1순위 URL이 없을 경우 Spring Security가 세션에 저장한 URL을 2순위
     * 2순위 URL이 없을 경우 Request의 REFERER를 사용하고 그 REFERER URL이 존재할 경우 그 URL을 3순위
     * 3순위 URL이 없을 경우 Default URL을 4순위로 한다
     *
     * @param request
     * @param response
     * @return
     */
    private int decideRedirectStrategy(HttpServletRequest request, HttpServletResponse response) {

        int result = 0;

        SavedRequest savedRequest = requestCache.getRequest(request, response);

        if (!"".equals(targetUrlParameter)) {
            String targetUrl = request.getParameter(targetUrlParameter);
            if (StringUtils.hasText(targetUrl)) {
                result = 1;
            } else {
                if (savedRequest != null) {
                    result = 2;
                } else {
                    String refererUrl = request.getHeader("REFERER");
                    if (useReferer && StringUtils.hasText(refererUrl)) {
                        result = 3;
                    } else {
                        result = 0;
                    }
                }
            }

            return result;
        }

        if (savedRequest != null) {
            result = 2;
            return result;
        }

        String refererUrl = request.getHeader("REFERER");
        if (useReferer && StringUtils.hasText(refererUrl)) {
            result = 3;
        } else {
            result = 0;
        }

        return result;
    }
}
