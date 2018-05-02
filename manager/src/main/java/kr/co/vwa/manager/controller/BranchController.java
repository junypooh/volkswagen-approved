package kr.co.vwa.manager.controller;

import kr.co.vwa.domain.BranchVo;
import kr.co.vwa.domain.EmailVo;
import kr.co.vwa.services.IBranchService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 전시장관리 컨트롤러
 */
@Controller
@Slf4j
@RequestMapping("branch")
public class BranchController {

    @Resource(name = "branchService")
    private IBranchService branchService;

    /**
     * 전시장관리/목록
     * @param model
     * @param searchParam
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping("/list")
    public String branchList(Model model, @RequestParam Map<Object, Object> searchParam){

        List<BranchVo> branchList = branchService.selectBranchList(searchParam);

        model.addAttribute("searchParam", searchParam);
        model.addAttribute("branchList", branchList);
        return "branch/branchList";
    }

    /**
     * 전시장관리/목록 노출여부 수정
     * @param branch
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/updateExpsYn")
    @ResponseBody
    public int updateExpsYn(BranchVo branch){
        return branchService.updateExpsYn(branch);
    }

    /**
     * 전시장관리/목록 정렬저장
     * @param index
     * @param exhHallSeq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/updateExpsdNo")
    @ResponseBody
    public int updateExpsdNo(Integer[] index, Integer[] exhHallSeq){
        return branchService.updateExpsdNo(index, exhHallSeq);
    }

    /**
     * 전시장관리/등록
     * @param model
     * @param exhHallSeq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @GetMapping("detail")
    public String registeBranch(Model model, Integer exhHallSeq){
        Map<String, Object> resultMap = branchService.selectOneBranch(exhHallSeq);
        model.addAttribute("result", resultMap);
        return "branch/branchRegiste";
    }

    /**
     * 전시장관리/상세 이동
     * @param model
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @GetMapping("/detail/{exhHallSeq}")
    public String detailBranch(Model model, @PathVariable("exhHallSeq") Integer exhHallSeq){

        Map<String, Object> result = branchService.selectOneBranch(exhHallSeq);

        model.addAttribute("result", result);
        return "branch/branchRegiste";
    }

    /**
     * 전시장관리/등록 전시장정보 등록
     * @param branch
     * @param email
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/saveBranch")
    @ResponseBody
    public BranchVo saveBranch(BranchVo branch, EmailVo email){

        if(branch.getExhHallSeq() != null && branch.getExhHallSeq() != 0) {
            //수정
            branch = branchService.updateBranch(branch, email);
        } else {
            //등록
            branch = branchService.registeBranch(branch, email);
        }

        return branch;
    }

    /**
     * 전시장관리/상세 전시장정보삭제
     * @param branch
     * @param email
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/deleteBranch")
    @ResponseBody
    public int deleteBranch(BranchVo branch, EmailVo email){
        return branchService.deleteBranch(branch, email);
    }
}
