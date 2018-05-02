package kr.co.vwa.services;

import kr.co.vwa.domain.WebLogVo;
import kr.co.vwa.repository.WebLogRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by eunsoo on 2018-03-02.
 * <pre>
 * kr.co.vwa.services
 *
 * 웹로그 Service
 *
 * </pre>
 *
 * @author EunSoo, Choi
 * @see
 * @since 2018-03-02 오후 1:42
 */
@Slf4j
@Service
public class WebLogService implements IWebLogService {

    @Autowired
    private WebLogRepository webLogRepository;

    @Override
    public void insertWebLog(WebLogVo webLogVo) {
        webLogRepository.insertWebLog(webLogVo);
    }
}
