package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by DaDa on 2018-02-06.
 * <pre>
 * kr.co.vwa.domain
 *
 * 매물관리 > 판매관리 Vo.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-02-06 오전 11:31
 */
@Data
public class SellMngVo {

    /** 매물차량번호 */
    private Long sellCarSeq;

    /** 판매상태(판매완료, 판매종료/삭제) */
    private String sellStat;

    /** 판매/종료/삭제 일자 */
    private String statDate;

    /** 종료/삭제 사유 */
    private String reason;

    /** DB 상태 */
    private String dbSts;

    /** 등록자 */
    private String creUser;

    /** 등록일자 */
    private String creDate;

    /** 수정자 */
    private String updUser;

    /** 수정일자 */
    private String updDate;


    /** 조회수 */
    private String hits;

    /** 판매기간 */
    private String sellTime;

    /** 재고기간 */
    private String stockTime;

    /** 노출상태 */
    private String cdNm;

    /** 노출여부 */
    private String viewYn;

}
