package top.itshanhe.picturetradeplatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Value;
import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.entity.PictureData;
import top.itshanhe.picturetradeplatform.entity.PictureTagRelation;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.mapper.PictureTagRelationMapper;
import top.itshanhe.picturetradeplatform.service.*;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

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
    @Resource
    private IPictureDataService pictureDataService;
    @Resource
    private IPictureInfoService pictureInfoService;
    @Resource
    private IPictureFileService pictureFileService;
    @Resource
    private IPictureUserService pictureUserService;
    @Value("${data.domain}")
    private String Domain;
    @Override
    public void insertTagAndPictureId(long id, Long uid) {
        PictureTagRelation pictureTagRelation = new PictureTagRelation();
        pictureTagRelation.setImgId(id);
        pictureTagRelation.setTagId(uid);
        baseMapper.insert(pictureTagRelation);
    }
    
    @Override
    public List<PictureImg> getPicturesByKeyword(Long tagId, int offset, int pageSize) {
        QueryWrapper<PictureTagRelation> pictureTagRelationQueryWrapper = new QueryWrapper<>();
        pictureTagRelationQueryWrapper.eq("tag_id", tagId);
        Page<PictureTagRelation> page = page(new Page<>(offset / pageSize + 1, pageSize),pictureTagRelationQueryWrapper);
        List<PictureTagRelation> list = page.getRecords();
        return convertToDTOList(list);
    }
    
    private List<PictureImg> convertToDTOList(List<PictureTagRelation> list) {
        return list.stream().map(this::converList).collect(Collectors.toList());
    }
    
    private PictureImg converList(PictureTagRelation pictureTagRelation) {
        PictureImg pictureImg = new PictureImg();
        pictureImg.setId(pictureTagRelation.getImgId());
        PictureData pictureData = pictureDataService.getPictureDataInfo(pictureTagRelation.getImgId());
        pictureImg.setMoney(pictureData.getImgMoney());
        pictureImg.setAuthorName(pictureUserService.getIdByUserName(pictureData.getUserId()));
        // 将 LocalDateTime 转换为 Date
        Date utilDate = Date.from(pictureData.getImgCreateTime().atZone(ZoneId.systemDefault()).toInstant());
    
        // 使用 SimpleDateFormat 格式化 Date
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDate = dateFormat.format(utilDate);
        pictureImg.setImgTime(currentDate);
        pictureImg.setImgUrl(Domain + "/download?uid=" +pictureData.getImgId()+ "&imgName="+  pictureFileService.getFileUrl(pictureData.getImgId()));
        pictureImg.setImgTitle(pictureInfoService.getImgTitle(pictureData.getImgId()));
        pictureImg.setUid(String.valueOf(pictureTagRelation.getImgId()));
        return pictureImg;
    }
}
