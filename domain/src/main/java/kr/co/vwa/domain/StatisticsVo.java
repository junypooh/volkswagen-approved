package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by user on 2018-03-19.
 * <pre>
 * kr.co.vwa.domain
 *
 * 통계관리/통계 Vo
 *
 * </pre>
 *
 * @author Hana, Lee
 * @see
 * @since 2018-03-19 오후 5:09
 */

@Data
public class StatisticsVo {

    /**
     * 메뉴 명
     */
    private String menu;

    /**
     * PC COUNT
     */
    private String pc;

    /**
     * MOBILE COUNT
     */
    private String mo;

    /**
     * 그 외 COUNT
     */
    private String un;

    /**
     * TOTAL PERCENT (총합계의 비율)
     */
    private Double per;

    /**
     * TOTAL COUNT (총 갯수)
     */
    private String tot;

    /**
     * 시작일
     */
    private String startDate;

    /**
     * 종료일
     */
    private String endDate;

    /**
     * 유입경로
     */
    private String refererSite;

    /**
     * 플랫폼
     */
    private String platform;

    /**
     * 디바이스
     */
    private String device;

    /**
     * 브라우저
     */
    private String browser;

}
