package kr.co.vwa.web.controller;

import eu.bitwalker.useragentutils.DeviceType;
import eu.bitwalker.useragentutils.UserAgent;
import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.domain.*;
import kr.co.vwa.services.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
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
    private ICarService iCarService;

    @Autowired
    private IFrontItemService iFrontItemService;

    @Autowired
    private IEventService iEventService;

    @Autowired
    private IBannerService iBannerService;

    @Autowired
    private IPopupService iPopupService;

    @Value("${s3.url}")
    private String fileUrlPath;

    /**
     * 메인페이지
     */
    @GetMapping(value = {"", "index"})
    @WebLogInfo(menuPath = "Home")
    public String index(Model model, HttpServletRequest request) {

        // S3 URL
        model.addAttribute("fileUrlPath", fileUrlPath);

        // 배너 영역
        model.addAttribute("banners", iBannerService.selectFrontBannerList());

        // 최근 입고된 차량
        FrontItemVo itemVo = new FrontItemVo();
        itemVo.setCertYn("Y");
        Map<String, Object> item = iFrontItemService.selectItemList(itemVo);
        List<FrontItemVo> itemList = (List<FrontItemVo>) item.get("info");
        if(itemList != null && itemList.size() > 3) {
            while (itemList.size() > 3) {
                itemList.remove(itemList.size()-1);
            }
        }

        model.addAttribute("items", itemList);

        // 이벤트 영역
        List<EventVo> list = iEventService.eventFrontMainList();

        String userAgentAsString = request.getHeader("User-Agent");
        UserAgent userAgent = UserAgent.parseUserAgentString(userAgentAsString);

        DeviceType deviceType = userAgent.getOperatingSystem().getDeviceType();

        if (DeviceType.MOBILE.equals(deviceType) || DeviceType.TABLET.equals(deviceType)) {
            model.addAttribute("pcMobile", "mobile");
        } else {
            model.addAttribute("pcMobile", "pc");
        }
        model.addAttribute("events", list);

        // 팝업
        PopupVo popupVo = new PopupVo();
        model.addAttribute("popups", iPopupService.selectFrontPopupList(popupVo));

        // 하단 검색 영역
        model.addAttribute("maks", iFrontItemService.selectNonVwaCarMakList());
        model.addAttribute("models", iCarService.selectCarModelList());

        CarInfoVo carInfoVo = new CarInfoVo();
        carInfoVo.setMak("폭스바겐");
        model.addAttribute("sellCount", iFrontItemService.selectNowSellingItemCount(carInfoVo));

        return "index";
    }

    /**
     * 최근 입고된 차량 갱신
     * @param itemVo
     * @return
     */
    @GetMapping(value = "recentList")
    public ModelAndView getRecentInCarList(FrontItemVo itemVo) {

        ModelAndView modelAndView = new ModelAndView("index");

        Map<String, Object> item = iFrontItemService.selectItemList(itemVo);
        List<FrontItemVo> itemList = (List<FrontItemVo>) item.get("info");
        if(itemList != null && itemList.size() > 3) {
            while (itemList.size() > 3) {
                itemList.remove(itemList.size()-1);
            }
        }

        modelAndView.addObject("items", itemList);

        return modelAndView;
    }

    /**
     * 제조사별 모델 조회
     * @return
     */
    @PostMapping(value = "index/model")
    @ResponseBody
    public List<?> getCarModelList(CarInfoVo carInfoVo) {

        if("폭스바겐".equals(carInfoVo.getMak())) {
            return iCarService.selectCarModelList();
        } else {
            return iFrontItemService.selectNonVwaCarModelList(carInfoVo);
        }
    }

    /**
     * 모델별 세부모델 조회
     * @return
     */
    @PostMapping(value = "index/model/detail")
    @ResponseBody
    public List<?> getCarDetailModelList(CarInfoVo carInfoVo) {

        CarMngVo carMngVo = new CarMngVo();
        BeanUtils.copyProperties(carInfoVo, carMngVo);
        if("폭스바겐".equals(carMngVo.getMak())) {
            return iCarService.selectCarDetailModelList(carMngVo);
        } else {
            return iFrontItemService.selectNonVwaCarDetailModelList(carInfoVo);
        }
    }

    /**
     * 현재 판매진행 중이 차량수
     * @return
     */
    @PostMapping(value = "index/item/count")
    @ResponseBody
    public Integer getNowSellingItemCount(CarInfoVo carInfoVo) {

        return iFrontItemService.selectNowSellingItemCount(carInfoVo);
    }
}
