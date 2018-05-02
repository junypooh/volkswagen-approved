package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by junypooh on 2018-03-28.
 * <pre>
 * kr.co.vwa.domain
 *
 * 관리자 대시보드 Vo
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-03-28 오후 2:22
 */
@Data
public class DashBoardVo {

    /** 구분 */
    private String type;

    /** 전시장(약자) */
    private String hallType;

    /** 전시장 */
    private String storeNm;

    /** 판매중 */
    private Integer sellCnt;

    /** 완료 */
    private Integer compCnt;

    /** 취소 */
    private Integer cancelCnt;

    /** 위클리 SEQ */
    private Integer weekRepSeq;

    /** 유형 코드 */
    private String categoryCd;

    /** 유형 */
    private String categoryNm;

    /** 제목 */
    private String title;

    /** 업로드기간 시작일 */
    private String strDate;

    /** 업로드기간 종료일 */
    private String endDate;

    /** 상태 */
    private String status;

    /** 완료 건수 */
    private Integer count;

    /** 디바이스 */
    private String device;

    /** 접속수 */
    private Integer tot;

    /** 비율 */
    private Double percent;

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 차량매물번호 */
    private String carSellNo;

    /** 제조사 */
    private String mak;

    /** 모델 */
    private String model;

    /** 상세 모델 */
    private String detailModel;

    /** 형식연도 */
    private String fromYear;

    /** 가격 */
    private String sellPrice;

    /** VWA */
    private String certYn;

    /** 전시장시퀀스 */
    private Long exhHallSeq;
}
