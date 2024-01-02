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
 * @since 2023-12-31
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("picture_info")
public class PictureInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键Id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 图片id
     */
    private Long imgId;

    /**
     * 图片名
     */
    private String imgName;

    /**
     * 图片分类id
     */
    private Integer imgTypeId;

    /**
     * 图片标签id用,分割开
     */
    private String imgTag;

    /**
     * 图片描述
     */
    private String imgDesc;


}
