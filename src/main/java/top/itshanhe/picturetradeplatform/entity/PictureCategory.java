package top.itshanhe.picturetradeplatform.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 分类板块表
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("picture_category")
public class PictureCategory implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键Id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 分类索引id
     */
    private String categoryKeyId;

    /**
     * 分类id
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

    /**
     * 分类关键词，用,分割
     */
    private String categoryKeywords;

    /**
     * 分类描述
     */
    private String categoryDescription;


}
