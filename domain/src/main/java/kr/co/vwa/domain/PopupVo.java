package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by junypooh on 2018-01-15.
 * <pre>
 * kr.co.vwa.domain.popup
 *
 * 팝업 VO
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-15 오전 11:23
 */
@Data
public class PopupVo {

    /**
     * 팝업 시퀀스
     */
    private Integer popupSeq;

    /**
     * 팝업 제목
     */
    private String title;

    /**
     * 팝업 URL
     */
    private String linkUrl;

    /**
     * 팝업 새창여부
     */
    private String newWinYn;

    /**
     * 이미지 시퀀스
     */
    private Integer imgSeq;

    /**
     * 노출여부
     */
    private String expsYn;

    /**
     * 시작일자
     */
    private String strDate;

    /**
     * 종료일자
     */
    private String endDate;

    /**
     * DB상태
     */
    private String dbSts;

    /**
     * 생성 유저
     */
    private String creUser;

    /**
     * 생성 날짜
     */
    private String creDate;

    /**
     * 업데이트 유저
     */
    private String updUser;

    /**
     * 업데이트 날짜
     */
    private String updDate;

    /**
     * 팝업상태 구분자
     */
    private Integer flag;

    /**
     * 팝업FORM 구분자
     */
    private Integer formFlag;

    /**
     * 파일정보
     */
    private FileVo file;

    /**
     * 파일 URL
     */
    private String fileUrl;


}
