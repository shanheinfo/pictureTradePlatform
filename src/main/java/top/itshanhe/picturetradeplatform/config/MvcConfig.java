package top.itshanhe.picturetradeplatform.config;


import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import top.itshanhe.picturetradeplatform.interceptor.HomeInterceptor;

/**
 * <p>
 *  MVC 路由 拦截器 配置类
 * </p>
 *
 * @author shanhe
 * @date  2023-11-21
 */
public class MvcConfig implements WebMvcConfigurer {

//    @Override
//    public void addViewControllers(ViewControllerRegistry registry) {
//        //重定向到首页
//        registry.addViewController("/").setViewName("forward:index.html");
//    }
    /**
     * 设置静态资源映射
     * @param registry
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/autoImg/**")
//                .addResourceLocations("./uploads/");  // 这里设置实际文件存储的路径
        registry.addResourceHandler("doc.html").addResourceLocations("classpath:/META-INF/resources/");
        registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
    }
    
    public void addInterceptors(InterceptorRegistry registry) {
        // 添加一个拦截器，拦截以/admin为前缀的url路径（后台登陆拦截）
        registry.addInterceptor(new HomeInterceptor())
                .addPathPatterns("*")
                .excludePathPatterns("/admin/**");
    }
}
