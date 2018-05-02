package kr.co.vwa.services;

import kr.co.vwa.common.enums.VWACode;
import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.OptionVo;
import kr.co.vwa.repository.MajorOptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 주요옵션 Service
 */
@Service("majorOptionService")
public class MajorOptionService implements IMajorOptionService {

    @Autowired
    private MajorOptionRepository majorOptionRepository;

    @Value("${s3.url}")
    private String fileUrlPath;

    /**
     * 주요옵션관리 목록 조회
     * @param searchParam
     * @return
     */
    @Override
    public List<OptionVo> selectMajorOptionList(Map<String, String> searchParam) {
        searchParam.put("fileUrlPath", fileUrlPath);
        List<OptionVo> optionList = majorOptionRepository.selectMajorOptionList(searchParam);

        //코드값 코드명으로 변경
        for (OptionVo option: optionList) {
            if(VWACode.trim.getCode().equals(option.getCategoryCd())){
                option.setCateName(VWACode.trim.getCodeNm());
            } else if(VWACode.viscus.getCode().equals(option.getCategoryCd())){
                option.setCateName(VWACode.viscus.getCodeNm());
            } else if(VWACode.safety.getCode().equals(option.getCategoryCd())){
                option.setCateName(VWACode.safety.getCodeNm());
            } else if(VWACode.convenience.getCode().equals(option.getCategoryCd())){
                option.setCateName(VWACode.convenience.getCodeNm());
            } else if(VWACode.multimedia.getCode().equals(option.getCategoryCd())){
                option.setCateName(VWACode.multimedia.getCodeNm());
            }
        }

        return optionList;
    }

    /**
     * 주요옵션관리 수정
     * @param optionVo
     * @return
     */
    @Override
    public int updateMajorOption(OptionVo optionVo) {
        optionVo.setUpdUser(SessionUtils.getUser().getUsername());
        return majorOptionRepository.updateMajorOption(optionVo);
    }

    /**
     * 주요옵션관리 정렬순서 수정
     * @param index
     * @param optSeq
     * @return
     */
    @Override
    public int updateMajorOrdNo(Integer[] index, Integer[] optSeq) {

        for (int i = 0; i < index.length; i++){
            OptionVo optionVo = new OptionVo();
            optionVo.setOptSeq(optSeq[i]);
            optionVo.setMajOrdNo(index[i]);
            optionVo.setUpdUser(SessionUtils.getUser().getUsername());
            majorOptionRepository.updateMajorOrdNo(optionVo);
        }

        return index.length;
    }
}
