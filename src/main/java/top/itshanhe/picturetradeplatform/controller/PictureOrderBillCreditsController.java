package top.itshanhe.picturetradeplatform.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;
import top.itshanhe.picturetradeplatform.entity.PictureOrderBillCredits;
import top.itshanhe.picturetradeplatform.service.IPictureOrderBillCreditsService;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 积分流水表 前端控制器
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Controller
public class PictureOrderBillCreditsController {

//    public String searchMoney(Model model,String userId) {
//        List<PictureOrderBillCredits> list = pictureOrderBillCreditsService.selectOrderMoneyByUserId(userId);
//        model.addAttribute("order",list);
//        return "user/admin/payData";
//    }
}
