package kr.co.vwa.manager.controller;

import kr.co.vwa.common.util.PageUtil;
import kr.co.vwa.domain.*;
import kr.co.vwa.services.ICarService;
import kr.co.vwa.services.IFrontItemService;
import kr.co.vwa.services.IItemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by DaDa on 2018-01-18.
 * <pre>
 * kr.co.vwa.manager.controller
 *
 * 매물관리 Controller.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-18 오전 11:06
 */
@Controller
@Slf4j
@RequestMapping("/item")
public class ItemController {

    @Autowired
    private IItemService iItemService;

    @Autowired
    private IFrontItemService iFrontItemService;

    @Autowired
    private ICarService iCarService;

    @Autowired
    private PageUtil pageUtil;

    @Value("${s3.url}")
    private String fileUrlPath;

    @Value("${vwa.front.url}")
    private String vwaFrontUrl;

    /**
     * 매물관리 - 리스트
     * @param itemVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView list(ItemVo itemVo) {

        log.debug("### [ItemController] [list] ### itemVo: {}", itemVo.toString());
        log.debug("### [ItemController] [list] ### {}, {}", itemVo.getCurrentPage(), itemVo.getContentsCount());

        ModelAndView mav = new ModelAndView("item/list");

        Map<String, Object> itemList = iItemService.selectItem(itemVo);
        int totCnt = (int) itemList.get("infoTotCnt");

        mav.addObject("pageHtml", pageUtil.makePageHtml(totCnt, itemVo.getCurrPage(), itemVo.getContentsCount()));
        mav.addObject("result", itemList);

        return mav;
    }

    /**
     * 매물관리 - 엑셀 다운로드
     * @param itemVo
     * @param model
     * @return
     * @throws Exception
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "listExcel")
    public ModelAndView itemListExcel(ItemVo itemVo, Model model) throws Exception {
        log.debug("################## : {}", itemVo.toString());

        List<ItemVo> list = iItemService.selectItemListExcel(itemVo);

        model.addAttribute("fileName", LocalDate.now().toString() + "_매물리스트.xls");
        model.addAttribute("domains", list);

        return new ModelAndView("excelView", "data", model);
    }

    /**
     * 매물관리 - 이력보기
     * @param itemVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "sellStatHis")
    public ModelAndView sellStatHis(ItemVo itemVo) {
        ModelAndView mav = new ModelAndView("item/list");
        mav.addObject("sellStatHis", iItemService.selectSellStatHis(itemVo));
        return mav;
    }


    /**
     * 매물관리 - 내 설명글 관리
     * @param discSeq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "sellMyDiscMng")
    public ModelAndView sellMyDiscMng(Long discSeq) {
        ModelAndView mav = new ModelAndView("item/list");
        mav.addObject("result", iItemService.selectSellMyDiscMng(discSeq));
        return mav;
    }

    /**
     * 매물관리 - 내 설명글 등록
     * @param myDiscMngVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "insDiscMng")
    @ResponseBody
    public String insertMyDiscMng(MyDiscMngVo myDiscMngVo) {
        return iItemService.insertMyDiscMng(myDiscMngVo);
    }

    /**
     * 매물관리 - 내 설명글 수정
     * @param myDiscMngVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "updDiscMng")
    @ResponseBody
    public String updateMyDiscMng(MyDiscMngVo myDiscMngVo) {
        return iItemService.updateMyDiscMng(myDiscMngVo);
    }

    /**
     * 매물관리 - 내 설명글 삭제
     * @param myDiscMngVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "delDiscMng")
    @ResponseBody
    public String deleteMyDiscMng(MyDiscMngVo myDiscMngVo) {
        return iItemService.deleteMyDiscMng(myDiscMngVo);
    }

    /**
     * 폭스바겐 차량 등록
     * @param model
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @GetMapping(value = "register/vwa")
    public String vwa(Model model) {

        model.addAttribute("models", iCarService.selectCarModelListByUseYnIsY());
        model.addAttribute("vwa", "Y");
        return "item/register/item";
    }

    /**
     * 폭스바겐 모델별 세부모델 조회
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/model/detail")
    @ResponseBody
    public List<CarMngVo> getCarDetailModelList(CarMngVo carMngVo) {

        return iCarService.selectCarDetailModelListByUseYnIsY(carMngVo);
    }

    /**
     * 폭스바겐 세부모델별 등급 조회
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/rating")
    @ResponseBody
    public List<CarMngVo> getCarRatingList(CarMngVo carMngVo) {

        return iCarService.selectCarRatingListByUseYnIsY(carMngVo);
    }

    /**
     * 폭스바겐 등급별 세부등급 조회
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/rating/detail")
    @ResponseBody
    public List<CarMngVo> getCarDetailRatingList(CarMngVo carMngVo) {

        return iCarService.selectCarDetailRatingListByUseYnIsY(carMngVo);
    }

    /**
     * 비폭스바겐 차량 등록
     * @param model
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @GetMapping(value = "register/nvwa")
    public String nvwa(Model model) {

        model.addAttribute("vwa", "N");
        return "item/register/item";
    }

    /**
     * 차량 기본정보 등록
     * @param carInfoVo
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/defaultInfo")
    public String registerInfo(CarInfoVo carInfoVo, @AuthenticationPrincipal User user) {
        log.debug("### [ItemController] [registerInfo] ### carInfoVo : {}", carInfoVo.toString());

        carInfoVo.setCreAdmSeq(user.getAdmSeq());
        carInfoVo.setCreUser(user.getUsername());

        String rtn = iItemService.insertCarDefaultInfo(carInfoVo);
        if("SUCC".equals(rtn)) {
            return "redirect:/item/register/price/" + carInfoVo.getSellCarSeq();
        } else {
            return "error/500";
        }
    }

    /**
     * 차량 기본정보 수정
     * @param carInfoVo
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/update/defaultInfo")
    @ResponseBody
    public String updateInfo(CarInfoVo carInfoVo, @AuthenticationPrincipal User user) {
        log.debug("### [ItemController] [updateInfo] ### carInfoVo : {}", carInfoVo.toString());

        //carInfoVo.setCreAdmSeq(user.getAdmSeq());
        carInfoVo.setUpdUser(user.getUsername());

        return iItemService.updateCarDefaultInfo(carInfoVo);
    }

    /**
     * 차량 기본정보 조회
     * @param sellCarSeq
     * @param model
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @GetMapping(value = "register/info/{sellCarSeq}")
    public String carDefaultInfo(@PathVariable("sellCarSeq") Long sellCarSeq, Model model) {

        model.addAllAttributes(iItemService.selectDefaultCarInfo(sellCarSeq));
        model.addAttribute("auth", iItemService.selectUserExhHallAuth(sellCarSeq));
        return "item/register/info";
    }

    /**
     * ######################################
     * 가격/사고이력 View
     * @param model
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @GetMapping(value = "register/price/{sellCarSeq}")
    public String price(@PathVariable("sellCarSeq") Long sellCarSeq, Model model) {
        model.addAttribute("result", iItemService.selectPriceTroubleHistory(sellCarSeq));
        model.addAttribute("auth", iItemService.selectUserExhHallAuth(sellCarSeq));
        return "item/register/price";
    }

    /**
     * 가격/사고이력 임시저장
     * @param priceTroubleHistoryVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/price/tempSave")
    @ResponseBody
    public Map<String, String> priceTempSave(PriceTroubleHistoryVo priceTroubleHistoryVo) {
        log.debug("### [ItemController] [priceTempSave] ### priceTroubleHistoryVo : {}", priceTroubleHistoryVo.toString());
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("rtnStr", iItemService.insertPriceTroubleHistory(priceTroubleHistoryVo));
        resultMap.put("reqApplyYn", iItemService.selectTempSaveYn(priceTroubleHistoryVo.getSellCarSeq()));
        return resultMap;
    }

    /**
     * ######################################
     * 옵션/전차주 View
     * @param model
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @GetMapping(value = "register/option/{sellCarSeq}")
    public String option(@PathVariable("sellCarSeq") Long sellCarSeq, Model model) {
        model.addAttribute("result", iItemService.selectOption(sellCarSeq));
        model.addAttribute("auth", iItemService.selectUserExhHallAuth(sellCarSeq));
        return "item/register/option";
    }


    /**
     * 옵션/전차주 임시저장
     * @param optionVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/option/tempSave")
    @ResponseBody
    public Map<String, String> optionTempSave(OptionVo optionVo) {
        log.debug("### [ItemController] [optionTempSave] ### optionVo : {}", optionVo.toString());
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("rtnStr", iItemService.insertOption(optionVo));
        resultMap.put("reqApplyYn", iItemService.selectTempSaveYn(optionVo.getSellCarSeq()));
        return resultMap;
    }

    /**
     * ######################################
     * 제시/성능점검 View
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @RequestMapping(value = "register/performance/{sellCarSeq}", method = RequestMethod.GET)
    public String performance(@PathVariable("sellCarSeq") Long sellCarSeq, Model model) {
        model.addAttribute("result", iItemService.selectPerformanceCheck(sellCarSeq));
        model.addAttribute("auth", iItemService.selectUserExhHallAuth(sellCarSeq));
        return "item/register/performance";
    }

    /**
     * 제시/성능점검 등록
     * @param performanceVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/performance/tempSave")
    @ResponseBody
    public Map<String, String> performanceTempSave(PerformanceVo performanceVo) {
        log.debug("### [ItemController] [performanceTempSave] ### performanceVo : {}", performanceVo.toString());
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("rtnStr", iItemService.insertPerformanceCheck(performanceVo));
        resultMap.put("reqApplyYn", iItemService.selectTempSaveYn(performanceVo.getSellCarSeq()));
        return resultMap;
    }

    /**
     * ######################################
     * 설명 View
     * @param model
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @GetMapping(value = "register/disc/{sellCarSeq}")
    public String disc(@PathVariable("sellCarSeq") Long sellCarSeq, Model model) {
        model.addAttribute("result", iItemService.selectDisc(sellCarSeq));
        model.addAttribute("auth", iItemService.selectUserExhHallAuth(sellCarSeq));
        return "item/register/disc";
    }

    /**
     * 전시장 정보 조회 Ajax
     * @param exhHallSeq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/disc/exhHall")
    public String selectExhibitionHall(Long exhHallSeq, Long sellCarSeq, Model model) {
//        ModelAndView mav = new ModelAndView("/item/register/disc");
        model.addAttribute("result", iItemService.selectExhibitionHall(exhHallSeq, sellCarSeq));
        return "/item/register/discBranchAjax";
    }

    /**
     * 내설명글 조회 Ajax
     * @param discSeq
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/disc/myDiscMng", produces = "application/text; charset=utf8")
    @ResponseBody
    public String selectMyDiscMng(Long discSeq) {
        return iItemService.selectMyDiscMng(discSeq);
    }

    /**
     * 설명 등록
     * @param discriptionVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/disc/tempSave")
    @ResponseBody
    public Map<String, String> discTempSave(DiscriptionVo discriptionVo) {
        log.debug("### [ItemController] [discTempSave] ### discriptionVo : {}", discriptionVo.toString());
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("rtnStr", iItemService.insertDisc(discriptionVo));
        resultMap.put("reqApplyYn", iItemService.selectTempSaveYn(discriptionVo.getSellCarSeq()));
        return resultMap;
    }

    /**
     * ######################################
     * 사진 View
     * @param model
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @GetMapping(value = "register/photo/{sellCarSeq}")
    public String photo(@PathVariable("sellCarSeq") Long sellCarSeq, Model model) {
        model.addAttribute("result", iItemService.selectPhoto(sellCarSeq));
        model.addAttribute("auth", iItemService.selectUserExhHallAuth(sellCarSeq));
        return "item/register/photo";
    }

    /**
     * 사진 등록
     * @param carPhotoVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/photo/tempSave")
    @ResponseBody
    public Map<String, String> photoTempSave(CarPhotoVo carPhotoVo) {
        log.debug("### [ItemController] [photoTempSave] ### carPhotoVo : {}", carPhotoVo.toString());
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("rtnStr", iItemService.insertCarPhoto(carPhotoVo));
        resultMap.put("reqApplyYn", iItemService.selectTempSaveYn(carPhotoVo.getSellCarSeq()));
        return resultMap;
    }

    /**
     * ############################################################################
     *
     * 승인 요청, 요청완료, 반려
     * @param carSellStatHisVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/carSellStat/{status}")
    @ResponseBody
    public String requestApply(CarSellStatHisVo carSellStatHisVo, @PathVariable("status") String status) {
        carSellStatHisVo.setType(status);
        return iItemService.insertCarSellStatHis(carSellStatHisVo);
    }

    /**
     * ######################################
     * 판매관리 View
     * @param model
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @GetMapping(value = "register/sellMng/{sellCarSeq}")
    public String sellMng(@PathVariable("sellCarSeq") Long sellCarSeq, Model model) {
        model.addAttribute("result", iItemService.selectSellMng(sellCarSeq));

        return "item/register/sellMng";
    }

    /**
     * 판매관리 저장
     * @param sellMngVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/sellMng/save")
    @ResponseBody
    public String sellMngSave(SellMngVo sellMngVo) {
        log.debug("### [ItemController] [sellMngSave] ### sellMngVo : {}", sellMngVo.toString());
        return iItemService.insertSellMng(sellMngVo);
    }

    /**
     * 판매관리 노출여부
     * @param carSellStatHisVo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @PostMapping(value = "register/sellMng/viewChange")
    @ResponseBody
    public String sellMngViewChange(CarSellStatHisVo carSellStatHisVo) {
        log.debug("### [ItemController] [sellMngdispChange] ### sellMngVo : {}", carSellStatHisVo.toString());

        return iItemService.insertSellMngViewChange(carSellStatHisVo);
    }

    /**
     * 미리보기
     * @param sellCarSeq
     * @param model
     * @return
     */
    @PreAuthorize("hasRole('ROLE_OPERATOR')")
    @GetMapping(value = "register/preview/{sellCarSeq}")
    public String preview(@PathVariable("sellCarSeq") Long sellCarSeq, Model model) {

        model.addAttribute("fileUrlPath", fileUrlPath);
        model.addAttribute("vwaFrontUrl", vwaFrontUrl);
        model.addAttribute("result", iFrontItemService.selectItemDetail(sellCarSeq, "Y"));

        model.addAttribute("itemView", "Y");

        return "item/register/preview";
    }


}
