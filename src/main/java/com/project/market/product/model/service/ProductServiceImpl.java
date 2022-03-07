package com.project.market.product.model.service;

import java.util.List;
import java.util.Map;

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

	@Override
	public int insertCart(Map<String, Object> cartInfo) {
		String userId = (String) cartInfo.get("userId");
		String pcode = (String) cartInfo.get("pcode");

		List<Map<String, Object>> userCartList = productDao.selectUserCartList(userId);

		int result = 0;
		int checkNum = 0;
		for(Map<String, Object> product : userCartList) {
			String productCode = (String) product.get("P_CODE");
			
			if(pcode.equals(productCode)) {
				result = productDao.updateCart(cartInfo);
				checkNum = result > 0 ? checkNum + 1 : 0;
			}
		}
		
		if(checkNum == 0) {
			result = productDao.insertCart(cartInfo);
		}
		
		return result;
	}

	@Override
	public List<Map<String, Object>> selectProductInCart(String userId) {
		return productDao.selectUserCartList(userId);
	}
	
	
	
	
}
