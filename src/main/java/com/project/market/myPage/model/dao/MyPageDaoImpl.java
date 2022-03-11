package com.project.market.myPage.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MyPageDaoImpl implements MyPageDao {
	
	@Autowired
	private SqlSession session;

}
