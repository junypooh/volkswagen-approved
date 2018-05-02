package kr.co.vwa.manager.controller;

import kr.co.vwa.domain.StatisticsVo;
import kr.co.vwa.services.IStatisticsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by user on 2018-03-20.
 * <pre>
 * kr.co.vwa.manager.controller
 *
 * 통계관리 Controller.
 *
 * </pre>
 *
 * @author Hana, Lee
 * @see
 * @since 2018-03-20 오후 5:59
 */
@Controller
@Slf4j
@RequestMapping("statics")
public class StatisticsController {

    @Autowired
    private IStatisticsService iStatisticsService;

    /**
     * 통계관리/사이트통계 일별 접속수
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/serviceAccess")
    public ModelAndView dateServiceAccess(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/serviceAccess");
        List<StatisticsVo> statisticsVo=iStatisticsService.dateAccessService(vo);
        mav.addObject("list", statisticsVo);

        return mav;

    }

    /**
     * 통계관리/사이트통계 월별 접속수
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/monthAccessService")
    public ModelAndView monthAccessService(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/serviceAccess");
        List<StatisticsVo> statisticsVo=iStatisticsService.monthAccessService(vo);
        mav.addObject("list", statisticsVo);

        return mav;
    }

    /**
     * 통계관리/사이트통계 연도별 접속수
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/yearAccessService")
    public ModelAndView yearAccessService( StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/serviceAccess");

        List<StatisticsVo> statisticsVo = iStatisticsService.yearAccessService(vo);
        mav.addObject("list", statisticsVo);

        return mav;
    }

    /**
     * 통계관리/사이트통계 일별 유입경로
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/flow")
    public ModelAndView dateAccessPath(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/flow");

        List<StatisticsVo> statisticsVo = iStatisticsService.dateAccessPath(vo);
        mav.addObject("list", statisticsVo);

        return mav;
    }

    /**
     * 통계관리/사이트통계 월별 유입경로

     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/monthAccessPath")
    public ModelAndView monthAccessPath(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/flow");

        List<StatisticsVo> statisticsVo=iStatisticsService.monthAccessPath(vo);
        mav.addObject("list", statisticsVo);

        return mav;
    }

    /**
     * 통계관리/사이트통계 연도별 유입경로
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/yearAccessPath")
    public ModelAndView yearAccessPath(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/flow");

        List<StatisticsVo> statisticsVo=iStatisticsService.yearAccessPath(vo);
        mav.addObject("list", statisticsVo);

        return mav;

    }

    /**
     * 통계관리/사이트통계 일별 매물공유수
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/share")
    public ModelAndView dateShareCount(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/share");

        List<StatisticsVo> statisticsVo=iStatisticsService.dateShareCount(vo);
        mav.addObject("list", statisticsVo);

        return mav;

    }

    /**
     * 통계관리/사이트통계 월별 매물공유수
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/monthShareCount")
    public ModelAndView monthShareCount(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/share");

        List<StatisticsVo> statisticsVo=iStatisticsService.monthShareCount(vo);
        mav.addObject("list", statisticsVo);

        return mav;
    }

    /**
     * 통계관리/사이트통계 연도별 매물공유수
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/yearShareCount")
    public ModelAndView yearShareCount(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/share");

        List<StatisticsVo> statisticsVo=iStatisticsService.yearShareCount(vo);
        mav.addObject("list", statisticsVo);

        return mav;

    }

    /**
     * 통계관리/사이트통계 일별 접속디바이스
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/device")
    public ModelAndView dateAccessDevice(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/device");

        List<StatisticsVo> statisticsVo=iStatisticsService.dateAccessDevice(vo);
        mav.addObject("list", statisticsVo);

        return mav;

    }

    /**
     * 통계관리/사이트통계 월별 접속디바이스
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/monthAccessDevice")
    public ModelAndView monthAccessDevice(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/device");

        List<StatisticsVo> statisticsVo=iStatisticsService.monthAccessDevice(vo);
        mav.addObject("list", statisticsVo);

        return mav;

    }

    /**
     * 통계관리/사이트통계 연도별 접속디바이스
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/yearAccessDevice")
    public ModelAndView yearAccessDevice(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/device");

        List<StatisticsVo> statisticsVo=iStatisticsService.yearAccessDevice(vo);
        mav.addObject("list", statisticsVo);

        return mav;

    }

    /**
     * 통계관리/사이트통계 일별 접속브라우저
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/browser")
    public ModelAndView dateAccessBrowser(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/browser");

        List<StatisticsVo> statisticsVo=iStatisticsService.dateAccessBrowser(vo);
        mav.addObject("list", statisticsVo);

        return mav;

    }

    /**
     * 통계관리/사이트통계 월별 접속브라우저
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/monthAccessBrowser")
    public ModelAndView monthAccessBrowser(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/browser");

        List<StatisticsVo> statisticsVo=iStatisticsService.monthAccessBrowser(vo);
        mav.addObject("list", statisticsVo);

        return mav;

    }

    /**
     * 통계관리/사이트통계 연도별 접속브라우저
     * @param vo
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping(value = "/yearAccessBrowser")
    public ModelAndView yearAccessBrowser(StatisticsVo vo) {

        ModelAndView mav = new ModelAndView("statics/browser");

        List<StatisticsVo> statisticsVo=iStatisticsService.yearAccessBrowser(vo);
        mav.addObject("list", statisticsVo);

        return mav;

    }
}
