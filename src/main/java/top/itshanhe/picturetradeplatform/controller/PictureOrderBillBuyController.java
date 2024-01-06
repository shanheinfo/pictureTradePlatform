package top.itshanhe.picturetradeplatform.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import top.itshanhe.picturetradeplatform.common.Constants;
import top.itshanhe.picturetradeplatform.service.IPictureDataService;
import top.itshanhe.picturetradeplatform.service.IPictureOrderBillBuyService;
import top.itshanhe.picturetradeplatform.service.IPictureOrderBillCreditsService;
import top.itshanhe.picturetradeplatform.service.IPictureUserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 * 购买流水表 前端控制器
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Controller
@Slf4j
public class PictureOrderBillBuyController {
    @Resource
    private IPictureOrderBillBuyService pictureOrderBillBuyService;
    @Resource
    private IPictureOrderBillCreditsService pictureOrderBillCreditsService;
//    @GetMapping("/buy/{uid}")
    public String buyPictures(Long uid,
                              HttpServletRequest request,
                              Model model, IPictureUserService userService, IPictureDataService pictureDataService, RedirectAttributes redirectAttributes) {
        String loginSession = (String) request.getSession().getAttribute(Constants.LOGIN_KEY);
        if (loginSession == null || loginSession.isEmpty()) {
            return "redirect:/content/"+ String.valueOf(uid);
        }
        
        String success =  pictureOrderBillBuyService.buyPicture(pictureDataService.getByIdSelect(uid),userService.getIdByUserNameData(loginSession),pictureDataService,pictureOrderBillCreditsService);
        redirectAttributes.addFlashAttribute("buydata",success);
        log.info("{}",success);
        return "redirect:/content/"+ String.valueOf(uid);
    }
}
