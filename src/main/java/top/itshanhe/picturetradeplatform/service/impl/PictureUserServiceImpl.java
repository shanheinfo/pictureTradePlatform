package top.itshanhe.picturetradeplatform.service.impl;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import top.itshanhe.picturetradeplatform.dto.UserDTO;
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
@Slf4j
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
    public List<UserLookDataDTO> getUserLookDataPaged(int offset, int pageSize) {
        // 执行分页查询，计算页码（offset / pageSize + 1）并指定每页显示的记录数
        // offset 为开始查询页码， pageSize 为 每次显示多少页 初始偏移量是 0 那么就要+1 变成第一页
        // 假设查询第一页 （初始） 0 / 30 +1 = 1
        //  假设查询第二页  30 / 30 +1 = 2
        Page<PictureUser> page = page(new Page<>(offset / pageSize + 1, pageSize));
        // 获取记录
        List<PictureUser> userList = page.getRecords();
        // 转换需要字段给dto
        return convertToDTOList(userList);
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
    
    private List<UserLookDataDTO> convertToDTOList(List<PictureUser> userList) {
        return userList.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }
    
    @Override
    public List<UserLookDataDTO> searchUserLookData(String keyword, String searchOption, String searchType, int offset, int pageSize) {
        // 使用 MyBatis-Plus 提供的 QueryWrapper 进行条件查询
        QueryWrapper<PictureUser> queryWrapper = new QueryWrapper<>();
        // 根据 searchOption 判断搜索的字段
        if ("userId".equals(searchOption)) {
            queryWrapper.like("user_id", keyword);
        } else if ("username".equals(searchOption)) {
            queryWrapper.like("user_name", keyword);
        } else if ("email".equals(searchOption)) {
            queryWrapper.like("user_mail", keyword);
        }
        // 根据 searchType 判断搜索类型
        if ("twoSearch".equals(searchType)) {
            queryWrapper.eq("user_name", keyword);
        }
        // 分页处理
        Page<PictureUser> page = page(new Page<>(offset / pageSize + 1, pageSize), queryWrapper);
        List<PictureUser> userList = page.getRecords();
        return convertToDTOList(userList);
    }
    
    @Override
    public UserDTO getNameUserData(String loginSession) {
        PictureUser pictureUser = lambdaQuery().eq(PictureUser::getUserName, loginSession).one();
        UserDTO userDTO = new UserDTO();
        userDTO.setUserName(pictureUser.getUserName());
        userDTO.setUserId(pictureUser.getUserId());
        userDTO.setUserMail(pictureUser.getUserMail());
        return userDTO;
    }
    
    @Override
    public String getIdByUserName(String userId) {
        PictureUser pictureUser = query().eq("user_id",userId).one();
        return pictureUser.getUserName();
    }
    
}
