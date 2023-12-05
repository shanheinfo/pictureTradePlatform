package top.itshanhe.picturetradeplatform.util;

import com.google.code.kaptcha.impl.DefaultNoise;

import java.awt.*;
import java.awt.image.BufferedImage;

/**
 * <p>
 *    干扰线工具类
 * </p>
 *
 * @author shanhe
 * @date 2023-11-25
 */

// 自定义干扰线的实现类，继承DefaultNoise类，重写makeNoise方法，设置干扰线的数量和颜色
public class RandomColorNoise extends DefaultNoise {
    @Override
    public void makeNoise(BufferedImage image, float factorOne, float factorTwo, float factorThree, float factorFour) {
        Color color = getConfig().getNoiseColor(); // 获取配置的干扰线颜色
        int width = image.getWidth();
        int height = image.getHeight();
        int num = 3; // 设置干扰线的数量为3
        for (int i = 0; i < num; i++) {
            // 生成随机颜色
            int r = (int) (Math.random() * 255);
            int g = (int) (Math.random() * 255);
            int b = (int) (Math.random() * 255);
            color = new Color(r, g, b); // 用随机颜色替换配置的颜色
            // 生成随机坐标
            int x = (int) (Math.random() * width);
            int y = (int) (Math.random() * height);
            int xl = (int) (Math.random() * width);
            int yl = (int) (Math.random() * height);
            // 画干扰线
            drawLine(image, x, y, xl, yl, color, factorOne, factorTwo, factorThree, factorFour);
        }
    }
    
    // 画干扰线的方法，继承自DefaultNoise类，使用Graphics2D对象绘制直线
    protected void drawLine(BufferedImage image, int x1, int y1, int x2, int y2, Color color, float factorOne, float factorTwo, float factorThree, float factorFour) {
        Graphics2D graph = (Graphics2D) image.getGraphics(); // 获取图像的Graphics2D对象
        graph.setColor(color); // 设置画笔的颜色
        graph.setStroke(new BasicStroke(1.5f)); // 设置画笔的粗细
        graph.drawLine(x1, y1, x2, y2); // 画一条直线，从(x1, y1)到(x2, y2)
    }
}

