package top.itshanhe.picturetradeplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
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
    private Long id;
    
    private String imgUrl;
    
    private String authorName;
    
    private BigDecimal money;
    
    private LocalDateTime imgTime;
    
    public PictureImg() {
    }
    
    public PictureImg(Long id, String imgUrl, String authorName, BigDecimal money, LocalDateTime imgTime) {
        this.id = id;
        this.imgUrl = imgUrl;
        this.authorName = authorName;
        this.money = money;
        this.imgTime = imgTime;
    }
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
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
    
    public BigDecimal getMoney() {
        return money;
    }
    
    public void setMoney(BigDecimal money) {
        this.money = money;
    }
    
    public LocalDateTime getImgTime() {
        return imgTime;
    }
    
    public void setImgTime(LocalDateTime imgTime) {
        this.imgTime = imgTime;
    }
}
