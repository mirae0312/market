package com.project.market.myPage.model.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.project.market.myPage.model.vo.Address;
import com.project.market.purchase.model.vo.Coupon;

public interface MyPageService {


	Coupon selectCoupon(String writeCoupon);

	int insertUserCoupon(Map<String, Object> param);

	List<Map<String, Object>> selectuserCoupon(String userId);

	int insertAddress(LinkedHashMap<String, Object> param);

	List<Map<String, Object>> selectmkAddress(String userId);

	int selectmkAddressCheck(Map<String, Object> checkParam);

	Address selectOneAddress(String no);

}
