package top.itshanhe.picturetradeplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2023/12/31
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PictureDataDTO {
    private Long id;
    /**
     * 图片索引id
     */
    private String imgIndex;
    private String userId;
    /**
     * 图片价格
     */
    private BigDecimal imgMoney;
    /**
     * 图片名
     */
    private String imgName;
    /**
     * 账号
     */
    private String userName;
    /**
     * 图片地址
     */
    private String imgAddr;
}
