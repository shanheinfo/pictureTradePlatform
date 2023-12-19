package top.itshanhe.picturetradeplatform.util;

import org.springframework.util.DigestUtils;

/**
 * md5盐值加密
 * @author shanhe
 * @since 2023-07-03
 */
public class MD5Util {
    static String salt= "shanhe-=+picture";
    
    public static String Md5Code(String password) {
        String saltPassword=salt+"/"+password;
        String md5Password = DigestUtils.md5DigestAsHex(saltPassword.getBytes());
        return md5Password;
    }
    
}
