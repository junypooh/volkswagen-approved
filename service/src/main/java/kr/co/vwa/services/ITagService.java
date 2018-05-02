package kr.co.vwa.services;

import kr.co.vwa.domain.TagVo;
import kr.co.vwa.domain.User;

import java.util.List;
import java.util.Map;

/**
 * Created by hyeongju on 2018-01-15.
 * 태그관리 Interface
 */
public interface ITagService {

    /**
     * 태그관리/목록 GET방식
     * @param map
     * @return
     */
    List<TagVo> tagMngList(Map map);

    /**
     * 태그관리/목록 등록
     * @param tagVo
     * @return
     */
    int registeTagMng(TagVo tagVo);

    /**
     * 태그관리/목록 편집저장
     * @param tagVo
     * @return
     */
    int updateTagMng(TagVo tagVo);

    /**
     * 태그관리/목록 정렬저장
     * @param ordNo
     * @param tagSeq
     * @return
     */
    int updateTagMngOrdNo(Integer[] ordNo, Integer[] tagSeq);
}
