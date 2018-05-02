package kr.co.vwa.services;

import kr.co.vwa.domain.BannerVo;
import kr.co.vwa.domain.User;

import java.util.List;
import java.util.Map;

/**
 * Created by hyeongju on 2018-01-15.
 * 배너 Interface
 */
public interface IBannerService {

    /**
     * 프론트 메인 배너 리스트
     * @return
     */
    List<BannerVo> selectFrontBannerList();

    /**
     * 배너관리/목록 GET방식
     * @param searchParam
     * @return
     */
    List<BannerVo> bannerList(Map searchParam);

    /**
     * 배너관리/목록 노출여부
     * @param bannerVo
     * @return
     */
    int bannerExpsYnUpdate(BannerVo bannerVo);

    /**
     * 배너관리/목록 정렬저장
     * @param bannerSeq
     * @param ordNo
     * @return
     */
    int updateBannerOrdNo(Integer[] bannerSeq,Integer[] ordNo);

    /**
     * 배너관리/등록폼 GET방식
     * @return
     */
    BannerVo bannerFormVo();

    /**
     * 배너관리/등록 저장
     * @param bannerVo
     * @return
     */
    BannerVo bannerRegiste(BannerVo bannerVo);

    /**
     * 배너관리/편집 POST방식
     * @param bannerVo
     * @return
     */
    BannerVo bannerDetailVo(BannerVo bannerVo);

    /**
     * 배너관리/편집 저장
     * @param bannerVo
     * @return
     */
    int updateBanner(BannerVo bannerVo);

    /**
     * 배너관리/편집 삭제
     * @param bannerVo
     * @return
     */
    int bannerDelete(BannerVo bannerVo);
}
