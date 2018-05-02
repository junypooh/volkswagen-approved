package kr.co.vwa.web.configuration;

import kr.co.vwa.common.util.ApplicationContextUtils;
import kr.co.vwa.web.security.CustomAccessDeniedHandler;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.concurrent.ConcurrentTaskScheduler;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.CorsUtils;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

/**
 * Created by junypooh on 2017-12-29.
 * SecurityConfiguration Class
 */
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Bean
    public StandardPasswordEncoder standardPasswordEncoderBean() {
        return new StandardPasswordEncoder();
    }

    @Bean
    public ApplicationContextUtils applicationContextUtilsBean() {
        return new ApplicationContextUtils();
    }

    @Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }

    @Bean
    public TaskScheduler taskScheduler() {
        return new ConcurrentTaskScheduler(); //single threaded by default
    }

    @Bean
    public CustomAccessDeniedHandler customAccessDeniedHandler() {
        return new CustomAccessDeniedHandler("/error/403");
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http
//                .requiresChannel().anyRequest().requiresSecure()
//                .and()
                .authorizeRequests()
                .requestMatchers(CorsUtils::isCorsRequest).permitAll()
                .anyRequest().permitAll().and()
                .cors().and()
                .csrf().and()
                .exceptionHandling()
                .accessDeniedHandler(customAccessDeniedHandler())
                .and()
                .sessionManagement()
                .maximumSessions(10);
    }

    @Bean
    public CorsConfigurationSource corsConfiguration() {

        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("http://localhost"
                , "http://dev-admin.vwa.co.kr", "https://dev-admin.vwa.co.kr"
                , "http://dev-admin.volkswagenapproved.co.kr", "https://dev-admin.volkswagenapproved.co.kr"
                , "http://admin.vwa.co.kr", "https://admin.vwa.co.kr"
                , "http://admin.volkswagenapproved.co.kr", "https://admin.volkswagenapproved.co.kr"));
        configuration.setAllowedMethods(Arrays.asList("GET"));
//        configuration.setAllowedHeaders(Arrays.asList("Accept", "Accept-Language", "Content-Language", "Content-Type", "application/x-www-form-urlencoded", "multipart/form-data", "text/plain"));
        configuration.setAllowCredentials(true);
        configuration.setMaxAge(3600L);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/resources/**", configuration);

        return source;
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**"); // Static resources are ignored
    }
}
