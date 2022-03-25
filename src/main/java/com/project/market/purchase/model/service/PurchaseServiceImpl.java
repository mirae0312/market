package com.project.market.purchase.model.service;

import java.util.List;
import java.util.Map;

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

	@Override
	public List<Coupon> getUserCouponList(String userId) {
		return purchaseDao.getUserCouponList(userId);
	}

	@Override
	public int updateCouponStatus(String couponCode) {
		return purchaseDao.updateCouponStatus(couponCode);
	}

	@Override
	public int addAcc(Map<String, Object> param) {
		return purchaseDao.addAcc(param);
	}

	
	
	
	
}
