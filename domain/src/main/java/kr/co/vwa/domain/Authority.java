package kr.co.vwa.domain;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;

/**
 * Created by junypooh on 2018-01-19.
 * <pre>
 * kr.co.vwa.domain
 *
 * Spring GrantedAuthority 구현체
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-19 오후 5:31
 */
@Data
public class Authority implements GrantedAuthority {

    public Authority(String authority) {
        this.authority = "ROLE_" + authority;
    }

    private String authority;
}
