package kr.co.vwa.services;

import kr.co.vwa.common.enums.VWACode;
import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.AuthorityVo;
import kr.co.vwa.domain.WeeklyDataVo;
import kr.co.vwa.domain.WeeklyDetailVo;
import kr.co.vwa.domain.WeeklyVo;
import kr.co.vwa.repository.WeeklyRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * 주간보고 Service
 */
@Service
@Slf4j
public class WeeklyService implements IWeeklyService{

    @Autowired
    private WeeklyRepository weeklyRepository;

    /**
     * 통계관리/목록 관리자 전체 개수 조회
     * @param searchParam
     * @return
     */
    @Override
    public int selectWeeklyListTotalCount(Map<String, Object> searchParam) {
        return weeklyRepository.selectWeeklyListTotalCount(searchParam);
    }

    /**
     * 통계관리/목록 코드값에 따른 관리자 조회
     * @param searchParam
     * @return
     */
    @Override
    public List<WeeklyVo> WeeklyListSelect(Map<String, Object> searchParam){
        List<WeeklyVo> wList=weeklyRepository.WeeklyListSelect(searchParam);
        for(int i=0;i<wList.size();i++){
            if(VWACode.purchase.getCode().equals(wList.get(i).getCategoryCd())){
                wList.get(i).setCategoryNm(VWACode.purchase.getCodeNm());
            }
            if(VWACode.sale.getCode().equals(wList.get(i).getCategoryCd())){
                wList.get(i).setCategoryNm(VWACode.sale.getCodeNm());
            }
        }
        return wList;
    }

    /**
     * 통계관리/weekly report/상세 weekly report정보 조회
     * @param weekly
     * @return
     */
    @Override
    public WeeklyVo selectWeekly(WeeklyVo weekly) {

        WeeklyVo resultWeekly = weeklyRepository.selectWeekly(weekly);

        if(resultWeekly == null) {
            throw new RuntimeException(String.format("조회된 Weekreport 정보가 존재하지 않습니다. [weekRepSeq : \"%d\"]", weekly.getWeekRepSeq()));
        }

        return resultWeekly;
    }

    /**
     * 통계관리/weekly report/모달팝업 전체 관리자정보 조회
     * @param weekly
     * @return
     */
    @Override
    public List<AuthorityVo> selectBranchAuthList(WeeklyVo weekly) {

        List<AuthorityVo> authorityList = weeklyRepository.selectBranchAuthList(weekly);

        //이미 선택된 관리자를 체크한다.
        if(weekly.getAdmSeq() != null){
            for (AuthorityVo authority : authorityList) {
                for (int i = 0; i < weekly.getAdmSeq().length; i++){
                    if(authority.getAdmSeq() == weekly.getAdmSeq()[i]){
                        authority.setCheckYn(true);
                        break;
                    } else {
                        authority.setCheckYn(false);
                    }
                }
            }
        }
        return authorityList;
    }

    /**
     * 통계관리/weekly report/상세 수정
     * @param weekly
     * @return
     */
    @Override
    public int updateWeekly(WeeklyVo weekly) {
        weekly.setUpdUser(SessionUtils.getUser().getUsername());
        int result = weeklyRepository.updateWeekly(weekly);

        //원래데이터와 비교하여 체크 안된 데이터는 삭제
        checkWeeklyDetail(weekly);

        //upsert
        for (int i = 0; weekly.getAdmSeq() != null && i < weekly.getAdmSeq().length; i++) {
            WeeklyDetailVo weeklyDetail = new WeeklyDetailVo();
            weeklyDetail.setWeekRepSeq(weekly.getWeekRepSeq());
            weeklyDetail.setAdmSeq(weekly.getAdmSeq()[i]);
            weeklyDetail.setStrDate(weekly.getDetailStrDate()[i]);
            weeklyDetail.setEndDate(weekly.getDetailEndDate()[i]);
            weeklyDetail.setCreUser(SessionUtils.getUser().getUsername());
            weeklyRepository.upsertWeeklyDetail(weeklyDetail);
        }
        return result;
    }

