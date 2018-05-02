package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by junypooh on 2018-02-07.
 * <pre>
 * kr.co.vwa.domain
 *
 * 차량 기본 정보 Vo
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-07 오후 5:08
 */
@Data
public class CarInfoVo {

    /** 매물차량 시퀀스 */
    private Long sellCarSeq;

    /** 제조사 */
    private String mak;

    /** 모델 */
    private String model;

    /** 세부모델 */
    private String detailModel;

    /** 차종 */
    private String carType;

    /** 연료 */
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

    /** 내장 색상 */
    private String innerColor;

    /** 주행거리 */
    private String driveDist;

    /** 등록어드민시퀀스 */
    private Long creAdmSeq;

    /** 등록어드민아이디 */
    private String creUser;

    /** 수정어드민아이디 */
    private String updUser;
}
