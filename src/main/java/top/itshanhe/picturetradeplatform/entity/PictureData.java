package top.itshanhe.picturetradeplatform.entity;

import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 图片表
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("picture_data")
public class PictureData implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键Id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 图片索引id
     */
    private String imgIndex;

    /**
     * 图片id
     */
    private Long imgId;

    /**
     * 发布图片的用户id
     */
    private String userId;

    /**
     * 图片价格
     */
    private BigDecimal imgMoney;

    /**
     * 是否是唯一版权
     */
    private Boolean imgKey;

    /**
     * 购买次数
     */
    private Integer imgBuyCount;

    /**
     * 上传时间
     */
    private LocalDateTime imgCreateTime;


}
