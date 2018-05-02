package kr.co.vwa.services;

import kr.co.vwa.domain.OptionVo;

import java.util.List;
import java.util.Map;

/**
 * 주요옵션관리 Interface
 */
public interface IMajorOptionService {
    /**
     * 주요옵션관리 목록 조회
     * @param searchParam
     * @return
     */
    List<OptionVo> selectMajorOptionList(Map<String, String> searchParam);

    /**
     * 주요옵션관리 수정
     * @param optionVo
     * @return
     */
    int updateMajorOption(OptionVo optionVo);

    /**
     * 주요옵션관리 정렬순서 수정
     * @param index
     * @param optSeq
     * @return
     */
    int updateMajorOrdNo(Integer[] index, Integer[] optSeq);
}
