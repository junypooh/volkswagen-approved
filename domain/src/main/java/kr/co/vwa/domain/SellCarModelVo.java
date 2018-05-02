package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by DaDa on 2018-01-16.
 * <pre>
 * kr.co.vwa.domain.sell
 *
 * 매물관리 > 차량기본정보 Vo
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-16 오후 5:09
 */
@Data
public class SellCarModelVo {

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 차량번호 */
    private String carSellNo;

    /** 제조사 */
    private String mak;

    /** 모델 */
    private String model;

    /** 세부모델 */
    private String detailModel;

    /** 차종 */
    private String carType;

    /** 연료  */
    private String fuel;

    /** 등급 */
    private String rating;

    /** 세부등급 */
    private String detailRating;

    /** 수입구분 */
    private String impoType;

    /** 인증여부 */
    private String certYn;

    /** 연식 */
    private String prodYear;

    /** 형식연도 */
    private String fromYear;

    /** 배기량 */
    private String disp;

    /** 변속기 */
    private String gear;

    /** 색상 */
    private String color;

    /** 차량 내장 색상 */
    private String innerColor;

    /** 주행거리 */
    private String driveDist;

    /** 조회수 */
    private String hits;

    /** 승인요청가능여부 */
    private String apprReqPosiYn;

    /** DB상태 */
    private String dbSts;

    /** 등록자 */
    private String creUser;

    /** 등록일 */
    private String creDate;

    /** 매물차량상태코드 */
    private String carStatCd;

    /** 사유 */
    private String reason;
}
