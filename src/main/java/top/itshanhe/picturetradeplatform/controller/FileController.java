package top.itshanhe.picturetradeplatform.controller;

import cn.hutool.core.lang.Snowflake;
import cn.hutool.core.lang.UUID;
import cn.hutool.core.util.IdUtil;
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
import top.itshanhe.picturetradeplatform.dto.CategoryArrayDTO;
import top.itshanhe.picturetradeplatform.dto.CategoryDTO;
import top.itshanhe.picturetradeplatform.dto.UserDTO;
import top.itshanhe.picturetradeplatform.service.*;
import top.itshanhe.picturetradeplatform.util.ImageUtils;
import top.itshanhe.picturetradeplatform.util.UserHolder;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

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
    @Resource
    private IPictureCategoryService iPictureCategoryService;
    @Resource
    private IPictureTagService iPictureTagService;
    @Resource
    private IPictureTagRelationService iPictureTagRelationService;
    @Resource
    private IPictureInfoService iPictureInfoService;
    @Resource
    private IPictureDataService iPictureDataService;
    @Resource
    private IPictureFileService iPictureFileService;
    
    @GetMapping("/uploadData")
    public String showUploadForm(Model model) {
        CategoryArrayDTO categoryArrayDTO = new CategoryArrayDTO(iPictureCategoryService.selectAllCatgory());
        model.addAttribute("categoryDTOS", categoryArrayDTO);
        return "/user/admin/upload";
    }
    
    
    
    @PostMapping("/upload")
    public String handleFileUpload( @RequestParam("file") MultipartFile file,
                                    @RequestParam("pictureName") String pictureName,
                                    @RequestParam("categoryKeyId") Long categoryKeyId,
                                    @RequestParam("copyKey") Boolean copyKey,
                                    @RequestParam("money") BigDecimal money,
                                    @RequestParam("keywords") String keywords,
                                    @RequestParam("textareaData") String textareaData,
                                    Model model) {
        try {
            // 检查文件大小
            if (file.getSize() > 10 * 1024 * 1024) {
                model.addAttribute("error", "文件大小不能超过10MB");
                return "/user/admin/upload";
            }
    
            // 检查文件类型
            if (!file.getContentType().startsWith("image/")) {
                model.addAttribute("error", "请选择图片文件");
                return "/user/admin/upload";
            }
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
            // uid 唯一id
            Snowflake snowflake = IdUtil.getSnowflake(1, 1);
            long id = snowflake.nextId();
            // 插入地址
            iPictureFileService.insertFileAddr(id,tempFile);
            UserDTO userData = UserHolder.getUser();
            // 获取当前时间
            LocalDateTime currentDateTime = LocalDateTime.now();
            // 定义日期时间格式
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            // 格式化日期时间
            String formattedDateTime = currentDateTime.format(formatter);
            // 插入图片内容 fixme IdUtil.objectId() 第一个参数是设计错误，已经废弃，但是还是需要填充值
            // 截取后两位小数
            money = money.setScale(2, RoundingMode.HALF_DOWN);
            iPictureDataService.insertFileData(IdUtil.objectId(),id,userData.getUserId(),money,copyKey,formattedDateTime);
            // 图片其他信息
            model.addAttribute("message", fileName);
            return "/user/admin/uploadShow";
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "文件上传失败: " + e.getMessage());
            return "/user/admin/upload";
        }
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