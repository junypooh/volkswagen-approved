package kr.co.vwa.services;

import kr.co.vwa.domain.CommunityVo;

import java.util.List;
import java.util.Map;

/**
 * 커뮤니티 Interface
 */
public interface ICommunityService {

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
     * 자주하는질문관리/목록 정렬저장
     * @param index
     * @param commSeq
     * @return
     */
    int updateCommNo(Integer[] index, Integer[] commSeq);

    /**
     * 커뮤니티관리/상세 커뮤니티정보 등록
     * @param community
     * @return
     */
    CommunityVo insertCommunity(CommunityVo community);

    /**
     * 커뮤니티관리/상세 커뮤니티정보 조회
     * @param community
     * @return
     */
    CommunityVo selectCommunity(CommunityVo community);

    /**
     * 커뮤티니관리/상세 커뮤니티정보 수정
     * @param community
     * @return
     */
    CommunityVo updateCommunity(CommunityVo community);

    /**
     * 커뮤니티관리/상세 커뮤니티정보 삭제
     * @param community
     * @return
     */
    int deleteCommunity(CommunityVo community);

    /**
     * front 커뮤니티/목록 커뮤니티 목록 조회
     * @param searchParam
     * @return
     */
    Map<String,Object> selectFrontCommunityList(Map<String, Object> searchParam);

    /**
     * front 커뮤니티/상세 커뮤니티정보 조회
     * @param commSeq
     * @return
     */
    Map<String,Object> selectFrontCommunity(Integer commSeq);

    /**
     * 커뮤니티/상세, 등록 상단고정게시물 수
     * @return
     */
    int selectCommunityFixYCount(CommunityVo community);

    /**
     * front 커뮤니티 유형 그룹핑
     * @return
     */
    List<CommunityVo> selectCommunityTypeList();
}
