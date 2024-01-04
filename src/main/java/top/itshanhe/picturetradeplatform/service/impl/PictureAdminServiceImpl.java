package top.itshanhe.picturetradeplatform.service.impl;

import top.itshanhe.picturetradeplatform.entity.PictureAdmin;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.mapper.PictureAdminMapper;
import top.itshanhe.picturetradeplatform.service.IPictureAdminService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 管理员表 服务实现类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Service
public class PictureAdminServiceImpl extends ServiceImpl<PictureAdminMapper, PictureAdmin> implements IPictureAdminService {
    
    @Override
    public boolean getAdminByUserID(String userId) {
    
        PictureAdmin pictureAdmin = query().eq("user_id",userId).one();
        if (pictureAdmin.getStatus() == 0) {
            return true;
        } else {
            return false;
        }
    }
    
    @Override
    public String ifAdmin(String loginUserId) {
        PictureAdmin pictureAdmin = query().eq("user_id",loginUserId).one();
        if (pictureAdmin == null) {
            return "null";
        }
        if (pictureAdmin.getStatus() == 1) {
            return "true";
        }
        return "null";
    }
}
