package kr.co.vwa.web.controller;

import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.domain.BranchVo;
import kr.co.vwa.domain.EmailAgreeVo;
import kr.co.vwa.services.IBranchService;
import kr.co.vwa.services.IEmailService;
import kr.co.vwa.services.IFrontItemService;
import kr.co.vwa.services.IShareService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by junypooh on 2018-02-20.
 * <pre>
 * kr.co.vwa.web.controller
 *
 * 빠른문의/FRONT Controller
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-20 오후 2:46
 */
@Controller
@Slf4j
public class QuickController {

    @Resource(name = "branchService")
    private IBranchService branchService;

    @Autowired
    private IFrontItemService iFrontItemService;

    @Autowired
    private IEmailService emailService;

    @Autowired
    private IShareService shareService;

    /**
     * 빠른 문의
     */
    @RequestMapping(value = "layer/quick")
    public void index(Model model, HttpServletRequest request, @RequestParam Map<Object, Object> searchParam) {
        searchParam.put("expsYn","Y");
        model.addAttribute("branchList", branchService.selectBranchList(searchParam));
    }

    @PostMapping("layer/quick/inquiry")
    @WebLogInfo(menuPath = "빠른 문의")
    @ResponseBody
    public void inquiry(@RequestParam Map<Object, String> inquiryParam, EmailAgreeVo emailAgree){

        BranchVo branch = (BranchVo) branchService.selectOneBranch(Integer.parseInt(inquiryParam.get("branch"))).get("branch");
        String toEmail = branch.getEmailList().get(0).getEmail();
        String title = "[빠른문의] " + inquiryParam.get("name") + "님의 빠른문의 메일입니다.";

        String strDriveDist = "".equals(inquiryParam.get("strDriveDist"))? "0Km" : inquiryParam.get("strDriveDist") + "Km";
        String endDriveDist = "".equals(inquiryParam.get("endDriveDist"))? "최대" : inquiryParam.get("endDriveDist") + "Km";
        String strPrice = "".equals(inquiryParam.get("strPrice"))? "0원" : inquiryParam.get("strPrice") + "원";
        String endPrice = "".equals(inquiryParam.get("endPrice"))? "최대" : inquiryParam.get("endPrice") + "원";
        String strProdYear = "".equals(inquiryParam.get("strProdYear"))? "" : inquiryParam.get("strProdYear") + "년";
        String endProdYear = "".equals(inquiryParam.get("endProdYear"))? "2018년" : inquiryParam.get("endProdYear") + "년";

        String text = "[차량정보]\n제조사 : " + inquiryParam.get("mak") + "\n";
        text += "모델 : " + inquiryParam.get("model") + "\n";
        text += "주행거리 : " + strDriveDist + " ~ " + endDriveDist + "\n";
        text += "가격대 : " + strPrice + " ~ " + endPrice + "\n";
        text += "연식 : " + strProdYear + " ~ " + endProdYear + "\n";
        text += "사고유무 : " + inquiryParam.get("accidYn") + "\n";
        text += "추가내용 : " + inquiryParam.get("addContents") + "\n\n";
        text += "[고객정보]\n고객 이름 : " + inquiryParam.get("name") + "\n";
        text += "이메일 주소 : " + inquiryParam.get("email") + "\n";

        emailService.sendEmailMessage(toEmail, title, text);

        //이메일 동의이력 생성
        shareService.insertEmailAgreeHistory("빠른문의", emailAgree);
    }

}
