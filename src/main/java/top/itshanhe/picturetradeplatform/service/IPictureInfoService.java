package top.itshanhe.picturetradeplatform.service;

import top.itshanhe.picturetradeplatform.entity.PictureInfo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 图片其他信息表 服务类
 * </p>
 *
 * @author shanhe
 * @since 2024-01-03
 */
public interface IPictureInfoService extends IService<PictureInfo> {
    
    void insertFileInfo(long id, String pictureName, Integer categoryKeyId, String textareaData);
    
    String getImgTitle(Long imgId);
}
