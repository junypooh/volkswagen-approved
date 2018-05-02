package kr.co.vwa.domain;

import lombok.Data;

import java.util.Date;

/**
 * 자주하는질문 VO
 */
@Data
public class FaqVo {

    /** 자주하는질문 시퀀스 */
    private Integer faqSeq;

    /** 유형코드 */
    private String categoryCd;

    /** 제목 */
    private String title;

    /** 내용 */
    private String ctnt;

    /** 노출여부 */
    private String expsYn;

    /** 고정여부 */
    private String fixYn;

    /** 정렬순서 */
    private Integer ordNo;

    /** DB 상태 */
    private String dbSts;

    /** 등록자 */
    private String creUser;

    /** 등록일자 */
    private Date creDate;

    /** 수정자 */
    private String updUser;

    /** 수정일자 */
    private Date updDate;

    /** 유형명 */
    private String categoryNm;
}
