package top.itshanhe.picturetradeplatform;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("top.itshanhe.picturetradeplatform.mapper")
public class PictureTradePlatformApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(PictureTradePlatformApplication.class, args);
    }
    
}
