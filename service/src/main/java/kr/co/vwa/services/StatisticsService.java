package kr.co.vwa.services;

import kr.co.vwa.domain.StatisticsVo;
import kr.co.vwa.repository.StatisticsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by user on 2018-03-20.
 * <pre>
 * kr.co.vwa.services
 *
 * 통계관리/통계 Service
 *
 * </pre>
 *
 * @author Hana, Lee
 * @see
 * @since 2018-03-20 오후 5:42
 */
@Service
public class StatisticsService implements IStatisticsService{

    @Autowired
    private StatisticsRepository statisticsRepository;

    /**
     * 통계관리/사이트통계 일별 서비스 접속수
     * @param vo
     * @return
     */
    @Override
    public List<StatisticsVo> dateAccessService(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.dateAccessService(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 월별 서비스 접속수
     * @param vo
     * @return
     */
    @Override
    public List<StatisticsVo> monthAccessService(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.monthAccessService(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 연도별 서비스 접속수
     * @param vo
     * @return
     */
    @Override
    public List<StatisticsVo> yearAccessService(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.yearAccessService(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 일자별 유입경로
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> dateAccessPath(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.dateAccessPath(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 월별 유입경로
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> monthAccessPath(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.monthAccessPath(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 연도별 유입경로
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> yearAccessPath(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.yearAccessPath(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 일별 매물공유수
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> dateShareCount(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.dateShareCount(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 월별 매물공유수
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> monthShareCount(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.monthShareCount(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 연도별 매물공유수
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> yearShareCount(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.yearShareCount(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 일별 접속디바이스
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> dateAccessDevice(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.dateAccessDevice(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 월별 접속디바이스
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> monthAccessDevice(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.monthAccessDevice(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 연도별 접속디바이스
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> yearAccessDevice(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.yearAccessDevice(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 일별 접속브라우저
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> dateAccessBrowser(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.dateAccessBrowser(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 월별 접속브라우저
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> monthAccessBrowser(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.monthAccessBrowser(vo);
        return statisticsVo;
    }

    /**
     * 통계관리/사이트통계 연도별 접속브라우저
     * 
     * @return
     */
    @Override
    public List<StatisticsVo> yearAccessBrowser(StatisticsVo vo) {
        List<StatisticsVo> statisticsVo = statisticsRepository.yearAccessBrowser(vo);
        return statisticsVo;
    }


}
