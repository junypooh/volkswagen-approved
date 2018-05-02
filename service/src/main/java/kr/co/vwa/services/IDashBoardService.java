package kr.co.vwa.services;

import kr.co.vwa.domain.User;

import java.util.Map;

/**
 * Created by junypooh on 2018-03-28.
 * <pre>
 * kr.co.vwa.services
 *
 * 관리자 대시보드 서비스
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-03-28 오전 11:37
 */
public interface IDashBoardService {

    /**
     * 권한별 대시보드 정보 조회
     * @param user
     * @return
     */
    Map<String, Object> selectDashBoardData(User user);
}
