package kr.co.vwa.services;

import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.BannerVo;
import kr.co.vwa.repository.BannerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 배너관리 서비스
 */
@Service
public class BannerService implements IBannerService {

    @Autowired
    private BannerRepository bannerRepository;

    @Value("${s3.url}")
    private String fileUrlPath;

    /**
     * 프론트 메인 배너 리스트
     * @return
     */
    @Override
    public List<BannerVo> selectFrontBannerList() {
        return bannerRepository.selectFrontBannerList();
    }

    /**
     * 배너관리/목록 GET방식
     * @param searchParam
     * @return
     */
    @Override
    public List<BannerVo> bannerList(Map searchParam){
        searchParam.put("fileUrlPath", fileUrlPath);
        List<BannerVo> list =bannerRepository.bannerList(searchParam);
        return list;
    }

    /**
     * 배너관리/목록 노출여부
     * @param bannerVo
     * @return
     */
    @Override
    public int bannerExpsYnUpdate(BannerVo bannerVo){
        bannerVo.setUpdUser(SessionUtils.getUser().getUsername());
        return bannerRepository.bannerExpsYnUpdate(bannerVo);
    }

    /**
     * 배너관리/목록 정렬저장
     * @param bannerSeq
     * @param ordNo
     * @return
     */
    @Override
    public int updateBannerOrdNo(Integer[] bannerSeq,Integer[] ordNo){
        for(int i=0;i<bannerSeq.length;i++){
            BannerVo bannerVo=new BannerVo();
            bannerVo.setBannerSeq(bannerSeq[i]);
            bannerVo.setOrdNo(ordNo[i]);
            bannerRepository.updateBannerOrdNo(bannerVo);
        }
        return 1;
    }

    /**
     * 배너관리/등록폼 GET방식
     * @return
     */
    @Override
    public BannerVo bannerFormVo(){
        BannerVo bannerVo=new BannerVo();
        bannerVo.setFlag(0);
        return bannerVo;
    }

    /**
     * 배너관리/등록 저장
     * @param bannerVo
     * @return
     */
    @Override
    public BannerVo bannerRegiste(BannerVo bannerVo){
        bannerVo.setUpdUser(SessionUtils.getUser().getUsername());
        bannerRepository.bannerRegiste(bannerVo);
        return bannerVo;
    }

    /**
     * 배너관리/편집 GET방식
     * @param bannerVo
     * @return
     */
    @Override
    public BannerVo bannerDetailVo(BannerVo bannerVo){
        BannerVo bannerVo1=bannerRepository.bannerDetailVo(bannerVo);

        if(bannerVo1 == null) {
            throw new RuntimeException(String.format("조회된 배너 정보가 존재하지 않습니다. [bannerSeq : \"%d\"]", bannerVo.getBannerSeq()));
        }

        String filePath=bannerVo1.getFile().getFilePath();
        String fileNm=bannerVo1.getFile().getFileNm();
        String fileUrl=fileUrlPath+filePath+fileNm;
        bannerVo1.setFileUrl(fileUrl);
        bannerVo1.setFlag(1);
        return bannerVo1;
    }

    /**
     * 배너관리/편집 저장
     * @param bannerVo
     * @return
     */
    @Override
    public int updateBanner(BannerVo bannerVo){
        bannerVo.setUpdUser(SessionUtils.getUser().getUsername());
        return bannerRepository.updateBanner(bannerVo);
    }

    /**
     * 배너관리/편집 삭제
     * @param bannerVo
     * @return
     */
    @Override
    public int bannerDelete(BannerVo bannerVo){
        bannerVo.setUpdUser(SessionUtils.getUser().getUsername());
        return bannerRepository.bannerDelete(bannerVo);
    }
}
