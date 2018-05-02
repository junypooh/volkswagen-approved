package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by junypooh on 2018-01-15.
 * <pre>
 * kr.co.vwa.domain.banner
 *
 * 판매차량 VO
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-15 오전 11:23
 */
@Data
public class SellCarVo {

    /**
     * 소유자 구분
     */
    private String type;

    /**
     * 이름
     */
    private String user;

    /**
     * 이메일
     */
    private String email;

    /**
     * 이메일 주소
     */
    private String emailaddress;

    /**
     * 차량 번호
     */
    private String carNum;

    /**
     * 전시장 시퀀스
     */
    private Integer exhHallSeq;

    /**
     * 연식
     */
    private Integer carYear;

    /**
     * 주행거리
     */
    private Integer carStreet;

    /**
     * 추가내용
     */
    private String addText;
}
