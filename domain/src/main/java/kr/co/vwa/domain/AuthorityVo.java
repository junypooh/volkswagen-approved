package kr.co.vwa.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * 전시장 관리/Back VO
 */
@Data
public class AuthorityVo {

    /** 관리자 시퀀스 */
    private Integer admSeq;

    /** 권한구분 */
    private String authType;

    /** 아이디 */
    private String id;

    /** 비밀번호 */
    private String pwd;

    /** 메모 */
    private String memo;

    /** 사용여부 */
    private String useYn;

    /** DB상태 */
    private String dbSts;

    /** 등록자 */
    private String creUser;

    /** 등록일 */
    private Date creDate;

    /** 수정자 */
    private String updUser;

    /** 수정일 */
    private String updDate;

    /** 최근방문일 */
    private String visitDay;

    /** 최종승인일 */
    private String lastDay;

    /** 관리자,전시장관리 매핑VO */
    private List<AuthExhibMapVo> list;

    private Object[] array;

    /** 화면에서 전달받을 파라미터 */
    /** 전시장사용여부 */
    private String[] exhibUseYn;

    /** 전시장 시퀀스 */
    private Integer[] exhHallSeq;

    /** 전시장별 권한 */
    private String[] auth;

    /** 이용자 구분 값 */
    private int flag;

    /** weeklyReport 그룹관리자 찾기 시 체크여부 */
    private Boolean checkYn;

    /** 디폴트 소속 전시장 */
    private String defaultExhHallSeq;

}
