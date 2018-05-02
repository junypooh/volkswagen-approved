package kr.co.vwa.domain;

import lombok.Data;

import java.util.List;

/**
 * 옵션 VO
 */
@Data
public class OptionVo {

    /** 옵션시퀀스 */
    private Integer optSeq;

    /** 유형코드 */
    private String categoryCd;

    /** 옵션명 */
    private String optNm;

    /** 썸네일 ON 이미지 */
    private Integer thumImgOn;

    /** 썸네일 OFF 이미지 */
    private Integer thumImgOff;

    /** 주요옵션여부 */
    private String majOptYn;

    /** 노출여부 */
    private String expsYn;

    /** 정렬순서 */
    private Integer ordNo;

    /** 주요정렬순서 */
    private Integer majOrdNo;

    /** DB상태 */
    private String dbSts;

    /** 등록자 */
    private String creUser;

    /** 등록일자 */
    private String creDate;

    /** 수정자 */
    private String updUser;

    /** 수정일자 */
    private String updDate;

    /** 카테고리 이름 */
    private String cateName;

    /** 썸네일 ON 이미지 파일VO */
    private FileVo thumImgOnFile;

    /** 썸네일 ON 이미지 파일VO */
    private FileVo thumImgOffFile;

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 흡연여부 [비흡연 : N, 흡연: Y] */
    private String smokYn;

    /** 차량용도 [출퇴근: C, 레저: L, 영업: B] */
    private String carUse;

    /** 체크여부 */
    private String checked;

    /** option sequence List */
    private List<Long> options;

    /** 옵션 리스트일부 */
    private List<OptionVo> optList;

    /** 옵션 설명 */
    private String disc;

    /** 폭스바겐차량여부 */
    private String vwYn;
}
