package kr.co.vwa.domain;

import lombok.Data;

import java.util.Date;

/**
 * Email VO
 */
@Data
public class EmailVo {

    /**
     *  전시장 시퀀스
     */
    private Integer exhHallSeq;

    /**
     *  이메일
     */
    private String email;

    /**
     *  대표이메일 여부
     */
    private String reprEmailYn;

    /**
     *  DB 상태
     */
    private String dbSts;

    /**
     *  등록자
     */
    private String creUser;

    /**
     *  등록일자
     */
    private Date creDate;

    /**
     *  수정자
     */
    private String updUser;

    /**
     *  수정일자
     */
    private Date updDate;

    /**
     * 화면에서 받을 파라미터 변수
     */
    private String etcEmail[];
}
