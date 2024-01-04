package top.itshanhe.picturetradeplatform.service.impl;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import top.itshanhe.picturetradeplatform.entity.PictureInfo;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.mapper.PictureInfoMapper;
import top.itshanhe.picturetradeplatform.service.IPictureInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 图片其他信息表 服务实现类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Service
public class PictureInfoServiceImpl extends ServiceImpl<PictureInfoMapper, PictureInfo> implements IPictureInfoService {
    
    @Override
    public void insertFileInfo(long id, String pictureName, Integer categoryKeyId, String textareaData) {
        PictureInfo pictureInfo = new PictureInfo(id, pictureName, categoryKeyId, textareaData);
        baseMapper.insert(pictureInfo);
    }
    
    @Override
    public String getImgTitle(Long imgId) {
        PictureInfo pictureInfo = query().eq("img_id",imgId).one();
        return pictureInfo.getImgName();
    }
}
