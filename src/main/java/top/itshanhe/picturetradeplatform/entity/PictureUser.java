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
 * 用户表
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("picture_user")
public class PictureUser implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键Id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户id
     */
    private String userId;

    /**
     * 账号
     */
    private String userName;

    /**
     * 邮箱
     */
    private String userMail;

    /**
     * 手机号
     */
    private String userPhone;

    /**
     * 密码
     */
    private String userPwd;

    /**
     * 积分余额
     */
    private BigDecimal moneyData;

    /**
     * 头像id,默认为默认头像地址
     */
    private Integer userIcon;

    /**
     * 创建时IP
     */
    private Integer userCreateIp;

    /**
     * 创建时间
     */
    private LocalDateTime userCreateTime;

    /**
     * 用户是否封禁 0 封禁
     */
    private Boolean userStatus;


}
