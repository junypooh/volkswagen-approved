package kr.co.vwa.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by junypooh on 2018-01-25.
 * <pre>
 * kr.co.vwa.web.controller
 *
 * 에러 처리 Controller
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-25 오후 2:12
 */
@Controller
@RequestMapping("error")
public class ErrorController {

    /**
     * HTTP 에러 페이지
     */
    @GetMapping(value = {"400", "401", "403", "404", "405", "500"})
    public void error() {}
}
