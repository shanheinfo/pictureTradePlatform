package top.itshanhe.picturetradeplatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Value;
import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.entity.PictureData;
import top.itshanhe.picturetradeplatform.entity.PictureInfo;
import top.itshanhe.picturetradeplatform.entity.PictureTagRelation;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.mapper.PictureInfoMapper;
import top.itshanhe.picturetradeplatform.service.IPictureDataService;
import top.itshanhe.picturetradeplatform.service.IPictureFileService;
import top.itshanhe.picturetradeplatform.service.IPictureInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.itshanhe.picturetradeplatform.service.IPictureUserService;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

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
    
    @Resource
    private IPictureFileService pictureFileService;
    @Resource
    private IPictureUserService pictureUserService;
    @Value("${data.domain}")
    private String Domain;
    
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
    
    @Override
    public List<PictureImg> getPicturesByKeyword(Long id, int offset, int pageSize,IPictureDataService iPictureDataService) {
    
        QueryWrapper<PictureInfo> pictureTagRelationQueryWrapper = new QueryWrapper<>();
        pictureTagRelationQueryWrapper.eq("img_type_id", id);
        Page<PictureInfo> page = page(new Page<>(offset / pageSize + 1, pageSize),pictureTagRelationQueryWrapper);
        List<PictureInfo> list = page.getRecords();
        return convertToDTOList(list,iPictureDataService);
    }
    
    private List<PictureImg> convertToDTOList(List<PictureInfo> list,IPictureDataService iPictureDataService) {
        List<PictureImg> resultList = new ArrayList<>();
        
        for (PictureInfo pictureInfo : list) {
            resultList.add(convertList(pictureInfo,iPictureDataService));
        }
        
        return resultList;
    }
    
    private PictureImg convertList(PictureInfo pictureInfo,IPictureDataService pictureDataService) {
        PictureImg pictureImg = new PictureImg();
        pictureImg.setId(pictureInfo.getImgId());
        
        PictureData pictureData = pictureDataService.getPictureDataInfo(pictureInfo.getImgId());
        
        if (pictureData != null) {
            pictureImg.setMoney(pictureData.getImgMoney());
            pictureImg.setAuthorName(pictureUserService.getIdByUserName(pictureData.getUserId()));
            // 将 LocalDateTime 转换为 Date
            Date utilDate = Date.from(pictureData.getImgCreateTime().atZone(ZoneId.systemDefault()).toInstant());
            
            // 使用 SimpleDateFormat 格式化 Date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String currentDate = dateFormat.format(utilDate);
            pictureImg.setImgTime(currentDate);
            pictureImg.setImgUrl(Domain + "/download?uid=" +pictureData.getImgId()+ "&imgName="+  pictureFileService.getFileUrl(pictureData.getImgId()));
            pictureImg.setImgTitle(this.getImgTitle(pictureData.getImgId()));
            pictureImg.setUid(String.valueOf(pictureInfo.getImgId()));
        }
        
        return pictureImg;
    }
}
