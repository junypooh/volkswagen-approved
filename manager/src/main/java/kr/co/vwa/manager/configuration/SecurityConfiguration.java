package kr.co.vwa.manager.configuration;

import kr.co.vwa.common.util.ApplicationContextUtils;
import kr.co.vwa.manager.security.*;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.concurrent.ConcurrentTaskScheduler;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.security.web.session.HttpSessionEventPublisher;

/**
 * Created by junypooh on 2017-12-29.
 * SecurityConfiguration Class
 */
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Bean
    public CustomAuthenticationProvider customAuthenticationProvider() {
        return new CustomAuthenticationProvider();
    }

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

    @Bean
    public LoginAuthenticationSuccessHandler loginAuthenticationSuccessHandler() {
        LoginAuthenticationSuccessHandler loginAuthenticationSuccessHandler = new LoginAuthenticationSuccessHandler();
        loginAuthenticationSuccessHandler.setTargetUrlParameter("_spring_security_target_url");
        loginAuthenticationSuccessHandler.setDefaultTargetUrl("/index");
        loginAuthenticationSuccessHandler.setUseReferer(false);
        return loginAuthenticationSuccessHandler;
    }

    @Bean
    public LoginAuthenticationFailureHandler loginAuthenticationFailureHandler() {
        LoginAuthenticationFailureHandler loginAuthenticationFailureHandler = new LoginAuthenticationFailureHandler();
        loginAuthenticationFailureHandler.setDefaultFailureUrl("/login?error");

        return loginAuthenticationFailureHandler;
    }

    @Bean
    public LogoutAuthenticationSuccessHandler logoutAuthenticationSuccessHandler() {
        return new LogoutAuthenticationSuccessHandler();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(customAuthenticationProvider());
    }

    @Bean
    @Override
    protected AuthenticationManager authenticationManager() throws Exception {
        return super.authenticationManager();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
//                .requiresChannel().anyRequest().requiresSecure()
//                .and()
                .authorizeRequests()
//                .antMatchers("/login", "/encode").permitAll()
                .antMatchers("/login", "/encode", "/error/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .csrf()
                .and()
                .formLogin()
                .loginPage("/login")
                .usernameParameter("username")
                .passwordParameter("password")
                .successHandler(loginAuthenticationSuccessHandler())
                .failureHandler(loginAuthenticationFailureHandler())
                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessHandler(logoutAuthenticationSuccessHandler())
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID", "hazelcast.sessionId")
                .permitAll()
                .and()
                .exceptionHandling()
                .accessDeniedHandler(customAccessDeniedHandler());

        http
                .headers()
                .xssProtection().block(false)
                .and()
                .frameOptions().disable();
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/**"); // Static resources are ignored
    }
}
