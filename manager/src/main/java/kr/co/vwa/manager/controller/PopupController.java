package kr.co.vwa.manager.controller;

import kr.co.vwa.common.util.PageUtil;
import kr.co.vwa.domain.PopupVo;
import kr.co.vwa.services.IPopupService;
import kr.co.vwa.services.PopupService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 팝업관리 컨트롤러
 */
@Controller
@Slf4j
@RequestMapping("popup")
public class PopupController {

    @Autowired
    private IPopupService popupService;

    @Autowired
    private PageUtil pageUtil;

    /**
     * 팝업 관리/목록 GET방식
     * @param model
     * @param searchParam
     */
    @RequestMapping("/list")
    public void popupList(Model model,@RequestParam Map<String, Object> searchParam) {
        //limit 설정을 위한 로직
        int currPage = searchParam.get("currPage") == null ? 1 : Integer.parseInt((String)searchParam.get("currPage"));
        int limitRow = (currPage - 1) * pageUtil.getDefaultContentsCount();
        searchParam.put("currPage", currPage);
        searchParam.put("limitRow", limitRow);
        searchParam.put("defaultContentsCount", pageUtil.getDefaultContentsCount());

        List<PopupVo> list=popupService.popupList(searchParam);
        int totalCount = popupService.popupTotalCount(searchParam);
        String pageHtml = pageUtil.makePageHtml(totalCount, currPage);

        int popupExpsYCount = popupService.popupExpsYCount((Integer) searchParam.get("popupSeq"));

        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageHtml", pageHtml);
        model.addAttribute("searchParam",searchParam);
        model.addAttribute("list",list);
        model.addAttribute("popupExpsYCount", popupExpsYCount);
    }

    /**
     * 팝업 관리/목록 노출여부
     * @param model
     * @param popupVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/popupExpsYnUpdate")
    public int popupExpsYnUpdate(Model model,PopupVo popupVo) {
        return popupService.popupExpsYnUpdate(popupVo);
    }

    /**
     * 팝업 관리/목록 등록폼이동
     * @param model
     * @return
     */
    @GetMapping(value = "/registeForm")
    public String popupRegisteForm(Model model) {
        PopupVo popupVo=popupService.popupFormVo();
        int popupExpsYCount = popupService.popupExpsYCount(popupVo.getPopupSeq());
        model.addAttribute("popupVo",popupVo);
        model.addAttribute("popupExpsYCount", popupExpsYCount);
        return "popup/detail";
    }

    /**
     * 팝업 관리/등록 POST방식
     * @param model
     * @param popupVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/popupRegiste")
    public int popupRegiste(Model model,PopupVo popupVo) {
        PopupVo popupVo1=popupService.popupRegiste(popupVo);
        return popupVo1.getPopupSeq();
    }

    /**
     * 팝업 관리/편집 GET방식
     * @param model
     * @param popupVo
     * @return
     */
    @GetMapping(value = "/detail/{popupSeq}")
    public String popupdetail(Model model,PopupVo popupVo) {
        PopupVo popupVo1=popupService.popupDetailVo(popupVo);
        int popupExpsYCount = popupService.popupExpsYCount(popupVo1.getPopupSeq());
        model.addAttribute("popupVo",popupVo1);
        model.addAttribute("popupExpsYCount", popupExpsYCount);
        return "popup/detail";
    }

    /**
     * 팝업 관리/편집저장
     * @param model
     * @param popupVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/updatePopup")
    public int updatePopup(Model model,PopupVo popupVo) {
        popupService.updatePopup(popupVo);
        return popupVo.getPopupSeq();
    }

    /**
     * 팝업 관리/삭제
     * @param model
     * @param popupVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/popupDelete")
    public int popupDelete(Model model,PopupVo popupVo) {
        return popupService.popupDelete(popupVo);
    }

}
