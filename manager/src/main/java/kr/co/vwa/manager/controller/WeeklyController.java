package kr.co.vwa.manager.controller;

import kr.co.vwa.common.util.PageUtil;
import kr.co.vwa.domain.*;
import kr.co.vwa.services.IWeeklyService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import java.util.Map;

/**
 * 주간보고 Controller
 */
@Controller
@Slf4j
@RequestMapping("weekly")
public class WeeklyController {

    @Autowired
    private IWeeklyService weeklyService;

    @Autowired
    private PageUtil pageUtil;

    /**
     * 통계관리/weekly report/목록
     * @param model
     * @param searchParam
     * @param user
     */
    @RequestMapping("/list")
    public void weeklyList (Model model, @RequestParam Map<String, Object> searchParam, @AuthenticationPrincipal User user){
        //limit 설정을 위한 로직
        int currPage = searchParam.get("currPage") == null ? 1 : Integer.parseInt((String)searchParam.get("currPage")) ;
        int limitRow = (currPage - 1) * pageUtil.getDefaultContentsCount();
        searchParam.put("currPage", currPage);
        searchParam.put("limitRow", limitRow);
        searchParam.put("defaultContentsCount", pageUtil.getDefaultContentsCount());

        int totalCount = weeklyService.selectWeeklyListTotalCount(searchParam);
        List<WeeklyVo> list=weeklyService.WeeklyListSelect(searchParam);
        String pageHtml = pageUtil.makePageHtml(totalCount, currPage);

        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageHtml", pageHtml);
        model.addAttribute("list",list);
        model.addAttribute("searchParam",searchParam);
        model.addAttribute("authType", user.getAuthType());
    }

    /**
     * 통계관리/weekly report/등록폼 이동
     * @param model
     * @return
     */
    @GetMapping("/registeForm")
    public String weeklyRegiste (Model model){
        return "weekly/registe";
    }

    /**
     * 통계관리/weekly report/상세
     * @param model
     * @param weekly
     * @return
     */
    @GetMapping("/detail/{weekRepSeq}")
    public String weeklyUpdate(Model model, WeeklyVo weekly, @AuthenticationPrincipal User user){

        weekly = weeklyService.selectWeekly(weekly);
        model.addAttribute("weekly", weekly);
        model.addAttribute("authType", user.getAuthType());
        model.addAttribute("userSeq", user.getAdmSeq());
        return "weekly/detail";
    }

    /**
     * 통계관리/weekly report/모달 팝업
     * @param model
     * @param weekly
     * @return
     */
    @PostMapping(value = "/openModal")
    public String openModal(Model model, WeeklyVo weekly){

        List<AuthorityVo> authorityList = weeklyService.selectBranchAuthList(weekly);
        model.addAttribute("authorityList", authorityList);
        model.addAttribute("searchText", weekly.getSearchText());
        return "weekly/modalPop";
    }

    /**
     * 통계관리/weekly report/상세 저장
     * @param weekly
     * @return
     */
    @PostMapping("/saveWeekly")
    @ResponseBody
    public int saveWeekly(WeeklyVo weekly){
        return weeklyService.updateWeekly(weekly);
    }

    /**
     * 통계관리/weekly report/모달창 저장
     * @param model
     * @param admSeq
     * @param detailStrDate
     * @param detailEndDate
     * @return
     */
    @PostMapping(value = "/modalSave")
    public String modalSave(Model model, Integer[] admSeq, String[] detailStrDate,String[] detailEndDate){
        WeeklyVo weeklyVo=new WeeklyVo();
        weeklyVo.setAdmSeq(admSeq);
        List<AuthorityVo> authorityList = weeklyService.selectBranchAuthList(weeklyVo);
        model.addAttribute("authorityList", authorityList);
        model.addAttribute("strDate", detailStrDate.length == 0 ? "" : detailStrDate[0]);
        model.addAttribute("endDate", detailEndDate.length == 0 ? "" : detailEndDate[0]);
        return "weekly/registe";
    }

    /**
     * 통계관리/weekly report/등록
     * @param weekly
     * @return
     */
    @PostMapping("/registeWeekly")
    @ResponseBody
    public Integer saveWeek(WeeklyVo weekly){
        WeeklyVo weeklyVo=weeklyService.registeWeekly(weekly);
        weeklyService.registeWeeklyDetail(weekly.getAdmSeq(),weekly.getWeekRepSeq(),weekly.getDetailStrDate(),weekly.getDetailEndDate());
        return weekly.getWeekRepSeq();
    }

    /**
     * 통계관리/weekly report/상세 모달팝업 저장
     * @param weekly
     * @return
     */
    @PostMapping("/updateModal")
    @ResponseBody
    public int updateModal(WeeklyVo weekly){
        return weeklyService.updateModal(weekly);
    }

    /**
     * 통계관리/weekly report/상세 삭제
     * @param weekly
     * @return
     */
    @PostMapping("/deleteWeekly")
    @ResponseBody
    public WeeklyVo deleteWeekly(WeeklyVo weekly){
        weeklyService.deleteWeekly(weekly);
        return weekly;
    }

    /**
     * 통계관리/weekly report/상세 엑셀 업로드
     * @param weeklyFile
     * @param weeklyDetail
     * @return
     */
    @PostMapping("/readExcel")
    @ResponseBody
    public WeeklyDetailVo readExcel(@RequestParam (name = "weeklyFile") MultipartFile weeklyFile, WeeklyDetailVo weeklyDetail){
        weeklyService.readExcel(weeklyFile, weeklyDetail);

        return weeklyDetail;
    }

    /**
     * 통계관리/weekly report/상세 엑셀 다운로드
     * @param model
     * @param weekly
     * @return
     */
    @PostMapping("/detailExcelDown")
    public ModelAndView detailExcelDown(Model model, WeeklyVo weekly){
        weekly = weeklyService.selectWeekly(weekly);
        List<WeeklyDataVo> weeklyDataList = weeklyService.selectWeeklyDataList(weekly);
        model.addAttribute("domains", weeklyDataList);

        model.addAttribute("fileName", weekly.getTitle() + ".xls");
        return new ModelAndView("excelView", "data", model);
    }

    /**
     * 통계관리/weekly report/상세 파일삭제
     * @param weeklyDetail
     * @return
     */
    @PostMapping("/deleteFile")
    @ResponseBody
    public int deleteFile(WeeklyDetailVo weeklyDetail){
        return weeklyService.deleteFile(weeklyDetail);
    }
}
