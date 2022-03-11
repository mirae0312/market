package com.project.market.myPage.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.market.myPage.model.dao.MyPageDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MyPageServiceImpl implements MyPageService {
	
	@Autowired 
	private MyPageDao mypageDao;

}
