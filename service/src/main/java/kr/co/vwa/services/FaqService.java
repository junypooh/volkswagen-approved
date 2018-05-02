package kr.co.vwa.services;

import kr.co.vwa.common.enums.VWACode;
import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.FaqVo;
import kr.co.vwa.repository.FaqRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 자주묻는질문관리 Service
 */
@Service
public class FaqService implements IFaqService {

    @Autowired
    private FaqRepository faqRepository;

    /**
     * 자주하는질문관리/목록 자주하는질문 목록 조회
     * @param searchParam
     * @return
     */
    @Override
    public List<FaqVo> selectFaqList(Map<String, Object> searchParam) {
        List<FaqVo> faqList = faqRepository.selectFaqList(searchParam);

        for (FaqVo faq: faqList) {
            if (VWACode.questionRelation.getCode().equals(faq.getCategoryCd())){
                faq.setCategoryNm(VWACode.questionRelation.getCodeNm());
            } else if (VWACode.useSite.getCode().equals(faq.getCategoryCd())){
                faq.setCategoryNm(VWACode.useSite.getCodeNm());
            } else if (VWACode.purchaseGuide.getCode().equals(faq.getCategoryCd())){
                faq.setCategoryNm(VWACode.purchaseGuide.getCodeNm());
            }
        }
        return faqList;
    }

    /**
     * 자주하는질문관리/목록 노출여부 수정
     * @param faq
     * @return
     */
    @Override
    public int updateExpsYn(FaqVo faq) {
        faq.setUpdUser(SessionUtils.getUser().getUsername());
        return faqRepository.updateExpsYn(faq);
    }

    /**
     * 자주하는질문관리/목록 정렬저장
     * @param index
     * @param faqSeq
     * @return
     */
    @Override
    public int updateExpsdNo(Integer[] index, Integer[] faqSeq) {

        for (int i = 0; i < index.length; i++){
            FaqVo faq = new FaqVo();
            faq.setFaqSeq(faqSeq[i]);
            faq.setOrdNo(index[i]);
            faq.setUpdUser(SessionUtils.getUser().getUsername());
            faqRepository.updateExpsdNo(faq);
        }

        return index.length;
    }

    /**
     * 자주하는질문관리/상세 자주하는질문 조회
     * @param faq
     * @return
     */
    @Override
    public FaqVo selectFaq(FaqVo faq) {
        FaqVo resultFaq = faqRepository.selectFaq(faq);
        if(resultFaq == null) {
            throw new RuntimeException(String.format("조회된 자주하는질문 정보가 존재하지 않습니다. [faqSeq : \"%d\"]", faq.getFaqSeq()));
        }
        return resultFaq;
    }

    /**
     * 자주하는질문관리/상세 자주하는질문정보 등록
     * @param faq
     * @return
     */
    @Override
    public FaqVo insertFaq(FaqVo faq) {
        //작성자 set
        faq.setCreUser(SessionUtils.getUser().getUsername());
        //노출여부 set
        faq.setExpsYn("Y".equals(faq.getExpsYn()) ? "Y" : "N");
        //상단고정
        faq.setFixYn("Y".equals(faq.getFixYn()) ? "Y" : "N");

        int result = faqRepository.insertFaq(faq);
        return faq;
    }

    /**
     * 자주하는질문관리/상세 자주하는질문정보 수정
     * @param faq
     * @return
     */
    @Override
    public FaqVo updateFaq(FaqVo faq) {
        //작성자 set
        faq.setUpdUser(SessionUtils.getUser().getUsername());
        //노출여부 set
        faq.setExpsYn("Y".equals(faq.getExpsYn()) ? "Y" : "N");
        //상단고정
        faq.setFixYn("Y".equals(faq.getFixYn()) ? "Y" : "N");

        int result = faqRepository.updateFaq(faq);
        return faq;
    }

    /**
     * 자주하는질문관리/상세 자주하는질문정보 삭제
     * @param faq
     * @return
     */
    @Override
    public int deleteFaq(FaqVo faq) {
        faq.setUpdUser(SessionUtils.getUser().getUsername());
        return faqRepository.deleteFaq(faq);
    }

    /**
     * Front 자주하는질문/목록 조회
     * @param searchParam
     * @return
     */
    @Override
    public List<FaqVo> selectFrontFaqList(Map<String, Object> searchParam) {
        List<FaqVo> faqList = faqRepository.selectFrontFaqList(searchParam);

        for (FaqVo faq: faqList) {
            if (VWACode.questionRelation.getCode().equals(faq.getCategoryCd())){
                faq.setCategoryNm(VWACode.questionRelation.getCodeNm());
            } else if (VWACode.useSite.getCode().equals(faq.getCategoryCd())){
                faq.setCategoryNm(VWACode.useSite.getCodeNm());
            } else if (VWACode.purchaseGuide.getCode().equals(faq.getCategoryCd())){
                faq.setCategoryNm(VWACode.purchaseGuide.getCodeNm());
            }
        }

        return faqList;
    }

    /**
     * 자주하는질문관리/상세, 등록 상단고정게시물 수
     * @return
     */
    @Override
    public int selectFaqFixYCount(FaqVo faq) {
        return faqRepository.selectFaqFixYCount(faq);
    }

    /**
     * front 자주하는질문 유형 그룹핑
     * @return
     */
    @Override
    public List<FaqVo> selectFaqTypeList() {
        return faqRepository.selectFaqTypeList();
    }
}
