package kr.co.vwa.repository;

import kr.co.vwa.domain.BranchVo;
import kr.co.vwa.domain.EmailVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 전시장관리 repository
 */
@Repository
public interface BranchRepository {

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
     * @param branch
     * @return
     */
    int updateExpsdNo(BranchVo branch);

    /**
     * 전시장관리/등록 전시장정보등록
     * @param branch
     * @return
     */
    int registeBranch(BranchVo branch);

    /**
     * 전시장관리/등록 이메일리스트등록
     * @param emailList
     * @return
     */
    int registeEmailList(List<EmailVo> emailList);

    /**
     * 전시장관리/등록 IP리스트 등록
     * @param branch
     * @return
     */
    int registeIpList(BranchVo branch);

    /**
     * 전시장관리/등록 IP리스트 삭제
     * @param branch
     */
    void deleteIpList(BranchVo branch);

    /**
     * 전시장관리/상세 전시장정보조회
     * @param seq
     * @return
     */
    BranchVo selectOneBranch(Integer seq);

    /**
     * 전시장관리/상세 전시장정보수정
     * @param branch
     * @return
     */
    int updateBranch(BranchVo branch);

    /**
     * 전시장관리/상세 전시장정보삭제
     * @param branch
     * @return
     */
    int deleteBranch(BranchVo branch);

    /**
     * 전시장관리/상세 전시장의 이메일리스트삭제
     * @param branch
     * @return
     */
    int deleteEmail(BranchVo branch);

    /**
     * 전시장관리/상세 전시장의 IP 리스트삭제
     * @param branch
     * @return
     */
    int deleteIpAddress(BranchVo branch);

    /**
     * 전시장관리/상세 전시장 이메일 upsert
     * @param email
     * @return
     */
    int upsertEmail(EmailVo email);

    /**
     * 전시장관리/프론트 그룹정보
     * @param searchParam
     * @return
     */
    List<BranchVo> groupBranchList(Map<Object, Object> searchParam);
}
