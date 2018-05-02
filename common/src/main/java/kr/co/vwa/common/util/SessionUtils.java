package kr.co.vwa.common.util;

import kr.co.vwa.domain.Authority;
import kr.co.vwa.domain.User;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.List;

/**
 * Created by junypooh on 2018-01-24.
 * <pre>
 * kr.co.vwa.common.util
 *
 * Session 관련 Class
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-24 오전 9:59
 */
public class SessionUtils {

    private static Authentication getAuthentication() {
        SecurityContext context = SecurityContextHolder.getContext();
        if (context == null) {
            return null;
        }

        return context.getAuthentication();
    }


    public static User getUser() {
        Authentication authentication = getAuthentication();
        if(authentication != null){
            Object principal = authentication.getPrincipal();
            if (!(principal instanceof User)) {
                return null;
            }
            return (User) principal;
        }
        return null;
    }


    public static List<Authority> getAuthorities() {
        User User = getUser();
        if (User == null) {
            return Collections.emptyList();
        }
        return User.getAuthorities();
    }


    public static boolean hasRole(String role) {
        for (GrantedAuthority authorityInfo : getAuthorities()) {
            if (StringUtils.equals(role, authorityInfo.getAuthority())) {
                return true;
            }
        }
        return false;
    }

    public static String getClientIpAddr(HttpServletRequest request) {

        String ip = request.getHeader("X-Forwarded-For");
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }

        return ip;
    }


    public static boolean hasAnyRole(String... roles) {
        for (GrantedAuthority authorityInfo : getAuthorities()) {
            if (ArrayUtils.contains(roles, authorityInfo.getAuthority())) {
                return true;
            }
        }
        return false;
    }
}
