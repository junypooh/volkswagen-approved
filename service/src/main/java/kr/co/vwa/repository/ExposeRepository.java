package kr.co.vwa.repository;

import kr.co.vwa.domain.CodeVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 기간/주기 설정 repository
 */
@Repository
public interface ExposeRepository {

    /**
     * 기간/주기 목록/GET방식
     * @param map
     * @return
     */
    List<CodeVo> exposeMngList(Map map);

    /**
     * 기간/주기 설정 수정
     * @param codeVo
     * @return
     */

    int updateExposeMng(CodeVo codeVo);

}
