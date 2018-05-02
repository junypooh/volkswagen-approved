package kr.co.vwa.domain;

import kr.co.vwa.annotation.ExcelFieldName;
import lombok.Data;

import java.util.Date;

/**
 * 주간보고 VO
 */
@Data
public class WeeklyDataVo {

    /**
     * 주간보고 시퀀스
     */
    private Integer weekRepSeq;

    /**
     * 관리자 시퀀스
     */
    private Integer admSeq;

    /**
     * 차대번호
     */
    @ExcelFieldName(name="차대번호" ,order=1)
    private String chasNo;

    /**
     * 구분
     */
    @ExcelFieldName(name="구분" ,order=2)
    private String type;

    /**
     * 딜러사명
     */
    @ExcelFieldName(name="딜러사명" ,order=3)
    private String dealCorpNm;

    /**
     * 전시장명
     */
    @ExcelFieldName(name="전시장명" ,order=4)
    private String exhHallNm;

    /**
     * 브랜드
     */
    @ExcelFieldName(name="브랜드" ,order=5)
    private String brand;

    /**
     * 모델그룹
     */
    @ExcelFieldName(name="모델그룹" ,order=6)
    private String modelGroup;

    /**
     * 모델명
     */
    @ExcelFieldName(name="모델명" ,order=7)
    private String modelNm;

    /**
     * 등록번호
     */
    @ExcelFieldName(name="등록번호" ,order=8)
    private String creNo;

    /**
     * 연식
     */
    @ExcelFieldName(name="연식" ,order=9)
    private String prodYear;

    /**
     * 주행거리
     */
    @ExcelFieldName(name="주행거리" ,order=10)
    private String driveDist;

    /**
     * 우선등록일자
     */
    @ExcelFieldName(name="우선등록일자" ,order=11)
    private String firstCreDate;

    /**
     * 매입일
     */
    @ExcelFieldName(name="매입일" ,order=12)
    private String buyDate;

    /**
     * 판매일
     */
    @ExcelFieldName(name="판매일" ,order=13)
    private String sellDate;

    /**
     * 고객유입경로
     */
    @ExcelFieldName(name="고객유입경로" ,order=14)
    private String inflowPath;

    /**
     * 매물구분
     */
    @ExcelFieldName(name="매물구분" ,order=15)
    private String sellType;

    /**
     * 매입형태
     */
    @ExcelFieldName(name="매입형태" ,order=16)
    private String buyType;

    /**
     * 매도가
     */
    @ExcelFieldName(name="매도가" ,order=17)
    private String sellCost;

    /**
     * 매입가
     */
    @ExcelFieldName(name="매입가" ,order=18)
    private String buyCost;

    /**
     * 수리정비비용
     */
    @ExcelFieldName(name="수리정비비용" ,order=19)
    private String servicingCost;

    /**
     * 커미션
     */
    @ExcelFieldName(name="커미션" ,order=20)
    private String commission;

    /**
     * 상품화비용
     */
    @ExcelFieldName(name="상품화비용" ,order=21)
    private String commercializeCost;

    /**
     * 보관비
     */
    @ExcelFieldName(name="보관비" ,order=22)
    private String keepCost;

    /**
     * 운반비
     */
    @ExcelFieldName(name="운반비" ,order=23)
    private String conveyCost;

    /**
     * 연장보증보험료
     */
    @ExcelFieldName(name="연장보증보험료" ,order=24)
    private String warrInsurCost;

    /**
     * 명의변경비용
     */
    @ExcelFieldName(name="명의변경비용" ,order=25)
    private String transferFee;

    /**
     * 매입진행인
     */
    @ExcelFieldName(name="매입진행인" ,order=26)
    private String buyProgress;

    /**
     * 매입담당
     */
    @ExcelFieldName(name="매입담당" ,order=27)
    private String buyResponsibility;

    /**
     * 판매사원
     */
    @ExcelFieldName(name="판매사원" ,order=28)
    private String sellEmpl;

    /**
     * 고객유형
     */
    @ExcelFieldName(name="고객유형" ,order=29)
    private String customerType;

    /**
     * 금융상품유형
     */
    @ExcelFieldName(name="금융상품유형" ,order=30)
    private String financeProdType;

    /**
     * 금융사
     */
    @ExcelFieldName(name="금융사" ,order=31)
    private String financeCorp;

    /**
     * DB 상태
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

}