    /**
     * 통계관리/weekly report/등록
     * @param weekly
     * @return
     */
    @Override
    public WeeklyVo registeWeekly(WeeklyVo weekly){
        weekly.setCreUser(SessionUtils.getUser().getUsername());
        weeklyRepository.registeWeekly(weekly);
        return weekly;
    }

    /**
     * 통계관리/weekly report/등록 detail부분
     * @param admSeq
     * @param weekRepSeq
     * @param strDate
     * @param endDate
     * @return
     */
    @Override
    public int registeWeeklyDetail(Integer[] admSeq,Integer weekRepSeq,String[] strDate, String[] endDate){
        for(int i=0;i<admSeq.length;i++){
            WeeklyDetailVo weeklyDetailVo=new WeeklyDetailVo();
            weeklyDetailVo.setAdmSeq(admSeq[i]);
            weeklyDetailVo.setWeekRepSeq(weekRepSeq);
            weeklyDetailVo.setCreUser(SessionUtils.getUser().getUsername());
            weeklyDetailVo.setStrDate(strDate[i]);
            weeklyDetailVo.setEndDate(endDate[i]);
            weeklyRepository.registeWeeklyDetail(weeklyDetailVo);
        }

        return 1;
    }

    /**
     * 통계관리/weekly report/상세 모달팝업 저장
     * @param weekly
     * @return
     */
    @Override
    public int updateModal(WeeklyVo weekly) {

        //원래데이터와 비교하여 체크 안된 데이터는 삭제
        checkWeeklyDetail(weekly);

        //upsert
        for (int i = 0; weekly.getAdmSeq() != null && i < weekly.getAdmSeq().length; i++) {
            WeeklyDetailVo weeklyDetail = new WeeklyDetailVo();
            weeklyDetail.setWeekRepSeq(weekly.getWeekRepSeq());
            weeklyDetail.setAdmSeq(weekly.getAdmSeq()[i]);
            weeklyDetail.setStrDate(weekly.getDetailStrDate().length == 0 ? "" : weekly.getDetailStrDate()[0]);
            weeklyDetail.setEndDate(weekly.getDetailEndDate().length == 0 ? "" : weekly.getDetailEndDate()[0]);
            weeklyDetail.setCreUser(SessionUtils.getUser().getUsername());
            weeklyRepository.upsertModalSave(weeklyDetail);
        }

        return weekly.getWeekRepSeq();
    }

    /**
     * 통계관리/weekly report/상세 삭제
     * @param weekly
     */
    @Override
    public void deleteWeekly(WeeklyVo weekly) {
        weekly.setUpdUser(SessionUtils.getUser().getUsername());
        //weekly 삭제
        weeklyRepository.deleteWeekly(weekly);
        //weeklyDetail 삭제
        weeklyRepository.deleteAllWeeklyDetail(weekly);
        //weeklyData 삭제
        weeklyRepository.deleteAllWeeklyData(weekly);
    }

