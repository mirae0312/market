package com.project.market.common.coupon;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CreateCoupon {
	
	public static StringBuilder createCoupon() {
		
		StringBuilder str = new StringBuilder();
		
		for(int i = 0; i < 12; i++) {
			if(i == 4 || i == 5 || i == 6) {
				int appendNumber = (int) (Math.random() * 10);
				str.append(appendNumber);
			} else {
				double num = Math.random();
				char alphabet = (char)((num * 26) + 65);
				str.append(alphabet);
			}
		}
		
		log.debug("code = {}", str);
		
		return str;
	}
}
