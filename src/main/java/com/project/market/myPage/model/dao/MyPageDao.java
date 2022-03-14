package com.project.market.myPage.model.dao;

import java.util.List;
import java.util.Map;

import com.project.market.purchase.model.vo.Coupon;

public interface MyPageDao {

	Coupon selectCoupon(String writeCoupon);

	int insertUserCoupon(Map<String, Object> param);

	List<Map<String, Object>> selectuserCoupon(String userId);

}
