package kr.co.vwa.services;

import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.PopupVo;
import kr.co.vwa.repository.PopupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 팝업관리 서비스
 */
@Service
public class PopupService implements IPopupService {

    @Autowired
    private PopupRepository popupRepository;

    @Value("${s3.url}")
    private String fileUrlPath;

    /**
     * 팝업 관리/목록 GET방식
     * @param searchParam
     * @return
     */
    @Override
    public List<PopupVo> popupList(Map searchParam){
        searchParam.put("fileUrlPath", fileUrlPath);
        List<PopupVo> list =popupRepository.popupList(searchParam);
        return list;
    }

    /**
     * 팝업 관리/전체 갯수
     * @param searchParam
     * @return
     */
    @Override
    public int popupTotalCount(Map searchParam){
        return popupRepository.popupTotalCount(searchParam);
    }

    /**
     * 팝업 관리/목록 노출여부
     * @param popupVo
     * @return
     */
    @Override
    public int popupExpsYnUpdate(PopupVo popupVo){
        popupVo.setUpdUser(SessionUtils.getUser().getUsername());
        return popupRepository.popupExpsYnUpdate(popupVo);
    }

    /**
     * 팝업 관리/목록 등록폼이동
     * @return
     */
    @Override
    public PopupVo popupFormVo(){
        PopupVo popupVo=new PopupVo();
        popupVo.setFormFlag(0);
        return popupVo;
    }

    /**
     * 팝업 관리/등록 POST방식
     * @param popupVo
     * @return
     */
    @Override
    public PopupVo popupRegiste(PopupVo popupVo){
        popupVo.setUpdUser(SessionUtils.getUser().getUsername());
        popupRepository.popupRegiste(popupVo);
        return popupVo;
    }

    /**
     * 팝업 관리/편집 GET방식
     * @param popupVo
     * @return
     */
    @Override
    public PopupVo popupDetailVo(PopupVo popupVo){
        PopupVo popupVo1=popupRepository.popupDetailVo(popupVo);

        if(popupVo1 == null) {
            throw new RuntimeException(String.format("조회된 팝업 정보가 존재하지 않습니다. [bannerSeq : \"%d\"]", popupVo.getPopupSeq()));
        }

        String filePath=popupVo1.getFile().getFilePath();
        String fileNm=popupVo1.getFile().getFileNm();
        String fileUrl=fileUrlPath+filePath+fileNm;
        popupVo1.setFileUrl(fileUrl);
        popupVo1.setFormFlag(1);
        return popupVo1;
    }

    /**
     * 팝업 관리/편집저장
     * @param popupVo
     * @return
     */
    @Override
    public int updatePopup(PopupVo popupVo){
        popupVo.setUpdUser(SessionUtils.getUser().getUsername());
        return popupRepository.updatePopup(popupVo);
    }

    /**
     * 팝업 관리/삭제
     * @param popupVo
     * @return
     */
    @Override
    public int popupDelete(PopupVo popupVo){
        popupVo.setUpdUser(SessionUtils.getUser().getUsername());
        return popupRepository.popupDelete(popupVo);
    }

    /**
     * 팝업 전체 조회(프론트용)
     * @param popupVo
     * @return
     */
    @Override
    public List<PopupVo> selectFrontPopupList(PopupVo popupVo) {
        return popupRepository.selectFrontPopupList(popupVo);
    }

    /**
     * 팝업관리/목록, 상세 노출여부 Y인 팝업개수
     * @param popupSeq
     * @return
     */
    @Override
    public int popupExpsYCount(Integer popupSeq) {
        return popupRepository.popupExpsYCount(popupSeq);
    }
}
