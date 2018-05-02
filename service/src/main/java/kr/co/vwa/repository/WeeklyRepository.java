package kr.co.vwa.repository;

import kr.co.vwa.domain.AuthorityVo;
import kr.co.vwa.domain.WeeklyDataVo;
import kr.co.vwa.domain.WeeklyDetailVo;
import kr.co.vwa.domain.WeeklyVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 주간보고 Repository
 */
@Repository
public interface WeeklyRepository {

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
     * 통계관리/weekly report/모달팝업 관리자 전체조회
     * @return
     */
    List<AuthorityVo> selectBranchAuthList(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/상세 weekly report 수정
     * @param weeklyVo
     * @return
     */
    int updateWeekly(WeeklyVo weeklyVo);

    /**
     * 통계관리/weekly report/상세 detail 삭제
     * @param weeklyDetail
     */
    void deleteWeeklyDetail(WeeklyDetailVo weeklyDetail);

    /**
     * 통계관리/weekly report/상세 업로드했던 데이터 삭제
     * @param weeklyDetail
     */
    void deleteWeeklyData(WeeklyDetailVo weeklyDetail);

    /**
     * 통계관리/weekly report/상세 detail 등록/수정
     * @param weeklyDetail
     */
    void upsertWeeklyDetail(WeeklyDetailVo weeklyDetail);

    /**
     * 통계관리/weekly report/등록
     * @param weekly
     * @return
     */
    int registeWeekly(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/등록 detail부분
     * @param weeklyDetailVo
     * @return
     */
    int registeWeeklyDetail(WeeklyDetailVo weeklyDetailVo);

    /**
     * 통계관리/weekly report/상세 모달팝업 저장
     * @param weeklyDetail
     */
    void upsertModalSave(WeeklyDetailVo weeklyDetail);

    /**
     * 통계관리/weekly report/상세 weekly 삭제
     * @param weekly
     */
    void deleteWeekly(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/상세 삭제할 weekly의 모든 detail 삭제
     * @param weekly
     */
    void deleteAllWeeklyDetail(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/상세 삭제할 weekly의 모든 data 삭제
     * @param weekly
     */
    void deleteAllWeeklyData(WeeklyVo weekly);

    /**
     * 통계관리/weekly report/상세 파일첨부 weeklyDetail 수정
     * @param weeklyDetail
     */
    void updateWeeklyDetail(WeeklyDetailVo weeklyDetail);

    /**
     * 통계관리/weekly report/상세 파일첨부 weeklyData 저장
     * @param weeklyDataList
     */
    void saveWeeklyData(List<WeeklyDataVo> weeklyDataList);

    /**
     * 통계관리/weekly report/상세 엑셀다운로드
     * @param weeklyVo
     * @return
     */
    List<WeeklyDataVo> excelDownload(WeeklyVo weeklyVo);

    /**
     * 통계관리/weekly report/상세 Detail 파일명삭제
     * @param weeklyDetail
     * @return
     */
    int updateFileName(WeeklyDetailVo weeklyDetail);
}
