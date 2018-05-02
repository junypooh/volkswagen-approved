package kr.co.vwa.manager.controller;

import kr.co.vwa.common.util.PageUtil;
import kr.co.vwa.domain.CommunityVo;
import kr.co.vwa.domain.User;
import kr.co.vwa.services.ICommunityService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 커뮤니티/Back Controller
 */
@Controller
@Slf4j
@RequestMapping("community")
public class CommunityController {

    @Autowired
    private ICommunityService communityService;

    /**
     * 커뮤니티관리/목록
     * @param model
     * @param searchParam
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping("/list")
    public void communityList(Model model, @RequestParam  Map<String, Object> searchParam){

        //고정여부에 따라 커뮤니티리스트 따로 조회
        searchParam.put("fixYn", "Y");
        List<CommunityVo> communityFixYList = communityService.selectCommunityList(searchParam);
        model.addAttribute("communityFixYList", communityFixYList);

        searchParam.put("fixYn", "N");
        List<CommunityVo> communityFixNList = communityService.selectCommunityList(searchParam);
        model.addAttribute("communityFixNList", communityFixNList);
        model.addAttribute("searchParam", searchParam);
    }

    /**
     * 커뮤니티관리/목록 노출여부 수정
     * @param community
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/expsYnUpdate")
    @ResponseBody
    public int expsYnUpdate(CommunityVo community){
        int result = communityService.updateExpsYn(community);
        return result;
    }

    /**
     * 커뮤니티관리/목록 정렬저장
     * @param index
     * @param commSeq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/updateCommNo")
    @ResponseBody
    public int updateCommNo(Integer[] index, Integer[] commSeq){

        return communityService.updateCommNo(index, commSeq);

    }

    /**
     * 커뮤니티관리/등록
     * @param model
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @GetMapping("/detail")
    public void communityRegiste(Model model){
        CommunityVo community = new CommunityVo();
        int fixYCount = communityService.selectCommunityFixYCount(community);
        model.addAttribute("community", community);
        model.addAttribute("fixYCount", fixYCount);
    }

    /**
     * 커뮤니티관리/상세
     * @param model
     * @param community
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @GetMapping("/detail/{commSeq}")
    public String communityDetail(Model model, CommunityVo community){
        community = communityService.selectCommunity(community);
        int fixYCount = communityService.selectCommunityFixYCount(community);
        model.addAttribute("community", community);
        model.addAttribute("fixYCount", fixYCount);
        return "community/detail";
    }

    /**
     * 커뮤니티관리/상세 커뮤니티정보 저장
     * @param community
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/saveCommunity")
    @ResponseBody
    public CommunityVo saveCommunity(CommunityVo community){

        String originCont = StringEscapeUtils.unescapeHtml3(community.getCtnt());
        community.setCtnt(originCont);

        if(community.getCommSeq() != null && community.getCommSeq() != 0) {
            community = communityService.updateCommunity(community);
        } else {
            community = communityService.insertCommunity(community);
        }

        return community;
    }

    /**
     * 커뮤티니관리/상세 커뮤니티정보 삭제
     * @param community
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/deleteCommunity")
    @ResponseBody
    public int deleteCommunity(CommunityVo community){
        return communityService.deleteCommunity(community);
    }

}
