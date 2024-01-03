package top.itshanhe.picturetradeplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2024/1/2
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryDTO {
    
    /**
     * 分类索引id
     */
    private Integer categoryId;
    
    /**
     * 分类名称
     */
    private String categoryName;
    
    /**
     * 分类英文名
     */
    private String categoryEnglishName;
}
