package kr.co.vwa.services;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import kr.co.vwa.domain.FileVo;
import kr.co.vwa.repository.FileRepository;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

/**
 * Created by junypooh on 2018-01-17.
 * <pre>
 * kr.co.vwa.services
 *
 * 파일 업로드 Service 구현체
 *
 * </pre>
 *
 * @author Kyungjun, Park
 * @see
 * @since 2018-01-17 오전 11:22
 */
@Service
@Slf4j
public class UploadService implements IUploadService {

    @Autowired
    private FileRepository fileRepository;

    @Value("${upload.file.thumbnailLogoWidth:192}")
    private int thumbnailLogoWidth;

    @Value("${upload.file.thumbnailLogoHeight:68}")
    private int thumbnailLogoHeight;

    @Value("${upload.file.thumbnailBannerWidth:260}")
    private int thumbnailBannerWidth;

    @Value("${upload.file.thumbnailBannerHeight:260}")
    private int thumbnailBannerHeight;

    @Value("${upload.file.thumbnailSubBannerWidth:206}")
    private int thumbnailSubBannerWidth;

    @Value("${upload.file.thumbnailSubBannerHeight:260}")
    private int thumbnailSubBannerHeight;

    @Value("${s3.burket.name}")
    private String BURKETNAME;

    @Value("${s3.accessKeyId}")
    private String ACCESS_KEY;

    @Value("${s3.secretAccessKey}")
    private String SECRET_KEY;

    @Value("${s3.upload.path}")
    private String fileUploadRootPath;

    private static final String[] allowedFileExts =
            new String[]{
                    "JPG", "PNG", "GIF", "JPEG", "XLSX", "XLS", "PDF"
            };

    private static final String[] convertThumnailExts =
            new String[]{
                    "JPG", "PNG", "GIF", "JPEG"
            };

