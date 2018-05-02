package kr.co.vwa.domain;
/**
 * Created by Hyeongju on 2018-01-22.
 * 관리자 전시장관리 매핑 VO
 */
import lombok.Data;


@Data
public class AuthExhibMapVo {

    /** 구분 */
    private String type;

    /** 상호 */
    private String storeNm;

    /** 관리자 시퀀스 */
    private Integer admSeq;

    /** 권한 */
    private String auth;

    /** 전시장 시퀀스 */
    private Integer exhHallSeq;

    /** DB싱태 */
    private String dbSts;

    /** 생성유저 */
    private String creUser;

    /** 생성날짜 */
    private String creDate;

    /** 업데이트 유저 */
    private String updUser;

    /** 업데이트 날짜 */
    private String updDate;

    /** 관리자id */
    private String id;
}
