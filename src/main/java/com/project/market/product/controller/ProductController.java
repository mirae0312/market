package com.project.market.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.market.customerService.model.service.CustomerServiceService;
import com.project.market.product.model.service.ProductService;
import com.project.market.product.model.vo.Product;
import com.project.market.security.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private CustomerServiceService customerService;
	
	
	@GetMapping("/productList")
	public void productList(Product product, Model model) {
		List<Product> pdtList = productService.selectProductListByCategory(product);
		log.debug("pdtlist = {}", pdtList);
		
		model.addAttribute("pdtList", pdtList);
	}
	
	@GetMapping("/productDetail")
	public void productDetail(@RequestParam String pcode, Model model) {
		Product pdt = productService.selectProductDetail(pcode);
		log.debug("product = {}", pdt);
		
		model.addAttribute("product", pdt);
	}
	
	@GetMapping("/cart/myCart")
	public void myCart(@AuthenticationPrincipal Member member, Model model) {
		String userId = member.getId();
		List<Map<String, Object>> productInCartList = productService.selectProductInCart(userId);
		log.debug("cartList = {}", productInCartList);
		
		Map<String, Integer> returnMap = calculateAmount(productInCartList);
		int ogp = returnMap.get("ogp");
		int dcp = returnMap.get("dcp");
		
		Map<String, Object> addressMap = customerService.selectUserDefaultAddress(userId);
		log.debug("userAddress = {}", addressMap);
		
		model.addAttribute("cartList", productInCartList);
		model.addAttribute("ogp", ogp);
		model.addAttribute("dcp", dcp);
		model.addAttribute("address", addressMap);
		
	}
	
	@PostMapping("/addCart")
	public ResponseEntity<?> addCart(@RequestParam String pcode, @RequestParam int count, @AuthenticationPrincipal Member member){
		log.debug("addCart pcode, count = {}, {}", pcode, count);
		Map<String, Object> cartInfo = new HashMap<>();
		cartInfo.put("pcode", pcode);
		cartInfo.put("count", count);
		cartInfo.put("userId", member.getId());
		
		int result = productService.insertCart(cartInfo);
		
		return ResponseEntity.ok(result);
	}
	
	@DeleteMapping("/cart/deleteCart")
	public ResponseEntity<?> deleteCart(@RequestParam(value="deleteArr[]") List<String> deleteArr, @AuthenticationPrincipal Member member){
		log.debug("deletePcode = {}", deleteArr);
		String userId = member.getId();
		
		Map<String, Object> param = new HashMap<>();
		param.put("deleteArr", deleteArr);
		param.put("userId", userId);
		
		int result = productService.deleteCart(param);
		
		return ResponseEntity.ok(result);
	}
	
	@GetMapping("/cart/getPurchaseAmount")
	public ResponseEntity<?> getPurchaseAmount(@AuthenticationPrincipal Member member){
		String userId = member.getId();
		List<Map<String, Object>> productInCartList = productService.selectProductInCart(userId);
		
		Map<String, Integer> returnMap = calculateAmount(productInCartList);
		
		log.debug("returnMap = {}", returnMap);
		
		return ResponseEntity.ok(returnMap);
	}
	
	@GetMapping("/cart/getProductAmount")
	public ResponseEntity<?> getProductAmount(@RequestParam String pcode, @AuthenticationPrincipal Member member){
		String userId = member.getId();
		
		Map<String, Object> param = new HashMap<>();
		param.put("pcode", pcode);
		param.put("userId", userId);
		
		Map<String, Object> cart = productService.selectOneProductInCart(param);
		
		log.debug("cart = {}", cart);
		
		int dcp = 0;
		int ogp = 0;
		
		int price = Integer.parseInt(String.valueOf(cart.get("PRICE")));
		int count = Integer.parseInt(String.valueOf(cart.get("COUNT")));
		
		if(cart.get("DISCOUNT_RATE") != null) {
			int dcRate = Integer.parseInt(String.valueOf(cart.get("DISCOUNT_RATE")));
			ogp = price * count;
			dcp = ogp - ((price - (price/100 * (100 - dcRate))) * count);
			
		} else {
			ogp = price * count;
		}
		
		cart.put("ogp", ogp);
		cart.put("dcp", dcp);
		
		return ResponseEntity.ok(cart); 
	}
	
	public Map<String, Integer> calculateAmount(List<Map<String, Object>> list){
		int ogp = 0;
		int dcp = 0;
		for(Map<String, Object> pdt : list) {
			int count = Integer.parseInt(String.valueOf(pdt.get("COUNT")));
			int og = Integer.parseInt(String.valueOf(pdt.get("PRICE")));
			ogp += og * count;
			if(pdt.get("DISCOUNT_RATE") != null) {
				int dc = Integer.parseInt(String.valueOf(pdt.get("DISCOUNT_RATE")));	
				log.debug("dc = {}", (og - (og / 100 * (100 - dc))));
				dcp += (og - (og / 100 * (100 - dc)))*count;
			}
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("ogp", ogp);
		map.put("dcp", dcp);
		
		return map;
	}
}
