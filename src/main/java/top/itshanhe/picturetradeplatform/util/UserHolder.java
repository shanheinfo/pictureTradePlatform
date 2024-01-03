package top.itshanhe.picturetradeplatform.util;

import org.springframework.stereotype.Component;
import top.itshanhe.picturetradeplatform.dto.UserDTO;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2024/1/3
 */
@Component
public class UserHolder {
    private static final ThreadLocal<UserDTO> tl = new ThreadLocal<>();
    public static void saveUser(UserDTO user){
        tl.set(user);
    }
    
    public static UserDTO getUser(){
        return tl.get();
    }
    
    public static void removeUser(){
        tl.remove();
    }
}
