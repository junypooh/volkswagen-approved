package kr.co.vwa.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.List;

/**
 * Created by junypooh on 2018-01-23.
 * <pre>
 * kr.co.vwa.domain
 *
 * Spring UserDetails 구현체
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-23 오전 11:15
 */
@Data
@EqualsAndHashCode(callSuper = false)
@ToString
public class User implements UserDetails {

    private Long admSeq;

    private String authType;

    private LocalDateTime visitDay;

    private String memo;

    private String useYn;

    /** 로그인 용 아이디 */
    private String username;

    /** 로그인 용 비밀번호 */
    private String password;

    private String role;

    /** 디폴트 전시장 */
    private Integer exhHallSeq;

    /** 디폴트 권한 */
    private String defaultRole;

    /** spring security 사용 권한s */
    private List<Authority> authorities;


    /** UserDetails default variable */
    private boolean accountNonExpired = true;
    private boolean accountNonLocked = true;
    private boolean credentialsNonExpired = true;
    private boolean enabled = true;

    public void setRole(Role role) {
        this.role = role.getAuthorityCd();
    }

    public Role getRole() {
        return Role.getRole(this.role);
    }

    public void setDefaultRole(Role defaultRole) {
        this.defaultRole = defaultRole.getAuthorityCd();
    }

    public Role getDefaultRole() {
        if(this.defaultRole != null)
            return Role.getRole(this.defaultRole);
        else
            return null;
    }
}