    /**
     * 통계관리/weekly report/상세 엑셀 업로드
     * @param weeklyFile
     * @param weeklyDetail
     */
    @Override
    public void readExcel(MultipartFile weeklyFile, WeeklyDetailVo weeklyDetail) {
        List<WeeklyDataVo> weeklyDataList = new ArrayList<>();

        try {
            //원래 존재하던 weeklyReport 양식인지, list페이지에서 다운받은 양식인지 구분하여 읽는다.
            int seetNum = 0;
            int rowNum = 0;

            InputStream fis = weeklyFile.getInputStream();
            XSSFWorkbook workbook = new XSSFWorkbook(fis);
            //셀의 수식 계산 값만 뽑아내기 위한 변수
            FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
            //첫번째시트 첫번째 sell이 '차대번호'라면 list페이지에서 다운받은 양식이므로 1번째 시트에서부터 읽는다.
            XSSFRow checkRow = workbook.getSheetAt(0).getRow(0);
            if(checkRow != null){
                String check = readCellValue(evaluator, checkRow.getCell(0), 0);
                if("차대번호".equals(check)){
                    seetNum = 0;
                    rowNum = 1;
                } else {
                    seetNum = 1;
                    rowNum = 8;
                }
            } else {
                seetNum = 1;
                rowNum = 8;
            }

            //시트 수
            XSSFSheet sheet = workbook.getSheetAt(seetNum);
            //행의 수
            int rows = sheet.getPhysicalNumberOfRows();
            //행의 index는 0부터 시작하며 엑셀양식에 따라 읽기 시작하는 행을 지정한다.
            for(int rowindex = rowNum; rowindex < rows; rowindex++){
                //행을읽는다
                XSSFRow row = sheet.getRow(rowindex);
                if(row != null){
                    WeeklyDataVo weeklyData = new WeeklyDataVo();
                    weeklyData.setWeekRepSeq(weeklyDetail.getWeekRepSeq());
                    weeklyData.setAdmSeq(weeklyDetail.getAdmSeq());
                    weeklyData.setCreUser(SessionUtils.getUser().getUsername());
                    //각셀 읽어서 weeklyData 객체에 set
                    weeklyData.setChasNo(readCellValue(evaluator, row.getCell(0), 0));
                    //행의 첫 시작 셀이 빈칸이면 다음 행을 읽는다.
                    if(weeklyData.getChasNo().equals("continue")) continue;

                    weeklyData.setType(readCellValue(evaluator, row.getCell(1), 1));
                    weeklyData.setDealCorpNm(readCellValue(evaluator, row.getCell(2), 2));
                    weeklyData.setExhHallNm(readCellValue(evaluator, row.getCell(3), 3));
                    weeklyData.setBrand(readCellValue(evaluator, row.getCell(4), 4));
                    weeklyData.setModelGroup(readCellValue(evaluator, row.getCell(5), 5));
                    weeklyData.setModelNm(readCellValue(evaluator, row.getCell(6), 6));
                    weeklyData.setCreNo(readCellValue(evaluator, row.getCell(7), 7));
                    weeklyData.setProdYear(readCellValue(evaluator, row.getCell(8), 8));
                    weeklyData.setDriveDist(readCellValue(evaluator, row.getCell(9), 9));
                    weeklyData.setFirstCreDate(readCellValue(evaluator, row.getCell(10), 10));
                    weeklyData.setBuyDate(readCellValue(evaluator, row.getCell(11), 11));
                    weeklyData.setSellDate(readCellValue(evaluator, row.getCell(12), 12));
                    weeklyData.setInflowPath(readCellValue(evaluator, row.getCell(13), 13));
                    weeklyData.setSellType(readCellValue(evaluator, row.getCell(14), 14));
                    weeklyData.setBuyType(readCellValue(evaluator, row.getCell(15), 15));
                    weeklyData.setSellCost(readCellValue(evaluator, row.getCell(16), 16));
                    weeklyData.setBuyCost(readCellValue(evaluator, row.getCell(17), 17));
                    weeklyData.setServicingCost(readCellValue(evaluator, row.getCell(18), 18));
                    weeklyData.setCommission(readCellValue(evaluator, row.getCell(19), 19));
                    weeklyData.setCommercializeCost(readCellValue(evaluator, row.getCell(20), 20));
                    weeklyData.setKeepCost(readCellValue(evaluator, row.getCell(21), 21));
                    weeklyData.setConveyCost(readCellValue(evaluator, row.getCell(22), 22));
                    weeklyData.setWarrInsurCost(readCellValue(evaluator, row.getCell(23), 23));
                    weeklyData.setTransferFee(readCellValue(evaluator, row.getCell(24), 24));
                    weeklyData.setBuyProgress(readCellValue(evaluator, row.getCell(25), 25));
                    weeklyData.setBuyResponsibility(readCellValue(evaluator, row.getCell(26), 26));
                    weeklyData.setSellEmpl(readCellValue(evaluator, row.getCell(27), 27));
                    weeklyData.setCustomerType(readCellValue(evaluator, row.getCell(28), 28));
                    weeklyData.setFinanceProdType(readCellValue(evaluator, row.getCell(29), 29));
                    weeklyData.setFinanceCorp(readCellValue(evaluator, row.getCell(30), 30));

                    weeklyDataList.add(weeklyData);
                }
            }

        } catch(Exception e){
            log.debug(e.getMessage());
            throw new RuntimeException(String.format("올바르지 않는 확장자인 파일입니다.", weeklyFile.getOriginalFilename()));
        }

        weeklyDetail.setFileNm(weeklyFile.getOriginalFilename());
        weeklyDetail.setUpdUser(SessionUtils.getUser().getUsername());
        weeklyRepository.updateWeeklyDetail(weeklyDetail);

        //weekly data 원 데이터 삭제 후 insert
        weeklyRepository.deleteWeeklyData(weeklyDetail);
        if(weeklyDataList.size() > 0){
            weeklyRepository.saveWeeklyData(weeklyDataList);
        }
    }

