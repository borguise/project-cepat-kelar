package com.project.cepat.kelar.common.util;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.project.cepat.kelar.common.exception.StorageException;

import jakarta.annotation.PostConstruct;

@Component
public class FileUploadUtil {
    public static final String PORTAL_USERS_INQUIRY = "svc_users_inquiry";
    public static final String PORTAL_USERS_TESTIMONY = "svc_users_testimony";

    private static final Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);
    @Value("${file.uploaded-temp-dir}")
    private String fileUploadTempDir;

    @Value("${file.uploaded-dir}")
    private String fileUploadDir;

    private Path tempLocation;
    private Path uploadedDirLocation;

    @PostConstruct
    public void setFileUploadDir() {
        logger.info("Checking file upload dir on " + fileUploadTempDir);
        this.tempLocation = Paths.get(fileUploadTempDir);
        this.uploadedDirLocation= Paths.get(fileUploadDir);
    }

    /**
     * Copy file to temporary folder
     * @param file file to copy
     * @param identifier string identifier for
     * @return string final name of moved file
     *
     * */
    public String copyFileUploadedToTempFolder(MultipartFile file, String identifier){
        String filename = StringUtils.cleanPath(file.getOriginalFilename());
        try {
            if (file.isEmpty()) {
                throw new StorageException("Failed to store empty file " + filename);
            }
            if (filename.contains("..")) {
                // This is a security check
                throw new StorageException(
                        "Cannot store file with relative path outside current directory "
                                + filename);
            }
            String finalFileName = "temp_" + identifier + filename.substring(filename.lastIndexOf("."));
            logger.info("Final File Name : " + finalFileName);
            Files.copy(file.getInputStream(), this.tempLocation.resolve(finalFileName),
                    StandardCopyOption.REPLACE_EXISTING);
            return finalFileName;
        } catch (IOException e) {
            logger.error("Fail copyFileUploadedToTempFolder", e);
            throw new StorageException("Failed to store file " + filename, e);
        }
    }

    public String copyFileToUploadedFolder(MultipartFile file, String productSKU) {
        String filename = StringUtils.cleanPath(file.getOriginalFilename());
        try {
            if (file.isEmpty()) {
                throw new StorageException("Failed to store empty file " + filename);
            }
            if (filename.contains("..")) {
                // This is a security check
                throw new StorageException(
                        "Cannot store file with relative path outside current directory "
                                + filename);
            }
            String finalFileName = "temp_" + productSKU +filename.substring(filename.indexOf("."));
            logger.info("Final File Name : " + finalFileName);
            Files.copy(file.getInputStream(), this.tempLocation.resolve(finalFileName),
                    StandardCopyOption.REPLACE_EXISTING);
            resize(this.tempLocation.resolve(finalFileName).toString(),this.tempLocation.resolve(finalFileName).toString(),400,300);
            return finalFileName;
        } catch (IOException e) {
            logger.error("Fail copyFileToUploadedFolder", e);
            throw new StorageException("Failed to store file " + filename, e);
        }
    }


    /**
     * Resizes an image to a absolute width and height (the image may not be
     * proportional)
     * @param inputImagePath Path of the original image
     * @param outputImagePath Path to save the resized image
     * @param scaledWidth absolute width in pixels
     * @param scaledHeight absolute height in pixels
     * @throws IOException
     */
    private static void resize(String inputImagePath,
                              String outputImagePath, int scaledWidth, int scaledHeight)
            throws IOException {
        // reads input image
        File inputFile = new File(inputImagePath);
        BufferedImage inputImage = ImageIO.read(inputFile);

        // creates output image
        BufferedImage outputImage = new BufferedImage(scaledWidth,
                scaledHeight, inputImage.getType());

        // scales the input image to the output image
        Graphics2D g2d = outputImage.createGraphics();
        g2d.drawImage(inputImage, 0, 0, scaledWidth, scaledHeight, null);
        g2d.dispose();

        // extracts extension of output file
        String formatName = outputImagePath.substring(outputImagePath
                .lastIndexOf(".") + 1);

        // writes to output file
        ImageIO.write(outputImage, formatName, new File(outputImagePath));
    }


    /**
     * function to move file from upload-temp folder to services based uploaded-folder
     * @param service service name must be declared as static constants variable in this class
     * @param fileToMove name of file will be moved from upload-temp to service based uploaded folder
     *
     * */
    public void moveUsersFile(String service, String fileToMove) {
        logger.info("Moving User Uploaded File with Service Name :" + service +" and file to move : " + fileToMove);
        Path targetFile = this.uploadedDirLocation;
        Path sourceFile = this.tempLocation.resolve(fileToMove);
        if(service.equalsIgnoreCase(PORTAL_USERS_INQUIRY)){
            targetFile = this.uploadedDirLocation.resolve("portal-services"+File.separator+fileToMove);
        }else if(service.equalsIgnoreCase(PORTAL_USERS_TESTIMONY)){
            targetFile = this.uploadedDirLocation.resolve("portal-services"+File.separator+fileToMove); //still on portal-services folder
        }

        try{
            Files.move(sourceFile,targetFile,StandardCopyOption.REPLACE_EXISTING);
        }catch (Exception e){
            logger.error("Fail moveUsersFile", e);
        }

    }
}
