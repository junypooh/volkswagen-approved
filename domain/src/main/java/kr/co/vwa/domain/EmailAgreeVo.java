package kr.co.vwa.domain;

import lombok.Data;

import java.util.Date;

/**
 * Created by eunsoo on 2018-03-13.
 * <pre>
 * kr.co.vwa.domain
 *
 * 이메일 동의 vo
 *
 * </pre>
 *
 * @author EunSoo, Choi
 * @see
 * @since 2018-03-13 오전 10:54
 */

@Data
public class EmailAgreeVo {

    /** 구분 */
    private String type;

    /** 보낸일자 */
    private Date sendDay;

    /** AGREE1 */
    private String agree1;

    /** AGREE2 */
    private String agree2;

    /** AGREE3 */
    private String agree3;
}
