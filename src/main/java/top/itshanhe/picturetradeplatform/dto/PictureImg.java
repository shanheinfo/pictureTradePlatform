package top.itshanhe.picturetradeplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2023/12/15
 */
public class PictureImg {
    private Integer id;
    
    private String imgUrl;
    
    private String authorName;
    
    private Double money;
    
    private LocalDateTime imgTime;
    
    public PictureImg(Integer id, String imgUrl, String authorName, Double money, LocalDateTime imgTime) {
        this.id = id;
        this.imgUrl = imgUrl;
        this.authorName = authorName;
        this.money = money;
        this.imgTime = imgTime;
    }
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getImgUrl() {
        return imgUrl;
    }
    
    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }
    
    public String getAuthorName() {
        return authorName;
    }
    
    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }
    
    public Double getMoney() {
        return money;
    }
    
    public void setMoney(Double money) {
        this.money = money;
    }
    
    public LocalDateTime getImgTime() {
        return imgTime;
    }
    
    public void setImgTime(LocalDateTime imgTime) {
        this.imgTime = imgTime;
    }
}
