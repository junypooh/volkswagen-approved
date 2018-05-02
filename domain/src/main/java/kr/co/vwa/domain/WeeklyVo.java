package kr.co.vwa.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * 주간보고 기본 VO
 */
@Data
public class WeeklyVo {

    /**
     * 주간보고 시퀀스
     */
    private Integer weekRepSeq;

    /**
     * 유형코드
     */
    private String categoryCd;

    /**
     * 제목
     */
    private String title;

    /**
     * 업로드시작일자
     */
    private String strDate;

    /**
     * 업로드종료일자
     */
    private String endDate;

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
    private String creDate;

    /**
     * 수정자
     */
    private String updUser;

    /**
     * 수정일자
     */
    private String updDate;

    /**
     * 유형명
     */
    private String categoryNm;

    /**
     * 상태 구분값
     */
    private Integer flag;

    /**
     * 현재상태
     */
    private String status;

    /**
     * weekly report 리스트
     */
    private List<WeeklyDetailVo> weeklyDetailList;

    /**
     * 화면에서 받을 파라미터
     */
    private Integer[] admSeq;

    /**
     * 업로드 시작일자 배열형태
     */
    private String[] detailStrDate;

    /**
     * 업로드 종료일자 배열형태
     */
    private String[] detailEndDate;

    /**
     * 화면에서 받을 모달창 검색어
     */
    private String searchText;
}
