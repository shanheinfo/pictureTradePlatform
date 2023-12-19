package top.itshanhe.picturetradeplatform.service.impl;

import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.mapper.PictureUserMapper;
import top.itshanhe.picturetradeplatform.service.IPictureUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.itshanhe.picturetradeplatform.util.MD5Util;

/**
 * <p>
 * 用户表 服务实现类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Service
public class PictureUserServiceImpl extends ServiceImpl<PictureUserMapper, PictureUser> implements IPictureUserService {
    
    @Override
    public Boolean login(String username, String password) {
        PictureUser pictureUser = query().eq("user_name",username).one();
        if (pictureUser == null) {
            return false;
        }
        // 密码
        if (!MD5Util.Md5Code(password).equals(pictureUser.getUserPwd())) {
            return false;
        }
        return true;
    }
}
