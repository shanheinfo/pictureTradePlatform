package top.itshanhe.picturetradeplatform.service.impl;

import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.entity.PictureOrderBillBuy;
import top.itshanhe.picturetradeplatform.entity.PictureOrderBillCredits;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.mapper.PictureOrderBillBuyMapper;
import top.itshanhe.picturetradeplatform.service.IPictureDataService;
import top.itshanhe.picturetradeplatform.service.IPictureOrderBillBuyService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.itshanhe.picturetradeplatform.service.IPictureOrderBillCreditsService;

import java.math.BigDecimal;
import java.util.List;

/**
 * <p>
 * 购买流水表 服务实现类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Service
public class PictureOrderBillBuyServiceImpl extends ServiceImpl<PictureOrderBillBuyMapper, PictureOrderBillBuy> implements IPictureOrderBillBuyService {
    
    @Override
    public String buyPicture(PictureImg byIdSelect, PictureUser idByUserNameData, IPictureDataService pictureDataService, IPictureOrderBillCreditsService pictureOrderBillCreditsService) {
        BigDecimal moneyData = idByUserNameData.getMoneyData();
        BigDecimal money = byIdSelect.getMoney();
        if (moneyData.compareTo(money) >= 0 ) {
    
            // 检查用户是否购买过该图片
            boolean hasBought = hasBoughtPicture(idByUserNameData.getUserId(), byIdSelect.getId());
    
            if (hasBought) {
                return "已经购买过该图片";
            }
            
            // 余额足够 可以购买
            if (pictureDataService.setUserMoney(idByUserNameData.getUserId(),moneyData.subtract(money))) {
                // 购买成功，记录购买流水
                PictureOrderBillBuy orderBillBuy = new PictureOrderBillBuy();
                orderBillBuy.setImgId(byIdSelect.getId());
                orderBillBuy.setUserId(idByUserNameData.getUserId());
                orderBillBuy.setBillCreditsMoneyData(money);
                // 插入购买流水记录
                boolean insertResult = save(orderBillBuy);
    
                PictureOrderBillCredits pictureOrderBillCredits = new PictureOrderBillCredits();
                pictureOrderBillCredits.setUserId(idByUserNameData.getUserId());
                pictureOrderBillCredits.setBillCreditsData("购买了图片:图片id:"+byIdSelect.getId());
                pictureOrderBillCredits.setBillCreditsMoneyData(money);
                pictureOrderBillCreditsService.save(pictureOrderBillCredits);
                return "购买成功";
            } else {
                return "购买失败";
            }
        }
        return "购买失败余额不足";
    }
    
    public boolean hasBoughtPicture(String userId, Long imgId) {
        // 查询购买流水表是否存在对应记录
        List<PictureOrderBillBuy> list = list(
                lambdaQuery().eq(PictureOrderBillBuy::getUserId, userId).eq(PictureOrderBillBuy::getImgId, imgId)
        );
        
        return list != null && !list.isEmpty();
    }
}
