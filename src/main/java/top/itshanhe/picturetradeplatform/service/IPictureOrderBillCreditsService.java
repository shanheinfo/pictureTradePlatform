package top.itshanhe.picturetradeplatform.service;

import top.itshanhe.picturetradeplatform.entity.PictureOrderBillCredits;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 积分流水表 服务类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
public interface IPictureOrderBillCreditsService extends IService<PictureOrderBillCredits> {
    
    List<PictureOrderBillCredits> selectOrderMoneyByUserId(String userId);
}
