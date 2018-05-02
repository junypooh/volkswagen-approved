package kr.co.vwa.services;

import kr.co.vwa.domain.FrontItemVo;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 비교하기 Interface
 */
public interface IComparisonService {
    void shareContents(Map<String, Object> firstResult, Map<String, Object> lastResult, FrontItemVo itemVo, HttpServletRequest httpServletRequest);
}
