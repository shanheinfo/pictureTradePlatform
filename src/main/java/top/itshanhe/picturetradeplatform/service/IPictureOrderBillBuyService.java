package top.itshanhe.picturetradeplatform.service;

import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.entity.PictureOrderBillBuy;
import com.baomidou.mybatisplus.extension.service.IService;
import top.itshanhe.picturetradeplatform.entity.PictureUser;

/**
 * <p>
 * 购买流水表 服务类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
public interface IPictureOrderBillBuyService extends IService<PictureOrderBillBuy> {
    
    String buyPicture(PictureImg byIdSelect, PictureUser idByUserNameData, IPictureDataService pictureDataService, IPictureOrderBillCreditsService pictureOrderBillCreditsService);
}
