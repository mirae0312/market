package com.project.market.myPage.model.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.market.purchase.model.vo.Coupon;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MyPageDaoImpl implements MyPageDao {
	
	@Autowired
	private SqlSession session;

	@Override
	public Coupon selectCoupon(String writeCoupon) {
		
		return session.selectOne("selectCoupon",writeCoupon);
	}

	@Override
	public int insertUserCoupon(Map<String, Object> param) {
	
		return session.insert("insertUserCoupon", param);
	}

	@Override
	public List<Map<String, Object>> selectuserCoupon(String userId) {
		
		return session.selectList("selectuserCoupon", userId);
	}

	@Override
	public int insertAddress(LinkedHashMap<String, Object> param) {
		
		return session.insert("insertAddress", param);
	}

	@Override
	public List<Map<String, Object>> selectmkAddress(String userId) {
		
		return session.selectList("selectmkAddress", userId);
	}

	@Override
	public int selectmkAddressCheck(Map<String, Object> checkParam) {
		
		return session.selectOne("selectmkAddressCheck",checkParam);
	}

}
