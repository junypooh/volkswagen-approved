package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by DaDa on 2018-01-26.
 * <pre>
 * kr.co.vwa.domain
 *
 * 내 설명글 관리 Vo.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-26 오후 1:54
 */
@Data
public class MyDiscMngVo {

    /** 설명시퀀스 */
    private Long discSeq;

    /** 관리자시퀀스 */
    private Long admSeq;

    /** 설명명 */
    private String discNm;

    /** 내용 */
    private String discCtnt;

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
