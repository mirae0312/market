package com.project.market.purchase.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.market.purchase.model.vo.Coupon;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class PurchaseDaoImpl implements PurchaseDao{

	@Autowired
	private SqlSession session;

	@Override
	public String selectCouponCode(String code) {
		return session.selectOne("purchase.selectCouponCode", code);
	}

	@Override
	public int insertCoupon(Coupon coupon) {
		return session.insert("purchase.insertCoupon", coupon);
	}

	@Override
	public List<Coupon> getUserCouponList(String userId) {
		return session.selectList("purchase.getUserCouponList", userId);
	}

	@Override
	public int updateCouponStatus(String couponCode) {
		return session.update("purchase.updateCouponStatus", couponCode);
	}

	@Override
	public int addAcc(Map<String, Object> param) {
		return session.insert("purchase.addAcc", param);
	}
	
	
	
}
