package top.itshanhe.picturetradeplatform.controller;

import cn.hutool.core.lang.UUID;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import top.itshanhe.picturetradeplatform.util.ImageUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2023/12/22
 */
@Controller
@RequestMapping("/api/files")
class FileController {
    
    private final String uploadDir = "uploads";
    
    @GetMapping("/upload-form")
    public String showUploadForm() {
        return "admin/user/upload";
    }
    
    
    
    @PostMapping("/upload")
    public String handleFileUpload(@RequestParam("file") MultipartFile file, Model model) {
        try {
            // 获取当前日期
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String currentDate = dateFormat.format(new Date());
            
            // 构建存储路径
            Path uploadPath = Path.of(uploadDir, currentDate);
            Files.createDirectories(uploadPath);
            
            // 生成随机 UUID 作为文件名
            String fileName = UUID.randomUUID().toString() + getFileExtension(file.getOriginalFilename());
            
            // 构建文件路径
            Path targetPath = Path.of(uploadPath.toString(), fileName);
            
            // 保存文件
            Files.copy(file.getInputStream(), targetPath, StandardCopyOption.REPLACE_EXISTING);
            
            // 获取临时文件路径
            File tempFile = targetPath.toFile();
            
//            // 延迟删除
//            tempFile.deleteOnExit();
    
//            File imageFile = new File("D:\\idea_java_projects\\pictureTradePlatform\\uploads\\2023-12-22\\4776e59f-faa8-40df-b5ae-2d5bc6f66c4d.JPG");
//
//            try {
//                String base64Image = ImageUtils.encodeImageToBase64(imageFile);
//                model.addAttribute("base64Image", base64Image);
//            } catch (IOException e) {
//                e.printStackTrace();
//                // handle exception
//            }
//
//            return "/admin/user/imageO";
//
            model.addAttribute("message", fileName);
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "文件上传失败: " + e.getMessage());
        }
        return "/admin/user/uploadImg";
    }
    
    // 获取文件扩展名
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf(".");
        return (dotIndex == -1) ? "" : fileName.substring(dotIndex);
    }
    
}