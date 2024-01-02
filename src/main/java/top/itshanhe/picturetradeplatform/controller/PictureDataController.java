package top.itshanhe.picturetradeplatform.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import top.itshanhe.picturetradeplatform.dto.PictureDataDTO;
import top.itshanhe.picturetradeplatform.dto.UserLookDataDTO;
import top.itshanhe.picturetradeplatform.service.IPictureDataService;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 图片表 前端控制器
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Controller
@RequestMapping("/admin")
public class PictureDataController {
    @Resource
    private IPictureDataService pictureDataService;
    // 每页显示的条目数量
    private static final int PAGE_SIZE = 30;
    @GetMapping("pictureDataSearch")
    public String pictureDataSearch(Model model,
                                    @RequestParam(name = "page", defaultValue = "1") int page,
                                    @RequestParam(defaultValue = "") String keyword,
                                    @RequestParam(defaultValue = "userId") String searchOption,
                                    @RequestParam(defaultValue = "oneSearch") String searchType,
                                    @RequestParam(defaultValue = "0") int minPrice,
                                    @RequestParam(defaultValue = "1000000") int maxPrice,
                                    @RequestParam(defaultValue = "0") int minPriceInput,
                                    @RequestParam(defaultValue = "1000000") int maxPriceInput) {
        
        // 打印请求参数
        System.out.println("Page: " + page + ", Keyword: " + keyword + ", Search Option: " + searchOption +
                ", Search Type: " + searchType + ", Min Price: " + minPrice + ", Max Price: " + maxPrice +
                ", Min Price Input: " + minPriceInput + ", Max Price Input: " + maxPriceInput);
        
        int offset = (page - 1) * PAGE_SIZE;
        List<PictureDataDTO> pictureDataDTOS;
        
        if ("".equals(keyword) && "userId".equals(searchOption) && "oneSearch".equals(searchType)) {
            // 没有关键字或有搜索条件，获取全部数据或根据条件查询数据
            pictureDataDTOS = pictureDataService.getPictureDataPaged(offset, PAGE_SIZE);
        } else {
            // 根据关键字和价格范围查询数据
            // 传递手动输入的价格参数
            pictureDataDTOS = pictureDataService.searchPictureData(keyword, searchOption, searchType,
                    minPrice, maxPrice, minPriceInput, maxPriceInput, offset, PAGE_SIZE);
        }
        
        int totalPictures = pictureDataService.getTotalPictures();
        
        int totalPages = (int) Math.ceil((double) totalPictures / PAGE_SIZE);
        
        model.addAttribute("pictureDataDTOS", pictureDataDTOS);
        model.addAttribute("currentPage", page);
        model.addAttribute("currentNextPage", page + 1);
        model.addAttribute("currentLastPage", page - 1);
        model.addAttribute("totalPages", totalPages);
        
        return "/admin/user/fileData";
    }
}
