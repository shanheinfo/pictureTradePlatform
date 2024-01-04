package top.itshanhe.picturetradeplatform.controller;


import cn.hutool.core.util.StrUtil;
import com.google.code.kaptcha.Producer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import top.itshanhe.picturetradeplatform.common.Constants;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.service.IPictureAdminService;
import top.itshanhe.picturetradeplatform.service.IPictureUserService;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * <p>
 * 用户表 前端控制器
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Slf4j
@Controller
public class PictureUserController {
    @Autowired
    private Producer kaptchaProducer;
    @Resource
    private IPictureUserService userService;
    @Resource
    private IPictureAdminService adminService;
    
    @GetMapping({"/login", "/login.html"})
    public String homeLogin() {
        return "home/login";
    }
    
    @GetMapping({"/register", "/register.html"})
    public String homeRegister() {
        return "home/register";
    }
    
    
    // 生成验证码的方法
    @GetMapping("/CacheCode")
    public void createCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/png");
        // 生成验证码
        String text = kaptchaProducer.createText();
        // 验证码存入session
        request.getSession().setAttribute(Constants.KAPTCHA_KEY, text);
        // 输出验证码图片
        BufferedImage image = kaptchaProducer.createImage(text);
        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(image, "png", out);
    }
    
    @PostMapping("/register-info")
    public String register(@RequestParam("userName") String username, @RequestParam("password") String password, @RequestParam("email") String email, @RequestParam("code") String code, HttpServletRequest request, HttpSession session) {
        if (StrUtil.isEmpty(code)) {
            session.setAttribute("errorMsg", "验证码不能为空");
            return "redirect:/register";
        }
        // 账号密码判断
        if (StrUtil.isEmpty(username) || StrUtil.isEmpty(password) || StrUtil.isEmpty(email)) {
            session.setAttribute("errorMsg", "账号/密码/邮箱为空");
            return "redirect:/register";
        }
        String ipAddress = request.getRemoteAddr();
        //  注册
        String userRegister = userService.register(username, password, email,ipAddress);
        if (userRegister.equals("success")) {
            request.getSession().setAttribute(Constants.LOGIN_KEY, username);
            return "redirect:userAdmin/";
        } else {
            //注册失败
            session.setAttribute("errorMsg", userRegister);
            return "redirect:/register";
        }
    }
    // 登录
    @PostMapping("/login-info")
    public String login(@RequestParam("userName") String username,@RequestParam("password") String password,@RequestParam("code") String code, HttpServletRequest request, HttpSession session) {
        log.info("123");
        if (StrUtil.isEmpty(code)) {
            session.setAttribute("errorMsg", "验证码不能为空");
            return "redirect:/login";
        }
        // 账号密码判断
        if (StrUtil.isEmpty(username) || StrUtil.isEmpty(password)) {
            session.setAttribute("errorMsg", "账号密码为空");
            return "redirect:/login";
        }
        // 从session中获取验证码
        String sessionCode = (String) request.getSession().getAttribute(Constants.KAPTCHA_KEY);
        // 比较输入的验证码和session中的验证码是否一致
        if (sessionCode == null || !sessionCode.equalsIgnoreCase(code)) {
            session.setAttribute("errorMsg", "验证码不正确");
            return "redirect:/login";
        }
        String loginUserId = userService.login(username,password);
        if (loginUserId.equals("null")) {
            session.setAttribute("errorMsg", "账号或者密码不存在");
            return "redirect:/login";
        }
        String loginAdmin = adminService.ifAdmin(loginUserId);
        if (loginAdmin.equals("null")) {
            return "redirect:userAdmin/";
        }
        // 账号名存入session
        request.getSession().setAttribute(Constants.Admin_KEY, loginAdmin);
        request.getSession().setAttribute(Constants.LOGIN_KEY, username);
        return "redirect:admin/index";
    }
}
