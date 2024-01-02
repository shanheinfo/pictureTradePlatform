package top.itshanhe.picturetradeplatform.controller;

import cn.hutool.core.lang.UUID;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.resource.CachingResourceResolver;
import org.springframework.web.servlet.resource.ResourceResolver;
import org.springframework.web.servlet.resource.ResourceResolverChain;
import top.itshanhe.picturetradeplatform.util.ImageUtils;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
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
@Slf4j
@Controller
@RequestMapping("/userAdmin")
class FileController {
    @Value("${file.upload.path}")
    private String uploadDir;
    
    @GetMapping("/uploadData")
    public String showUploadForm() {
        return "/user/admin/upload";
    }
    
    
    
    @PostMapping("/upload")
    public String handleFileUpload(@RequestParam("file") MultipartFile file, Model model) {
        try {
            // 获取当前日期
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String currentDate = dateFormat.format(new Date());
            
//            // 构建存储路径
//            Path uploadPath = Path.of(uploadDir+"/"+currentDate);
            // 构建存储路径
            Path uploadPath = Path.of(uploadDir, currentDate);
            Files.createDirectories(uploadPath);
//            log.info("Upload path created: {}", uploadPath.toAbsolutePath());
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
        return "/user/admin/uploadShow";
    }
    
    // 获取文件扩展名
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf(".");
        return (dotIndex == -1) ? "" : fileName.substring(dotIndex);
    }
    
    @GetMapping("/download")
    public void download(String name, HttpServletResponse response) throws Exception {
        // 获取当前日期
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String currentDate = dateFormat.format(new Date());
        // 读取文件
        FileInputStream fileInputStream = new FileInputStream(uploadDir +currentDate+"\\" + name);
        // 文件写回浏览器
        ServletOutputStream outputStream = response.getOutputStream();
        
        response.setContentType("image/jpeg");
        
        int len;
        byte[] bytes = new byte[1024];
        while (-1 != (len = fileInputStream.read(bytes))) {
            outputStream.write(bytes, 0, len);
            outputStream.flush();
        }
        // 关流
        outputStream.close();
        fileInputStream.close();
    }
    
}