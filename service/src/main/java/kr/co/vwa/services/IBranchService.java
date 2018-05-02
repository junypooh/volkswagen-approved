package kr.co.vwa.services;

import kr.co.vwa.domain.BranchVo;
import kr.co.vwa.domain.EmailVo;

import java.util.List;
import java.util.Map; /**
 * 전시장관리 서비스 인터페이스
 */
public interface IBranchService {

    /**
     * 전시장관리/목록 전시장 리스트 조회
     * @param searchParam
     * @return
     */
    List<BranchVo> selectBranchList(Map<Object, Object> searchParam);

    /**
     * 전시장관리/목록 노출여부 수정
     * @param branch
     * @return
     */
    int updateExpsYn(BranchVo branch);

    /**
     * 전시장관리/목록 정렬저장
     * @param index
     * @param exhHallSeq
     * @return
     */
    int updateExpsdNo(Integer[] index, Integer[] exhHallSeq);

    /**
     * 전시장관리/등록 전시장정보등록
     * @param branch
     * @param email
     * @return
     */
    BranchVo registeBranch(BranchVo branch, EmailVo email);

    /**
     * 전시장관리/상세 전시장정보조회
     * @param seq
     * @return
     */
    Map<String, Object> selectOneBranch(Integer seq);

    /**
     * 전시장관리/상세 전시장정보수정
     * @param branch
     * @param email
     * @return
     */
    BranchVo updateBranch(BranchVo branch, EmailVo email);

    /**
     * 전시장관리/상세 전시장정보삭제
     * @param branch
     * @param email
     * @return
     */
    int deleteBranch(BranchVo branch, EmailVo email);

    /**
     * 전시장관리/프론트 그룹정보
     * @param searchParam
     * @return
     */
    List<BranchVo> groupBranchList(Map<Object, Object> searchParam);
}
