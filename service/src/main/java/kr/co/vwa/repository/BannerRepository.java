package kr.co.vwa.repository;


import kr.co.vwa.domain.BannerVo;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;


/**
 * 배너관리 repository
 */
@Repository
public interface BannerRepository {

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
     * @param bannerVo
     * @return
     */
    int updateBannerOrdNo(BannerVo bannerVo);

    /**
     * 배너관리/등록 저장
     * @param bannerVo
     * @return
     */
    int bannerRegiste(BannerVo bannerVo);

    /**
     * 배너관리/편집 GET방식
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