    /**
     * 통계관리/weekly report/상세 엑셀다운로드
     * @param weekly
     * @return
     */
    @Override
    public List<WeeklyDataVo> selectWeeklyDataList(WeeklyVo weekly) {
        return weeklyRepository.excelDownload(weekly);
    }

    @Override
    public int deleteFile(WeeklyDetailVo weeklyDetail) {
        //detail의 파일명, 업로드일시 삭제
        int result = weeklyRepository.updateFileName(weeklyDetail);
        //해당 파일 Data 삭제
        weeklyRepository.deleteWeeklyData(weeklyDetail);
        return result;
    }

    /**
     * 원래데이터와 비교하여 체크 안된 데이터는 삭제
     * @param weekly
     */
    private void checkWeeklyDetail(WeeklyVo weekly){
        WeeklyVo resultWeekly = weeklyRepository.selectWeekly(weekly);
        List<WeeklyDetailVo> weeklyDetailList = resultWeekly.getWeeklyDetailList();
        //원래 있던 데이터와 비교하여 화면에서 삭제시킨 데이터를 분리한다.
        for(Iterator<WeeklyDetailVo> it = weeklyDetailList.iterator(); it.hasNext() ; ){
            WeeklyDetailVo weeklyDetail = it.next();
            if(weekly.getAdmSeq() != null){
                for (Integer updateSeq: weekly.getAdmSeq()) {
                    if(weeklyDetail.getAdmSeq() == updateSeq){
                        it.remove();
                        break;
                    }
                }
            }
        }
        //삭제
        for (WeeklyDetailVo weeklyDetail : weeklyDetailList) {
            weeklyDetail.setUpdUser(SessionUtils.getUser().getUsername());
            weeklyRepository.deleteWeeklyDetail(weeklyDetail);
            weeklyRepository.deleteWeeklyData(weeklyDetail);
        }
    }

    /**
     * 셀값 읽기
     * @param evaluator
     * @param cell
     * @param columnindex
     * @return
     */
    private String readCellValue(FormulaEvaluator evaluator, XSSFCell cell, int columnindex) {
        //수식 결과값이 숫자일 경우 값이 클때 E7, E8으로 나오기 때문에 변환해줘야한다.
        DecimalFormat df = new DecimalFormat();
        //셀 수식 결과값 계산
        CellValue cellValue = evaluator.evaluate(cell);
        String value="";
        //행의 첫 시작 셀이 빈칸이면 다음 행을 읽는다.
        if(columnindex == 0 && cellValue == null){
            return "continue";
        } else if(cellValue != null) {
            //셀 수식 결과 값 타입별 분기처리
            switch(cellValue.getCellTypeEnum()) {
                case STRING:
                    value = cellValue.getStringValue();
                    break;
                case NUMERIC:
                    //수식결과는 무조건 숫자로 계산되기 때문에 결과값이 날짜여야 하는 경우 강제로 formatting해준다
                    if(columnindex == 10 || columnindex == 11 || columnindex == 12){
                        Date date = HSSFDateUtil.getJavaDate(cellValue.getNumberValue());
                        //Date값 String으로 변환
                        value = LocalDateTime.ofInstant(date.toInstant(), ZoneId.systemDefault()).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    } else {
                        value = df.format(cellValue.getNumberValue());
                    }
                    break;
                case BOOLEAN:
                    value = cellValue.getBooleanValue() + "";
                    break;
            }
            //셀이 수식이 아닐때 값에 ("")가 붙어있음
            value = value.replaceAll("\"", "");
        }

        return value;
    }

}