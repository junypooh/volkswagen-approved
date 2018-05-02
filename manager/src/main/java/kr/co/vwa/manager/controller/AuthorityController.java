package kr.co.vwa.manager.controller;

import kr.co.vwa.common.util.PageUtil;
import kr.co.vwa.domain.AuthExhibMapVo;
import kr.co.vwa.domain.AuthorityVo;
import kr.co.vwa.domain.BranchVo;
import kr.co.vwa.domain.User;
import kr.co.vwa.services.IAuthorityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 권한관리 컨트롤러
 */
@Controller
@Slf4j
@RequestMapping("auth")
public class AuthorityController {

    @Resource(name = "authorityService")
    private IAuthorityService authorityService;

    @Autowired
    private PageUtil pageUtil;

    /**
     * 권한관리/목록 GET방식
     * @param model
     * @return
     */
    @RequestMapping(value = "/list")
    public void authListSelect(Model model, @RequestParam Map<String, Object> searchParam, @AuthenticationPrincipal User user) {
        //limit 설정을 위한 로직
        int currPage = searchParam.get("currPage") == null ? 1 : Integer.parseInt((String)searchParam.get("currPage")) ;
        int limitRow = (currPage - 1) * pageUtil.getDefaultContentsCount();
        searchParam.put("currPage", currPage);
        searchParam.put("limitRow", limitRow);
        searchParam.put("defaultContentsCount", pageUtil.getDefaultContentsCount());

        int totalCount = authorityService.selectAuthListTotalCount(searchParam);
        List<AuthorityVo> cList=authorityService.authListSelect(searchParam);
        String pageHtml = pageUtil.makePageHtml(totalCount, currPage);

        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageHtml", pageHtml);
        model.addAttribute("cList",cList);
        model.addAttribute("authorityCd", user.getRole().getAuthorityCd());
    }

    /**
     * 권한관리/등록 이동
     * @param model
     * @return
     */
    @GetMapping("/registe")
    public String registeForm(Model model, @AuthenticationPrincipal User user){
        List<BranchVo> branchList = authorityService.selectExhibList();
        model.addAttribute("branchList", branchList);

        //로그인한 관리자가 그룹관리자인 경우 권한이 있는 전시장만 권한 관리가 가능해야 함
        if("Branch".equals(user.getAuthType())){
            List<BranchVo> userBranchList = authorityService.selectAuthExhibList(user.getAdmSeq());
            model.addAttribute("branchList", userBranchList);
        }
        model.addAttribute("authType", user.getAuthType());
        return "auth/authRegiste";
    }

    /**
     * 권한관리/등록 등록저장
     * @param authorityVo
     * @return
     */
    @PostMapping("registe")
    @ResponseBody
    public AuthorityVo registeAuthority(AuthorityVo authorityVo){

        int result = authorityService.registeAuthority(authorityVo);

        return authorityVo;
    }

    /**
     * 권한관리/상세
     * @param model
     * @param authorityVo
     * @return
     */
    @GetMapping(value = "/detail/{admSeq}")
    public String authMngDetail(Model model, AuthorityVo authorityVo) {
        AuthorityVo aVo=authorityService.authMngDetail(authorityVo);
        List<AuthExhibMapVo> detail=authorityService.authExhMapDetail(aVo);
        model.addAttribute("detail",detail);
        model.addAttribute("aVo",aVo);
        return "auth/authDetail";
    }

    /**
     * 권한관리/상세 authVo업데이트
     * @param authorityVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/authUpdate")
    public int authUpdate(AuthorityVo authorityVo) {
        return authorityService.authUpdate(authorityVo);
    }

    /**
     * 권한관리/상세 AuthMap업데이트
     * @param authExhibMapVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/updateExhMap")
    public int updateExhMap(AuthExhibMapVo authExhibMapVo) {
        return authorityService.updateExhMap(authExhibMapVo);
    }

    /**
     * 권한관리/상세 AuthMap등록
     * @param authExhibMapVo
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/registeExhMap")
    public int registeExhMap(AuthExhibMapVo authExhibMapVo) {
        return authorityService.registeExhMap(authExhibMapVo);
    }

    /**
     * 권한관리/상세 비밀번호 초기화화
     * @param authority
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/authPwdReset")
    public int authPwdReset(AuthorityVo authority) {
        return authorityService.authPwdReset(authority);
    }

    /**
     * 권한관리/상세 비밀번호 변경
     * @param authority
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/authPwdChange")
    public int authPwdChange(AuthorityVo authority) {
        return authorityService.authPwdChange(authority);
    }

}
