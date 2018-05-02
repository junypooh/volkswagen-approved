package kr.co.vwa.manager.controller;

import kr.co.vwa.domain.FileVo;
import kr.co.vwa.services.IUploadService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by junypooh on 2018-01-17.
 * <pre>
 * kr.co.vwa.web.controller
 *
 * 파일 업로드 관련 공통 Controller
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-17 오전 11:21
 */
@Slf4j
@Controller
@RequestMapping("file")
public class FileController {

    @Autowired
    private IUploadService iUploadService;

    @Value("${s3.url}")
    private String fileUrlPath;

    /**
     * 파일 업로드 샘플 페이지
     */
    @GetMapping("upload")
    public void upload() throws Exception {
    }

    /**
     * 파일 업로드
     * @param uploadFile
     * @return
     * @throws Exception
     */
    @PostMapping(value="/upload")
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam MultipartFile uploadFile, String type) throws Exception {

        Assert.notNull(type, "Type(appendPath) must be not null.");

        FileVo fileVo = iUploadService.uploadFile(uploadFile, type);

        log.debug("###############################");
        log.debug("{}", fileVo);
        log.debug("###############################");

        Map<String, Object> map = new HashMap<>();
        map.put("fileSeq", fileVo.getFileSeq());
        map.put("oriFileName", fileVo.getOriFileNm());
        map.put("fileName", fileVo.getFileNm());
        map.put("fileSize", fileVo.getFileSize());
        map.put("fileExt", fileVo.getFileExt());

        return map;
    }

    /**
     * Dropzone 파일 업로드
     * @param request
     * @param type
     * @return
     * @throws Exception
     */
    @PostMapping(value="/upload/dropzone")
    @ResponseBody
    public Map<String, Object> uploadFileDropzone(MultipartHttpServletRequest request, String type) throws Exception {

        Assert.notNull(type, "Type(appendPath) must be not null.");

        Map<String, MultipartFile> fileMap = request.getFileMap();

        FileVo fileVo = new FileVo();
        // 한개만 등록..
        for(MultipartFile multipartFile : fileMap.values()) {
            fileVo = iUploadService.uploadFile(multipartFile, type);
            break;
        }

        log.debug("###############################");
        log.debug("{}", fileVo);
        log.debug("###############################");

        Map<String, Object> map = new HashMap<>();
        map.put("fileSeq", fileVo.getFileSeq());
        map.put("oriFileName", fileVo.getOriFileNm());
        map.put("fileName", fileVo.getFileNm());
        map.put("fileSize", fileVo.getFileSize());
        map.put("fileExt", fileVo.getFileExt());

        return map;
    }

    /**
     * CKEditor 파일 업로드
     * @param request
     * @param type
     * @return
     * @throws Exception
     */
    @PostMapping(value="/upload/CKEditor")
    @ResponseBody
    public String uploadFileCKEditor(MultipartHttpServletRequest request, String type) throws Exception {

        Assert.notNull(type, "Type(appendPath) must be not null.");

        Map<String, MultipartFile> fileMap = request.getFileMap();

        FileVo fileVo = new FileVo();
        // 한개만 등록..
        for(MultipartFile multipartFile : fileMap.values()) {
            fileVo = iUploadService.uploadFile(multipartFile, type);
            break;
        }

        String funcNum=request.getParameter("CKEditorFuncNum");

        log.debug("###############################");
        log.debug("{}", fileVo);
        log.debug("###############################");

        String filePath=fileVo.getFilePath();
        String fileNm=fileVo.getFileNm();
        String fileUrl="http://"+fileUrlPath+filePath+fileNm;

        String url= "<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction('"+funcNum+"','"+fileUrl+"','SUCCESS');</script>";

        return url;
    }
}
