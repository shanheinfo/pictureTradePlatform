package top.itshanhe.picturetradeplatform.service.impl;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import top.itshanhe.picturetradeplatform.dto.UserLookDataDTO;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.mapper.PictureUserMapper;
import top.itshanhe.picturetradeplatform.service.IPictureUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.itshanhe.picturetradeplatform.util.LocalDateTimeUtil;
import top.itshanhe.picturetradeplatform.util.MD5Util;
import top.itshanhe.picturetradeplatform.util.RegexUtils;

import java.util.List;
import java.util.stream.Collectors;

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
    
    @Override
    public String register(String username, String password, String email, String ipAddress) {
        // 校验邮箱
        if (RegexUtils.isEmailInvalid(email)) {
            return "请输入正确的邮箱";
        }
        PictureUser pictureUserName = query().eq("user_name",username).one();
        if (pictureUserName != null) {
            return "此账号名已经有人注册";
        }
        PictureUser pictureUserEmail = query().eq("user_name",email).one();
        if (pictureUserEmail != null) {
            return "此邮箱已经有人注册";
        }
        PictureUser pictureUser = new PictureUser();
        // 随机用户id(唯一) ObjectId是MongoDB数据库的一种唯一ID生成策略，是UUID version1的变种
        pictureUser.setUserId(IdUtil.objectId());
        pictureUser.setUserName(username);
        pictureUser.setUserMail(email);
        pictureUser.setUserPwd(MD5Util.Md5Code(password));
        pictureUser.setUserCreateIp(ipAddress);
        pictureUser.setUserCreateTime(LocalDateTimeUtil.localDateTime());
        pictureUser.setUserStatus(true);
        save(pictureUser);
        return "success";
    }
    
    
    public int getTotalUsers() {
//        count() 方法是 MyBatis-Plus 提供的方法，用于统计记录数。
        return count();
    }
    
    @Override
    /**
     * 获取分页的用户数据，转换为 UserLookDataDTO 对象列表
     *
     * @param offset   查询的偏移量
     * @param pageSize 每页的数据量
     * @return 包含转换后的 UserLookDataDTO 对象的列表
     */
    public List<UserLookDataDTO> getUserLookDataPaged(int offset, int pageSize) {
        // 使用 MyBatis-Plus 提供的 page 方法进行分页查询，构建 Page 对象
        Page<PictureUser> page = page(new Page<>(offset / pageSize + 1, pageSize));
        
        // 从 Page 对象中获取分页查询的结果列表
        List<PictureUser> userList = page.getRecords();
    
        // 将查询结果列表转换为流，并使用 map 操作将每个 PictureUser 转换为相应的 UserLookDataDTO 对象
        List<UserLookDataDTO> userLookDataList = userList.stream()
                .map(this::convertToDTO) // 使用 convertToDTO 方法将 PictureUser 转换为 UserLookDataDTO
                .collect(Collectors.toList()); // 将转换后的结果收集到一个新的 List 中
    
        // 返回包含转换后的 UserLookDataDTO 对象的列表
        return userLookDataList;
    }
    
    private UserLookDataDTO convertToDTO(PictureUser pictureUser) {
        UserLookDataDTO userLookDataDTO = new UserLookDataDTO();
        userLookDataDTO.setUserId(pictureUser.getUserId());
        userLookDataDTO.setUserName(pictureUser.getUserName());
        userLookDataDTO.setUserEmail(pictureUser.getUserMail());
        userLookDataDTO.setUserMoney(pictureUser.getMoneyData());
        userLookDataDTO.setUserStatus(pictureUser.getUserStatus());
        
        return userLookDataDTO;
    }
}
