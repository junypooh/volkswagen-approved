package kr.co.vwa.domain;

import kr.co.vwa.annotation.ExcelFieldName;
import lombok.Data;

import java.util.List;

/**
 * Created by DaDa on 2018-02-07.
 * <pre>
 * kr.co.vwa.domain
 *
 * 매물관리 리스트 Vo.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-02-07 오후 2:08
 */
@Data
public class ItemVo extends PageBaseVo {

    /** 권한구분 */
    private String authType;

    /** 관리자시퀀스 */
    private Long admSeq;

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 차량매물번호 */
    @ExcelFieldName(name="매물번호" ,order=1)
    private String carSellNo;

    /** 제조사 */
    @ExcelFieldName(name="제조사" ,order=2)
    private String mak;

    /** 모델 */
    @ExcelFieldName(name="모델" ,order=3)
    private String model;

    /** 연식 */
    @ExcelFieldName(name="연식" ,order=4)
    private String prodYear;

    /** 형식연도 */
    private String fromYear;

    /** VWA */
    @ExcelFieldName(name="VWA" ,order=6)
    private String vwa;

    /** 등록자 */
    @ExcelFieldName(name="등록자" ,order=10)
    private String creUser;

    /** 조회수 */
    @ExcelFieldName(name="조회수" ,order=13)
    private String hits;

    /** 가격 */
    @ExcelFieldName(name="가격(만원)" ,order=5)
    private String sellPrice;

    /** 상태코드 */
    private String carStatCd;

    /** 상태 */
    @ExcelFieldName(name="상태" ,order=7)
    private String cdNm;

    /** 전시장(약자) */
    @ExcelFieldName(name="전시장" ,order=8)
    private String hallType;

    /** 전시장 */
    private String type;

    /** 지점 */
    @ExcelFieldName(name="지점" ,order=9)
    private String storeNm;

    /** 판매기간 */
    @ExcelFieldName(name="판매기간" ,order=11)
    private String sellTime;

    /** 재고기간 */
    @ExcelFieldName(name="재고기간" ,order=12)
    private String stockTime;

    /** 차량썸네일 */
    private String fileUrl;

    /** 파일경로 */
    private String fileUrlPath;

    /** 판매시작일자 */
    private String sellStrDate;

    /** 판매종료일자 */
    private String sellEndDate;

    /** 검색 Text */
    private String searchWord;

    /** 상태코드 List */
    private List<String> carStatCds;

    /** 전시장시퀀스 */
    private Long exhHallSeq;

    /** 등록자시퀀스 */
    private Long creAdmSeq;

    /** 등록일자 */
    private String creDate;

    /** 차량상태등록메뉴 */
    private String carStatMnu;

    /** 노출, 비노출 */
    private String disp;

    /** 정렬컬럼명 */
    private String orderColumn;

    /** 정렬타입 */
    private String orderType;

    /** 상태체크타입 */
    private String checkType;





}
