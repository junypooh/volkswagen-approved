package kr.co.vwa.domain;

import lombok.Data;

import java.util.Date;

/**
 * 코드 VO
 */
@Data
public class CodeVo {

    /** 코드 */
    private String cd;

    /** 상위코드 */
    private String uppCd;

    /** 코드명 */
    private String cdNm;

    /** 코드설명 */
    private String cdDisc;

    /** 옵션 */
    private String opt;

    /** 옵션설명 */
    private String optDisc;

    /** 정렬 */
    private Integer ord;

    /** DB상태 */
    private String dbSts;

    /** 등록 자 */
    private String creUser;

    /** 등록 일자 */
    private Date creDate;

    /** 수정 자 */
    private String updUser;

    /** 수정 일자 */
    private Date updDate;

}
