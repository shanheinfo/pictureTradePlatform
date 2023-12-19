package top.itshanhe.picturetradeplatform.controller;


import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;
import top.itshanhe.picturetradeplatform.common.Constants;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * <p>
 * 管理员表 前端控制器
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Controller
@RequestMapping("/admin")
@Slf4j
public class PictureAdminController {
    @GetMapping({"/index", "/index.html"})
    public String adminHome(HttpServletRequest request, HttpSession session) {
        // 从session中获取账号信息
        String loginSession = (String) request.getSession().getAttribute(Constants.LOGIN_KEY);
        log.info("数据:{}",loginSession);
        if (loginSession.isEmpty()) {
            return "redirect:/register";
        }
        return "redirect:admin/index";
    }
}
