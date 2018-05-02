package kr.co.vwa.domain;

import lombok.Data;

import java.util.List;

/**
 * Created by DaDa on 2018-01-29.
 * <pre>
 * kr.co.vwa.domain
 *
 * 매물관리 > 사진 Vo.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-29 오후 1:44
 */
@Data
public class CarPhotoVo {

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 사진코드 */
    private String photoCd;

    /** 이미지시퀀스 */
    private Long imgSeq;

    /** DB 상태 */
    private String dbSts;

    /** 등록자 */
    private String creUser;

    /** 등록일자 */
    private String creDate;

    /** 수정자 */
    private String updUser;

    /** 수정일자 */
    private String updDate;


    /** 코드 */
    private String cd;

    /** 코드명(사진 타이틀명) */
    private String title;

    /** 욥션(사진 주요등록 여부)  */
    private String required;

    /** 이미지 경로 */
    private String fileUrl;

    private List<CarPhotoVo> carPhotoVos;




}
