package top.itshanhe.picturetradeplatform.service.impl;

import top.itshanhe.picturetradeplatform.dto.CategoryDTO;
import top.itshanhe.picturetradeplatform.entity.PictureCategory;
import top.itshanhe.picturetradeplatform.mapper.PictureCategoryMapper;
import top.itshanhe.picturetradeplatform.service.IPictureCategoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 分类板块表 服务实现类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Service
public class PictureCategoryServiceImpl extends ServiceImpl<PictureCategoryMapper, PictureCategory> implements IPictureCategoryService {
    
    @Override
    public List<CategoryDTO> selectAllCatgory() {
        // 查询全部分类数据
        List<PictureCategory> categoryList = list();
    
        // 将 PictureCategory 转换为 CategoryDTO
        List<CategoryDTO> categoryDTOList = categoryList.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());

    
        return categoryDTOList;
    }
    
    @Override
    public List<PictureCategory> selectPictureCategoryAll() {
        return list();
    }
    
    private CategoryDTO convertToDTO(PictureCategory pictureCategory) {
        CategoryDTO categoryDTO = new CategoryDTO();
        categoryDTO.setCategoryId(pictureCategory.getCategoryId());
        categoryDTO.setCategoryName(pictureCategory.getCategoryName());
        categoryDTO.setCategoryEnglishName(pictureCategory.getCategoryEnglishName());
        
        return categoryDTO;
    }
    
    
}
