package kr.co.vwa.manager.controller;

import kr.co.vwa.domain.CarMngVo;
import kr.co.vwa.services.ICarService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 차량관리/Back Controller
 */
@Controller
@Slf4j
@RequestMapping("car")
public class CarController {

    @Resource(name = "carService")
    private ICarService carService;

    /**
     * 차량관리/목록
     * @param model
     * @param searchParam
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @RequestMapping("/list")
    public String carMngList(Model model, @RequestParam Map<String, String> searchParam){

        //차량전체조회
        List<CarMngVo> carMngList = carService.selectCarMngList(searchParam);
        //셀렉트박스의 차량모델리스트
        List<CarMngVo> carModelList = carService.selectCarModelList();

        model.addAttribute("searchParam", searchParam);
        model.addAttribute("carMngList", carMngList);
        model.addAttribute("carModelList", carModelList);
        return "car/carList";
    }

    /**
     * 차량관리/등록 화면이동
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @GetMapping("/registe")
    public String carMngRegisteForm(){
        return "car/carRegiste";
    }

    /**
     * 차량관리/등록 엑셀 읽기
     * @param registeFile
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping(value = "/readExcel", consumes = "multipart/form-data")
    @ResponseBody
    public List<CarMngVo> readExcel(@RequestParam (name = "registeFile") MultipartFile registeFile){

        List<CarMngVo> carMngVoList = carService.readExcelCarMngList(registeFile);

        return carMngVoList;
    }

    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping(value = "/registe", consumes = "multipart/form-data")
    @ResponseBody
    public int registeCarMng(@RequestParam (name = "registeFile") MultipartFile registeFile){
        List<CarMngVo> carMngVoList = carService.readExcelCarMngList(registeFile);
        int result = carService.insertCarMngList(carMngVoList);

        return result;
    }


    /**
     * 차량관리/목록 편집저장
     * @param carMng
     * @return
     */
    @PreAuthorize("hasRole('ROLE_VW')")
    @PostMapping("/update")
    @ResponseBody
    public int updateCarMng(CarMngVo carMng){

        return carService.updateCarMng(carMng);
    }


}
