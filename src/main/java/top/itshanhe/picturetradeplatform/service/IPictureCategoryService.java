package top.itshanhe.picturetradeplatform.service;

import top.itshanhe.picturetradeplatform.dto.CategoryDTO;
import top.itshanhe.picturetradeplatform.dto.PictureNav;
import top.itshanhe.picturetradeplatform.entity.PictureCategory;
import com.baomidou.mybatisplus.extension.service.IService;
import top.itshanhe.picturetradeplatform.entity.PictureTag;

import java.util.List;

/**
 * <p>
 * 分类板块表 服务类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
public interface IPictureCategoryService extends IService<PictureCategory> {
    
    List<CategoryDTO> selectAllCatgory();
    
    List<PictureCategory> selectPictureCategoryAll();
}
