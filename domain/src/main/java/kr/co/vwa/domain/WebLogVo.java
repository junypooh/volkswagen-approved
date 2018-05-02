package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by junypooh on 2018-02-27.
 * <pre>
 * kr.co.vwa.domain
 *
 * WebLog Vo
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-27 오후 3:32
 */
@Data
public class WebLogVo {

    /** 요청일시 */
    private String reqDtm;

    /** 요청연도 */
    private String reqYear;

    /** 요청월 */
    private String reqMonth;

    /** 요청일자 */
    private String reqDate;

    /** 요청시각 */
    private String reqTime;

    /** 현재 URL */
    private String url;

    /** REFERER 전문 */
    private String referer;

    /** REFERER 도메인 */
    private String refererSite;

    /** 현재 접속한 메뉴명 */
    private String menu;

    /** 젤 하위 메뉴 URL */
    private String page;

    /** 접속한 장치(PC/mobile/tablet) */
    private String device;

    /** 접속한 장치(PC/mobile)의 OS */
    private String os;

    /** 접속한 장치(PC/mobile)의 OS_GROUP*/
    private String osGroup;

    /** 접속한 browser 정보 */
    private String browser;

    /** 접속한 browser_group 정보 */
    private String browserGroup;

    /** 접속자 IP 정보 */
    private String ipAddress;

    /** request user agent 값 */
    private String userAgent;
}
