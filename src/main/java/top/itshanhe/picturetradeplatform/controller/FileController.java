package top.itshanhe.picturetradeplatform.controller;

import cn.hutool.core.lang.Snowflake;
import cn.hutool.core.lang.UUID;
import cn.hutool.core.util.IdUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.coyote.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.resource.CachingResourceResolver;
import org.springframework.web.servlet.resource.ResourceResolver;
import org.springframework.web.servlet.resource.ResourceResolverChain;
import top.itshanhe.picturetradeplatform.common.Constants;
import top.itshanhe.picturetradeplatform.dto.CategoryArrayDTO;
import top.itshanhe.picturetradeplatform.dto.CategoryDTO;
import top.itshanhe.picturetradeplatform.dto.UserDTO;
import top.itshanhe.picturetradeplatform.entity.PictureTag;
import top.itshanhe.picturetradeplatform.service.*;
import top.itshanhe.picturetradeplatform.util.ImageUtils;
import top.itshanhe.picturetradeplatform.util.UserHolder;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
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
    @Resource
    private IPictureUserService iPictureUserService;
    
    @GetMapping("/userAdmin/uploadData")
    public String showUploadForm(Model model) {
        CategoryArrayDTO categoryArrayDTO = new CategoryArrayDTO(iPictureCategoryService.selectAllCatgory());
        model.addAttribute("categoryDTOS", categoryArrayDTO);
        return "/user/admin/upload";
    }
    
    
    
    @PostMapping("/userAdmin/upload")
    public String handleFileUpload(@RequestParam("file") MultipartFile file,
                                   @RequestParam("pictureName") String pictureName,
                                   @RequestParam("categoryKeyId") Integer categoryKeyId,
                                   @RequestParam(name = "copyKey" , defaultValue = "0") Boolean copyKey,
                                   @RequestParam("money") BigDecimal money,
                                   @RequestParam("keywords") String keywords,
                                   @RequestParam("textareaData") String textareaData,
                                   Model model, HttpServletRequest request) {
        try {
            // 检查文件大小
            if (file.getSize() > 10 * 1024 * 1024) {
                model.addAttribute("message", "文件大小不能超过10MB");
                return "/user/admin/upload";
            }
    
            // 检查文件类型
            if (!file.getContentType().startsWith("image/")) {
                model.addAttribute("message", "请选择图片文件");
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
            iPictureFileService.insertFileAddr(id,fileName);
            // 获取当前时间
            LocalDateTime currentDateTime = LocalDateTime.now();
            // 定义日期时间格式
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            // 格式化日期时间
            String formattedDateTime = currentDateTime.format(formatter);
            // 插入图片内容 fixme IdUtil.objectId() 第一个参数是设计错误，已经废弃，但是还是需要填
            //  充值
            // 截取后两位小数
            if (money != null && money.scale() > 2) {
                money = money.setScale(2, RoundingMode.HALF_DOWN);
            }
            String loginSession = (String) request.getSession().getAttribute(Constants.LOGIN_KEY);
            UserDTO userData = iPictureUserService.getNameUserData(loginSession);
            iPictureDataService.insertFileData(IdUtil.objectId(),id,userData.getUserId(),money,copyKey,formattedDateTime);
            // 图片其他信息
            iPictureInfoService.insertFileInfo(id,pictureName,categoryKeyId,textareaData);
            // 截取循环处理标签
            String[] keywordArray = keywords.split(",");
            for (String keyword : keywordArray) {
                // 在此处插入标签表
                // 先判断标签是否存在
                if (iPictureTagService.selectTag(keyword.trim())) {
                    // 获取tag id信息
                    Long Uid = iPictureTagService.getTagId(keyword.trim());
                    // 插入图片tag信息
                    iPictureTagRelationService.insertTagAndPictureId(id,Uid);
                } else {
                    PictureTag pictureTag = new PictureTag();
                    pictureTag.setTagName(keyword.trim());
                    iPictureTagService.save(pictureTag);
                    // 获取tag id信息
                    Long Uid = iPictureTagService.getTagId(keyword.trim());
                    // 插入图片tag信息
                    iPictureTagRelationService.insertTagAndPictureId(id,Uid);
                }
                
            }
            model.addAttribute("message", "上传图片成功！");
            CategoryArrayDTO categoryArrayDTO = new CategoryArrayDTO(iPictureCategoryService.selectAllCatgory());
            model.addAttribute("categoryDTOS", categoryArrayDTO);
            return "/user/admin/upload";
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("message", "文件上传失败: " + e.getMessage());
            return "/user/admin/upload";
        }
    }
    
    // 获取文件扩展名
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf(".");
        return (dotIndex == -1) ? "" : fileName.substring(dotIndex);
    }
    
    @GetMapping("/download")
    public void download(@RequestParam("uid") Long imgId,
                         @RequestParam("imgName") String name, HttpServletResponse response) throws Exception {
        LocalDateTime date = iPictureDataService.getImgTime(imgId);
        if (date == null) {
            response.sendRedirect("/login");
            return;
        }

        // 将 LocalDateTime 转换为 Date
        Date utilDate = Date.from(date.atZone(ZoneId.systemDefault()).toInstant());

        // 使用 SimpleDateFormat 格式化 Date
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String currentDate = dateFormat.format(utilDate);
        // 构建文件路径
        String filePath = uploadDir + currentDate + "\\" + name;
        // 读取文件
        try (FileInputStream fileInputStream = new FileInputStream(filePath)) {
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
        } catch (FileNotFoundException e) {
            // 文件不存在，重定向到错误页面或其他页面
            response.sendRedirect("/your-redirect-url");
        }

       
    }
    
}