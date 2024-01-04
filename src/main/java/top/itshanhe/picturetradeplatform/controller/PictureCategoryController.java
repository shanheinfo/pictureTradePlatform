package top.itshanhe.picturetradeplatform.controller;


import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.dto.PictureNav;
import top.itshanhe.picturetradeplatform.service.IPictureDataService;
import top.itshanhe.picturetradeplatform.service.IPictureInfoService;
import top.itshanhe.picturetradeplatform.service.IPictureTagService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 分类板块表 前端控制器
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Controller
public class PictureCategoryController {
    @Resource
    private IPictureInfoService pictureInfoService;
    @Resource
    private IPictureTagService pictureTagService;
    @Resource
    private IPictureDataService pictureDataService;
    private static final int PAGE_SIZE = 15;
    @GetMapping("/category/{id}")
    public String tagHome(@PathVariable Long id, Model model,
                          @RequestParam(defaultValue = "1") int page,
                          HttpServletRequest request) {
    
        String defaultDomain = request.getServerName() + ":" + request.getServerPort();
        List<PictureNav> strings = pictureTagService.selectTagAll(defaultDomain);
        
        
        // 如果 page = 2 那么 offset = 30 就是 30+1 条往下查询
        int offset = (page- 1) * PAGE_SIZE;
        
        // 根据关键词和分页信息查询图片
        List<PictureImg> picturePage = pictureInfoService.getPicturesByKeyword(id, offset,PAGE_SIZE,pictureDataService);
        
        model.addAttribute("pictureImg",picturePage);
        model.addAttribute("pictureNav",strings);
        model.addAttribute("uuid",id);
        return "/category";
    }
    
    
    @GetMapping("/category/{id}/data")
    public ResponseEntity<List<PictureImg>> tagHome(@PathVariable Long id,
                                                    @RequestParam(defaultValue = "1") int page,
                                                    HttpServletRequest request) {
        
        String defaultDomain = request.getServerName() + ":" + request.getServerPort();
        List<PictureNav> strings = pictureTagService.selectTagAll(defaultDomain);
        
        
        // 如果 page = 2 那么 offset = 30 就是 30+1 条往下查询
        int offset = (page - 1) * PAGE_SIZE;
        
        // 根据关键词和分页信息查询图片
        List<PictureImg> picturePage = pictureInfoService.getPicturesByKeyword(id, offset,PAGE_SIZE,pictureDataService);
        
        return ResponseEntity.ok(picturePage);
    }

}
