package kr.co.vwa.domain;

import lombok.Data;

/**
 * Created by junypooh on 2018-01-17.
 * <pre>
 * kr.co.vwa.domain
 *
 * File VO
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-17 오전 11:31
 */
@Data
public class FileVo {

    private Long fileSeq;

    private String fileNm;

    private String filePath;

    private Long fileSize;

    private String fileExt;

    private String oriFileNm;

    private String creUser;
}
