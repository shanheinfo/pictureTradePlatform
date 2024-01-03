package top.itshanhe.picturetradeplatform.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;
import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.dto.PictureNav;
import top.itshanhe.picturetradeplatform.service.IPictureTagService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 标签表 前端控制器
 * </p>
 *
 * @author shanhe
 * @since 2024-01-03
 */
@Controller
public class PictureTagController {
    @Resource
    private IPictureTagService pictureTagService;
    @GetMapping("/tag/{id}")
    public String tagHome(@PathVariable String id, Model model, HttpServletRequest request) {
    
        String defaultDomain = request.getServerName() + ":" + request.getServerPort();
        List<PictureNav> strings = pictureTagService.selectTagAll(defaultDomain);
    
        List<PictureImg> stringse = new ArrayList<>();
//        stringse.add(new PictureImg(1,"/home/img/6.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/5.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/1.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/3.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/4.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/5.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/6.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/1.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/3.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/3.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/2.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/3.jpg","山河",30.99, LocalDateTime.now()));
//        stringse.add(new PictureImg(1,"/home/img/5.jpg","山河",30.99, LocalDateTime.now()));
        model.addAttribute("pictureImg",stringse);
        model.addAttribute("pictureNav",strings);
        return "/tag";
    }
    
}
