package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by DaDa on 2018-01-16.
 * 코드관리계층 하위 VO
 */
@Data
public class HierarckySubVo {

    /** 상세코드 */
    private String value;

    /** 상세코드명 */
    private String text;

    /** 체크여부 */
    private String checked;

    /** 의견 */
    private String opinion;

    /** 라디오 name */
    private String radioName;
}
