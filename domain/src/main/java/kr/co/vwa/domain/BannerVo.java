package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by junypooh on 2018-01-15.
 * <pre>
 * kr.co.vwa.domain.banner
 *
 * 배너 VO
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-15 오전 11:23
 */
@Data
public class BannerVo {

    /** 시퀀스 */
    private Integer bannerSeq;

    /** 제목 */
    private String title;

    /** 내용 */
    private String ctnt;

    /** 링크 */
    private String linkUrl;

    /** 새창여부 */
    private String newWinYn;

    /** 이미지 시퀀스 */
    private Integer imgSeq;

    /** 노출여부 */
    private String expsYn;

    /** 시작날짜 */
    private String strDate;

    /** 마지막날짜 */
    private String endDate;

    /** 순서 */
    private Integer ordNo;

    /** DB상태 */
    private String dbSts;

    /** 등록자 */
    private String creUser;

    /** 등록날짜 */
    private String creDate;

    /** 수정자 */
    private String updUser;

    /** 수정날짜 */
    private String updDate;

    /** 비교용 오늘날짜 */
    private String today;

    /** 수정Form,등록Form 비교 */
    private int flag;

    /** 이미지 파일 정보*/
    private FileVo file;

    /** 이미지 파일 경로*/
    private String fileUrl;
}
