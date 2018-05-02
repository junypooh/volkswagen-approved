package kr.co.vwa.services;

import kr.co.vwa.domain.AuthorityVo;
import kr.co.vwa.domain.User;
import kr.co.vwa.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Component;

/**
 * Created by junypooh on 2018-02-13.
 * <pre>
 * kr.co.vwa.services
 *
 * 최초 유저 생성 운영 Class
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-13 오후 12:24
 */
@Profile("production")
@Component
public class InitialDataProviderProduction implements IInitialDataProvider {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private StandardPasswordEncoder standardPasswordEncoder;

    @Override
    public void initData() {

        String username = "vwa";
        User user = userRepository.selectUserInfoByUsername(username);

        if(user == null) {
            AuthorityVo authorityVo = new AuthorityVo();
            authorityVo.setAuthType("VW");
            authorityVo.setId(username);
            authorityVo.setPwd(standardPasswordEncoder.encode("vwaadmin"));
            authorityVo.setMemo("시스템 생성 슈퍼유저");

            userRepository.insertUserInfo(authorityVo);
        }

    }
}
