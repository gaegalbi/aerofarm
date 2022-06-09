package yj.capstone.aerofarm.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import marvin.image.MarvinImage;
import org.marvinproject.image.transform.scale.Scale;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Objects;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class S3Service {
    private final AmazonS3 amazonS3;

    private static final String FOLDER_NAME = "aerofarm/";

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    public String uploadImage(MultipartFile multipartFile, int resizeWidth, int resizeHeight) {
        if (Objects.requireNonNull(multipartFile.getContentType()).contains("image")) {
            try (InputStream inputStream = multipartFile.getInputStream()) {
                BufferedImage originalImage = ImageIO.read(inputStream);

                BufferedImage resizedImage = ImageResizer.resizeImage(originalImage, resizeWidth, resizeHeight);

                String type = multipartFile.getContentType().substring(multipartFile.getContentType().lastIndexOf("/") + 1);

                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                ImageIO.write(resizedImage, type, baos);
                baos.flush();
                InputStream is = new ByteArrayInputStream(baos.toByteArray());

                String fileName = "business_card/" + UUID.randomUUID();

                ObjectMetadata objectMetadata = new ObjectMetadata();
                objectMetadata.setContentLength(baos.size());
                objectMetadata.setContentType(multipartFile.getContentType());

                amazonS3.putObject(new PutObjectRequest(bucket, fileName, is, objectMetadata)
                        .withCannedAcl(CannedAccessControlList.PublicRead));

                return "https://yj-aerofarm-cityfarmer.s3.ap-northeast-2.amazonaws.com/" + fileName;
            } catch (IOException e) {
                throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
        return "/image/default-image.png";
    }


    public void deleteFile(String fileName) {
        amazonS3.deleteObject(new DeleteObjectRequest(bucket, FOLDER_NAME + fileName.substring(fileName.lastIndexOf("/") + 1)));
    }
}
