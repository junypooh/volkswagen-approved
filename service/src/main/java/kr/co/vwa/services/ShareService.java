package kr.co.vwa.services;

import kr.co.vwa.domain.EmailAgreeVo;
import kr.co.vwa.domain.ShareVo;
import kr.co.vwa.repository.ShareRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by junypooh on 2018-03-02.
 * <pre>
 * kr.co.vwa.services
 *
 * 공유 이력 Service 구현체
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-03-02 오후 1:07
 */
@Service
@Slf4j
public class ShareService implements IShareService {

    @Autowired
    private ShareRepository shareRepository;

    /**
     * 공유 이력 생성
     * @param shareVo
     */
    @Override
    public void insertShareHistory(ShareVo shareVo) {
        shareRepository.insertShareHistory(shareVo);
    }

    /**
     * 이메일 동의 이력 생성
     * @param type
     * @param emailAgree
     */
    @Override
    public void insertEmailAgreeHistory(String type, EmailAgreeVo emailAgree) {
        emailAgree.setType(type);
        emailAgree.setAgree1("Y".equals(emailAgree.getAgree1()) ? emailAgree.getAgree1() : "N");
        emailAgree.setAgree2("Y".equals(emailAgree.getAgree2()) ? emailAgree.getAgree2() : "N");
        emailAgree.setAgree3("Y".equals(emailAgree.getAgree3()) ? emailAgree.getAgree3() : "N");
        shareRepository.insertEmailAgreeHistory(emailAgree);
    }
}
