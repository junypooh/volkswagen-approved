package kr.co.vwa.services;

import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.CommunityVo;
import kr.co.vwa.repository.CommunityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 커뮤니티 Service
 */
@Service
public class CommunityService implements ICommunityService {

    @Autowired
    private CommunityRepository communityRepository;

    @Value("${s3.url}")
    private String fileUrlPath;

    /**
     * 커뮤니티관리/목록 커뮤니티목록 조회
     * @param searchParam
     * @return
     */
    @Override
    public List<CommunityVo> selectCommunityList(Map<String, Object> searchParam) {
        searchParam.put("fileUrlPath", fileUrlPath);
        return communityRepository.selectCommunityList(searchParam);
    }

    /**
     * 커뮤니티관리/목록 노출여부 수정
     * @param community
     * @return
     */
    @Override
    public int updateExpsYn(CommunityVo community) {
        community.setUpdUser(SessionUtils.getUser().getUsername());
        return communityRepository.updateExpsYn(community);
    }

    /**
     * 커뮤니티관리/목록 정렬저장
     * @param index
     * @param commSeq
     * @return
     */
    @Override
    public int updateCommNo(Integer[] index, Integer[] commSeq) {

        for (int i = 0; i < index.length; i++){
            CommunityVo comm = new CommunityVo();
            comm.setCommSeq(commSeq[i]);
            comm.setOrdNo(index[i]);
            comm.setUpdUser(SessionUtils.getUser().getUsername());
            communityRepository.updateCommNo(comm);
        }

        return index.length;
    }

    /**
     * 커뮤니티관리/상세 커뮤니티정보 등록
     * @param community
     * @return
     */
    @Override
    public CommunityVo insertCommunity(CommunityVo community) {
        //작성자 set
        community.setCreUser(SessionUtils.getUser().getUsername());
        //노출여부 set
        community.setExpsYn("Y".equals(community.getExpsYn()) ? "Y" : "N");
        //상단고정여부 set
        community.setFixYn("Y".equals(community.getFixYn()) ? "Y" : "N");

        //상단고정이 아닐경우 다른 게시물의 정렬순서를 +1해준다
        if("N".equals(community.getFixYn())){
            communityRepository.updateCommOrdNo();
        }

        int result = communityRepository.insertCommunity(community);

        return community;
    }

    /**
     * 커뮤니티관리/상세 커뮤니티정보 조회
     * @param community
     * @return
     */
    @Override
    public CommunityVo selectCommunity(CommunityVo community) {
        community.setFileUrlPath(fileUrlPath);

        CommunityVo resultCommunity = communityRepository.selectCommunity(community);

        if(resultCommunity == null) {
            throw new RuntimeException(String.format("조회된 커뮤니티 정보가 존재하지 않습니다. [commSeq : \"%d\"]", community.getCommSeq()));
        }
        return resultCommunity;
    }

    /**
     * 커뮤티니관리/상세 커뮤니티정보 수정
     * @param community
     * @return
     */
    @Override
    public CommunityVo updateCommunity(CommunityVo community) {
        //작성자 set
        community.setUpdUser(SessionUtils.getUser().getUsername());
        //노출여부 set
        community.setExpsYn("Y".equals(community.getExpsYn()) ? "Y" : "N");
        //상단고정여부 set
        community.setFixYn("Y".equals(community.getFixYn()) ? "Y" : "N");

        int result = communityRepository.updateCommunity(community);

        return community;
    }

    /**
     * 커뮤니티관리/상세 커뮤니티정보 삭제
     * @param community
     * @return
     */
    @Override
    public int deleteCommunity(CommunityVo community) {
        community.setUpdUser(SessionUtils.getUser().getUsername());
        return communityRepository.deleteCommunity(community);
    }

