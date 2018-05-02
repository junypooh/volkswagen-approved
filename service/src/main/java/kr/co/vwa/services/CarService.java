package kr.co.vwa.services;

import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.CarMngVo;
import kr.co.vwa.repository.CarRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 차량관리 Service
 */
@Service("carService")
@Slf4j
public class CarService implements ICarService {

    @Autowired
    private CarRepository carRepository;

    /**
     * 차량관리/목록 차량목록 조회
     * @param searchParam
     * @return
     */
    @Override
    public List<CarMngVo> selectCarMngList(Map<String, String> searchParam){
        return carRepository.selectCarMngList(searchParam);
    }

    /**
     * 차량관리/목록 차량모델 그룹핑 조회
     * @return
     */
    @Override
    public List<CarMngVo> selectCarModelList() {
        return carRepository.selectCarModelList();
    }

    /**
     * 차량관리/목록 차량모델 그룹핑 조회(매물 등록 시 사용 [사용여부 ON 만])
     * @return
     */
    @Override
    public List<CarMngVo> selectCarModelListByUseYnIsY() {
        return carRepository.selectCarModelListByUseYnIsY();
    }

    /**
     * 폭스바겐 모델별 세부모델 조회
     * @param carMngVo
     * @return
     */
    @Override
    public List<CarMngVo> selectCarDetailModelList(CarMngVo carMngVo) {
        return carRepository.selectCarDetailModelList(carMngVo);
    }

    /**
     * 폭스바겐 모델별 세부모델 조회(매물 등록 시 사용 [사용여부 ON 만])
     * @param carMngVo
     * @return
     */
    @Override
    public List<CarMngVo> selectCarDetailModelListByUseYnIsY(CarMngVo carMngVo) {
        return carRepository.selectCarDetailModelListByUseYnIsY(carMngVo);
    }

    /**
     * 폭스바겐 세부모델별 등급 조회
     * @param carMngVo
     * @return
     */
    @Override
    public List<CarMngVo> selectCarRatingList(CarMngVo carMngVo) {
        return carRepository.selectCarRatingList(carMngVo);
    }


    /**
     * 폭스바겐 세부모델별 등급 조회(매물 등록 시 사용 [사용여부 ON 만])
     * @param carMngVo
     * @return
     */
    @Override
    public List<CarMngVo> selectCarRatingListByUseYnIsY(CarMngVo carMngVo) {
        return carRepository.selectCarRatingListByUseYnIsY(carMngVo);
    }

    /**
     * 폭스바겐 등급별 세부등급 조회
     * @param carMngVo
     * @return
     */
    @Override
    public List<CarMngVo> selectCarDetailRatingList(CarMngVo carMngVo) {
        return carRepository.selectCarDetailRatingList(carMngVo);
    }

    /**
     * 폭스바겐 등급별 세부등급 조회(매물 등록 시 사용 [사용여부 ON 만])
     * @param carMngVo
     * @return
     */
    @Override
    public List<CarMngVo> selectCarDetailRatingListByUseYnIsY(CarMngVo carMngVo) {
        return carRepository.selectCarDetailRatingListByUseYnIsY(carMngVo);
    }


    /**
     * 차량관리/등록 엑셀 업로드 후 엑셀 읽기
     * @param registeFile
     * @return
     */
    @Override
    public List<CarMngVo> readExcelCarMngList(MultipartFile registeFile) {
        String creUser = SessionUtils.getUser().getUsername();
        List<CarMngVo> carMngVoList = new ArrayList<>();
        try {
            InputStream fis = registeFile.getInputStream();
            XSSFWorkbook workbook = new XSSFWorkbook(fis);

            //시트 수(1번째 시트)
            XSSFSheet sheet = workbook.getSheetAt(0);
            //행의 수
            int rows = sheet.getPhysicalNumberOfRows();
            //행의 index는 0부터 시작하며 엑셀양식에 따라 읽기 시작하는 행을 지정한다.
            for(int rowindex = 1; rowindex < rows; rowindex++){
                //행을읽는다
                XSSFRow row = sheet.getRow(rowindex);
                if(row != null){
                    CarMngVo carMngVo = new CarMngVo();
                    //셀값을 읽는다
                    //제조사
                    carMngVo.setMak(getCellValue(row.getCell(0)));
                    //모델
                    carMngVo.setModel(getCellValue(row.getCell(1)));
                    //세부모델
                    carMngVo.setDetailModel(getCellValue(row.getCell(2)));
                    //판매시작연도
                    carMngVo.setSellStrYear(getCellValue(row.getCell(3)));
                    //판매종료연도
                    carMngVo.setSellEndYear(getCellValue(row.getCell(4)));
                    //연료
                    carMngVo.setFuel(getCellValue(row.getCell(5)));
                    //배기량
                    carMngVo.setDisp(getCellValue(row.getCell(6)));
                    //등급
                    carMngVo.setRating(getCellValue(row.getCell(7)));
                    //세부등급
                    carMngVo.setDetailRating(getCellValue(row.getCell(8)));
                    //등급시작연도
                    carMngVo.setRatingStrYear(getCellValue(row.getCell(9)));
                    //등급종료연도
                    carMngVo.setRatingEndYear(getCellValue(row.getCell(10)));
                    //등록자
                    carMngVo.setCreUser(creUser);

                    carMngVoList.add(carMngVo);
                }
            }
        } catch (Exception e) {
            log.debug("올바르지 않는 확장자인 파일입니다.");
            log.debug(e.getMessage());
        }

        return carMngVoList;
    }

    /**
     * 차량관리/등록 차량 정보 등록
     * @param carMngVoList
     * @return
     */
    @Override
    public int insertCarMngList(List<CarMngVo> carMngVoList) {
        return carRepository.insertCarMngList(carMngVoList);
    }

    /**
     * 차량관리/목록 차량정보 수정
     * @param carMng
     * @return
     */
    @Override
    public int updateCarMng(CarMngVo carMng) {
        //수정자
        carMng.setUpdUser(SessionUtils.getUser().getUsername());

        return carRepository.updateCarMng(carMng);
    }

    /**
     * 엑셀 셀타입별 값 읽기
     * @param cell
     * @return
     */
    private String getCellValue(XSSFCell cell){
        String cellValue = "";
        DecimalFormat df = new DecimalFormat();
        if(cell != null) {
            //타입별로 내용 읽기
            switch (cell.getCellType()){
                case XSSFCell.CELL_TYPE_FORMULA:
                    cellValue = cell.getCellFormula();
                    break;
                case XSSFCell.CELL_TYPE_NUMERIC:
                    cellValue = df.format(cell.getNumericCellValue()).replaceAll(",", "");
                    break;
                case XSSFCell.CELL_TYPE_STRING:
                    cellValue = cell.getStringCellValue()+"";
                    break;
                case XSSFCell.CELL_TYPE_BLANK:
                    cellValue = "";
                    break;
                case XSSFCell.CELL_TYPE_ERROR:
                    cellValue = cell.getErrorCellValue()+"";
                    break;
            }
        }
        return cellValue;
    }


}
