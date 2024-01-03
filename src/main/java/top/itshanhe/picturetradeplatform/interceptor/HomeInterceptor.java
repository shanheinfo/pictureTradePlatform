package top.itshanhe.picturetradeplatform.interceptor;

import cn.hutool.core.util.StrUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import top.itshanhe.picturetradeplatform.common.Constants;
import top.itshanhe.picturetradeplatform.dto.UserDTO;
import top.itshanhe.picturetradeplatform.service.IPictureAdminService;
import top.itshanhe.picturetradeplatform.service.IPictureUserService;
import top.itshanhe.picturetradeplatform.util.UserHolder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <p>
 *    主页拦截器
 * </p>
 *
 * @author shanhe
 * @date 2023-11-21
 */
public class HomeInterceptor implements HandlerInterceptor {
    private IPictureAdminService iPictureAdminService;
    private IPictureUserService iPictureUserService;
    public HomeInterceptor(IPictureAdminService iPictureAdminService, IPictureUserService iPictureUserService) {
        this.iPictureAdminService = iPictureAdminService;
        this.iPictureUserService = iPictureUserService;
    }
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 从session中获取账号信息
        String loginSession = (String) request.getSession().getAttribute(Constants.LOGIN_KEY);
        if (StrUtil.isEmpty(loginSession)) {
            // 设置重定向地址
            response.sendRedirect("/login");
            return false;
        }
        UserDTO userDTO = iPictureUserService.getNameUserData(loginSession);
        userDTO.setUserAdmin(iPictureAdminService.getAdminByUserID(userDTO.getUserId()));
        // 存入本地线程
        UserHolder.saveUser(userDTO);
        return true;
    }
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }
    
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
//        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
        // 移除用户
        UserHolder.removeUser();
    }
}
