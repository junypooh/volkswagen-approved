package kr.co.vwa.repository;

import kr.co.vwa.domain.StatisticsVo;

import java.util.List;

/**
 * Created by user on 2018-03-19.
 * <pre>
 * kr.co.vwa.repository
 *
 * 통계 Repository
 *
 * </pre>
 *
 * @author Hana, Lee
 * @see
 * @since 2018-03-19 오후 5:53
 */
public interface StatisticsRepository {

    /**
     * 통계관리/사이트통계 일별 접속수
     * @param vo
     * @return
     */
    List<StatisticsVo> dateAccessService(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 월별 접속수
     * @param vo
     * @return
     */
    List<StatisticsVo> monthAccessService(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 연도별 접속수
     * @param vo
     * @return
     */
    List<StatisticsVo> yearAccessService(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 일별 유입경로
     * @param vo
     * @return
     */
    List<StatisticsVo> dateAccessPath(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 월별 유입경로
     * @param vo
     * @return
     */
    List<StatisticsVo> monthAccessPath(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 연도별 유입경로
     */
    List<StatisticsVo> yearAccessPath(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 일별 매물공유수
     * @param vo
     * @return
     */
    List<StatisticsVo> dateShareCount(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 월별 매물공유수
     * @param vo
     * @return
     */
    List<StatisticsVo> monthShareCount(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 연도별 매물공유수
     * @param vo
     * @return
     */
    List<StatisticsVo> yearShareCount(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 일별 접속디바이스
     * 
     * @return
     */
    List<StatisticsVo> dateAccessDevice(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 월별 접속디바이스
     * 
     * @return
     */
    List<StatisticsVo> monthAccessDevice(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 연도별 접속디바이스
     * 
     * @return
     */
    List<StatisticsVo> yearAccessDevice(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 일별 접속브라우저
     * 
     * @return
     */
    List<StatisticsVo> dateAccessBrowser(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 월별 접속브라우저
     * 
     * @return
     */
    List<StatisticsVo> monthAccessBrowser(StatisticsVo vo);

    /**
     * 통계관리/사이트통계 연도별 접속브라우저
     * 
     * @return
     */
    List<StatisticsVo> yearAccessBrowser(StatisticsVo vo);
}
