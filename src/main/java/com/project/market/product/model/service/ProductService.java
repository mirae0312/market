package com.project.market.product.model.service;

import java.util.List;

import com.project.market.product.model.vo.Product;

public interface ProductService {

	List<Product> selectProductListByCategory(Product product);

}
