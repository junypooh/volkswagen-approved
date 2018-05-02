package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by junypooh on 2018-03-02.
 * <pre>
 * kr.co.vwa.domain
 *
 * Share Vo
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-03-02 오후 12:54
 */
@Data
public class ShareVo {

    /** 플랫폼(페이스북,트위터,카카오,메일, URL) */
    private String platform;

    /** Device */
    private String device;

    /** OS */
    private String os;

    /** OS Group */
    private String osGroup;

    /** browser */
    private String browser;

    /** browser Group */
    private String browserGroup;
}
