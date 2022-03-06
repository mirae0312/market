package com.project.market.purchase.model.dao;

import com.project.market.purchase.model.vo.Coupon;

public interface PurchaseDao {

	String selectCouponCode(String code);

	int insertCoupon(Coupon coupon);

}
