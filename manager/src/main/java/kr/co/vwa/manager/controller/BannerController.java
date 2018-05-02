package kr.co.vwa.manager.controller;

import kr.co.vwa.common.util.PageUtil;
import kr.co.vwa.domain.BannerVo;
import kr.co.vwa.services.BannerService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * 배너관리 컨트롤러
 */
@Controller
@Slf4j
@RequestMapping("banner")
public class BannerController {

    @Autowired
    private BannerService bannerService;

    @Autowired
    private PageUtil pageUtil;

    @Value("${s3.url}")
    private String fileUrlPath;

    /**
     * 배너관리/목록 GET방식
     * @param model
     * @param searchParam
     */
    @RequestMapping("/list")
    public void bannerList(Model model,@RequestParam Map<String, Object> searchParam) {
        List<BannerVo> list=bannerService.bannerList(searchParam);
        model.addAttribute("searchParam",searchParam);
        model.addAttribute("list",list);
    }

    /**
     * 배너관리/목록 노출여부
     * @param model
     * @param bannerVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/bannerExpsYnUpdate")
    public int bannerExpsYnUpdate(Model model,BannerVo bannerVo) {
        return bannerService.bannerExpsYnUpdate(bannerVo);
    }

    /**
     * 배너관리/목록 정렬저장
     * @param model
     * @param bannerSeq
     * @param ordNo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/updateBannerOrdNo")
    public int updateBannerOrdNo(Model model,Integer[] bannerSeq, Integer[] ordNo) {
        return bannerService.updateBannerOrdNo(bannerSeq,ordNo);
    }

    /**
     * 배너관리/등록폼 이동 GET방식
     * @param model
     * @return
     */
    @GetMapping(value = "/registeForm")
    public String registeForm(Model model) {
        BannerVo bannerVo=bannerService.bannerFormVo();
        model.addAttribute("bannerVo",bannerVo);
        return "banner/detail";
    }

    /**
     * 배너관리/등록 POST방식
     * @param model
     * @param bannerVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/registe")
    public int bannerRegiste(Model model,BannerVo bannerVo) {
        BannerVo bannerVo1=bannerService.bannerRegiste(bannerVo);
        return bannerVo1.getBannerSeq();
    }

    /**
     * 배너관리/편집폼 이동 GET방식
     * @param model
     * @param bannerVo
     * @return
     */
    @GetMapping(value = "/detail/{bannerSeq}")
    public String bannerdetail(Model model,BannerVo bannerVo) {
        BannerVo bannerVo1=bannerService.bannerDetailVo(bannerVo);
        model.addAttribute("bannerVo",bannerVo1);
        return "banner/detail";
    }

    /**
     * 배너관리/편집 POST방식
     * @param model
     * @param bannerVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/updateBanner")
    public int updateBanner(Model model,BannerVo bannerVo) {
        bannerService.updateBanner(bannerVo);
        return bannerVo.getBannerSeq();
    }

    /**
     * 배너관리/삭제
     * @param model
     * @param bannerVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/bannerDelete")
    public int bannerDelete(Model model,BannerVo bannerVo) {
        return bannerService.bannerDelete(bannerVo);
    }
}
