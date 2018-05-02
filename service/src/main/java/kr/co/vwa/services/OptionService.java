package kr.co.vwa.services;

import kr.co.vwa.common.enums.VWACode;
import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.OptionVo;
import kr.co.vwa.repository.OptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


/**
 * 옵션관리 서비스
 */
@Service
public class OptionService implements IOptionService {

    @Autowired
    private OptionRepository optionRepository;

    /**
     * 옵션관리/목록
     * @return
     */
    @Override
    public List<OptionVo> optMngList(Long sellCarSeq, String vwYn){
        List<OptionVo> cList = new ArrayList<OptionVo>();
        String cateName = "";
        String cateCode = "";

        for (int i = 0; i < 5; i++) {
            OptionVo ov = new OptionVo();
            cList.add(ov);
            if (i == 0) {
                cateName = VWACode.trim.getCodeNm();
                cateCode = VWACode.trim.getCode();
            } else if (i == 1) {
                cateName = VWACode.viscus.getCodeNm();
                cateCode = VWACode.viscus.getCode();
            } else if (i == 2) {
                cateName = VWACode.safety.getCodeNm();
                cateCode = VWACode.safety.getCode();
            } else if (i == 3) {
                cateName = VWACode.convenience.getCodeNm();
                cateCode = VWACode.convenience.getCode();
            } else if (i == 4) {
                cateName = VWACode.multimedia.getCodeNm();
                cateCode = VWACode.multimedia.getCode();
            }

            cList.get(i).setCateName(cateName);
            cList.get(i).setCategoryCd(cateCode);

            OptionVo optionVo=new OptionVo();
            optionVo.setVwYn(vwYn);
            optionVo.setCategoryCd(cList.get(i).getCategoryCd());

            List<OptionVo> optlist = null;
            if(sellCarSeq == null) {
                optlist = optionRepository.optMngList(optionVo);
            } else {
                optionVo.setSellCarSeq(sellCarSeq);
                optlist = optionRepository.optMngListByCar(optionVo);
            }
            cList.get(i).setOptList(optlist);
        }

        return cList;
    }

    /**
     * 옵션관리/등록
     * @param optionVo
     * @return
     */
    @Override
    public int registeOptMng(OptionVo optionVo){
        optionVo.setUpdUser(SessionUtils.getUser().getUsername());
        return optionRepository.registeOptMng(optionVo);
    }

    /**
     * 옵션관리/노출편집
     * @param optionVo
     * @return
     */
    @Override
    public int optExpUpdate(OptionVo optionVo){
        optionVo.setUpdUser(SessionUtils.getUser().getUsername());
        return optionRepository.optExpUpdate(optionVo);
    }

    /**
     * 옵션관리/편집저장
     * @param optionVo
     * @return
     */
    @Override
    public int updateOptMng(OptionVo optionVo){
        optionVo.setUpdUser(SessionUtils.getUser().getUsername());
        return optionRepository.updateOptMng(optionVo);
    }

    /**
     * 옵션관리/정렬저장
     * @param seq
     * @param ordNo
     * @return
     */
    @Override
    public int updateOptMngOrdNo(Integer[] seq,Integer[] ordNo){
        for(int i=0;i<seq.length;i++) {
            OptionVo optionVo = new OptionVo();
            optionVo.setOrdNo(ordNo[i]);
            optionVo.setOptSeq(seq[i]);
            optionVo.setUpdUser(SessionUtils.getUser().getUsername());
            optionRepository.updateOptMngOrdNo(optionVo);
        }
        return 1;
    }

    /**
     * 옵션관리/삭제
     * @param optionVo
     * @return
     */
    @Override
    public int optDelete(OptionVo optionVo){
        optionVo.setUpdUser(SessionUtils.getUser().getUsername());
        return optionRepository.optDelete(optionVo);
    }

    /**
     * 옵션관리/목록중의 한그룹
     * @param optionVo
     * @return
     */
    @Override
    public List<OptionVo> optMngVo(OptionVo optionVo){
        return optionRepository.optMngList(optionVo);
    }

}
