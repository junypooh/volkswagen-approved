package kr.co.vwa.repository;

import kr.co.vwa.domain.WebLogVo;
import org.springframework.stereotype.Repository;

/**
 * Created by eunsoo on 2018-03-02.
 * <pre>
 * kr.co.vwa.repository
 *
 * 웹로그 Repository
 *
 * </pre>
 *
 * @author EunSoo, Choi
 * @see
 * @since 2018-03-02 오후 1:43
 */

@Repository
public interface WebLogRepository {
    void insertWebLog(WebLogVo webLogVo);
}
