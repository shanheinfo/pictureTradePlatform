package top.itshanhe.picturetradeplatform.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import top.itshanhe.picturetradeplatform.common.Constants;
import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.dto.PictureNav;
import top.itshanhe.picturetradeplatform.service.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2023/12/5
 */
@Controller
public class PictureHomeController {
    @Resource
    private IPictureDataService pictureDataService;
    @Resource
    private IPictureTagService pictureTagService;
    private static final int PAGE_SIZE = 15;
    @GetMapping({"/index", "/", "/index.html"})
    public String indexHome(Model model,HttpServletRequest request,
                            @RequestParam(defaultValue = "1") int page) {
        String defaultDomain = request.getServerName() + ":" + request.getServerPort();
        List<PictureNav> strings = pictureTagService.selectTagAll(defaultDomain);
        // 如果 page = 2 那么 offset = 30 就是 30+1 条往下查询
        int offset = (page - 1) * PAGE_SIZE;
        imgHome(model,offset,defaultDomain);
        String loginSession = (String) request.getSession().getAttribute(Constants.LOGIN_KEY);
        model.addAttribute("loginSession",loginSession);
        model.addAttribute("pictureNav",strings);
        return "/index";
    }

    public Model imgHome(Model model,int offset,String defaultDomain) {
        List<PictureImg> pictureList = pictureDataService.getLatestPictures(offset, PAGE_SIZE,defaultDomain);
        return model.addAttribute("pictureImg",pictureList);
    }
    
    @GetMapping("/latest")
    public ResponseEntity<List<PictureImg>> getLatestPictures(@RequestParam(defaultValue = "1") int page,
                                                              @RequestParam(defaultValue = "15") int pageSize,
                                                              HttpServletRequest request) {
        String defaultDomain = request.getServerName() + ":" + request.getServerPort();
        int offset = (page - 1) * pageSize;
        List<PictureImg> latestPictures = pictureDataService.getLatestPictures(offset, pageSize,defaultDomain);
        
        return ResponseEntity.ok(latestPictures);
    }
    @GetMapping("/content/{imgId}")
    public String getContentPicture(Model model, @PathVariable Long imgId,HttpServletRequest request) {
        String loginSession = (String) request.getSession().getAttribute(Constants.LOGIN_KEY);
        model.addAttribute("loginSession",loginSession);
        model.addAttribute("pictureImg",pictureDataService.getByIdSelect(imgId));
        return  "/content";
    }
    
}
