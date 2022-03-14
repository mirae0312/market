package com.project.market.myPage.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.market.myPage.model.dao.MyPageDao;
import com.project.market.purchase.model.vo.Coupon;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MyPageServiceImpl implements MyPageService {
	
	@Autowired 
	private MyPageDao mypageDao;

	@Override
	public Coupon selectCoupon(String writeCoupon) {
		
		return mypageDao.selectCoupon(writeCoupon);
	}

	@Override
	public int insertUserCoupon(Map<String, Object> param) {
		
		return mypageDao.insertUserCoupon(param);
	}

	@Override
	public List<Map<String, Object>> selectuserCoupon(String userId) {
		
		return mypageDao.selectuserCoupon(userId);
	}

	
}
