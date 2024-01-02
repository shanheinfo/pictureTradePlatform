package top.itshanhe.picturetradeplatform.controller;


import cn.hutool.core.util.StrUtil;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import top.itshanhe.picturetradeplatform.common.Constants;
import top.itshanhe.picturetradeplatform.dto.UserLookDataDTO;
import top.itshanhe.picturetradeplatform.service.IPictureUserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * <p>
 * 管理员表 前端控制器
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Controller
@Slf4j
public class PictureAdminController {
    @Resource
    private IPictureUserService userService;
    
    // 每页显示的条目数量
    private static final int PAGE_SIZE = 30;
    
    // 使用@GetMapping注解，指定处理的请求路径为"/admin/userData.html"或"/admin/userData"
    @GetMapping({"/admin/userData.html", "/admin/userData"})
    public String adminUserData(Model model,
                                @RequestParam(name = "page", defaultValue = "1") int page,
                                @RequestParam(defaultValue = "null") String keyword,
                                @RequestParam(defaultValue = "null") String searchOption,
                                @RequestParam(defaultValue = "null") String searchType) {
    
        // 计算偏移量，用于数据库查询时的分页 数据，也就是从哪里开始
        // 当 page 为 1 时，offset 为 0，表示从查询结果的第一条记录开始获取数据
        // 如果 page = 2 那么 offset = 30 就是 30+1 条往下查询
        int offset = (page - 1) * PAGE_SIZE;
        List<UserLookDataDTO> userLookDataDTOS;
        int totalUsers;
    
        if (keyword.equals("null") && searchOption.equals("null") && searchType.equals("null")
                || keyword.equals("null") && !searchOption.equals("null") && !searchType.equals("null")) {
            // 没有关键字或有搜索条件，获取全部数据或根据条件查询数据
            userLookDataDTOS = userService.getUserLookDataPaged(offset, PAGE_SIZE);
            // 获取总用户数，用于计算总页数
            totalUsers = userService.getTotalUsers();
        } else {
            // 根据关键字查询数据
            userLookDataDTOS = userService.searchUserLookData(keyword, searchOption, searchType, offset, PAGE_SIZE);
            // 获取总用户数，用于计算总页数
            totalUsers = userLookDataDTOS.size();
        }
    
        // 计算总页数，使用Math.ceil确保总页数为正整数
        int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);
    
        // 将分页数据传递到前端，供页面渲染使用
        model.addAttribute("userLookDataDTOS", userLookDataDTOS);
        model.addAttribute("currentPage", page);
        // 下一页
        model.addAttribute("currentNextPage", page + 1);
        // 上一页
        model.addAttribute("currentLastPage", page - 1);
        model.addAttribute("totalPages", totalPages);
        
        return "/admin/user/userData";
    }

    @GetMapping({"/admin/","/admin","/admin/index", "/admin/index.html"})
    public String adminHome(Model model,HttpServletRequest request, HttpSession session) {
        // 从session中获取账号信息
        String loginSession = (String) request.getSession().getAttribute(Constants.LOGIN_KEY);
        if (StrUtil.isEmpty(loginSession)) {
            return "redirect:/login";
        }
        // 用户名
        model.addAttribute("username",loginSession);
        // 返回后台首页视图
        return "admin/index";
    }
    
    @GetMapping({"/userAdmin","/userAdmin/","/userAdmin/index","/userAdmin/index.html"})
    public String adminUserHome(Model model,HttpServletRequest request) {
        // 返回后台首页视图
        return "user/index";
    }
}
