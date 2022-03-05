package com.project.market.product.model.dao;

import java.util.List;

import com.project.market.product.model.vo.Product;

public interface ProductDao {

	List<Product> selectProductListByCategory(Product product);

}
