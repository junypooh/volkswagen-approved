package kr.co.vwa.web.controller;

import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.domain.FaqVo;
import kr.co.vwa.services.IFaqService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;
/**
 * 자주묻는질문/FRONT Controller
 */
@Controller
@Slf4j
@RequestMapping("/faq")
public class FaqController {

    @Autowired
    private IFaqService faqService;

    /**
     * 자주 묻는 질문
     * @param model
     * @param searchParam
     */
    @RequestMapping("/list")
    @WebLogInfo(menuPath = "자주 묻는 질문")
    public void faqList(Model model, @RequestParam Map<String, Object> searchParam){

        //유형 그룹핑
        List<FaqVo> faqTypeList = faqService.selectFaqTypeList();
        model.addAttribute("faqTypeList", faqTypeList);

        //고정여부에 따라 faq리스트 따로 조회
        searchParam.put("fixYn", "Y");
        List<FaqVo> faqFixYList = faqService.selectFrontFaqList(searchParam);
        model.addAttribute("faqFixYList", faqFixYList);

        searchParam.put("fixYn", "N");
        List<FaqVo> faqFixNList = faqService.selectFrontFaqList(searchParam);
        model.addAttribute("faqFixNList", faqFixNList);
        model.addAttribute("searchParam", searchParam);
    }
}
