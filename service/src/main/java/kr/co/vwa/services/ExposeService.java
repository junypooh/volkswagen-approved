package kr.co.vwa.services;


import kr.co.vwa.domain.CodeVo;
import kr.co.vwa.repository.ExposeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 기간/주기 서비스
 */
@Service
public class ExposeService implements IExposeService {

    @Autowired
    private ExposeRepository exposeRepository;

    /**
     * 기간/주기 설정 목록
     * @param map
     * @return
     */
    @Override
    public List<CodeVo> exposeMngList(Map map) {
        List<CodeVo> codeVo = exposeRepository.exposeMngList(map);
        return codeVo;
    }


    /**
     * 기간/주기 설정 저장
     * @param codeVo
     * @return
     */

    @Override
    public int updateExposeMng(CodeVo codeVo) {
        return exposeRepository.updateExposeMng(codeVo);
    }


}
