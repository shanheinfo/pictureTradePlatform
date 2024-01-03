package top.itshanhe.picturetradeplatform.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import top.itshanhe.picturetradeplatform.dto.PictureDataDTO;
import top.itshanhe.picturetradeplatform.entity.PictureData;
import top.itshanhe.picturetradeplatform.entity.PictureInfo;
import top.itshanhe.picturetradeplatform.entity.PictureUser;
import top.itshanhe.picturetradeplatform.mapper.PictureDataMapper;
import top.itshanhe.picturetradeplatform.service.IPictureDataService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.itshanhe.picturetradeplatform.service.IPictureInfoService;
import top.itshanhe.picturetradeplatform.service.IPictureUserService;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
        return pictureData.getImgCreateTime();
    }
    
    private PictureDataDTO convertToDTO(PictureData pictureData) {
        PictureDataDTO pictureDataDTO = new PictureDataDTO();
        pictureDataDTO.setId(pictureData.getId());
        // fixme 废弃了但是没办法删除
//        pictureDataDTO.setImgIndex(pictureData.getImgIndex());
        pictureDataDTO.setUserId(pictureData.getUserId());
        pictureDataDTO.setImgMoney(pictureData.getImgMoney());
        
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
