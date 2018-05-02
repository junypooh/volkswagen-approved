package kr.co.vwa.manager.security;

import kr.co.vwa.domain.Authority;
import kr.co.vwa.domain.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by junypooh on 2018-01-23.
 * <pre>
 * kr.co.vwa.manager.security
 *
 * Spring AuthenticationProvider 구현체
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-23 오전 11:23
 */
@Slf4j
@Component("customAuthenticationProvider")
public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    @Qualifier(value = "userDetailsService")
    private UserDetailsService userDetailsService;

    @Autowired
    private StandardPasswordEncoder standardPasswordEncoder;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {

        String username = authentication.getName();
        String password = (String) authentication.getCredentials();

        log.debug("username : " + username);
        log.debug("password : " + password);

        User user;
        List<Authority> authorities;

        try {

            // 사용자 정보 조회(by Id)
            user = (User) userDetailsService.loadUserByUsername(username);

            if (!standardPasswordEncoder.matches(password, user.getPassword())) {
                throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
            }

            authorities = user.getAuthorities();

        } catch (UsernameNotFoundException e) {
            log.info(e.toString());
            throw new UsernameNotFoundException(e.getMessage());
        } catch (BadCredentialsException e) {
            log.info(e.toString());
            throw new BadCredentialsException(e.getMessage());
        } catch (LockedException e) {
            log.info(e.toString());
            throw new LockedException(e.getMessage());
        } catch (Exception e) {
            log.error("Error : ", e);
            throw new RuntimeException(e.getMessage());
        }

        return new UsernamePasswordAuthenticationToken(user, password, authorities);

    }

    @Override
    public boolean supports(Class<?> authentication) {
        return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
    }
}
