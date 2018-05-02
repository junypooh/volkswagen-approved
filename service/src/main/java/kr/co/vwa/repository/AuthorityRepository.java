package kr.co.vwa.repository;

import kr.co.vwa.domain.AuthorityVo;
import kr.co.vwa.domain.AuthExhibMapVo;
import kr.co.vwa.domain.BranchVo;
import kr.co.vwa.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 권한관리 repository
 */
@Repository
public interface AuthorityRepository {

    /**
     * 권한관리/목록 관리자 전체 개수 조회
     * @param searchParam
     * @return
     */
    int selectAuthListTotalCount(Map<String, Object> searchParam);

    /**
     * 권한관리/목록 관리자 전체 조회
     * @param searchParam
     * @return
     */
    List<AuthorityVo> authListSelect(Map<String, Object> searchParam);

    /**
     * 권한관리/등록 관리자 정보 등록
     * @param authorityVo
     * @return
     */
    int registeAuthority(AuthorityVo authorityVo);

    /**
     * 권한관리/등록 관리자 max 시퀀스조회
     * @return
     */
    int selectMaxAdmSeq();

    /**
     * 관한관리/등록 관리자-전시장 매핑 등록
     * @param authExhibMapList
     * @return
     */
    int registeAuthExhMapList(List<AuthExhibMapVo> authExhibMapList);

    List<BranchVo> selectExhibList();

    /**
     * 권한관리/상세 authVo정보
     * @param authorityVo
     * @return
     */
    AuthorityVo authMngDetail(AuthorityVo authorityVo);

    /**
     * 권한관리/상세 AuthMap정보
     * @param aVo
     * @return
     */
    List<AuthExhibMapVo> authExhMapDetail(AuthorityVo aVo);

    /**
     * 권한관리/상세 authVo업데이트
     * @param authorityVo
     * @return
     */
    int authUpdate(AuthorityVo authorityVo);

    /**
     * 권한관리/상세 AuthMap업데이트
     * @param authExhibMapVo
     * @return
     */
    int updateExhMap(AuthExhibMapVo authExhibMapVo);

    /**
     * 권한관리/상세 AuthMap등록
     * @param authExhibMapVo
     * @return
     */
    int registeExhMap(AuthExhibMapVo authExhibMapVo);

    /**
     * 권한관리/상세 비밀번호 변경
     * @param authority
     * @return
     */
    int authPwdChange(AuthorityVo authority);

    /**
     * 권한관리/등록 그룹관리자 권한 select
     * @param admSeq
     * @return
     */
    List<BranchVo> selectAuthExhibList(Long admSeq);
}
