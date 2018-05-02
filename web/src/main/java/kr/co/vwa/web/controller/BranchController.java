package kr.co.vwa.web.controller;

import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.domain.BranchVo;
import kr.co.vwa.services.IBranchService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 전시장 목록/FRONT Controller
 */
@Controller
@Slf4j
@RequestMapping("branch")
public class BranchController {

    @Resource(name = "branchService")
    private IBranchService branchService;

    /**
     * 전시장 목록/FRONT
     * @param model
     * @param searchParam
     */
    @RequestMapping("/list")
    @WebLogInfo(menuPath = "전시장 안내")
    public void branchList(Model model, @RequestParam Map<Object, Object> searchParam) {
        searchParam.put("expsYn","Y");
        List<BranchVo> branchList = branchService.selectBranchList(searchParam);
        List<BranchVo> branchGroup = branchService.groupBranchList(searchParam);
        model.addAttribute("branchList", branchList);
        model.addAttribute("branchGroup",branchGroup);
        model.addAttribute("searchParam", searchParam);
    }
}
