package kr.co.vwa.services;

import kr.co.vwa.domain.DashBoardVo;
import kr.co.vwa.domain.Role;
import kr.co.vwa.domain.User;
import kr.co.vwa.repository.DashBoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by junypooh on 2018-03-28.
 * <pre>
 * kr.co.vwa.services
 *
 * 관리자 대시보드 서비스 구현체
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-03-28 오후 2:08
 */
@Service
public class DashBoardService implements IDashBoardService {

    @Autowired
    private DashBoardRepository dashBoardRepository;

    @Override
    public Map<String, Object> selectDashBoardData(User user) {

        Map<String, Object> map = new HashMap<>();
        Role role = user.getRole();
        Role defaultRole = user.getDefaultRole();

        // 슈퍼관리자
        if(role == Role.VW) {
            map.put("page", "dash/vw");

            // 판매중인 매물
            Integer sellingCount = dashBoardRepository.selectNowSellingCount("VW", null);
            map.put("sellingCount", sellingCount);

            // 최근 7일간 판매가 완료된 매물
            Integer soldOutWeeklyCount = dashBoardRepository.selectSoldOutWeeklyCount("VW", null);
            map.put("soldOutWeeklyCount", soldOutWeeklyCount);

            // 최근 7일간 판매가 취소된 매물
            Integer cancelWeeklyCount = dashBoardRepository.selectCancelWeeklyCount("VW", null);
            map.put("cancelWeeklyCount", cancelWeeklyCount);

            // 매물현황
            List<DashBoardVo> itemStatusList = dashBoardRepository.selectItemStatusList("VW", null);
            map.put("itemStatusList", itemStatusList);

            // 위클리 리포트
            List<DashBoardVo> weeklyReportList = dashBoardRepository.selectWeeklyReportList();
            map.put("weeklyReportList", weeklyReportList);

            // 어제 접속자 통계
            List<DashBoardVo> yesterDayVisit = dashBoardRepository.selectYesterDayVisit();
            map.put("yesterDayVisit", yesterDayVisit);
        } else {
            // 그룹 관리자
            if(defaultRole == Role.ADMIN) {
                map.put("page", "dash/admin");

                // 판매중인 매물
                Integer sellingCount = dashBoardRepository.selectNowSellingCount("ADMIN", user.getAdmSeq());
                map.put("sellingCount", sellingCount);

                // 최근 7일간 판매가 완료된 매물
                Integer soldOutWeeklyCount = dashBoardRepository.selectSoldOutWeeklyCount("ADMIN", user.getAdmSeq());
                map.put("soldOutWeeklyCount", soldOutWeeklyCount);

                // 최근 7일간 판매가 취소된 매물
                Integer cancelWeeklyCount = dashBoardRepository.selectCancelWeeklyCount("ADMIN", user.getAdmSeq());
                map.put("cancelWeeklyCount", cancelWeeklyCount);

                // 매물현황
                List<DashBoardVo> itemStatusList = dashBoardRepository.selectItemStatusList("ADMIN", user.getAdmSeq());
                map.put("itemStatusList", itemStatusList);

            } else {
                // 그룹 운영자
                map.put("page", "dash/operator");

                // 작성중인 매물
                List<DashBoardVo> tempList = dashBoardRepository.selectOperatorData("temp", user.getAdmSeq());
                map.put("tempList", tempList);

                // 심사대기 매물
                List<DashBoardVo> evaluateList = dashBoardRepository.selectOperatorData("evaluate", user.getAdmSeq());
                map.put("evaluateList", evaluateList);
            }
        }

        return map;
    }
}
