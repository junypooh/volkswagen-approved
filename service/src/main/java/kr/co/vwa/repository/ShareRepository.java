package kr.co.vwa.repository;

import kr.co.vwa.domain.EmailAgreeVo;
import kr.co.vwa.domain.ShareVo;

/**
 * Created by junypooh on 2018-03-02.
 * <pre>
 * kr.co.vwa.repository
 *
 * 공유 이력 Repository
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-03-02 오후 12:53
 */
public interface ShareRepository {

    /**
     * 공유 이력 생성
     * @param shareVo
     */
    void insertShareHistory(ShareVo shareVo);

    /**
     * 이메일 동의 이력 생성
     * @param emailAgree
     */
    void insertEmailAgreeHistory(EmailAgreeVo emailAgree);
}
