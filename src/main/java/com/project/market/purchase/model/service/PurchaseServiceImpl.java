package com.project.market.purchase.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.market.common.coupon.CreateCoupon;
import com.project.market.purchase.model.dao.PurchaseDao;
import com.project.market.purchase.model.vo.Coupon;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	private PurchaseDao purchaseDao;

	@Override
	public int insertCoupon(Coupon coupon) {
		int result = 0;
		
		while(true) {
			String code = CreateCoupon.createCoupon().toString();
			String selectCode = purchaseDao.selectCouponCode(code);
			
			log.debug("code ? = {}", code);
			
			if(!code.equals(selectCode)) {
				coupon.setCode(code);
				result = purchaseDao.insertCoupon(coupon);
				break;
			}
			
		}
		
		return result;
	}
	
	
}
