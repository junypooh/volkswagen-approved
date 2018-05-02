package kr.co.vwa.repository;

import kr.co.vwa.domain.FaqVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 자주하는질문관리 Repository
 */
@Repository
public interface FaqRepository {

    /**
     * 자주하는질문관리/목록 자주하는질문 목록 조회
     * @param searchParam
     * @return
     */
    List<FaqVo> selectFaqList(Map<String, Object> searchParam);

    /**
     * 자주하는질문관리/목록 노출여부 수정
     * @param faq
     * @return
     */
    int updateExpsYn(FaqVo faq);

    /**
     * 자주하는질문관리/목록 정렬저장
     * @param faq
     */
    void updateExpsdNo(FaqVo faq);

    /**
     * 자주하는질문관리/상세 자주하는질문정보 조회
     * @param faq
     * @return
     */
    FaqVo selectFaq(FaqVo faq);

    /**
     * 자주하는질문관리/상세 자주하는질문정보 등록
     * @param faq
     * @return
     */
    int insertFaq(FaqVo faq);

    /**
     * 자주하는질문관리/상세 자주하는질문정보 수정
     * @param faq
     * @return
     */
    int updateFaq(FaqVo faq);

    /**
     * 자주하는질문관리/상세 자주하는질문정보 삭제
     * @param faq
     * @return
     */
    int deleteFaq(FaqVo faq);

    List<FaqVo> selectFrontFaqList(Map<String, Object> searchParam);

    /**
     * 자주하는질문관리/상세, 등록 상단고정게시물 수
     * @return
     */
    int selectFaqFixYCount(FaqVo faq);

    /**
     * front 자주하는질문 유형 그룹핑
     * @return
     */
    List<FaqVo> selectFaqTypeList();
}
