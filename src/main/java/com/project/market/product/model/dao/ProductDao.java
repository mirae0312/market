package com.project.market.product.model.dao;

import java.util.List;
import java.util.Map;

import com.project.market.product.model.vo.Product;

public interface ProductDao {

	List<Product> selectProductListByCategory(Product product);

	Product selectProductDetail(String pcode);

	int insertCart(Map<String, Object> cartInfo);

	List<Map<String, Object>> selectUserCartList(String userId);

	int updateCart(Map<String, Object> cartInfo);

	Map<String, Object> selectOneProductInCart(Map<String, Object> param);

	int deleteCart(Map<String, Object> param);



}
