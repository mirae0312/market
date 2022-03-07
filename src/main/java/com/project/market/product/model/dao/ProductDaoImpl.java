package com.project.market.product.model.dao;

import java.util.List;
import java.util.Map;

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

	@Override
	public Product selectProductDetail(String pcode) {
		return session.selectOne("product.selectProductDetail", pcode);
	}

	@Override
	public int insertCart(Map<String, Object> cartInfo) {
		return session.insert("product.insertCart", cartInfo);
	}

	@Override
	public List<Map<String, Object>> selectUserCartList(String userId) {
		return session.selectList("product.selectUserCartList", userId);
	}

	@Override
	public int updateCart(Map<String, Object> cartInfo) {
		return session.update("product.updateCart", cartInfo);
	}
	
	
}
