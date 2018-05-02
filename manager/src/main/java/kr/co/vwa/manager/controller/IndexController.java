package kr.co.vwa.manager.controller;

import kr.co.vwa.domain.User;
import kr.co.vwa.services.IDashBoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

/**
 * Created by junypooh on 2017-12-19.
 * <pre>
 * kr.co.vwa.web.controller
 *
 * Index Controller
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2017-12-19 오후 5:31
 */
@Controller
@Slf4j
public class IndexController {

    @Autowired
    private IDashBoardService iDashBoardService;

    @Autowired
    private StandardPasswordEncoder standardPasswordEncoder;

    /**
     * 대시보드
     * @param model
     * @param user
     * @return
     */
    @GetMapping(value = {"", "index"})
    public String index(Model model, @AuthenticationPrincipal User user) {

        Map<String, Object> dashBoardData = iDashBoardService.selectDashBoardData(user);
        model.addAttribute("result", dashBoardData);

        model.addAttribute("strDate", LocalDate.now().minusDays(6).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        model.addAttribute("endDate", LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));

        return dashBoardData.get("page").toString();

        //return "redirect:/item/list";
    }

    /**
     * 암호화 모듈 테스트용
     * @param targetStr
     * @param encStr
     * @param model
     * @return
     */
    @RequestMapping(value = "encode", method = {RequestMethod.GET, RequestMethod.POST})
    public String encode(@RequestParam(value = "targetStr", required = false, defaultValue = "") String targetStr
            , @RequestParam(value = "encStr", required = false, defaultValue = "") String encStr
            , Model model) {

        if(StringUtils.hasText(targetStr)) {
            model.addAttribute("result", standardPasswordEncoder.encode(targetStr));
        }

        if(StringUtils.hasText(encStr)) {
            model.addAttribute("test", standardPasswordEncoder.matches(targetStr, encStr));
        }

        return "encode";
    }

    /**
     * 로그인 페이지
     * @param model
     * @param error
     * @param logout
     */
    @GetMapping(value = "login")
    public void login(Model model, String error, String logout) {

        if(error != null) {
            model.addAttribute("error", true);
        }
        if(logout != null) {
            model.addAttribute("logout", true);
        }
    }
}