    /**
     * front 커뮤니티/목록 커뮤니티 목록 조회
     * @param searchParam
     * @return
     */
    @Override
    public Map<String, Object> selectFrontCommunityList(Map<String, Object> searchParam) {
        Map<String, Object> resultMap = new HashMap<>();

        //상단고정이 아닌 리스트
        int currPage = searchParam.get("currPage") == null ? 1 : Integer.parseInt((String)searchParam.get("currPage")) ;
        int beforeCurrPage = currPage;
        int defaultContentsCount = 0;
        //기존유지되는 검색조건일경우
        if ("Y".equals(searchParam.get("retainYn"))) {
            defaultContentsCount = 9 * currPage;
            currPage = 1;
        } else {
            defaultContentsCount = 9;
        }
        int limitRow = (currPage - 1) * defaultContentsCount;
        //노출여부
        searchParam.put("expsYn", "Y");
        searchParam.put("fixYn", "N");
        //콘텐츠노출개수
        searchParam.put("defaultContentsCount", defaultContentsCount);
        searchParam.put("currPage", currPage);
        searchParam.put("limitRow", limitRow);
        List<CommunityVo> communityFixNList = communityRepository.selectFrontCommunityList(searchParam);

        //더보기 노출을 알기위해 last페이지를 구해야 하기 때문에 컨텐츠개수를 9로 수정
        defaultContentsCount = 9;
        int totalCount = communityRepository.selectFrontCommunityListCount(searchParam);
        int lastPage = (int) Math.ceil((double) totalCount / (double) defaultContentsCount);
        searchParam.put("currPage", beforeCurrPage);

        resultMap.put("communityFixNList", communityFixNList);
        resultMap.put("lastPage", lastPage);
        resultMap.put("totalCount", totalCount);

        //상단고정리스트
        searchParam.put("fixYn", "Y");
        List<CommunityVo> communityFixYList = communityRepository.selectFrontCommunityList(searchParam);

        //상단고정게시물이 3개 미만일 때 최신 게시물을 합쳐서 노출한다.
        if(communityFixYList.size() < 3){
            //최신업데이트순 커뮤니티 목록 조회
            List<CommunityVo> newCommunityList = communityRepository.selectNewCommunityList();
            for (CommunityVo each : newCommunityList) {
                if(communityFixYList.size() == 3) break;
                communityFixYList.add(each);
            }
        }

        resultMap.put("fileUrlPath", fileUrlPath);
        resultMap.put("communityFixYList", communityFixYList);
        return resultMap;
    }

    /**
     * front 커뮤니티/상세 커뮤니티정보 조회
     * @param commSeq
     * @return
     */
    @Override
    public Map<String, Object> selectFrontCommunity(Integer commSeq) {
        Map<String, Object> resultMap = new HashMap<>();
        CommunityVo community = new CommunityVo();
        community.setCommSeq(commSeq);
        community.setFileUrlPath(fileUrlPath);

        CommunityVo resultCommunity = communityRepository.selectCommunity(community);
        if(resultCommunity == null) {
            throw new RuntimeException(String.format("조회된 커뮤니티 정보가 존재하지 않습니다. [commSeq : \"%d\"]", commSeq));
        }

        resultMap.put("community", resultCommunity);
        //이전글
        resultCommunity.setStatus("prev");
        resultMap.put("prevCommunity", communityRepository.selectPrevNextCommunity(resultCommunity));
        //다음글
        resultCommunity.setStatus("next");
        resultMap.put("nextCommunity", communityRepository.selectPrevNextCommunity(resultCommunity));

        return resultMap;
    }

    /**
     * 커뮤니티/상세, 등록 상단고정게시물 수
     * @return
     */
    @Override
    public int selectCommunityFixYCount(CommunityVo community) {
        return communityRepository.selectCommunityFixYCount(community);
    }

    /**
     * front 커뮤니티 유형 그룹핑
     * @return
     */
    @Override
    public List<CommunityVo> selectCommunityTypeList() {
        return communityRepository.selectCommunityTypeList();
    }
}
