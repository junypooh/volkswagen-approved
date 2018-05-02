package kr.co.vwa.repository;

import kr.co.vwa.domain.AuthorityVo;
import kr.co.vwa.domain.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by junypooh on 2018-01-23.
 * <pre>
 * kr.co.vwa.repository
 *
 * 사용자 정보 Repository
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-23 오전 11:35
 */
@Repository
public interface UserRepository {

    /**
     * 사용자 정보 조회
     * @param username 아이디
     * @return
     */
    User selectUserInfoByUsername(@Param("username") String username);

    /**
     * 사용자 최종 로그인 시간 업데이트
     * @param username
     */
    void updateUserVisitDay(@Param("username") String username);

    /**
     * 사용자 등록 (서버 구동시 SUPER_ADMIN 생성 용)
     * @param authorityVo
     */
    void insertUserInfo(AuthorityVo authorityVo);

    /**
     * 접근 허용 IP 체크
     * @param admSeq
     * @param ipAdress
     * @return
     */
    boolean isValidateIpAddress(@Param("admSeq") Long admSeq, @Param("ipAdress") String ipAdress);
}
