package kr.co.vwa.manager.controller;

import kr.co.vwa.domain.OptionVo;
import kr.co.vwa.services.IMajorOptionService;
import kr.co.vwa.services.IUploadService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 주요옵션관리 Controller
 */
@Controller
@Slf4j
@RequestMapping("majoropt")
public class MajorOptionController {

    @Resource(name = "majorOptionService")
    IMajorOptionService majorOptionSerivce;

    @Autowired
    private IUploadService iUploadService;

    /**
     * 주요옵션관리/목록 GET방식
     * @param model
     * @param searchParam
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping("/list")
    public String majorOptionList(Model model, @RequestParam Map<String, String> searchParam){

        List<OptionVo> majorOptionList = majorOptionSerivce.selectMajorOptionList(searchParam);

        model.addAttribute("searchParam", searchParam);
        model.addAttribute("majorOptionList", majorOptionList);
        return "majoropt/majoroptList";
    }

    /**
     * 주요옵션관리/목록 편집저장
     * @param optionVo
     * @return
     */
    @PostMapping("/update")
    @ResponseBody
    public int updateMajorOption(OptionVo optionVo){
        return majorOptionSerivce.updateMajorOption(optionVo);
    }

    /**
     * 주요옵션관리/목록 정렬저장
     * @param index
     * @param optSeq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/updateMajOrdNo")
    @ResponseBody
    public int updateMajOrdNo(Integer[] index, Integer[] optSeq){

        int result = majorOptionSerivce.updateMajorOrdNo(index, optSeq);

        return result;
    }
}
