package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by DaDa on 2018-01-19.
 * <pre>
 * kr.co.vwa.domain
 *
 * 차량매물상태이력 Vo.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-19 오후 4:12
 */
@Data
public class CarSellStatHisVo {

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 차량상태코드 */
    private String carStatCd;

    /** 사유 */
    private String reason;

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

    /** 구분(승인대기,승인,반려) */
    private String type;

}
