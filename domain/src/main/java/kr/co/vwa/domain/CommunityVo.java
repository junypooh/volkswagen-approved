package kr.co.vwa.domain;

import lombok.Data;

import java.util.Date;

/**
 * 커뮤니티 VO
 */
@Data
public class CommunityVo {

    /**
     * 커뮤니티시퀀스
     */
    private Integer commSeq;

    /**
     * 구분
     */
    private String type;

    /**
     * 제목
     */
    private String title;

    /**
     * 내용
     */
    private String ctnt;

    /**
     * 이미지시퀀스
     */
    private Integer imgSeq;

    /**
     * 노출여부
     */
    private String expsYn;

    /**
     * 시작일자
     */
    private String strDate;

    /**
     * 종료일자
     */
    private String endDate;

    /**
     * DB상태
     */
    private String dbSts;

    /**
     * 등록자
     */
    private String creUser;

    /**
     * 등록일자
     */
    private Date creDate;

    /**
     * 수정자
     */
    private String updUser;

    /**
     * 수정일자
     */
    private Date updDate;

    /**
     * 예약상태
     */
    private String status;

    /**
     * 파일
     */
    private FileVo file;

    /**
     * 파일 url path
     */
    private String fileUrlPath;

    /**
     * 상단고정여부
     */
    private String fixYn;

    /**
     * 정렬순서
     */
    private Integer ordNo;
}
