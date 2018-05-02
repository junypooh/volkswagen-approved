package kr.co.vwa.manager.security;

import kr.co.vwa.domain.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by junypooh on 2018-01-23.
 * <pre>
 * kr.co.vwa.manager.security
 *
 * 로그아웃 성공 handler
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-23 오전 11:13
 */
@Slf4j
public class LogoutAuthenticationSuccessHandler extends SimpleUrlLogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response,
                                Authentication authentication) throws IOException, ServletException {

        if (authentication != null) {
            User user = (User)authentication.getPrincipal();
            log.debug(" LOGOUT SUCCESS [" + user.toString()+"]" );
        }

        super.onLogoutSuccess(request, response, authentication);
    }
}
