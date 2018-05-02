package kr.co.vwa.repository;

import kr.co.vwa.domain.TagVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 태그관리 repository
 */
@Repository
public interface TagRepository {

    /**
     * 태그관리 목록/GET방식
     * @param map
     * @return
     */
    List<TagVo> tagMngList(Map map);

    /**
     * 태그관리 목록/등록
     * @param tagVo
     */
    int registeTagMng(TagVo tagVo);

    /**
     * 태그관리/목록 편집저장
     * @param tagVo
     */
    int updateTagMng(TagVo tagVo);

    /**
     * 태그관리/목록 정렬저장
     * @param tagVo
     */
    int updateTagMngOrdNo(TagVo tagVo);

}
