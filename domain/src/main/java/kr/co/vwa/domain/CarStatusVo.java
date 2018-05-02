package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by DaDa on 2018-01-22.
 * <pre>
 * kr.co.vwa.domain
 *
 * 자동차 상태 표시 Vo.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-22 오후 3:00
 */
@Data
public class CarStatusVo {

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 부위코드 */
    private String partCd;

    /** 교환 */
    private String exch;

    /** 판금/용접 */
    private String weld;

    /** 부식 */
    private String corr;

    /** DB 상태 */
    private String dbSts;

    /** 등록자 */
    private String creUser;

    /** 등록일 */
    private String creDate;

    /** 수정자 */
    private String updUser;

    /** 수정일 */
    private String updDate;

    /** 번호 */
    private String no;

    /** 코드 */
    private String cd;

    /** 코드명 */
    private String cdNm;

}
