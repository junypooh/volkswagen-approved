package kr.co.vwa.services;

import kr.co.vwa.common.enums.EmailTypeEnum;
import kr.co.vwa.common.util.EmailContentUtil;
import kr.co.vwa.domain.FrontItemVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.velocity.tools.generic.NumberTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

/**
 * 비교하기 Service
 */
@Service
@Slf4j
public class ComparisonService implements IComparisonService{

    @Autowired
    private IEmailService iEmailService;

    @Value("${s3.url}")
    private String fileUrlPath;

    @Override
    public void shareContents(Map<String, Object> firstResult, Map<String, Object> lastResult, FrontItemVo itemVo, HttpServletRequest httpServletRequest) {
        Map<String, Object> data = new HashMap<>();
        data.put("firstResult", firstResult);
        data.put("lastResult", lastResult);
        data.put("number", new NumberTool());
        data.put("fileUrlPath", fileUrlPath);

        //연식, 주행거리 게이지 계산
        FrontItemVo firstItem = (FrontItemVo) firstResult.get("info");
        Double firstDist = Double.parseDouble(firstItem.getDriveDist()) / 150000 * 100;
        firstDist = firstDist < 0 ? 0 : firstDist;
        firstDist = firstDist > 100 ? 100 : firstDist;
        data.put("firstDist", firstDist);
        FrontItemVo lastItem = (FrontItemVo) lastResult.get("info");
        Double lastDist = Double.parseDouble(lastItem.getDriveDist()) / 150000 * 100;
        lastDist = lastDist < 0 ? 0 : lastDist;
        lastDist = lastDist > 100 ? 100 : lastDist;
        data.put("lastDist", lastDist);

        int year = Calendar.getInstance().get(Calendar.YEAR);
        int divYear = year - 2008;
        Double firstYear = (Double.parseDouble(firstItem.getFromYear()) - 2008) / divYear * 100;
        firstYear = firstYear < 0 ? 0 : firstYear;
        firstYear = firstYear > 100 ? 100 : firstYear;
        data.put("firstYear", firstYear);
        Double lastYear = (Double.parseDouble(lastItem.getFromYear()) - 2008) / divYear * 100;
        lastYear = lastYear < 0 ? 0 : lastYear;
        lastYear = lastYear > 100 ? 100 : lastYear;
        data.put("lastYear", lastYear);

        data.put("domainUrl", httpServletRequest.getScheme() + "://" + httpServletRequest.getServerName() + ":" + httpServletRequest.getServerPort() + httpServletRequest.getContextPath());
        data.put("linkUrl", httpServletRequest.getScheme() + "://" + httpServletRequest.getServerName() + ":" + httpServletRequest.getServerPort() + httpServletRequest.getContextPath() + "/comparison/view/" + itemVo.getFirstSellCarSeq() + "/" + itemVo.getLastSellCarSeq());

        String emailContents = EmailContentUtil.getStaticEmailContents(EmailTypeEnum.COMPARISON, data);

        iEmailService.sendEmailMimeMessage(itemVo.getMailAddr(), itemVo.getMailUserNm(), "[폭스바겐 인증중고차] 비교하신 차량정보입니다.", emailContents);
    }
}
