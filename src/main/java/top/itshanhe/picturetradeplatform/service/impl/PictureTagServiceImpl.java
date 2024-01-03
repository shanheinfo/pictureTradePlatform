package top.itshanhe.picturetradeplatform.service.impl;

import top.itshanhe.picturetradeplatform.dto.PictureNav;
import top.itshanhe.picturetradeplatform.entity.PictureCategory;
import top.itshanhe.picturetradeplatform.entity.PictureTag;
import top.itshanhe.picturetradeplatform.mapper.PictureTagMapper;
import top.itshanhe.picturetradeplatform.service.IPictureCategoryService;
import top.itshanhe.picturetradeplatform.service.IPictureTagService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

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
    @Resource
    IPictureCategoryService iPictureCategoryService;
    
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
    
    @Override
    public List<PictureNav> selectTagAll(String defaultDomain) {
        List<PictureTag> pictureTagList = list();
        List<PictureCategory> pictureCategories = iPictureCategoryService.selectPictureCategoryAll();
        return convertToPictureNavList(pictureTagList,pictureCategories,defaultDomain);
    }
    
    private List<PictureNav> convertToPictureNavList(List<PictureTag> pictureTagList,List<PictureCategory> pictureCategories,String defaultDomain) {
        List<PictureNav> pictureNavList = new ArrayList<>();
        for (PictureTag pictureTag : pictureTagList) {
            PictureNav pictureNav = new PictureNav();
            pictureNav.setNavTitle(pictureTag.getTagName());
            pictureNav.setDataUrl("http://" + defaultDomain + "/" + "tag/" + String.valueOf(pictureTag.getTagId()));
            pictureNavList.add(pictureNav);
        }
        for (PictureCategory pictureCategory : pictureCategories) {
            PictureNav pictureNav = new PictureNav();
            pictureNav.setNavTitle(pictureCategory.getCategoryName());
            pictureNav.setDataUrl("http://" + defaultDomain + "/" + "category/" + String.valueOf(pictureCategory.getCategoryId()));
            pictureNavList.add(pictureNav);
        }
        return pictureNavList;
    }
}
