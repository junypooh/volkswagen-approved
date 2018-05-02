package kr.co.vwa.web.controller;

import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.domain.BranchVo;

import kr.co.vwa.domain.EmailAgreeVo;
import kr.co.vwa.domain.SellCarVo;
import kr.co.vwa.services.IBranchService;
import kr.co.vwa.services.IEmailService;
import kr.co.vwa.services.IShareService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by junypooh on 2018-02-19.
 * <pre>
 * kr.co.vwa.web.controller
 *
 * 내차 팔기 Controller
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-19 오후 6:00
 */
@Controller
@Slf4j
@RequestMapping("sellcars")
public class SellCarsController {

    @Resource(name = "branchService")
    private IBranchService branchService;

    @Autowired
    private IEmailService emailService;

    @Autowired
    private IShareService shareService;

    /**
     * 내차 팔기
     */
    @RequestMapping("/view")
    @WebLogInfo(menuPath = "내차 팔기")
    public void sellCar(Model model) {

        Map<Object, Object> searchParam=new HashMap<Object, Object>();
        searchParam.put("expsYn","Y");
        List<BranchVo> branchList = branchService.selectBranchList(searchParam);
        model.addAttribute("branchList", branchList);

    }

    /**
     * 내차 팔기 이메일 보내기
     * @param sellCarVo
     * @return
     */
    @PostMapping(value = "/emailSend")
    @ResponseBody
    public int emailSend(SellCarVo sellCarVo, EmailAgreeVo emailAgree) {

        Map<String, Object> result = branchService.selectOneBranch(sellCarVo.getExhHallSeq());
        BranchVo branchVo=(BranchVo)result.get("branch");
        String email=branchVo.getEmailList().get(0).getEmail();
        String text="";
        text+="[차량정보]"+"\n";
        text+="소유구분 : "+sellCarVo.getType()+"\n";
        text+="차량번호 : "+sellCarVo.getCarNum()+"\n";
        text+="연식 : "+sellCarVo.getCarYear()+"\n";
        text+="주행거리 : "+sellCarVo.getCarStreet()+"\n";
        text+="지점 : "+branchVo.getStoreNm()+"\n";
        text+="추가내용 : "+sellCarVo.getAddText()+"\n";
        text+="\n"+"[고객정보]"+"\n";
        text+="고객이름 : "+sellCarVo.getUser()+"\n";
        text+="이메일 주소 : "+sellCarVo.getEmail()+"@"+sellCarVo.getEmailaddress()+"\n";
        emailService.sendEmailMessage(email,"[내차팔기] "+ sellCarVo.getUser()+"님의 내차팔기 문의메일입니다.",text);

        //이메일 동의이력 생성
        shareService.insertEmailAgreeHistory("내차팔기", emailAgree);
        return 1;
    }
}
