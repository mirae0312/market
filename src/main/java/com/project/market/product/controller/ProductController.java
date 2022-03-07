package com.project.market.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		
		int ogp = 0;
		int dcp = 0;
		for(Map<String, Object> pdt : productInCartList) {
			int count = Integer.parseInt(String.valueOf(pdt.get("COUNT")));
			int og = Integer.parseInt(String.valueOf(pdt.get("PRICE")));
			ogp += og * count;
			if(pdt.get("DISCOUNT_RATE") != null) {
				int dc = Integer.parseInt(String.valueOf(pdt.get("DISCOUNT_RATE")));	
				log.debug("dc = {}", (og - (og / 100 * (100 - dc))));
				dcp += (og - (og / 100 * (100 - dc)))*count;
			}
		}
		log.debug("ogp, dcp = {}, {}", ogp, dcp);
		
		model.addAttribute("cartList", productInCartList);
		model.addAttribute("ogp", ogp);
		model.addAttribute("dcp", dcp);
	}
	
	@PostMapping("/addCart")
	public ResponseEntity<?> addCart(@RequestParam String pcode, @RequestParam int count, @AuthenticationPrincipal Member member){
		Map<String, Object> cartInfo = new HashMap<>();
		cartInfo.put("pcode", pcode);
		cartInfo.put("count", count);
		cartInfo.put("userId", member.getId());
		
		int result = productService.insertCart(cartInfo);
		
		String msg = result == 1 ? "장바구니에 추가되었습니다." : "장바구니에 추가되지 않았습니다.";
		return ResponseEntity.ok(msg);
	}
}
