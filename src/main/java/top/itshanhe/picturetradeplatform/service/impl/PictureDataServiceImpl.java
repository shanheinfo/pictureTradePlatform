package top.itshanhe.picturetradeplatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import top.itshanhe.picturetradeplatform.dto.PictureDataDTO;
import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.entity.PictureData;
import top.itshanhe.picturetradeplatform.entity.PictureInfo;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.mapper.PictureDataMapper;
import top.itshanhe.picturetradeplatform.service.IPictureDataService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.itshanhe.picturetradeplatform.service.IPictureFileService;
import top.itshanhe.picturetradeplatform.service.IPictureInfoService;
import top.itshanhe.picturetradeplatform.service.IPictureUserService;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 图片表 服务实现类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
@Service
public class PictureDataServiceImpl extends ServiceImpl<PictureDataMapper, PictureData> implements IPictureDataService {
    
    @Autowired
    private IPictureInfoService pictureInfoService;
    
    @Autowired
    private IPictureUserService pictureUserService;
    
    @Resource
    private IPictureFileService pictureFileService;
    
    @Value("${data.domain}")
    private String Domain;
    @Resource
    private PictureDataMapper pictureDataMapper;

    
    
    
    
    @Override
    public List<PictureDataDTO> getPictureDataPaged(int offset, int pageSize) {
        IPage<PictureData> page = page(new Page<>(offset / pageSize + 1, pageSize));
        List<PictureData> pictureDataList = page.getRecords();
        return convertToDTOList(pictureDataList);
    }
    
    @Override
    public List<PictureDataDTO> searchPictureData(String keyword, String searchOption, String searchType,
                                                  int minPrice, int maxPrice, int minPriceInput, int maxPriceInput,
                                                  int offset, int pageSize) {
        QueryWrapper<PictureData> queryWrapper = new QueryWrapper<>();
        
        if ("userId".equals(searchOption)) {
            queryWrapper.like("user_id", keyword);
        } else if ("imgId".equals(searchOption)) {
            queryWrapper.like("img_id", keyword);
        } else if ("imgName".equals(searchOption)) {
            queryWrapper.like("img_name", keyword);
        }
        
        if ("twoSearch".equals(searchType)) {
            queryWrapper.eq("img_name", keyword);
        }
        
        // 使用手动输入的价格范围，如果没有手动输入，则使用范围条的值
        int actualMinPrice = minPriceInput > 0 ? minPriceInput : minPrice;
        int actualMaxPrice = maxPriceInput < 1000000 ? maxPriceInput : maxPrice;
        
        // 根据手动输入的价格范围查询
        queryWrapper.between("img_money", actualMinPrice, actualMaxPrice);
        
        IPage<PictureData> page = page(new Page<>(offset / pageSize + 1, pageSize), queryWrapper);
        List<PictureData> pictureDataList = page.getRecords();
        
        return convertToDTOList(pictureDataList);
    }
    
    
    @Override
    public int getTotalPictures() {
        return count();
    }
    
    @Override
    public void insertFileData(String objectId, long id, String userId, BigDecimal money, Boolean copyKey, String formattedDateTime) {
        // 创建PictureData对象
        PictureData pictureData = new PictureData();
    
        // 设置对象的各个属性值
        pictureData.setImgIndex(objectId);
        pictureData.setImgId(id);
        pictureData.setUserId(userId);
        pictureData.setImgMoney(money);
        pictureData.setImgKey(copyKey);
        // 定义日期时间格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        pictureData.setImgCreateTime(LocalDateTime.parse(formattedDateTime, formatter));
        baseMapper.insert(pictureData);
    }
    
    @Override
    public LocalDateTime getImgTime(Long imgId) {
        PictureData pictureData = query().eq("img_id",imgId).one();
        if (pictureData == null) {
            return null;
        }
        return pictureData.getImgCreateTime();
    }
    
    @Override
    public List<PictureImg> getLatestPictures(int offset, int pageSize, String defaultDomain) {
        Page<PictureData> page = page(new Page<>(offset / pageSize + 1, pageSize));
        // 获取记录
        List<PictureData> userList = page.getRecords();
        // 转换需要字段给dto
        return convertToPictureDataList(userList);
    }
    
    @Override
    public PictureData getPictureDataInfo(Long imgId) {
        PictureData pictureData = query().eq("img_id",imgId).one();
        if (pictureData != null) {
            // 这里添加您需要执行的操作，例如日志记录或其他处理
            return pictureData;
        } else {
            // 如果未找到匹配记录，可以返回一个默认值或抛出异常，具体取决于您的业务需求
            return null; // 或者抛出自定义异常
        }
    }
    
    @Override
    public PictureImg getByIdSelect(Long imgId) {
        PictureData pictureData = query().eq("img_id",imgId).one();
        PictureImg pictureImg = new PictureImg();
        pictureImg.setId(imgId);
        pictureImg.setMoney(pictureData.getImgMoney());
        pictureImg.setAuthorName(pictureUserService.getIdByUserName(pictureData.getUserId()));
        // 将 LocalDateTime 转换为 Date
        Date utilDate = Date.from(pictureData.getImgCreateTime().atZone(ZoneId.systemDefault()).toInstant());
    
        // 使用 SimpleDateFormat 格式化 Date
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDate = dateFormat.format(utilDate);
        pictureImg.setImgTime(currentDate);
        pictureImg.setImgUrl(Domain + "/download?uid=" +pictureData.getImgId()+ "&imgName="+  pictureFileService.getFileUrl(pictureData.getImgId()));
        pictureImg.setImgTitle(pictureInfoService.getImgTitle(pictureData.getImgId()));
        pictureImg.setUid(String.valueOf(pictureData.getImgId()));
        if (pictureData.getImgKey()) {
            pictureImg.setKey("是");
        } else {
            pictureImg.setKey("否");
        }
        return pictureImg;
    }
    
