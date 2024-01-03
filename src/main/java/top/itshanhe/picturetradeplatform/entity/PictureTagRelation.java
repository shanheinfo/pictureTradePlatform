package top.itshanhe.picturetradeplatform.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 图片标签关联表
 * </p>
 *
 * @author shanhe
 * @since 2024-01-03
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)

@TableName("picture_tag_relation")
public class PictureTagRelation implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 图片id
     */
    @TableField(value = "img_id")
    private Long imgId;

    /**
     * 标签id
     */
    @TableField(value = "tag_id")
    private Long tagId;


}
