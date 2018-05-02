package kr.co.vwa.manager.controller;


import kr.co.vwa.domain.OptionVo;
import kr.co.vwa.services.IMajorOptionService;
import kr.co.vwa.services.IOptionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 옵션관리 컨트롤러
 */
@Controller
@Slf4j
@RequestMapping("option")
public class OptionController {

    @Autowired
    private IOptionService iOptionService;

    @Resource(name = "majorOptionService")
    IMajorOptionService majorOptionSerivce;

    /**
     * 옵션관리/목록 GET방식
     * @param model
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @GetMapping(value = "/list")
    public void optMngList(Model model, @RequestParam Map<String, String> searchParam) {
        List<OptionVo> cList = iOptionService.optMngList(null, searchParam.get("vwYn"));
        List<OptionVo> majorOptionList = majorOptionSerivce.selectMajorOptionList(searchParam);
        model.addAttribute("majorOptionList", majorOptionList);
        model.addAttribute("cList", cList);
    }

    /**
     * 옵션관리/등록
     * @param optionVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping(value = "/registeOptMng")
    @ResponseBody
    public int registeOptMng(OptionVo optionVo) {
        return iOptionService.registeOptMng(optionVo);
    }

    /**
     * 옵션관리/노출 편집
     * @param optionVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping(value = "/optExpUpdate")
    @ResponseBody
    public int optExpUpdate(OptionVo optionVo) {
        return iOptionService.optExpUpdate(optionVo);
    }

    /**
     * 옵션관리/편집저장
     * @param optionVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping(value = "/updateOptMng")
    @ResponseBody
    public int updateOptMng(OptionVo optionVo) {
        return iOptionService.updateOptMng(optionVo);
    }

    /**
     * 옵션관리/정렬저장
     * @param seq
     * @param ordNo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping(value = "/updateOptMngOrdNo")
    @ResponseBody
    public int updateOptMngOrdNo(Integer[] seq, Integer[] ordNo) {
        return iOptionService.updateOptMngOrdNo(seq,ordNo);
    }

    /**
     * 옵션관리/삭제
     * @param optionVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping(value = "/optDelete")
    @ResponseBody
    public int optDelete(OptionVo optionVo) {
        return iOptionService.optDelete(optionVo);
    }

    /**
     * 옵션관리/목록중의 한그룹
     * @param optionVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping(value = "/optMngVo")
    @ResponseBody
    public List<OptionVo> optMngVo(OptionVo optionVo) {
        return iOptionService.optMngVo(optionVo);
    }
}
