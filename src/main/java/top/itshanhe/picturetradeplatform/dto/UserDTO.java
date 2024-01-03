package top.itshanhe.picturetradeplatform.dto;

import lombok.Data;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2024/1/3
 */
@Data
public class UserDTO {
    private String userId;
    private String userName;
    private String userMail;
    private boolean userAdmin;
}
