package kr.co.vwa.domain;

import lombok.Data;

import java.util.List;

/**
 * Created by DaDa on 2018-01-26.
 * <pre>
 * kr.co.vwa.domain
 *
 * 매물설명 VO
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-26 오전 10:35
 */
@Data
public class DiscriptionVo {

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 전시장시퀀스 */
    private Long exhHallSeq;

    /** 매물설명 */
    private String sellDisc;

    /** 설명구분 [직접입력: D, 내설명글: M] */
    private String discType;

    /** 설명글 */
    private String discWrit;

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

    /** 태그 시퀀스 리스트 */
    private List<Long> tagSeqs;

}
