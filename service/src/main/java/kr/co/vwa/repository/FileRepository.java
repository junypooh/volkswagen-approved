package kr.co.vwa.repository;

import kr.co.vwa.domain.FileVo;
import org.springframework.stereotype.Repository;

/**
 * Created by junypooh on 2018-01-17.
 * <pre>
 * kr.co.vwa.repository
 *
 * File Repository
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-17 오전 11:33
 */
@Repository
public interface FileRepository {

    /**
     * 파일등록
     * @param fileVo
     */
    void insertFileInfo(FileVo fileVo);

    /**
     * 파일조회
     * @param fileSeq
     * @return
     */
    FileVo retrieveFile(Long fileSeq);
}
