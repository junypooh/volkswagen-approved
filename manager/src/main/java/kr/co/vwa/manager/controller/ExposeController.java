package kr.co.vwa.manager.controller;


import kr.co.vwa.domain.CodeVo;
import kr.co.vwa.services.IExposeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * 기간/주기 컨트롤러
 */
@Controller
@Slf4j
@RequestMapping("expose")
public class ExposeController {

    @Autowired
    private IExposeService iExposeService;

    /**
     * 기간/주기 관리 목록
     * @param model
     * @param searchParam
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/list")
    public String exposeMngList(Model model, @RequestParam Map<String, String> searchParam) {
        List<CodeVo> codeVo=iExposeService.exposeMngList(searchParam);
        model.addAttribute("searchParam", searchParam);
        model.addAttribute("list", codeVo);
        return "expose/list";
    }

    /**
     * 기간/주기 관리 수정
     * @param codeVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @ResponseBody
    @PostMapping(value = "/updateExposeMng")
    public int  updateExposeMng(CodeVo codeVo) {
        return iExposeService.updateExposeMng(codeVo);
    }

}
