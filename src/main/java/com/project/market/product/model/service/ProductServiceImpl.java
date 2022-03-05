package com.project.market.product.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.market.product.model.dao.ProductDao;
import com.project.market.product.model.vo.Product;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao productDao;

	@Override
	public List<Product> selectProductListByCategory(Product product) {
		return productDao.selectProductListByCategory(product);
	}

	@Override
	public Product selectProductDetail(String pcode) {
		return productDao.selectProductDetail(pcode);
	}
	
	
}
