package kr.co.vwa.repository;

import kr.co.vwa.domain.HierarckyVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by DaDa on 2018-01-16.
 * 코드관리계층 Repository
 */
@Repository
public interface HierarchyRepository {

    /**
     * 제시/성능점검 > 주요장치 조회
     * @param sellCarSeq: 매물차량시퀀스
     * @param startWith : 계층 시작 코드
     * @return
     */
    List<HierarckyVo> selectMajorDeviceData(@Param("sellCarSeq") Long sellCarSeq, @Param("startWith") String startWith);

    /**
     * 가격/사고이력 > 인증차량 품질보증 데이터 조회
     * @param sellCarSeq: 매물차량시퀀스
     * @param startWith : 계층 시작 코드
     * @return
     */
    List<HierarckyVo> selectSvcPlusData(@Param("sellCarSeq") Long sellCarSeq, @Param("startWith") String startWith);
}
