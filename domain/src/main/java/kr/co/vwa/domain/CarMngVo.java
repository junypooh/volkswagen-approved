package kr.co.vwa.domain;

import lombok.Data;

import java.sql.Date;

/**
 * 차량관리 VO
 */
@Data
public class CarMngVo {

    /** 차량시퀀스 */
    private Integer carSeq;

    /** 제조사 */
    private String mak;

    /** 모델 */
    private String model;

    /** 세부모델 */
    private String detailModel;

    /** 판매시작연도 */
    private String sellStrYear;

    /** 판매종료연도 */
    private String sellEndYear;

    /** 연료 */
    private String fuel;

    /** 배기량 */
    private String disp;

    /** 등급 */
    private String rating;

    /** 세부등급 */
    private String detailRating;

    /** 등급시작연도 */
    private String ratingStrYear;

    /** 등급종료연도 */
    private String ratingEndYear;

    /** 사용여부 */
    private String useYn;

    /** DB상태 */
    private String dbSts;

    /** 등록자 */
    private String creUser;

    /** 등록일자 */
    private Date creDate;

    /** 수정자 */
    private String updUser;

    /** 수정일자 */
    private Date updDate;

}
