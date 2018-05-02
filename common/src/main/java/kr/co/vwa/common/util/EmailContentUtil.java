package kr.co.vwa.common.util;

import kr.co.vwa.common.enums.EmailTypeEnum;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.ui.velocity.VelocityEngineUtils;

import java.util.Map;

/**
 * Created by junypooh on 2018-02-21.
 * <pre>
 * kr.co.vwa.common.util
 *
 * 메일 컨텐츠 데이터 생성 Class
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-02-21 오후 5:54
 */
public class EmailContentUtil {

    /**
     * 메일 컨텐츠 데이터 생성
     *
     * @param emailTypeEnum
     * @param data
     * @return
     */
    public static String getStaticEmailContents(EmailTypeEnum emailTypeEnum, Map<String, Object> data) {

        String vmFile = "";

        switch(emailTypeEnum) {
            case SHARE :
                vmFile = "/velocity/share.vm";
                break;
            case COMPARISON :
                vmFile = "/velocity/comparison.vm";
                break;
            default:
                break;
        }

        VelocityEngine velocityEngine = (VelocityEngine) ApplicationContextUtils.getBean("velocityEngineFactoryBean");
        String templateIntoString = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, vmFile, "UTF-8", data);

        return templateIntoString;

    }
}
