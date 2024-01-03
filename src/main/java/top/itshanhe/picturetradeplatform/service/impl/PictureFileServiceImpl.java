package top.itshanhe.picturetradeplatform.service.impl;

import top.itshanhe.picturetradeplatform.entity.PictureFile;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.mapper.PictureFileMapper;
import top.itshanhe.picturetradeplatform.service.IPictureFileService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.io.File;

/**
 * <p>
 * 图片表 服务实现类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Service
public class PictureFileServiceImpl extends ServiceImpl<PictureFileMapper, PictureFile> implements IPictureFileService {
    
    @Override
    public void insertFileAddr(Long uid, String tempFile) {
        PictureFile pictureFile = new PictureFile();
        pictureFile.setImgId(uid);
        pictureFile.setImgAddr(tempFile);
        
        baseMapper.insert(pictureFile);
    }
    
    @Override
    public String getFileUrl(Long imgId) {
        PictureFile pictureFile = query().eq("img_id",imgId).one();
        return pictureFile.getImgAddr();
    }
}
