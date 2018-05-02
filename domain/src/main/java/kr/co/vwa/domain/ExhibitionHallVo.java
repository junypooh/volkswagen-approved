package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by DaDa on 2018-01-26.
 * <pre>
 * kr.co.vwa.domain
 *
 * 전시장관리/Front Vo.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-26 오전 10:15
 */
@Data
public class ExhibitionHallVo {

    /** 전시장시퀀스 */
    private Long exhHallSeq;

    /** 구분(Meister Motors, Klasse Auto) */
    private String type;

    /** 상호 */
    private String storeNm;

    /** 전화번호 */
    private String tel;

    /** 시군 */
    private String sigun;

    /** 주소 */
    private String addr;

    /** 상세주소 */
    private String detailAddr;

    /** 노출여부 */
    private String expsYn;

    /** 노출순서 */
    private String expsNo;

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

    /** 대표 이메일 */
    private String email;

}
