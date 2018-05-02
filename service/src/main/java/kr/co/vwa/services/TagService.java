package kr.co.vwa.services;

import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.TagVo;
import kr.co.vwa.repository.TagRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

/**
 * 태그관리 서비스
 */
@Service
public class TagService implements ITagService {

    @Autowired
    private TagRepository tagRepository;

    /**
     * 태그관리 목록/GET 방식
     * @param map
     * @return
     */
    @Override
    public List<TagVo> tagMngList(Map map) {
        List<TagVo> tagVo=tagRepository.tagMngList(map);
        return tagVo;
    }

    /**
     * 태그관리/등록
     * @param tagVo
     * @return
     */
    @Override
    public int registeTagMng(TagVo tagVo) {
        tagVo.setUpdUser(SessionUtils.getUser().getUsername());
        return tagRepository.registeTagMng(tagVo);
    }

    /**
     * 태그관리/목록 편집저장
     * @param tagVo
     * @return
     */
    @Override
    public int updateTagMng(TagVo tagVo) {
        tagVo.setUpdUser(SessionUtils.getUser().getUsername());
        return tagRepository.updateTagMng(tagVo);
    }

    /**
     * 태그관리/목록 정렬저장
     * @param ordNo
     * @param tagSeq
     * @return
     */
    @Override
    public int updateTagMngOrdNo(Integer[] ordNo, Integer[] tagSeq) {
        for(int i=0;i<ordNo.length;i++){
            TagVo tagVo=new TagVo();
            tagVo.setUpdUser(SessionUtils.getUser().getUsername());
            tagVo.setOrdNo(ordNo[i]);
            tagVo.setTagSeq(tagSeq[i]);
            tagRepository.updateTagMngOrdNo(tagVo);
        }
        return 1;
    }

}
