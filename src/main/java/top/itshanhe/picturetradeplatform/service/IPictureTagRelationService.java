package top.itshanhe.picturetradeplatform.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.entity.PictureTagRelation;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

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
    
    List<PictureImg> getPicturesByKeyword(Long id, int offset, int pageSize);
}
