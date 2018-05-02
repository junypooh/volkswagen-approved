package kr.co.vwa.web.controller;

import kr.co.vwa.annotation.WebLogInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by junypooh on 2018-02-13.
 * <pre>
 * kr.co.vwa.web.controller
 *
 * 폭스바겐 인증중고차 혜택 Controller
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-13 오후 1:52
 */
@Controller
@Slf4j
@RequestMapping("benefit")
public class BenefitController {

    /**
     * 폭스바겐 인증중고차 혜택
     */
    @GetMapping(value = "view")
    @WebLogInfo(menuPath = "폭스바겐 인증중고차 혜택")
    public void view() {
    }
}
