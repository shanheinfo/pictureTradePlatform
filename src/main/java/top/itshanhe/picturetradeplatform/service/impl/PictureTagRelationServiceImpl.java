package top.itshanhe.picturetradeplatform.service.impl;

import top.itshanhe.picturetradeplatform.entity.PictureTagRelation;
import top.itshanhe.picturetradeplatform.mapper.PictureTagRelationMapper;
import top.itshanhe.picturetradeplatform.service.IPictureTagRelationService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 图片标签关联表 服务实现类
 * </p>
 *
 * @author shanhe
 * @since 2024-01-03
 */
@Service
public class PictureTagRelationServiceImpl extends ServiceImpl<PictureTagRelationMapper, PictureTagRelation> implements IPictureTagRelationService {
    
    @Override
    public void insertTagAndPictureId(long id, Long uid) {
        PictureTagRelation pictureTagRelation = new PictureTagRelation();
        pictureTagRelation.setImgId(id);
        pictureTagRelation.setTagId(uid);
        baseMapper.insert(pictureTagRelation);
    }
}
