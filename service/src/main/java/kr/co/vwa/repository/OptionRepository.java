package kr.co.vwa.repository;

import kr.co.vwa.domain.OptionVo;
import kr.co.vwa.domain.TagVo;
import org.springframework.stereotype.Repository;

import javax.swing.text.html.Option;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * Created by hyeongju on 2018-01-19.
 * 옵션관리 Repository
 */
@Repository
public interface OptionRepository {

    /**
     * 옵션관리/목록
     * @param optionVo
     * @return
     */
    List<OptionVo> optMngList(OptionVo optionVo);

    /**
     * 옵션관리/목록
     * @param optionVo
     * @return
     */
    List<OptionVo> optMngListByCar(OptionVo optionVo);

    /**
     * 옵션관리/등록
     * @param optionVo
     * @return
     */
    int registeOptMng(OptionVo optionVo);

    /**
     * 옵션관리/노출편집
     * @param optionVo
     * @return
     */
    int optExpUpdate(OptionVo optionVo);

    /**
     * 옵션관리/편집저장
     * @param optionVo
     * @return
     */
    int updateOptMng(OptionVo optionVo);

    /**
     * 옵션관리/정렬저장
     * @param optionVo
     * @return
     */
    int updateOptMngOrdNo(OptionVo optionVo);

    /**
     * 옵션관리/삭제
     * @param optionVo
     * @return
     */
    int optDelete(OptionVo optionVo);

}
