package kr.co.vwa.domain;
/**
 * Created by Hyeongju on 2018-01-16.
 */
import lombok.Data;

/**
 * 태그 VO
 */
@Data
public class TagVo {

    /** 태그 시퀀스 */
    private Integer tagSeq;

    /** 태그명 */
    private String tagNm;

    /** 노출여부 */
    private String expsYn;

    /** 순서 */
    private Integer ordNo;

    /** DB여부 */
    private String dbSts;

    /** 생성 유저 */
    private String creUser;

    /** 생성날짜 */
    private String creDate;

    /** 업데이트 유저*/
    private String updUser;

    /** 업데이트 날짜 */
    private String updDate;

    /** 매물태그 체크여부 */
    private String checked;

    /** 차량매물시퀀스 */
    private String sellCarSeq;

}
