package kr.co.vwa.domain;


import lombok.Data;

/**
 * Created by DaDa on 2018-02-09.
 * <pre>
 * kr.co.vwa.domain
 *
 * Page 설정 VO
 *
 * </pre>
 *
 * @author Dahye, Kim
 * @see
 * @since 2018-02-09 오후 4:45
 */
@Data
public class PageBaseVo {

    private int currPage = 1;

    private int contentsCount = 20;

    public int getCurrentPage() {
        return (currPage - 1) * contentsCount;
    }

}
