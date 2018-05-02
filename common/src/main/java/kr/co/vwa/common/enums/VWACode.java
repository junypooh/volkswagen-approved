package kr.co.vwa.common.enums;

/**
 * Created by DaDa on 2018-01-19.
 * <pre>
 * kr.co.vwa.common.enums
 *
 * 코드관리 enum.
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-01-19 오후 3:53
 */
public enum VWACode {

    applyStandby("D1001", "승인대기"  , "D1000"),
    sellStatus  ("D1002", "판매중"    , "D1000"),
    returnStatus("D1003", "반려"      , "D1000"),
    sellComplete("D1004", "판매완료"      , "D1000"),
    sellEnd     ("D1005", "판매종료/삭제"  , "D1000"),


    trim        ("B1001", "외장"      , "B1000"),
    viscus      ("B1002", "내장"      , "B1000"),
    safety      ("B1003", "안전"      , "B1000"),
    convenience ("B1004", "편의"      , "B1000"),
    multimedia  ("B1005", "멀티미디어" , "B1000"),


    coverPanel  ("H1100", "외판"      , "H1000"),
    majorFrame  ("H1200", "주요골격"   , "H1000"),


    questionRelation    ("A1001", "문의관련", "A1000"),
    useSite             ("A1002", "사이트이용", "A1000"),
    purchaseGuide       ("A1003", "구매가이드", "A1000"),

    purchase    ("I1001", "매입", "I1000"),
    sale        ("I1002", "판매", "I1000");


    private String code;
    private String codeNm;
    private String upperCode;

    VWACode(String code, String codeNm, String upperCode) {
        this.code = code;
        this.codeNm = codeNm;
        this.upperCode = upperCode;
    }

    public String getCode() {return code; }

    public void setCode(String code) { this.code = code; }

    public String getCodeNm() {return codeNm; }

    public void setCodeNm(String codeNm) { this.codeNm = codeNm; }

    public String getUpperCode() {return upperCode; }

    public void setUpperCode(String upperCode) { this.upperCode = upperCode; }

}
