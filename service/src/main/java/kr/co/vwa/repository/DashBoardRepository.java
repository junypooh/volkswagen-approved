package kr.co.vwa.repository;

import kr.co.vwa.domain.DashBoardVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by junypooh on 2018-03-28.
 * <pre>
 * kr.co.vwa.repository
 *
 * 관리자 대시보드 Repository
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-03-28 오후 2:16
 */
@Repository
public interface DashBoardRepository {

    /**
     * 작성중인 매물 / 심사대기 매물 (그룹운영자 권한)
     * @param type
     * @return
     */
    List<DashBoardVo> selectOperatorData(@Param("type") String type, @Param("admSeq") Long admSeq);

    /**
     * 판매중인 매물 (그룹관리자/슈퍼관리자 권한)
     * @param roleCd
     * @param admSeq
     * @return
     */
    Integer selectNowSellingCount(@Param("roleCd") String roleCd, @Param("admSeq") Long admSeq);

    /**
     * 최근 7일간 판매가 완료된 매물 (그룹관리자/슈퍼관리자 권한)
     * @param roleCd
     * @param admSeq
     * @return
     */
    Integer selectSoldOutWeeklyCount(@Param("roleCd") String roleCd, @Param("admSeq") Long admSeq);

    /**
     * 최근 7일간 판매가 취소된 매물 (그룹관리자/슈퍼관리자 권한)
     * @param roleCd
     * @param admSeq
     * @return
     */
    Integer selectCancelWeeklyCount(@Param("roleCd") String roleCd, @Param("admSeq") Long admSeq);

    /**
     * 매물현황 (그룹관리자/슈퍼관리자 권한)
     * @param roleCd
     * @param admSeq
     * @return
     */
    List<DashBoardVo> selectItemStatusList(@Param("roleCd") String roleCd, @Param("admSeq") Long admSeq);

    /**
     * 위클리 리포트 (슈퍼관리자 권한)
     * @return
     */
    List<DashBoardVo> selectWeeklyReportList();

    /**
     * 어제 접속자 통계 (슈퍼관리자 권한)
     * @return
     */
    List<DashBoardVo> selectYesterDayVisit();
}
