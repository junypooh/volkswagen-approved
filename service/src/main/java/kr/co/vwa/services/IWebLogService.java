package kr.co.vwa.services;

import kr.co.vwa.domain.WebLogVo; /**
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


public interface IWebLogService {
    void insertWebLog(WebLogVo webLogVo);
}
