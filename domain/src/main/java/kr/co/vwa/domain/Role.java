package kr.co.vwa.domain;

import com.google.common.base.MoreObjects;

/**
 * Created by junypooh on 2018-01-19.
 * <pre>
 * kr.co.vwa.domain
 *
 * Role Enum Class
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-19 오후 5:18
 */
public enum Role {

    VW("VW", "VW", "ADMIN"),
    ADMIN("Branch", "ADMIN", "OPERATOR"),
    OPERATOR("Branch", "OPERATOR", null);

    private String groupCd;
    private String authorityCd;
    private String childRoleCd;

    Role(String groupCd, String authorityCd, String childRoleCd) {
        this.groupCd = groupCd;
        this.authorityCd = authorityCd;
        this.childRoleCd = childRoleCd;
    }

    public Role getChildRole() {
        if (this.childRoleCd == null) {
            return null;
        } else {
            return Role.getRole(this.childRoleCd);
        }
    }

    public static Role getRole(String authorityCd) {
        for (Role role : values()) {
            if (role.authorityCd.equals(authorityCd))
                return role;
        }

        throw new IllegalArgumentException("No matching role for authority code [" + authorityCd + "] found.");
    }

    public String getGroupCd() {
        return this.groupCd;
    }

    public String getAuthorityCd() {
        return this.authorityCd;
    }

    @Override
    public String toString() {
        return MoreObjects.toStringHelper(this)
                .add("name", this.name())
                .add("groupCd", groupCd)
                .add("authorityCd", authorityCd)
                .toString();
    }
}
