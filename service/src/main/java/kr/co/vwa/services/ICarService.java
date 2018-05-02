package kr.co.vwa.services;

import kr.co.vwa.domain.CarMngVo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * 차량관리 Interface
 */
public interface ICarService {
    /**
     * 차량관리/목록 차량 목록 조회
     * @param searchParam
     * @return
     */
    List<CarMngVo> selectCarMngList(Map<String, String> searchParam);

    /**
     * 차량관리/목록 차량모델 그룹핑 조회
     * @return
     */
    List<CarMngVo> selectCarModelList();

    /**
     * 차량관리/목록 차량모델 그룹핑 조회(매물 등록 시 사용 [사용여부 ON 만])
     * @return
     */
    List<CarMngVo> selectCarModelListByUseYnIsY();

    /**
     * 폭스바겐 모델별 세부모델 조회
     * @param carMngVo
     * @return
     */
    List<CarMngVo> selectCarDetailModelList(CarMngVo carMngVo);

    /**
     * 폭스바겐 모델별 세부모델 조회(매물 등록 시 사용 [사용여부 ON 만])
     * @param carMngVo
     * @return
     */
    List<CarMngVo> selectCarDetailModelListByUseYnIsY(CarMngVo carMngVo);

    /**
     * 폭스바겐 세부모델별 등급 조회
     * @param carMngVo
     * @return
     */
    List<CarMngVo> selectCarRatingList(CarMngVo carMngVo);

    /**
     * 폭스바겐 세부모델별 등급 조회(매물 등록 시 사용 [사용여부 ON 만])
     * @param carMngVo
     * @return
     */
    List<CarMngVo> selectCarRatingListByUseYnIsY(CarMngVo carMngVo);

    /**
     * 폭스바겐 등급별 세부등급 조회
     * @param carMngVo
     * @return
     */
    List<CarMngVo> selectCarDetailRatingList(CarMngVo carMngVo);

    /**
     * 폭스바겐 등급별 세부등급 조회(매물 등록 시 사용 [사용여부 ON 만])
     * @param carMngVo
     * @return
     */
    List<CarMngVo> selectCarDetailRatingListByUseYnIsY(CarMngVo carMngVo);

    /**
     * 차량관리/등록 엑셀 업로드 후 엑셀 읽기
     * @param registeFile
     * @return
     */
    List<CarMngVo> readExcelCarMngList(MultipartFile registeFile);

    /**
     * 차량관리/등록 차량 정보 등록
     * @param carMngVoList
     * @return
     */
    int insertCarMngList(List<CarMngVo> carMngVoList);

    /**
     * 차량관리/목록 차량정보 수정
     * @param carMng
     * @return
     */
    int updateCarMng(CarMngVo carMng);

}
