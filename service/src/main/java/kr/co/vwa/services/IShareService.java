package kr.co.vwa.services;

import kr.co.vwa.domain.EmailAgreeVo;
import kr.co.vwa.domain.ShareVo;

/**
 * Created by junypooh on 2018-03-02.
 * <pre>
 * kr.co.vwa.services
 *
 * 공유 이력 Service
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-03-02 오후 1:06
 */
public interface IShareService {

    /**
     * 공유 이력 생성
     * @param shareVo
     */
    void insertShareHistory(ShareVo shareVo);

    /**
     * 이메일 동의 이력 생성
     * @param type
     * @param emailAgree
     */
    void insertEmailAgreeHistory(String type, EmailAgreeVo emailAgree);
}
