package com.project.market.purchase.model.dao;

import java.util.List;
import java.util.Map;

import com.project.market.purchase.model.vo.Coupon;

public interface PurchaseDao {

	String selectCouponCode(String code);

	int insertCoupon(Coupon coupon);

	List<Coupon> getUserCouponList(String userId);

	int updateCouponStatus(String couponCode);

	int addAcc(Map<String, Object> param);
	
	

}
