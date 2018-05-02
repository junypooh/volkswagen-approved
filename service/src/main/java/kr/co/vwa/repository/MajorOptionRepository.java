package kr.co.vwa.repository;

import kr.co.vwa.domain.OptionVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 주요옵션관리 Repository
 */
@Repository
public interface MajorOptionRepository {
    /**
     * 주요옵션관리 주요옵션 전체 조회
     * @param searchParam
     * @return
     */
    List<OptionVo> selectMajorOptionList(Map<String, String> searchParam);

    /**
     * 차량 주요옵션 전체 조회
     * @param optionVo
     * @return
     */
    List<OptionVo> selectMajorOptionListByCar(OptionVo optionVo);

    /**
     * 주요옵션관리 수정
     * @param optionVo
     * @return
     */
    int updateMajorOption(OptionVo optionVo);

    /**
     * 주요옵션관리 정렬저장
     * @param optionVo
     * @return
     */
    int updateMajorOrdNo(OptionVo optionVo);
}
