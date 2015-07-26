/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.hhf.seller.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hhf.common.util.CapthaUtils;
import com.hhf.seller.service.IValidatorService;

/**
 * 验证码生成器
 * 
 * @author xuzunyuan
 * @date 2014年6月18日
 */
@Controller
public class ValidatorController {
	@Autowired
	private IValidatorService validatorService;

	@RequestMapping("/validator")
	public void validatorGenerator(FormData formData,
			HttpServletResponse response, HttpServletRequest request) {

		String validator = CapthaUtils.getRand(formData.getBit());

		// 记入缓存
		validatorService.registerValidator(request, validator,
				formData.getPeriod());

		// 生成图像
		response.setContentType("image/jpeg");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "No-cache");
		response.setDateHeader("Expires", 0L);

		// 用RGB模式输出图像区域
		BufferedImage image = new BufferedImage(formData.getWidth(),
				formData.getHeight(), BufferedImage.TYPE_INT_RGB);
		// 定义画笔
		Graphics graph = image.getGraphics();
		// 设置验证码框背景色0-255
		graph.setColor(new Color(200, 200, 200));
		// 填充矩形
		graph.fillRect(0, 0, formData.getWidth(), formData.getHeight());

		// 设置矩形区域中随机数及干扰点的颜色
		graph.setColor(Color.black);
		// 设置随机数的字体大小
		graph.setFont(new Font("", Font.PLAIN, 20));
		// 在已有的矩形区域中绘制随机数
		graph.drawString(validator, 9, 22);
		// 随机产生100个干扰点
		Random rnd = new Random();
		for (int i = 0; i < 100; i++) {
			int x = rnd.nextInt(formData.getWidth());
			int y = rnd.nextInt(formData.getHeight());
			// 设置干扰点的位置长宽
			graph.drawOval(x, y, 1, 1);
		}
		// 将图像输出到页面上
		try {
			ImageIO.write(image, "JPEG", response.getOutputStream());
			response.flushBuffer();
		} catch (IOException e) {
		}
	}

	public static final class FormData {
		private int width = 63;
		private int height = 34;
		private int bit = 4;
		private int period = 120;

		public int getWidth() {
			return width;
		}

		public void setWidth(int width) {
			this.width = width;
		}

		public int getHeight() {
			return height;
		}

		public void setHeight(int height) {
			this.height = height;
		}

		public int getBit() {
			return bit;
		}

		public void setBit(int bit) {
			this.bit = bit;
		}

		public int getPeriod() {
			return period;
		}

		public void setPeriod(int period) {
			this.period = period;
		}

	}
}
