package kr.co.vwa.domain;

import lombok.Data;

import javax.validation.groups.ConvertGroup;
import java.util.List;
import java.util.Map;

/**
 * Created by DaDa on 2018-01-22.
 * <pre>
 * kr.co.vwa.domain
 *
 * 제시/성능점검 Vo.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-22 오후 2:51
 */
@Data
public class PerformanceVo {

    /** 매물차량시퀀스 */
    private Long sellCarSeq;

    /** 제시번호 */
    private String suggNo;

    /** 상태기록번호 */
    private String statRecNo;

    /** 검사유효시작기간 */
    private String strDate;

    /** 검사유효종료기간 */
    private String endDate;

    /** 원동기형식 */
    private String moterFrom;

    /** 차대번호 */
    private String chasNo;

    /** 동일성확인 */
    private String sameConf;

    /** 사고유무 */
    private String accidYn;

    /** 원동기진단여부 */
    private String moterDiagYn;

    /** 변속기진단여부 */
    private String gearDiagYn;

    /** 최초등록일(DD) */
    private String day;

    /** 보증유형 */
    private String warrCategory;

    /** 불법구조변경여부 */
    private String illeStruUpdYn;

    /** 침수유무 */
    private String flodYn;

    /** 일산화탄소 */
    private String co;

    /** 탄화수소 */
    private String hc;

    /** 매연 */
    private String exh;

    /** 상태점검일자 */
    private String statConfYear;

    /** 상태점검일자 */
    private String statConfMonth;

    /** 상태점검일자 */
    private String statConfDay;

    /** 상태점검자 */
    private String statConfUser;

    /** 상태고지자 */
    private String statNotfUser;

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

    /** 차량상태 List */
    private List<CarStatusVo> carStatusVos;

    /** 주요장치 데이터 상세코드 List */
    private List<String> detailCds;

    /** 주요장치 상세코드 */
    private String detailCd;

    /** 주요장치 특기사항 및 점검자의견 */
    private String opinion;

}
