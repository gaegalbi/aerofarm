package yj.capstone.aerofarm.service;

import marvin.image.MarvinImage;
import org.marvinproject.image.transform.scale.Scale;

import java.awt.image.BufferedImage;

public class ImageResizer {
    public static BufferedImage forceResizeImage(BufferedImage originalImage, int width, int height) {
        MarvinImage imageMarvin = new MarvinImage(originalImage);

        Scale scale = new Scale();
        scale.load();
        scale.setAttribute("newWidth", width);
        scale.setAttribute("newHeight", height);
        scale.process(imageMarvin.clone(), imageMarvin, null, null, false);

        return imageMarvin.getBufferedImageNoAlpha();
    }

    public static BufferedImage resizeImage(BufferedImage originalImage, int width, int height) {
        if (originalImage.getWidth() < width && originalImage.getHeight() < height) {
            return originalImage;
        }
        return forceResizeImage(originalImage, width, height);
    }
}
