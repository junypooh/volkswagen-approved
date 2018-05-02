package kr.co.vwa.web.configuration;

import net.sf.log4jdbc.Log4jdbcProxyDataSource;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.JdbcType;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

/**
 * Created by junypooh on 2018-01-03.
 * MyBatisConfiguration Class
 */
@Configuration
@EnableTransactionManagement
@MapperScan(basePackages = "kr.co.vwa.repository")
public class MyBatisConfiguration {

    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {

        final SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();

        // 마이바티스가 사용한 DataSource를 등록
//        sessionFactory.setDataSource(dataSource);
        sessionFactory.setDataSource(new Log4jdbcProxyDataSource(dataSource));

        // 마이바티스 설정
        org.apache.ibatis.session.Configuration mybatisConfiguration = new org.apache.ibatis.session.Configuration();
        mybatisConfiguration.setDefaultExecutorType(ExecutorType.REUSE);
        mybatisConfiguration.setMapUnderscoreToCamelCase(true);
        mybatisConfiguration.setJdbcTypeForNull(JdbcType.VARCHAR);
        mybatisConfiguration.setLazyLoadingEnabled(true);
        sessionFactory.setConfiguration(mybatisConfiguration);

        // Set locations of MyBatis mapper files
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        sessionFactory.setMapperLocations(resolver.getResources("classpath*:kr/co/vwa/repository/*.xml"));
        //sessionFactory.setTypeAliasesPackage("kr.co.vwa.domain");

        return sessionFactory.getObject();
    }

    @Bean(destroyMethod="clearCache")
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {
        final SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory);
        return sqlSessionTemplate;
    }

    @Bean
    public PlatformTransactionManager transactionManager(DataSource dataSource) {
        DataSourceTransactionManager dataSourceTransactionManager = new DataSourceTransactionManager();
        dataSourceTransactionManager.setDataSource(dataSource);
        dataSourceTransactionManager.setGlobalRollbackOnParticipationFailure(false);
        return dataSourceTransactionManager;
    }
}
