package top.itshanhe.picturetradeplatform.config;


import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;

/**
 * <p>
 *    验证码配置
 * </p>
 *
 * @author shanhe
 * @date 2023-11-25
 */

@Configuration
public class KaptchaConfig {
    @Bean
    public DefaultKaptcha producer() {
        // 创建一个Properties对象，用来设置kaptcha的属性
        Properties properties = new Properties();
        // 设置验证码图片没有边框
        properties.put("kaptcha.border", "no");
        // 设置验证码文字的颜色为黑色
        properties.put("kaptcha.textproducer.font.color", "black");
        // 设置验证码文字之间的间距
        properties.put("kaptcha.textproducer.char.space", "7");
        // 设置验证码文字的长度为3
        properties.put("kaptcha.textproducer.char.length", "3");
        // 设置验证码文字的大小为30
        properties.put("kaptcha.textproducer.font.size", "35");
        // 设置验证码图片的宽度为150
        properties.put("kaptcha.image.width", "150");
        // 设置验证码图片的高度为40
        properties.put("kaptcha.image.height", "50");
        properties.put("kaptcha.textproducer.char.string", "矫若游龙有紧没要天下为公忠贞不屈改途易辙听天委命秘鲁寒流高枕勿忧避影匿形同化政策慌不择路鱼肉百姓法斯蒂力蹙势穷悔之莫及鼎折覆餗恍恍荡荡以直报怨高人面罩一着上德若谷箭无空发问策深目海螺电信旌旐孤枕兆文迁格狎慢名业乱事要览独对金燕安祥眼白临池随高逐谦恪庶男朱矾筕篖口籍拔本国丈祗翼谦托法将公座下首低衣冠济济甄心动惧了然于心煨干避湿拥鼻微吟三衅三沐饮河满腹小廉大法五六七八九十龙泉虎豹马羊"); // 设置验证码文字的字符集为中文
        // 设置验证码图片有干扰线
        properties.put("kaptcha.noise.impl", "top.itshanhe.picturetradeplatform.util.RandomColorNoise");
        // 设置字体
        properties.setProperty ( "kaptcha.textproducer.font.names", "宋体,楷体,微软雅黑" );
        // 创建一个Config对象，用来配置kaptcha的属性
        Config config = new Config(properties);
        // 创建一个DefaultKaptcha对象，用来生成验证码
        DefaultKaptcha defaultKaptcha = new DefaultKaptcha();
        // 将Config对象设置为DefaultKaptcha对象的属性
        defaultKaptcha.setConfig(config);
        return defaultKaptcha;
    }
}
