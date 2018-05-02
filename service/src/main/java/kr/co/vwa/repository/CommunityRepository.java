package kr.co.vwa.repository;

import kr.co.vwa.domain.CommunityVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 커뮤니티 Repository
 */
@Repository
public interface CommunityRepository {

    /**
     * 커뮤니티관리/목록 커뮤니티목록 조회
     * @param searchParam
     * @return
     */
    List<CommunityVo> selectCommunityList(Map<String, Object> searchParam);

    /**
     * 커뮤니티관리/목록 노출여부 수정
     * @param community
     * @return
     */
    int updateExpsYn(CommunityVo community);

    /**
     * 커뮤니티관리/목록 정렬저장
     * @param comm
     */
    void updateCommNo(CommunityVo comm);


    /**
     * 커뮤니티관리/상세 커뮤니티정보 등록
     * @param community
     * @return
     */
    int insertCommunity(CommunityVo community);

    /**
     * 커뮤니티관리/상세 커뮤니티정보 조회
     * @param community
     * @return
     */
    CommunityVo selectCommunity(CommunityVo community);

    /**
     * 커뮤니티관리/상세 커뮤니티정보 수정
     * @param community
     * @return
     */
    int updateCommunity(CommunityVo community);

    /**
     * 커뮤니티관리/상세 커뮤니티정보 삭제
     * @param community
     * @return
     */
    int deleteCommunity(CommunityVo community);

    /**
     * front 커뮤니티/목록 목록 전체 수
     * @param searchParam
     * @return
     */
    int selectFrontCommunityListCount(Map<String, Object> searchParam);

    /**
     * front 커뮤니티/목록 목록 조회
     * @param searchParam
     * @return
     */
    List<CommunityVo> selectFrontCommunityList(Map<String, Object> searchParam);

    /**
     * front 커뮤니티/상세 이전글, 다음글 조회
     * @param community
     * @return
     */
    CommunityVo selectPrevNextCommunity(CommunityVo community);

    /**
     * 커뮤니티/상세, 등록 상단고정게시물 수
     * @return
     */
    int selectCommunityFixYCount(CommunityVo community);

    /**
     * front 커뮤니티/목록 최신업데이트순 커뮤니티 목록 조회
     * @return
     */
    List<CommunityVo> selectNewCommunityList();

    /**
     * 커뮤니티관리/상세 상단고정이 아닌게시물 정렬순서 +1
     */
    void updateCommOrdNo();

    /**
    * front 커뮤니티/목록 목록 유형 그룹핑
    * @return
    */
    List<CommunityVo> selectCommunityTypeList();
}
