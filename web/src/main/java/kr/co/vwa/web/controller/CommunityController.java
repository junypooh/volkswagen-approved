package kr.co.vwa.web.controller;

import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.domain.CommunityVo;
import kr.co.vwa.services.ICommunityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
/**
 * 커뮤니티/FRONT Controller
 */
@Controller
@Slf4j
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private ICommunityService communityService;


    /**
     * 커뮤니티/목록
     * @param model
     * @param searchParam
     */
    @RequestMapping("/list")
    @WebLogInfo(menuPath = "커뮤니티")
    public void communityList(Model model, @RequestParam Map<String, Object> searchParam){

        //유형 그룹핑
        List<CommunityVo> communityTypeList = communityService.selectCommunityTypeList();
        model.addAttribute("communityTypeList", communityTypeList);

        Map<String, Object> resultMap = communityService.selectFrontCommunityList(searchParam);

        model.addAttribute("result", resultMap);
        model.addAttribute("searchParam", searchParam);
    }

    /**
     * 커뮤니티 상세
     * @param model
     * @param commSeq
     */
    @GetMapping("/detail/{commSeq}")
    @WebLogInfo(menuPath = "커뮤니티 > 상세")
    public String communityDetail(Model model, @PathVariable("commSeq") Integer commSeq){
        Map<String, Object> resultMap = communityService.selectFrontCommunity(commSeq);

        model.addAttribute("result", resultMap);
        return "community/detail";
    }

}
