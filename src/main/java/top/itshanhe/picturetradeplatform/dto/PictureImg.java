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
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PictureImg {
    private Long id;
    
    private String imgUrl;
    
    private String authorName;
    
    private BigDecimal money;
    
    private String imgTime;
    
    private String imgTitle;
    
}
