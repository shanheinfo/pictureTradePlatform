package top.itshanhe.picturetradeplatform.service;

import top.itshanhe.picturetradeplatform.dto.PictureDataDTO;
import top.itshanhe.picturetradeplatform.dto.PictureImg;
import top.itshanhe.picturetradeplatform.entity.PictureData;
import com.baomidou.mybatisplus.extension.service.IService;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 * 图片表 服务类
 * </p>
 *
 * @author shanhe
 * @since 2023-12-05
 */
public interface IPictureDataService extends IService<PictureData> {
    
    List<PictureDataDTO> getPictureDataPaged(int offset, int pageSize);
    
    List<PictureDataDTO> searchPictureData(String keyword, String searchOption, String searchType, int minPrice, int maxPrice, int offset, int pageSize, int i, int size);
    
    int getTotalPictures();
    
    void insertFileData(String objectId, long id, String userId, BigDecimal money, Boolean copyKey, String formattedDateTime);
    
    LocalDateTime getImgTime(Long imgId);
    
    List<PictureImg> getLatestPictures(int offset, int pageSize,String defaultDomain);
    
    PictureData getPictureDataInfo(Long imgId);
    
    PictureImg getByIdSelect(Long imgId);
}
