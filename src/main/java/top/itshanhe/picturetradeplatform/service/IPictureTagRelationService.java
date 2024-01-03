package top.itshanhe.picturetradeplatform.service;

import top.itshanhe.picturetradeplatform.entity.PictureTagRelation;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 图片标签关联表 服务类
 * </p>
 *
 * @author shanhe
 * @since 2024-01-03
 */
public interface IPictureTagRelationService extends IService<PictureTagRelation> {
    
    void insertTagAndPictureId(long id, Long uid);
}
