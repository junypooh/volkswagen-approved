package kr.co.vwa.domain;

import lombok.Data;

import java.util.List;

/**
 * Created by DaDa on 2018-01-18.
 * <pre>
 * kr.co.vwa.domain
 *
 * 가격/사고이력 Vo.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-18 오후 1:46
 */
@Data
public class PriceTroubleHistoryVo {

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 판매구분 */
    private String sellType;

    /** 판매가격 */
    private String sellPrice;

    /** 월납입금 */
    private String monPayment;

    /** 품질 점검일 */
    private String qualityChkDay;

    /** 테크니션 일자 */
    private String techDate;

    /** 테크니션 성명 */
    private String techNm;

    /** 서비스어드바이저 일자 */
    private String svcAdvDate;

    /** 서비스어드바이저 성명 */
    private String svcAdvNm;

    /** 서비스매니저 일자 */
    private String svcMngDate;

    /** 서비스매니저 성명 */
    private String svcMngNm;

    /** 인증중고차 일자 */
    private String authCarDate;

    /** 인증중고차 성명 */
    private String authCarNm;

    /** 파일시퀀스 */
    private Long fileSeq;

    /** WARRANTY */
    private String wrt;

    /** WARRANTY PLUS */
    private String wrtPlus;

    /** 압류 */
    private String seize;

    /** 저당 */
    private String pled;

    /** 사고이력유무 */
    private String accidHisYn;

    /** DB상태 */
    private String dbSts;

    /** 등록자 */
    private String creUser;

    /** 등록일 */
    private String creDate;

    /** 수정자 */
    private String updUser;

    /** 수정일 */
    private String updDate;

    /** 인증차량 품질보증 데이터 상세코드 */
    private List<String> detailCds;

    /**
     * 88가지 품질 점검 파일
     */
    private FileVo qualityFile;

    /** 번호 */
    private String no;

    /** 상위코드 */
    private String uppCd;

    /** 코드 */
    private String cd;

    /** 코드명 */
    private String cdNm;

    /** 수리/교환 내역 */
    private String repairCtnt;

    /** 점검여부 */
    private String confYn;

    /** 차대번호  */
    private String chasNo;

    /** 사고이력 */
    private String accidHisNm;

    /** 88가지 품질 점검 정비내역 리스트 */
    private List<PriceTroubleHistoryVo> qualityList;


}
