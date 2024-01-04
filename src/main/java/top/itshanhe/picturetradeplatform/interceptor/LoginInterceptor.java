package top.itshanhe.picturetradeplatform.interceptor;

import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import top.itshanhe.picturetradeplatform.common.Constants;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2024/1/4
 */
@Slf4j
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String loginSession = (String) request.getSession().getAttribute(Constants.LOGIN_KEY);
        String userSession = (String) request.getSession().getAttribute(Constants.Admin_KEY);
    
        // 从session中获取账号信息
        if (!StrUtil.isEmpty(loginSession) && userSession.equals("true") && !response.isCommitted()) {
            // 设置重定向地址
            response.sendRedirect("/admin/");
            return false;
        } else if (!StrUtil.isEmpty(loginSession) && userSession.equals("null") && !response.isCommitted()){
            response.sendRedirect("/userAdmin/");
            return false;
        }
        return true;
    }
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }
    
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
//        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
    }
}
