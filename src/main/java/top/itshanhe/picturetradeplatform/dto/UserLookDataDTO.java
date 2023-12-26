package top.itshanhe.picturetradeplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2023/12/26
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserLookDataDTO {
    private String userId;
    private String userName;
    private String userEmail;
    private BigDecimal userMoney;
    private boolean userStatus;
}
