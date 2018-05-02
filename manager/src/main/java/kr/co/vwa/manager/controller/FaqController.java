package kr.co.vwa.manager.controller;

import kr.co.vwa.domain.FaqVo;
import kr.co.vwa.services.IFaqService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 자주하는질문관리/Back Controller
 */
@Controller
@Slf4j
@RequestMapping("/faq")
public class FaqController {

    @Autowired
    private IFaqService faqService;

    /**
     * 자주하는질문관리/목록
     * @param model
     * @param searchParam
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping("/list")
    public void faqList(Model model, @RequestParam Map<String, Object> searchParam){

        //고정여부에 따라 faq리스트 따로 조회
        searchParam.put("fixYn", "Y");
        List<FaqVo> faqFixYList = faqService.selectFaqList(searchParam);
        model.addAttribute("faqFixYList", faqFixYList);

        searchParam.put("fixYn", "N");
        List<FaqVo> faqFixNList = faqService.selectFaqList(searchParam);
        model.addAttribute("faqFixNList", faqFixNList);
        model.addAttribute("searchParam", searchParam);
    }

    /**
     * 자주하는질문관리/목록 노출여부 수정
     * @param faq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/expsYnUpdate")
    @ResponseBody
    public int expsYnUpdate(FaqVo faq){
        int result = faqService.updateExpsYn(faq);
        return result;
    }

    /**
     * 자주하는질문관리/목록 정렬저장
     * @param index
     * @param faqSeq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/updateExpsdNo")
    @ResponseBody
    public int updateExpsdNo(Integer[] index, Integer[] faqSeq){
        return faqService.updateExpsdNo(index, faqSeq);
    }

    /**
     * 자주하는질문관리/등록
     * @param model
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @GetMapping("/detail")
    public void faqRegiste(Model model){
        FaqVo faq = new FaqVo();
        int faqFixYCount = faqService.selectFaqFixYCount(faq);
        model.addAttribute("faq", faq);
        model.addAttribute("faqFixYCount", faqFixYCount);
    }

    /**
     * 자주하는질문관리/상세
     * @param model
     * @param faq
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @GetMapping("/detail/{faqSeq}")
    public String faqDetail(Model model, FaqVo faq){
        faq = faqService.selectFaq(faq);
        int faqFixYCount = faqService.selectFaqFixYCount(faq);
        model.addAttribute("faq", faq);
        model.addAttribute("faqFixYCount", faqFixYCount);

        return "faq/detail";
    }

    /**
     * 자주하는질문관리/상세 저장
     * @param faq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/saveFaq")
    @ResponseBody
    public FaqVo saveFaq(FaqVo faq){

        String originCont = StringEscapeUtils.unescapeHtml3(faq.getCtnt());
        faq.setCtnt(originCont);
        if(faq.getFaqSeq() != null && faq.getFaqSeq() != 0) {
            faq = faqService.updateFaq(faq);
        } else {

            faq = faqService.insertFaq(faq);
        }

        return faq;
    }

    /**
     * 자주하는질문관리/상세 삭제
     * @param faq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/deleteFaq")
    @ResponseBody
    public int deleteFaq(FaqVo faq){
        return faqService.deleteFaq(faq);
    }

}
