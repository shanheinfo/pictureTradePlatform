package top.itshanhe.picturetradeplatform.service.impl;

import top.itshanhe.picturetradeplatform.entity.PictureAdmin;
import top.itshanhe.picturetradeplatform.entity.PictureTag;
import top.itshanhe.picturetradeplatform.mapper.PictureTagMapper;
import top.itshanhe.picturetradeplatform.service.IPictureTagService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 标签表 服务实现类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Service
public class PictureTagServiceImpl extends ServiceImpl<PictureTagMapper, PictureTag> implements IPictureTagService {
    
    @Override
    public boolean selectTag(String trim) {
    
        PictureTag pictureTag = query().eq("tag_name",trim).one();
        
        return pictureTag != null;
    }
    
    @Override
    public Long getTagId(String trim) {
        PictureTag pictureTag = query().eq("tag_name",trim).one();
        return pictureTag.getTagId();
    }
}
