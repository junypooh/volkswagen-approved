package kr.co.vwa.services;

import kr.co.vwa.domain.CodeVo;

import java.util.List;
import java.util.Map;

/**
 * 기간/주기설정관리 Interface
 */
public interface IExposeService {

    /**
     * 기간/주기 설정 목록
     * @param map
     * @return
     */
    List<CodeVo> exposeMngList(Map map);

    /**
     * 기간/주기 설정 저장
     * @param codeVo
     * @return
     */
    int updateExposeMng(CodeVo codeVo);

}