    @Override
    public boolean setUserMoney(String userId, BigDecimal subtract) {
    
        UpdateWrapper<PictureUser> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("money_data", subtract).eq("user_id", userId);
    
        // 使用pictureUserService更新用户的金额
        boolean updateResult = pictureUserService.update(updateWrapper);
        
        if (!updateResult) {
            // 失败 todo 记录Log
        }
    
        // 返回更新操作的结果
        return updateResult;
    }
    
    @Override
    public List<PictureImg> selectImgData(String loginSession) {
        PictureUser idByUserNameData = pictureUserService.getIdByUserNameData(loginSession);
        QueryWrapper<PictureData> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", idByUserNameData.getUserId());
        List<PictureData> pictureDatas = pictureDataMapper.selectList(queryWrapper);
        List<PictureImg> pictureImgs = new ArrayList<>();
        for (PictureData pictureData : pictureDatas) {
            PictureImg pictureImg = new PictureImg();
            pictureImg.setId(pictureData.getImgId());
            pictureImg.setMoney(pictureData.getImgMoney());
            pictureImg.setAuthorName(pictureUserService.getIdByUserName(pictureData.getUserId()));
            // 将 LocalDateTime 转换为 Date
            Date utilDate = Date.from(pictureData.getImgCreateTime().atZone(ZoneId.systemDefault()).toInstant());
    
            // 使用 SimpleDateFormat 格式化 Date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String currentDate = dateFormat.format(utilDate);
            pictureImg.setImgTime(currentDate);
            pictureImg.setImgUrl(Domain + "/download?uid=" +pictureData.getImgId()+ "&imgName="+  pictureFileService.getFileUrl(pictureData.getImgId()));
            pictureImg.setImgTitle(pictureInfoService.getImgTitle(pictureData.getImgId()));
            pictureImg.setUid(String.valueOf(pictureData.getImgId()));
            if (pictureData.getImgKey()) {
                pictureImg.setKey("是");
            } else {
                pictureImg.setKey("否");
            }
            pictureImgs.add(pictureImg);
        }
        return pictureImgs;
    }
    
    @Override
    public void deleteByImgId(Long id) {
        QueryWrapper<PictureData> pictureDataQueryWrapper = new QueryWrapper<>();
        pictureDataQueryWrapper.eq("img_id", id);
        remove(pictureDataQueryWrapper);
    }
    
    private PictureImg convertToPictureDTO(PictureData pictureData) {
        PictureImg pictureImg = new PictureImg();
        pictureImg.setId(pictureData.getImgId());
        pictureImg.setMoney(pictureData.getImgMoney());
        // 将 LocalDateTime 转换为 Date
        Date utilDate = Date.from(pictureData.getImgCreateTime().atZone(ZoneId.systemDefault()).toInstant());
    
        // 使用 SimpleDateFormat 格式化 Date
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDate = dateFormat.format(utilDate);
        pictureImg.setImgTime(currentDate);
        pictureImg.setImgUrl(Domain + "/download?uid=" +pictureData.getImgId()+ "&imgName="+  pictureFileService.getFileUrl(pictureData.getImgId()));
        pictureImg.setAuthorName(pictureUserService.getIdByUserName(pictureData.getUserId()));
        pictureImg.setImgTitle(pictureInfoService.getImgTitle(pictureData.getImgId()));
        pictureImg.setUid(String.valueOf(pictureData.getImgId()));
        return pictureImg;
    }
    
    private List<PictureImg> convertToPictureDataList(List<PictureData> userList) {
        return userList.stream()
                .map(this::convertToPictureDTO)
                .collect(Collectors.toList());
    }
    
    private PictureDataDTO convertToDTO(PictureData pictureData) {
        PictureDataDTO pictureDataDTO = new PictureDataDTO();
        pictureDataDTO.setId(pictureData.getId());
        // fixme 废弃了但是没办法删除
//        pictureDataDTO.setImgIndex(pictureData.getImgIndex());
        pictureDataDTO.setUserId(pictureData.getUserId());
        pictureDataDTO.setImgMoney(pictureData.getImgMoney());
        pictureDataDTO.setImgAddr(Domain + "/download?uid=" +pictureData.getImgId()+ "&imgName="+  pictureFileService.getFileUrl(pictureData.getImgId()));
        PictureUser user = pictureUserService.getById(pictureData.getUserId());
        if (user != null) {
            pictureDataDTO.setUserName(user.getUserName());
        }
        
        PictureInfo pictureInfo = pictureInfoService.getById(pictureData.getImgId());
        if (pictureInfo != null) {
            pictureDataDTO.setImgName(pictureInfo.getImgName());
        }
        
        return pictureDataDTO;
    }
    
    private List<PictureDataDTO> convertToDTOList(List<PictureData> pictureDataList) {
        return pictureDataList.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }
}
