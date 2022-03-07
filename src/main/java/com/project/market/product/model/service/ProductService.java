package com.project.market.product.model.service;

import java.util.List;
import java.util.Map;

import com.project.market.product.model.vo.Product;

public interface ProductService {

	List<Product> selectProductListByCategory(Product product);

	Product selectProductDetail(String pcode);

	int insertCart(Map<String, Object> cartInfo);

	List<Map<String, Object>> selectProductInCart(String userId);

}
