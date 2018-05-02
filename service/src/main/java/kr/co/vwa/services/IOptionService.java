package kr.co.vwa.services;

import kr.co.vwa.domain.OptionVo;
import kr.co.vwa.domain.User;

import java.time.LocalDateTime;
import java.util.List;

/**
 * Created by hyeongju on 2018-01-19.
 * 옵션관리 Interface
 */
public interface IOptionService {

    /**
     * 옵션관리/목록
     * @return
     */
    List<OptionVo> optMngList(Long sellCarSeq, String vwYn);

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
     * @param seq
     * @param ordNo
     * @return
     */
    int updateOptMngOrdNo(Integer[] seq,Integer[] ordNo);

    /**
     * 옵션관리/삭제
     * @param optionVo
     * @return
     */
    int optDelete(OptionVo optionVo);

    /**
     * 옵션관리/목록중의 한그룹
     * @param optionVo
     * @return
     */
    List<OptionVo> optMngVo(OptionVo optionVo);
}
