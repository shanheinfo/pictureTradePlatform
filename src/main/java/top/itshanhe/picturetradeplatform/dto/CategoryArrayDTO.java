package top.itshanhe.picturetradeplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2024/1/2
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class CategoryArrayDTO {
    List<CategoryDTO> categoryDTOS;
}
