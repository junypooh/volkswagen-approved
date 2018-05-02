package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by DaDa on 2018-03-23.
 * <pre>
 * kr.co.vwa.domain
 *
 * 매물 판매 기간 Vo
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-03-23 오전 11:19
 */
@Data
public class SellDateInfoVo {

    /** 매물일자시퀀스 */
    private Long sellDateSeq;

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 차량상태코드 */
    private String carStatCd;

    /** 판매시작일자 */
    private String sellStrDate;

    /** 판매종료일자 */
    private String sellEndDate;

    /** 판매종료/취소 사유 */
    private String reason;

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


}
