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
 * 拍卖表
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("picture_auction")
public class PictureAuction implements Serializable {

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
     * 最高价格的用户id
     */
    private String userId;

    /**
     * 最高价格
     */
    private BigDecimal moneyTop;

    /**
     * 拍卖开始时间
     */
    private LocalDateTime imgCreateTime;

    /**
     * 拍卖结束时间
     */
    private LocalDateTime imgEndTime;


}
