package kr.co.vwa.manager;

import kr.co.vwa.services.IInitialDataProvider;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.session.jdbc.config.annotation.web.http.EnableJdbcHttpSession;

/**
 * Created by junypooh on 2017-12-18.
 * <pre>
 * kr.co.vwa.web
 *
 * WebApplication Class
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2017-12-19 오후 5:31
 */
@Slf4j
@SpringBootApplication(scanBasePackages = "kr.co.vwa")
@EnableAspectJAutoProxy
@EnableJdbcHttpSession(maxInactiveIntervalInSeconds = 1800)
public class WebApplication implements CommandLineRunner {

    @Autowired
    private IInitialDataProvider dataProvider;

    @Override
    public void run(String... args) throws Exception {
        log.info("Initializing data...");
        dataProvider.initData();
        log.info("Data initialization finished.");
    }

    public static void main(String[] args) {

        SpringApplication.run(WebApplication.class, args);
    }
}
