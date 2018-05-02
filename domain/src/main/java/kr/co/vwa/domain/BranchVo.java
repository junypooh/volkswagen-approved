package kr.co.vwa.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * 전시장 VO
 */
@Data
public class BranchVo {

    /**
     *  전시장시퀀스
     */
    private Integer exhHallSeq;

    /**
     *  구분
     */
    private String type;

    /**
     *  상호
     */
    private String storeNm;

    /**
     *  전화번호
     */
    private String tel;

    /**
     *  시군
     */
    private String sigun;

    /**
     *  주소
     */
    private String addr;

    /**
     *  상세주소
     */
    private String detailAddr;

    /**
     *  주소 x좌표
     */
    private String xcoordinate;

    /**
     *  주소 y좌표
     */
    private String ycoordinate;

    /**
     *  노출여부
     */
    private String expsYn;

    /**
     *  노출 순서
     */
    private Integer expsNo;

    /**
     *  DB 상태
     */
    private String dbSts;

    /**
     *  등록자
     */
    private String creUser;

    /**
     *  등록일자
     */
    private Date creDate;

    /**
     *  수정자
     */
    private String updUser;

    /**
     *  수정일자
     */
    private Date updDate;

    /**
     * 이메일 리스트
     */
    private List<EmailVo> emailList;

    /** 관리자,전시장관리 매핑VO */
    private List<AuthExhibMapVo> authExhibMapList;

    /**
     * 화면에서 받아서 사용할 파라미터
     */
    private String tel1;
    private String tel2;
    private String tel3;

    /**
     * 접근 IP 리스트
     */
    private List<String> ipAddresses;
}
