package kr.co.vwa.web.controller;

import eu.bitwalker.useragentutils.DeviceType;
import eu.bitwalker.useragentutils.UserAgent;
import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.common.util.PageUtil;
import kr.co.vwa.domain.CarInfoVo;
import kr.co.vwa.domain.CarMngVo;
import kr.co.vwa.domain.EmailAgreeVo;
import kr.co.vwa.domain.FrontItemVo;
import kr.co.vwa.services.ICarService;
import kr.co.vwa.services.IFrontItemService;
import kr.co.vwa.services.IShareService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by junypooh on 2018-02-13.
 * <pre>
 * kr.co.vwa.web.controller
 *
 * 차량 검색 Controller
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-13 오후 4:51
 */
@Controller
@Slf4j
@RequestMapping("/item")
public class ItemController {

    @Autowired
    private IFrontItemService iFrontItemService;

    @Autowired
    private ICarService iCarService;

    @Autowired
    private PageUtil pageUtil;

    @Autowired
    private IShareService iShareService;

    @Value("${s3.url}")
    private String fileUrlPath;

    @Value("${kakao.clientId}")
    private String kakaoClientId;

    /**
     * 차량 리스트
     * @param model
     */
    @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
    @WebLogInfo(menuPath = "차량 검색")
    public ModelAndView list(Model model, FrontItemVo itemVo) {
        ModelAndView mav = new ModelAndView("item/list");

        Integer oriCurrPage = itemVo.getCurrPage();

        // 기존 유지되는 검색조건일 경우
        if ("Y".equals(itemVo.getRetainYn())) {
            itemVo.setContentsCount(9 * itemVo.getCurrPage());
            itemVo.setCurrPage(1);
        } else {
            itemVo.setContentsCount(9);
        }


        Map<String, Object> itemMap = iFrontItemService.selectItemList(itemVo);
        int totCnt = (int) itemMap.get("infoTotCnt");

        log.debug("#################################### {}",itemVo.toString());

        mav.addObject("certYn", itemVo.getCertYn());
        mav.addObject("result", itemMap);

        // paging 초기화
        itemVo.setCurrPage(oriCurrPage);
        itemVo.setContentsCount(9);

        mav.addObject("pageHtml", pageUtil.makeMobilePageHtml(totCnt, itemVo.getCurrPage(), itemVo.getContentsCount()));

        // 상단 검색 영역
        mav.addObject("maks", iFrontItemService.selectNonVwaCarMakList());

        CarInfoVo carInfoVo = new CarInfoVo();
        BeanUtils.copyProperties(itemVo, carInfoVo);
        if (StringUtils.isNotBlank(itemVo.getMak())) {
            if("폭스바겐".equals(itemVo.getMak())) {
                mav.addObject("models", iCarService.selectCarModelList());
            } else {
                mav.addObject("models", iFrontItemService.selectNonVwaCarModelList(carInfoVo));
            }
        }

        if (StringUtils.isNotBlank(itemVo.getModel())) {
            if("폭스바겐".equals(itemVo.getMak())) {
                CarMngVo carMngVo = new CarMngVo();
                BeanUtils.copyProperties(carInfoVo, carMngVo);
                mav.addObject("detailModels", iCarService.selectCarDetailModelList(carMngVo));
            } else {
                mav.addObject("detailModels", iFrontItemService.selectNonVwaCarDetailModelList(carInfoVo));
            }
        }

        return mav;
    }

    /**
     * 차량 상세
     * @param sellCarSeq
     * @param model
     * @param httpServletRequest
     * @return
     */
    @GetMapping(value = "{sellCarSeq}")
    @WebLogInfo(menuPath = "차량 검색 > 상세")
    public String view(@PathVariable("sellCarSeq") Long sellCarSeq, Model model, HttpServletRequest httpServletRequest) {

        String userAgentAsString = httpServletRequest.getHeader("User-Agent");
        UserAgent userAgent = UserAgent.parseUserAgentString(userAgentAsString);

        DeviceType deviceType = userAgent.getOperatingSystem().getDeviceType();

        if(DeviceType.MOBILE.equals(deviceType) || DeviceType.TABLET.equals(deviceType)) {
            model.addAttribute("page", "itemView");
            model.addAttribute("mobileCheck", true);
        }

        model.addAttribute("fileUrlPath", fileUrlPath);
        model.addAttribute("kakaoClientId", kakaoClientId);
        model.addAttribute("result", iFrontItemService.selectItemDetail(sellCarSeq));
        model.addAttribute("shareUrl", httpServletRequest.getRequestURL().toString());

        model.addAttribute("itemView", "Y");

        String REFERER = httpServletRequest.getHeader("referer");

        if ( REFERER != null && (REFERER.indexOf("vwa.co.kr") > -1 || REFERER.indexOf("volkswagenapproved.co.kr") > -1 || REFERER.indexOf("localhost") > -1) ) {
            model.addAttribute("backBtnScript", "history.back()" );
        } else {
            model.addAttribute("backBtnScript", "location.href = '" + httpServletRequest.getContextPath() + "/item/list'" );
        }

        return "item/view";
    }

    /**
     * 메일 공유하기
     * @param itemVo
     * @return
     */
    @PostMapping(value = "share/mail")
    @ResponseBody
    public Object shareMail(FrontItemVo itemVo, HttpServletRequest httpServletRequest) {

        iFrontItemService.shareContents(itemVo, httpServletRequest);
        return "";
    }

    /**
     * 차량 문의하기
     * @param itemVo
     * @return
     */
    @PostMapping(value = "qna/mail")
    @ResponseBody
    public Object qnaMail(FrontItemVo itemVo, HttpServletRequest httpServletRequest, EmailAgreeVo emailAgree) {

        iFrontItemService.qnaContents(itemVo, httpServletRequest);

        //이메일 동의이력 생성
        iShareService.insertEmailAgreeHistory("매물상세 문의하기", emailAgree);
        return "";
    }
}
