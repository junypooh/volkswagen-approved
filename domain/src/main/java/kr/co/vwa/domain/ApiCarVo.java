package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by junypooh on 2018-01-29.
 * <pre>
 * kr.co.vwa.domain
 *
 * 차량API VO
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-29 오후 4:48
 */
@Data
public class ApiCarVo {

    /**
     * 차량 번호
     */
    private String carNo;

    /**
     * JSON Data
     */
    private String dataJson;

    /**
     * 등록자
     */
    private String creUser;
}
