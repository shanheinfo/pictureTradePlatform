package top.itshanhe.picturetradeplatform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;
import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.dto.PictureNav;

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
    @GetMapping({"/index", "/", "/index.html"})
    public String indexHome(Model model) {
        List<PictureNav> strings = new ArrayList<>();
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        strings.add(new PictureNav("山河","div/box.html"));
        imgHome(model);
        model.addAttribute("pictureNav",strings);
        return "/index";
    }

    public Model imgHome(Model model) {
        List<PictureImg> strings = new ArrayList<>();
        strings.add(new PictureImg(1,"/home/img/6.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/5.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/1.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/3.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/4.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/5.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/6.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/1.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/3.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/3.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/2.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/3.jpg","山河",30.99, LocalDateTime.now()));
        strings.add(new PictureImg(1,"/home/img/5.jpg","山河",30.99, LocalDateTime.now()));
        return model.addAttribute("pictureImg",strings);
    }
}
