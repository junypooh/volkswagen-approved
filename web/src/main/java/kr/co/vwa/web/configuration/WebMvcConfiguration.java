package kr.co.vwa.web.configuration;

import com.navercorp.lucy.security.xss.servletfilter.XssEscapeServletFilter;
import kr.co.vwa.web.view.GenericExcelView;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.ui.velocity.VelocityEngineFactoryBean;
import org.springframework.web.context.request.RequestContextListener;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.BeanNameViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by junypooh on 2017-12-18.
 * WebMvcConfiguration Class
 */
@Configuration
@EnableWebMvc
public class WebMvcConfiguration extends WebMvcConfigurerAdapter {

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("WEB-INF/resources/");
    }

    /*@Override
    public void configurePathMatch(PathMatchConfigurer configurer) {
        configurer.setUseRegisteredSuffixPatternMatch(true);
    }*/

    /*@Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addRedirectViewController("/", "/index");
    }*/

    /*@Bean
    public FilterRegistrationBean corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true);
        config.addAllowedOrigin("*");
        config.addAllowedHeader("*");
        config.addAllowedMethod("*");
        source.registerCorsConfiguration("/**", config);
        FilterRegistrationBean bean = new FilterRegistrationBean(new CorsFilter(source));
        bean.setOrder(0);
        return bean;
    }*/

    /**
     *
     * @return registrationBean with Utf-8 encoding config
     */
    @Bean
    public FilterRegistrationBean filterRegistrationBean() {
        FilterRegistrationBean registrationBean = new FilterRegistrationBean();
        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        registrationBean.setFilter(characterEncodingFilter);
        return registrationBean;
    }

    /**
     *
     * @return registrationBean xssEscapeServletFilter
     */
    @Bean
    public FilterRegistrationBean xssFilterRegistrationBean() {
        FilterRegistrationBean registrationBean = new FilterRegistrationBean();
        registrationBean.setFilter(new XssEscapeServletFilter());
        registrationBean.setOrder(1);  // @Order로 처리.
        registrationBean.addUrlPatterns("/*");
        return registrationBean;
    }

    /**
     *
     * @return resolver with tiles config
     */
    @Bean
    public TilesViewResolver tilesViewResolver() {

        TilesViewResolver tilesViewResolver = new TilesViewResolver();
        tilesViewResolver.setViewClass(TilesView.class);
        tilesViewResolver.setOrder(1);
        return tilesViewResolver;
    }

    @Bean
    public BeanNameViewResolver beanNameViewResolver() {

        BeanNameViewResolver beanNameViewResolver = new BeanNameViewResolver();
        beanNameViewResolver.setOrder(0);

        return beanNameViewResolver;
    }

    @Bean
    public ViewResolver viewResolver() {

        InternalResourceViewResolver internalResourceViewResolver = new InternalResourceViewResolver();
        internalResourceViewResolver.setPrefix("/WEB-INF/jsp/view/");
        internalResourceViewResolver.setSuffix(".jsp");
        internalResourceViewResolver.setOrder(2);
        return internalResourceViewResolver;
    }

    /*@Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver multipart = new CommonsMultipartResolver();
        multipart.setMaxUploadSize(10 * 1024 * 1024); *//* 10MB *//*
        multipart.setMaxInMemorySize(10 * 1024 * 1024); *//* 10MB *//*
        return multipart;
    }

    @Bean
    public MultipartFilter multipartFilter() {
        MultipartFilter multipartFilter = new MultipartFilter();
        multipartFilter.setMultipartResolverBeanName("multipartResolver");
        return multipartFilter;
    }*/

    /**
     *
     * @return tiles configure layers with every views of pizza app
     */
    @Bean
    public TilesConfigurer tilesConfigurer() {
        TilesConfigurer configurer = new TilesConfigurer();
        configurer.setDefinitions("WEB-INF/tiles/tiles.xml");
//        configurer.setDefinitions("classpath:tiles/tiles.xml");
        configurer.setCheckRefresh(true);
        return configurer;
    }

    @Bean
    public RequestContextListener requestContextListener(){
        return new RequestContextListener();
    }

    /*@Bean
    public SessionListener sessionListener() {
        return new SessionListener();
    }*/

    @Bean("excelView")
    public GenericExcelView genericExcelView() {
        return  new GenericExcelView();
    }

    @Bean
    public EmbeddedServletContainerCustomizer containerCustomizer() {

        return container -> {

            ErrorPage error400Page = new ErrorPage(HttpStatus.BAD_REQUEST, "/error/400");
            ErrorPage error401Page = new ErrorPage(HttpStatus.UNAUTHORIZED, "/error/401");
            ErrorPage error403Page = new ErrorPage(HttpStatus.FORBIDDEN, "/error/403");
            ErrorPage error404Page = new ErrorPage(HttpStatus.NOT_FOUND, "/error/404");
            ErrorPage error405Page = new ErrorPage(HttpStatus.METHOD_NOT_ALLOWED, "/error/405");
            ErrorPage error500Page = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error/500");

            container.addErrorPages(error400Page, error401Page, error403Page, error404Page, error405Page, error500Page);
        };
    }

    @Bean
    public VelocityEngineFactoryBean velocityEngineFactoryBean() {

        VelocityEngineFactoryBean velocityEngineFactoryBean = new VelocityEngineFactoryBean();
        Map<String, Object> velocityPropertiesMap = new HashMap<>();
        velocityPropertiesMap.put("resource.loader", "class");
        velocityPropertiesMap.put("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        velocityPropertiesMap.put("class.resource.loader.cache", "true");
        velocityPropertiesMap.put("input.encoding", "UTF-8");
        velocityPropertiesMap.put("output.encoding", "UTF-8");
        velocityEngineFactoryBean.setVelocityPropertiesMap(velocityPropertiesMap);

        return velocityEngineFactoryBean;
    }
}
