package com.project.market.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.market.product.model.vo.Product;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SqlSession session;

	@Override
	public List<Product> selectProductListByCategory(Product product) {
		return session.selectList("product.selectProductListByCategory", product);
	}
	
	
}
