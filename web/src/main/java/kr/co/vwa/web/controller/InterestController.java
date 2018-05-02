package kr.co.vwa.web.controller;

import kr.co.vwa.annotation.WebLogInfo;
import kr.co.vwa.domain.CarInfoVo;
import kr.co.vwa.domain.FrontItemVo;
import kr.co.vwa.services.IFrontItemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;

/**
 * Created by junypooh on 2018-02-20.
 * <pre>
 * kr.co.vwa.web.controller
 *
 * 관심차량/FRONT Controller
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-20 오후 2:54
 */
@Controller
@Slf4j
public class InterestController {

    @Autowired
    private IFrontItemService frontItemService;

    /**
     * 관심차량 Layer
     */
    @RequestMapping(value = "layer/interest")
    public void interest(Model model) {
    }

    /**
     * 관심차량
     * @param model
     * @param sellCarSeq
     */
    @RequestMapping(value = "layer/getInterest")
    @WebLogInfo(menuPath = "관심 차량")
    public String interest(Model model, Long[] sellCarSeq) {
        Map<String, Object> resultMap = new HashMap<>();
        List<CarInfoVo> info = new ArrayList<>();

        if(sellCarSeq != null && sellCarSeq.length != 0){
            for (int i = 0 ; i < sellCarSeq.length && info.size() < 3 ; i++) {
                FrontItemVo itemVo = new FrontItemVo();
                List<Long> longs = Arrays.asList(sellCarSeq[i]);
                itemVo.setSellCarSeqs(longs);
                itemVo.setCertYn("ALL");
                Map<String, Object> result = frontItemService.selectItemList(itemVo);
                List<CarInfoVo> resultList = (List<CarInfoVo>) result.get("info");
                if(resultList.size() > 0) info.add(resultList.get(0));
            }
            resultMap.put("infoTotCnt", info.size());
        } else {
            resultMap.put("infoTotCnt", 0);
        }
        resultMap.put("info", info);

        model.addAttribute("interest", resultMap);

        return "layer/interest";
    }
}
