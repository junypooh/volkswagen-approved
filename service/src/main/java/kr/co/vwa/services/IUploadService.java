package kr.co.vwa.services;

import kr.co.vwa.domain.FileVo;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by junypooh on 2018-01-17.
 * <pre>
 * kr.co.vwa.services
 *
 * 파일 업로드 Service
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-17 오전 11:22
 */
public interface IUploadService {

    /**
     * 파일 업로드
     * @param multipartFile
     * @param appendPath
     * @return
     * @throws Exception
     */
    FileVo uploadFile(MultipartFile multipartFile, String appendPath) throws Exception;
}
