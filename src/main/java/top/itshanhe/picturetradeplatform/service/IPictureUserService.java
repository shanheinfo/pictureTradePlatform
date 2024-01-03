package top.itshanhe.picturetradeplatform.service;

import top.itshanhe.picturetradeplatform.dto.UserDTO;
import top.itshanhe.picturetradeplatform.dto.UserLookDataDTO;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 用户表 服务类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
public interface IPictureUserService extends IService<PictureUser> {
    
    Boolean login(String username, String password);
    
    String register(String username, String password, String email,String ipAddress);
    
    int getTotalUsers();
    
    List<UserLookDataDTO> getUserLookDataPaged(int offset, int pageSize);
    
    List<UserLookDataDTO> searchUserLookData(String keyword, String searchOption, String searchType, int offset, int pageSize);
    
    UserDTO getNameUserData(String loginSession);
    
    String getIdByUserName(String userId);
}
