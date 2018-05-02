package kr.co.vwa.services;

import kr.co.vwa.domain.AuthorityVo;
import kr.co.vwa.domain.WeeklyDataVo;
import kr.co.vwa.domain.WeeklyDetailVo;
import kr.co.vwa.domain.WeeklyVo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * 주간보고 Service
 */
public interface IWeeklyService {

    /**
     * 통계관리/목록 관리자 전체 개수 조회
     * @param searchParam
     * @return
     */
    int selectWeeklyListTotalCount(Map<String, Object> searchParam);

    /**
     * 통계관리/목록 코드값에 따른 관리자 조회
     * @param searchParam
     * @return
     */
    List<WeeklyVo> WeeklyListSelect(Map<String, Object> searchParam);

    /**
     * 통계관리/weekly report/상세 weekly report 정보 조회
     * @param weekly
     * @return
     */
    WeeklyVo selectWeekly(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/모달팝업 관리자 전체정보조회
     * @param weekly
     * @return
     */
    List<AuthorityVo> selectBranchAuthList(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/상세 수정
     * @param weekly
     * @return
     */
    int updateWeekly(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/등록
     * @param weekly
     * @return
     */
    WeeklyVo registeWeekly(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/등록 detail부분
     * @param admSeq
     * @param weekRepSeq
     * @param strDate
     * @param endDate
     * @return
     */
    int registeWeeklyDetail(Integer[] admSeq,Integer weekRepSeq,String[] strDate, String[] endDate);

    /**
     * 통계관리/weekly report/상세 모달팝업 저장
     * @param weekly
     * @return
     */
    int updateModal(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/상세 삭제
     * @param weekly
     */
    void deleteWeekly(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/상세 엑셀 업로드
     * @param weeklyFile
     * @param weeklyDetail
     */
    void readExcel(MultipartFile weeklyFile, WeeklyDetailVo weeklyDetail);

    /**
     * 통계관리/weekly report/상세 엑셀다운로드
     * @param weekly
     * @return
     */
    List<WeeklyDataVo> selectWeeklyDataList(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/상세 파일삭제
     * @param weeklyDetail
     * @return
     */
    int deleteFile(WeeklyDetailVo weeklyDetail);
}
