package com.project.market.product.model.service;

import java.util.List;
import java.util.Map;

import com.project.market.product.model.vo.Product;
import com.project.market.security.model.vo.Member;

public interface ProductService {

	List<Product> selectProductListByCategory(Product product);

	Product selectProductDetail(String pcode);

	int insertCart(Map<String, Object> cartInfo);

	List<Map<String, Object>> selectProductInCart(String userId);

	Map<String, Object> selectOneProductInCart(Map<String, Object> param);

	int deleteCart(Map<String, Object> param);

	List<Product> selectProductOptionsDetail(String pcode);


}
