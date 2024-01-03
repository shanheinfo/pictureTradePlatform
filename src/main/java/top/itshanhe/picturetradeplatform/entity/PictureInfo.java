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
 * 图片其他信息表
 * </p>
 *
 * @author shanhe
 * @since 2024-01-03
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("picture_info")
public class PictureInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 图片id
     */
    @TableId(value = "img_id", type = IdType.AUTO)
    private Long imgId;

    /**
     * 图片名
     */
    @TableField("img_name")
    private String imgName;

    /**
     * 图片分类id
     */
    @TableField("img_type_id")
    private Integer imgTypeId;

    /**
     * 图片描述
     */
    @TableField("img_desc")
    private String imgDesc;


}
