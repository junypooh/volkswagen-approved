package kr.co.vwa.services;

import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.Authority;
import kr.co.vwa.domain.Role;
import kr.co.vwa.domain.User;
import kr.co.vwa.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by junypooh on 2018-01-23.
 * <pre>
 * kr.co.vwa.services
 *
 * Spring UserDetailsService 구현체
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-23 오전 11:28
 */
@Slf4j
@Service("userDetailsService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private Environment environment;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        // 아이디로 User 정보 조회
        User user = userRepository.selectUserInfoByUsername(username);

        if (user == null) {
            throw new UsernameNotFoundException("등록된 사용자 정보를 찾을 수 없습니다");
        }

        if (!"Y".equals(user.getUseYn())) {
            throw new LockedException("해당 아이디는 정지 상태 입니다. 관리자에게 문의 부탁 드립니다.");
        }

        List<Authority> authorities = new ArrayList<>();
        Role role = user.getRole();

        // 전시장 계정일 경우 접속 가능 IP 체크
        if(Arrays.stream(environment.getActiveProfiles()).anyMatch(
                env -> !env.equalsIgnoreCase("local"))) {

            if (user.getRole() != Role.VW) {
                String clientIpAddr = SessionUtils.getClientIpAddr(request);
                boolean validateIpAddress = userRepository.isValidateIpAddress(user.getAdmSeq(), clientIpAddr);
                if (!validateIpAddress) {
                    throw new BadCredentialsException("허용되지 않은 IP[" + clientIpAddr + "] 입니다.");
                }
            }
        }

        authorities.add(new Authority(role.name()));

        while (role.getChildRole() != null) {
            Role childRole = role.getChildRole();

            authorities.add(new Authority(childRole.name()));

            role = childRole;
        }

        user.setAuthorities(authorities);

        if (log.isDebugEnabled())
            log.debug("user :: " + user);

        return user;
    }
}