    private static AmazonS3 amazonS3 = null;

    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED)
    public FileVo uploadFile(MultipartFile multipartFile, String appendPath) throws Exception {

        if ("LOGO".equals(appendPath)) {
            return this.uploadFile(multipartFile, appendPath, this.thumbnailLogoWidth, this.thumbnailLogoHeight);
        } else if ("BANNER".equals(appendPath)) {
            return this.uploadFile(multipartFile, appendPath, this.thumbnailBannerWidth, this.thumbnailBannerHeight);
        } else if ("SUBBANNER".equals(appendPath)) {
            return this.uploadFile(multipartFile, appendPath, this.thumbnailSubBannerWidth, this.thumbnailSubBannerHeight);
        } else if ("PHOTO".equals(appendPath)) {
            return this.uploadFile(multipartFile, appendPath, 1140, 490);
        } else {
            return this.uploadFile(multipartFile, appendPath, 0, 0);
        }
    }

    private FileVo uploadFile(MultipartFile multipartFile, String appendPath, int thumbnailWidth, int thumbnailHeight) throws Exception {

        String fileStorePath = fileUploadRootPath + "/" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        if (StringUtils.isNotEmpty(appendPath))
            fileStorePath += "/" + appendPath + "/";
        else
            fileStorePath += "/";

        /*File saveFolder = new File(fileStorePath);

        if (!saveFolder.exists() || saveFolder.isFile()) {
            saveFolder.mkdirs();
        }*/

        String originalFilename = multipartFile.getOriginalFilename();
        if (StringUtils.isNotBlank(originalFilename)) {

            int index = originalFilename.lastIndexOf(".");
            String fileExt = StringUtils.upperCase(originalFilename.substring(index + 1));
            String newName = UUID.randomUUID().toString() + "." + StringUtils.lowerCase(fileExt);
//            String newName = originalFilename;
            long size = multipartFile.getSize();

            if (!ArrayUtils.contains(allowedFileExts, fileExt))
                throw new Exception("허용되지 않는 확장자입니다");

            int thumbnailSize = 0;
            ByteArrayInputStream thumbnailByteArrayInputStream = null;
            int thumbnailShareSize = 0;
            ByteArrayInputStream thumbnailShareByteArrayInputStream = null;
            if (ArrayUtils.contains(convertThumnailExts, fileExt) && thumbnailWidth > 0 && thumbnailHeight > 0) {
//                BufferedImage bufferedImage = ImageIO.read(multipartFile.getInputStream());
//                if (bufferedImage.getWidth() > thumbnailWidth || bufferedImage.getHeight() > thumbnailHeight) {
//                    String savePathString = fileStorePath + "thumbnail/";
//                    File thumbnail      = new File(savePathString + newName);
//                    thumbnail.getParentFile().mkdirs();

                    ByteArrayOutputStream outStream = new ByteArrayOutputStream();

                    Thumbnails.of(multipartFile.getInputStream())
                            .width(thumbnailWidth)
                            .height(thumbnailHeight)
                            .outputFormat("png").toOutputStream(outStream);

                    //byte[] -> InputStream
                    thumbnailByteArrayInputStream = new ByteArrayInputStream(outStream.toByteArray());
                    thumbnailSize = outStream.size();

                    // facebook share image
                    ByteArrayOutputStream outShareStream = new ByteArrayOutputStream();
                    Thumbnails.of(multipartFile.getInputStream())
                            .width(470)
                            .height(202)
                            .outputFormat("png").toOutputStream(outShareStream);

                    //byte[] -> InputStream
                    thumbnailShareByteArrayInputStream = new ByteArrayInputStream(outShareStream.toByteArray());
                    thumbnailShareSize = outShareStream.size();
//                }
            }

            if (amazonS3 == null) {
                AWSCredentials awsCredentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
                amazonS3 = new AmazonS3Client(awsCredentials);
            }

            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(multipartFile.getSize());
            metadata.setContentType(multipartFile.getContentType());
            metadata.setHeader("filename", URLEncoder.encode(multipartFile.getOriginalFilename(), "UTF-8"));

            amazonS3.putObject(new PutObjectRequest(BURKETNAME, fileStorePath + newName, multipartFile.getInputStream(), metadata).withCannedAcl(CannedAccessControlList.PublicRead));

            // thumbnail 생성
            if (thumbnailByteArrayInputStream != null) {

                ObjectMetadata thumbnailMetadata = new ObjectMetadata();
                thumbnailMetadata.setContentLength(thumbnailSize);
                thumbnailMetadata.setContentType("image/png");
                thumbnailMetadata.setHeader("filename", "thumbnail_" + newName);
                amazonS3.putObject(new PutObjectRequest(BURKETNAME, fileStorePath + "thumbnail/" + newName, thumbnailByteArrayInputStream, thumbnailMetadata).withCannedAcl(CannedAccessControlList.PublicRead));
            }

            // thumbnail facebook share image 생성
            if (thumbnailShareByteArrayInputStream != null) {

                ObjectMetadata thumbnailShareMetadata = new ObjectMetadata();
                thumbnailShareMetadata.setContentLength(thumbnailShareSize);
                thumbnailShareMetadata.setContentType("image/png");
                thumbnailShareMetadata.setHeader("filename", "thumbnail_" + newName);
                amazonS3.putObject(new PutObjectRequest(BURKETNAME, fileStorePath + "thumbnail/facebook/" + newName, thumbnailShareByteArrayInputStream, thumbnailShareMetadata).withCannedAcl(CannedAccessControlList.PublicRead));
            }

            //multipartFile.transferTo(new File(fileStorePath + File.separator + newName));

            FileVo fileVo = new FileVo();
            fileVo.setFileNm(newName);
            fileVo.setFilePath("/" + fileStorePath);
            fileVo.setFileSize(size);
            fileVo.setFileExt(fileExt);
            fileVo.setOriFileNm(originalFilename);

            fileRepository.insertFileInfo(fileVo);

            return fileVo;
        } else {
            return null;
        }
    }
}
