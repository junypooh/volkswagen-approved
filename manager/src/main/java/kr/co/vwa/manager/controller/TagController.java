package kr.co.vwa.manager.controller;

import kr.co.vwa.domain.TagVo;
import kr.co.vwa.services.ITagService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 태그관리 컨트롤러
 */
@Controller
@Slf4j
@RequestMapping("tag")
public class TagController {

    @Autowired
    private ITagService iTagService;

    /**
     * 태그관리/목록 GET방식
     * @param model
     * @param searchParam
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/list")
    public String tagMngList(Model model, @RequestParam Map<String, String> searchParam) {
        List<TagVo> tagVo=iTagService.tagMngList(searchParam);
        model.addAttribute("searchParam",searchParam);
        model.addAttribute("list",tagVo);
        return "tag/list";
    }

    /**
     * 태그관리/목록 등록
     * @param tagVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @ResponseBody
    @PostMapping(value = "/registeTagMng")
    public int  registeTagMng(TagVo tagVo) {
        return iTagService.registeTagMng(tagVo);
    }

    /**
     * 태그관리/목록 편집저장
     * @param tagVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @ResponseBody
    @PostMapping(value = "/updateTagMng")
    public int updateTagMng(TagVo tagVo) {
        return iTagService.updateTagMng(tagVo);
    }

    /**
     * 태그관리/목록 정렬저장
     * @param ordNo
     * @param tagSeq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @ResponseBody
    @PostMapping(value = "/updateTagMngOrdNo")
    public int updateTagMngOrdNo(Integer[] ordNo, Integer[] tagSeq) {
        return iTagService.updateTagMngOrdNo(ordNo,tagSeq);
    }

}
