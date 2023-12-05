package top.itshanhe.picturetradeplatform.entity;

import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 充值流水表
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("picture_order_bill_recharge")
public class PictureOrderBillRecharge implements Serializable {

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
     * 订单金额
     */
    private BigDecimal billRechargeMoneyData;

    /**
     * 订单描述
     */
    private String billRechargeInfo;

    /**
     * 充值来源0（支付宝）
     */
    private Boolean billRechargeAddr;

    /**
     * 订单号
     */
    private String billRechargeData;


}
