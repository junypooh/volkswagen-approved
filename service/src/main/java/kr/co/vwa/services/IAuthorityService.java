package kr.co.vwa.services;

import kr.co.vwa.domain.AuthExhibMapVo;
import kr.co.vwa.domain.AuthorityVo;
import kr.co.vwa.domain.BranchVo;
import kr.co.vwa.domain.User;

import java.util.List;

import java.util.Map;

/**
 * 권한관리 Interface
 */
public interface IAuthorityService {

    /**
     * 권한관리/목록 관리자 전체 개수 조회
     * @param searchParam
     * @return
     */
    int selectAuthListTotalCount(Map<String, Object> searchParam);

    /**
     * 권한관리/목록 코드값에 따른 관리자 조회
     * @param searchParam
     * @return
     */
    List<AuthorityVo> authListSelect(Map<String, Object> searchParam);

    /**
     * 권한관리/수정 관리자-전시장 매핑 전체조회
     * @return
     */
    List<BranchVo> selectExhibList();

    /**
     * 권한관리/등록 관리자 등록
     * @param authorityVo
     * @return
     */
    int registeAuthority(AuthorityVo authorityVo);

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
     * 권한관리/상세 비밀번호 초기화
     * @param authority
     * @return
     */
    int authPwdReset(AuthorityVo authority);

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
