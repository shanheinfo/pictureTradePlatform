package top.itshanhe.picturetradeplatform.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;

/**
 * <p>
 * 内容
 * </p>
 *
 * @author shanhe
 * @date 2023/12/22
 */
public class ImageUtils {
    public static String encodeImageToBase64(File imageFile) throws IOException {
        try (FileInputStream fileInputStreamReader = new FileInputStream(imageFile)) {
            byte[] bytes = new byte[(int) imageFile.length()];
            fileInputStreamReader.read(bytes);
            return Base64.getEncoder().encodeToString(bytes);
        }
    }
}
