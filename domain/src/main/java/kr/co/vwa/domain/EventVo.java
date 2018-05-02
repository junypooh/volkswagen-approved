package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by junypooh on 2018-01-15.
 * <pre>
 * kr.co.vwa.domain.banner
 *
 * 이벤트 VO
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-15 오전 11:23
 */
@Data
public class EventVo {

    /**
     * 이벤트 시퀀스
     */
    private Integer eventSeq;

    /**
     * 제목
     */
    private String title;

    /**
     * 이벤트 타입
     */
    private String type;

    /**
     * pc 내용
     */
    private String ctntPc;

    /**
     * mo 내용
     */
    private String ctntMo;

    /**
     * pcUrl 링크
     */
    private String pcLinkUrl;

    /**
     * moUrl 링크
     */
    private String moLinkUrl;

    /**
     * pc 새창여부
     */
    private String newWinYnPc;

    /**
     * mo 새창여부
     */
    private String newWinYnMo;

    /**
     * 이미지 시퀀스
     */
    private Integer imgSeq;

    /**
     * 메인 이미지 시퀀스
     */
    private Integer mainImgSeq;

    /**
     * 노출여부
     */
    private String expsYn;

    /**
     * 이벤트 시작일자
     */
    private String strDate;

    /**
     * 이벤트 종료일자
     */
    private String endDate;

    /**
     * 당첨자 새창여부
     */
    private String winnNewWinYn;

    /**
     * 당첨자 링크
     */
    private String winnLinkUrl;

    /**
     * DB상태
     */
    private String dbSts;

    /**
     * 생성 유저
     */
    private String creUser;

    /**
     * 생성날짜
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
     * 이벤트 상태 구분자
     */
    private Integer flag;

    /**
     * FORM양식 구분자
     */
    private Integer formFlag;

    /**
     * IMG FILE정보
     */
    private FileVo file;

    /**
     * 메인이미지 FILE 정보
     */
    private FileVo mainImgFile;

    /**
     * 이미지 URL
     */
    private String fileUrl;

    /**
     * 메인이미지 URL
     */
    private String mainFileUrl;
}
