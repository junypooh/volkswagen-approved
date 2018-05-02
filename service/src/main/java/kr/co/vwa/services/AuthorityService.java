package kr.co.vwa.services;

import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.AuthorityVo;
import kr.co.vwa.domain.AuthExhibMapVo;
import kr.co.vwa.domain.BranchVo;
import kr.co.vwa.domain.User;
import kr.co.vwa.repository.AuthorityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 권한관리 서비스
 */
@Service("authorityService")
public class AuthorityService implements IAuthorityService {

    @Autowired
    private AuthorityRepository authorityRepository;

    @Autowired
    private StandardPasswordEncoder standardPasswordEncoder;

    /**
     * 권한관리/목록 관리자 전체 개수 조회
     *
     * @param searchParam
     * @return
     */
    @Override
    public int selectAuthListTotalCount(Map<String, Object> searchParam) {
        return authorityRepository.selectAuthListTotalCount(searchParam);
    }

    /**
     * 권한관리/목록 코드값에 따른 관리자 조회
     *
     * @param searchParam
     * @return
     */
    @Override
    public List<AuthorityVo> authListSelect(Map<String, Object> searchParam) {
        return authorityRepository.authListSelect(searchParam);
    }

    /**
     * 권한관리/수정 관리자-전시장 매핑 전체조회
     *
     * @return
     */
    @Override
    public List<BranchVo> selectExhibList() {
        return authorityRepository.selectExhibList();
    }

    /**
     * 권한관리/등록 관리자 등록
     *
     * @param authorityVo
     * @return
     */
    @Override
    public int registeAuthority(AuthorityVo authorityVo) {

        authorityVo.setCreUser(SessionUtils.getUser().getUsername());

//        int maxAdmSeq = authorityRepository.selectMaxAdmSeq();
        authorityVo.setPwd(standardPasswordEncoder.encode("test"));
        int result = authorityRepository.registeAuthority(authorityVo);

        //ID는 등록할때 채번하기 때문에 패스워드는 insert 뒤에 update 한다.
        AuthorityVo resultAuthority = authorityRepository.authMngDetail(authorityVo);
        String password = resultAuthority.getId() + "_" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"))+"!";
        resultAuthority.setPwd(standardPasswordEncoder.encode(password));
        authorityRepository.authPwdChange(resultAuthority);

        if ("Branch".equals(authorityVo.getAuthType()) && authorityVo.getExhHallSeq() != null) {
            //관리자구분이 Branch일 때 and 전시장 사용여부가 ON인 전시장이 1개 이상 있을 때
            List<AuthExhibMapVo> authExhibMapList = new ArrayList<>();
            //화면에서 선택한 전시장 사용여부가 ON인 데이터들을 List로 만든다.
            for (int i = 0; i < authorityVo.getExhHallSeq().length; i++) {
                AuthExhibMapVo authExhibMap = new AuthExhibMapVo();
                authExhibMap.setAdmSeq(authorityVo.getAdmSeq());
                authExhibMap.setExhHallSeq(authorityVo.getExhHallSeq()[i]);
                authExhibMap.setAuth(authorityVo.getAuth()[i]);
                authExhibMap.setCreUser(SessionUtils.getUser().getUsername());
                authExhibMapList.add(authExhibMap);
            }
            result = authorityRepository.registeAuthExhMapList(authExhibMapList);
        }

        return result;
    }

    /**
     * 권한관리/상세 authVo정보
     * flag=0 VW - VW
     * flag=1 VW - Branch
     * flag=2 VW - VW(본인)
     * flag=3 Branch - VW
     * flag=4 Branch - Branch
     * flag=5 Branch - Branch(본인)
     *
     * @param authorityVo
     * @return
     */
    @Override
    public AuthorityVo authMngDetail(AuthorityVo authorityVo) {
        AuthorityVo aVo = authorityRepository.authMngDetail(authorityVo);

        if (aVo == null) {
            throw new RuntimeException(String.format("조회된 관리자 정보가 존재하지 않습니다. [admSeq : \"%d\"]", authorityVo.getAdmSeq()));
        }

        if ("VW".equals(aVo.getAuthType())) {
            if ("VW".equals(SessionUtils.getUser().getAuthType())) {
                if (Integer.parseInt(SessionUtils.getUser().getAdmSeq().toString()) == Integer.parseInt(aVo.getAdmSeq().toString())) {
                    aVo.setFlag(2);
                } else {
                    aVo.setFlag(0);
                }
            } else {
                aVo.setFlag(1);
            }
        } else {
            if ("VW".equals(SessionUtils.getUser().getAuthType())) {
                aVo.setFlag(3);
            } else {
                if (Integer.parseInt(SessionUtils.getUser().getAdmSeq().toString()) == Integer.parseInt(aVo.getAdmSeq().toString())) {
                    aVo.setFlag(5);
                } else {
                    aVo.setFlag(4);
                }
            }

        }
        return aVo;
    }

    /**
     * 권한관리/상세 AuthMap정보
     *
     * @param aVo
     * @return
     */
    @Override
    public List<AuthExhibMapVo> authExhMapDetail(AuthorityVo aVo) {
        return authorityRepository.authExhMapDetail(aVo);
    }

    /**
     * 권한관리/상세 authVo업데이트
     *
     * @param authorityVo
     * @return
     */
    @Override
    public int authUpdate(AuthorityVo authorityVo) {
        authorityVo.setUpdUser(SessionUtils.getUser().getUsername());
        return authorityRepository.authUpdate(authorityVo);
    }

    /**
     * 권한관리/상세 AuthMap업데이트
     *
     * @param authExhibMapVo
     * @return
     */
    @Override
    public int updateExhMap(AuthExhibMapVo authExhibMapVo) {
        authExhibMapVo.setUpdUser(SessionUtils.getUser().getUsername());
        return authorityRepository.updateExhMap(authExhibMapVo);
    }

    /**
     * 권한관리/상세 AuthMap등록
     *
     * @param authExhibMapVo
     * @return
     */
    @Override
    public int registeExhMap(AuthExhibMapVo authExhibMapVo) {
        authExhibMapVo.setUpdUser(SessionUtils.getUser().getUsername());
        return authorityRepository.registeExhMap(authExhibMapVo);
    }

    /**
     * 권한관리/상세 비밀번호 초기화
     *
     * @param authority
     * @return
     */
    @Override
    public int authPwdReset(AuthorityVo authority) {
        String password = authority.getId() + "_" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"))+"!";
        String pwd = standardPasswordEncoder.encode(password);
        authority.setPwd(pwd);
        return authorityRepository.authPwdChange(authority);
    }

    /**
     * 권한관리/상세 비밀번호 변경
     *
     * @param authority
     * @return
     */
    @Override
    public int authPwdChange(AuthorityVo authority) {
        String password = standardPasswordEncoder.encode(authority.getPwd());
        authority.setPwd(password);
        return authorityRepository.authPwdChange(authority);
    }

    /**
     * 권한관리/등록 그룹관리자 권한 select
     * @param admSeq
     * @return
     */
    @Override
    public List<BranchVo> selectAuthExhibList(Long admSeq) {
        return authorityRepository.selectAuthExhibList(admSeq);
    }
}
