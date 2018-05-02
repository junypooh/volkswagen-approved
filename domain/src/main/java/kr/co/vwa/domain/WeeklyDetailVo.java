package kr.co.vwa.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * 주간보고 detail VO
 */
@Data
public class WeeklyDetailVo {

    /**
     * 주간보고시퀀스
     */
    private Integer weekRepSeq;

    /**
     * 관리자시퀀스
     */
    private Integer admSeq;

    /**
     * 업로드시작일자
     */
    private String strDate;

    /**
     * 업로드종료일자
     */
    private String endDate;

    /**
     * 업로드파일명
     */
    private String fileNm;

    /**
     * 업로드날짜
     */
    private Date uploadDate;

    /**
     * DB 상태
     */
    private String dbSts;

    /**
     * 등록자
     */
    private String creUser;

    /**
     * 등록일자
     */
    private Date creDate;

    /**
     * 수정자
     */
    private String updUser;

    /**
     * 수정일자
     */
    private Date updDate;

    /**
     * 현재상태
     */
    private String status;

    /**
     * 그룹관리자 아이디
     */
    private String id;

    /**
     * 관리자 전시장관리 매핑 리스트
     */
    private List<AuthExhibMapVo> authExhibMapList;

}
