package kr.co.vwa.web.controller;

import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.domain.FrontItemVo;
import kr.co.vwa.services.IComparisonService;
import kr.co.vwa.services.IFrontItemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;
/**
 * 비교하기 목록/FRONT Controller
 */
@Controller
@Slf4j
@RequestMapping("comparison")
public class ComparisonController {

    @Autowired
    private IFrontItemService frontItemService;

    @Autowired
    private IComparisonService comparisonService;

    @Value("${s3.url}")
    private String fileUrlPath;

    @Value("${kakao.clientId}")
    private String kakaoClientId;

    @Value("${vwa.front.url}")
    private String vwaFrontUrl;

    /**
     * 비교하기
     * @param model
     * @param firstSellCarSeq
     * @param lastSellCarSeq
     * @param httpServletRequest
     * @return
     */
    @GetMapping(value = "/view/{firstSellCarSeq}/{lastSellCarSeq}")
    @WebLogInfo(menuPath = "비교하기")
    public String view(Model model, @PathVariable("firstSellCarSeq") Long firstSellCarSeq, @PathVariable("lastSellCarSeq") Long lastSellCarSeq, HttpServletRequest httpServletRequest){
        model.addAttribute("firstResult", frontItemService.selectItemDetail(firstSellCarSeq));
        model.addAttribute("lastResult", frontItemService.selectItemDetail(lastSellCarSeq));
        model.addAttribute("fileUrlPath", fileUrlPath);
        model.addAttribute("kakaoClientId", kakaoClientId);
        model.addAttribute("vwaFrontUrl", vwaFrontUrl);
        model.addAttribute("shareUrl", httpServletRequest.getRequestURL().toString());
        return "comparison/view";
    }

    /**
     * 비교하기 메일 공유하기
     * @param itemVo
     * @param httpServletRequest
     * @return
     */
    @PostMapping(value = "share/mail")
    @ResponseBody
    public Object sharMail(FrontItemVo itemVo, HttpServletRequest httpServletRequest){

        Map<String, Object> firstResult = frontItemService.selectItemDetail(itemVo.getFirstSellCarSeq());
        Map<String, Object> lastResult = frontItemService.selectItemDetail(itemVo.getLastSellCarSeq());
        comparisonService.shareContents(firstResult, lastResult, itemVo, httpServletRequest);

        return "";
    }
}
