package top.itshanhe.picturetradeplatform.service;

import top.itshanhe.picturetradeplatform.entity.PictureFile;
import com.baomidou.mybatisplus.extension.service.IService;

import java.io.File;

/**
 * <p>
 * 图片表 服务类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
public interface IPictureFileService extends IService<PictureFile> {
    
    void insertFileAddr(Long uid, String tempFile);
    
    String getFileUrl(Long imgId);
}
