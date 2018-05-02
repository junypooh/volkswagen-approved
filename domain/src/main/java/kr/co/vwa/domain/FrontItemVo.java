package kr.co.vwa.domain;

import lombok.Data;

import java.util.List;

/**
 * Created by DaDa on 2018-02-13.
 * <pre>
 * kr.co.vwa.domain
 *
 * 매물관리/Front VO
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-02-13 오후 6:16
 */
@Data
public class FrontItemVo extends PageBaseVo {

    /** 등급 */
    private String rating;

    /** 세부등급 */
    private String detailRating;

    /** 전시장 정보 */
    private String branch;

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 매물 번호 */
    private String carSellNo;

    /** 제조사 */
    private String mak;

    /** 모델 */
    private String model;

    /** 상세모델 */
    private String detailModel;

    /** 형식연도 */
    private String fromYear;

    /** 주행거리 */
    private String driveDist;

    /** 연료 */
    private String fuel;

    /** 변속기 */
    private String gear;

    /** 인증여부 */
    private String certYn;

    /** 차종 */
    private String carType;

    /** 차량 색상 */
    private String color;

    /** 차량 내장 색상 */
    private String innerColor;

    /** 차량상태코드 */
    private String carStatCd;

    /** new 라벨 여부 */
    private String labelYn;

    /** 판매금액 */
    private String sellPrice;

    /** 월납입금 */
    private String monPayment;

    /** 시군 */
    private String sigun;

    /** 전시장 이름 */
    private String storeNm;

    /** 전시장 구분 */
    private String type;

    /** 파일경로 */
    private String fileUrl;

    /** TAG List */
    private List<TagVo> tagVos;

    /** S3 file Url */
    private String fileUrlPath;

    /** 정렬 구분 */
    private String orderType;


    /** 검색 - 시작 가격 */
    private Integer strSellPrice;

    /** 검색 - 종료 가격 */
    private Integer endSellPrice;

    /** 검색 - 시작 연식 */
    private Integer strFromYear;

    /** 검색 - 종료 연식 */
    private Integer endFromYear;

    /** 검색 - 시작 주행거리 */
    private Integer strDriveDist;

    /** 검색 - 종료 주행거리 */
    private Integer endDriveDist;

    /** 검색 Text */
    private String searchWord;

    /** 차량매물번호 List */
    private List<Long> sellCarSeqs;

    /** 조회 종류(추천:recommend) */
    private String selectType;

    /** 메일 보내기 (이름) */
    private String mailUserNm;

    /** 메일 보내기 (이메일 주소) */
    private String mailAddr;

    /** 메인 보내기 (메일 내용) */
    private String mailContents;

    /** 비교하기 앞 차량시퀀스 */
    private Long firstSellCarSeq;

    /** 비교하기 뒤 차량시퀀스스 */
    private Long lastSellCarSeq;

    /** 검색기능 유지 여부 */
    private String retainYn;

    /** 미리보기 여부 */
    private String previewYn;

}
