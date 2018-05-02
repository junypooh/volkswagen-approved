package kr.co.vwa.domain;

import lombok.Data;

import java.util.List;

/**
 * Created by DaDa on 2018-01-16.
 * 코드관리계층 VO
 */
@Data
public class HierarckyVo {

    /** 1Depth */
    private String path;

    /** 2Depth */
    private String device;

    /** 3Depth */
    private String item;

    /** 4Depth */
    private String part;

    /** 코드 */
    private String cd;

    /** 의견 */
    private String opinion;

    /** 상세 정보 */
    List<HierarckySubVo> state;

}
