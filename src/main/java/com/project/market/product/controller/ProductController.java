package com.project.market.product.controller;

import java.util.ArrayList;
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
	public void productDetail(@RequestParam String pcode, Model model, @AuthenticationPrincipal Member member) {
		Product pdt = productService.selectProductDetail(pcode);
		log.debug("product = {}", pdt);
		
		if(member != null) {
			String userId = member.getId();
			
			int accumulationRate = customerService.selectUserAccumulationRate(userId);
			
			int dcPrice = pdt.getPrice()/100 * (100 - pdt.getDiscountRate());
			int accAmount = (int) Math.ceil(dcPrice / 100 * accumulationRate);			
			model.addAttribute("acRate", accumulationRate);
			model.addAttribute("dcPrice", dcPrice);
			model.addAttribute("accAmount", accAmount);
		}
		
		List<Product> hasOption = productService.selectProductOptionsDetail(pcode);
		
		if(hasOption.size() != 0) {
			List<Map<String, Object>> optionList = new ArrayList<>();
			
			for(Product optPdt : hasOption) {
				Map<String, Object> option = new HashMap<>();
				option.put("brand", optPdt.getBrandTitle());
				option.put("title", optPdt.getTitle());
				option.put("price", optPdt.getPrice());
				option.put("pcode", optPdt.getPcode());
				
				int dcPrice = optPdt.getPrice()/100 * (100 - optPdt.getDiscountRate());
				option.put("dcPrice", dcPrice);
				
				log.debug("option = {}", option);
				optionList.add(option);
			}
			
			model.addAttribute("optionList", optionList);
		}
		
		model.addAttribute("product", pdt);
	}
	
	@GetMapping("/cart/cart")
	public void cart() {}
	
	@GetMapping("/cart/myCart")
	public void myCart(@AuthenticationPrincipal Member member, Model model) {
		if(member != null) {
			String userId = member.getId();
			List<Map<String, Object>> productInCartList = productService.selectProductInCart(userId);
			log.debug("cartList = {}", productInCartList);
			
			int accumulationRate = customerService.selectUserAccumulationRate(userId);
			
			int accAmountAll = calculateAccumulateAmount(productInCartList, accumulationRate);
			
			Map<String, Integer> returnMap = calculateAmount(productInCartList);
			int ogp = returnMap.get("ogp");
			int dcp = returnMap.get("dcp");
			
			Map<String, Object> addressMap = customerService.selectUserDefaultAddress(userId);
			
			model.addAttribute("cartList", productInCartList);
			model.addAttribute("ogp", ogp);
			model.addAttribute("dcp", dcp);
			model.addAttribute("acp", accAmountAll);
			model.addAttribute("address", addressMap);			
		}
		
	}
	
	@PostMapping("/addCart")
	public ResponseEntity<?> addCart(@RequestParam String pcode, @RequestParam int count, @AuthenticationPrincipal Member member){
		Map<String, Object> cartInfo = new HashMap<>();
		cartInfo.put("pcode", pcode);
		cartInfo.put("count", count);
		cartInfo.put("userId", member.getId());
		
		int result = productService.insertCart(cartInfo);
		
		return ResponseEntity.ok(result);
	}
	
	@DeleteMapping("/cart/deleteCart")
	public ResponseEntity<?> deleteCart(@RequestParam(value="deleteArr[]") List<String> deleteArr, @AuthenticationPrincipal Member member){
		String userId = member.getId();
		
		Map<String, Object> param = new HashMap<>();
		param.put("deleteArr", deleteArr);
		param.put("userId", userId);
		
		int result = productService.deleteCart(param);
		
		return ResponseEntity.ok(result);
	}
	
	@GetMapping("/cart/getPurchaseAmount")
	public ResponseEntity<?> getPurchaseAmount(@RequestParam(value="checkedArr[]") List<String> checkedArr, @AuthenticationPrincipal Member member){
		String userId = member.getId();
		List<Map<String, Object>> productInCartList = productService.selectProductInCart(userId);		
		List<Map<String, Object>> checkedCartList = new ArrayList<>();
		
		for(Map<String, Object> cart : productInCartList) {
			String cartCode = String.valueOf(cart.get("P_CODE"));
			
			for(String code : checkedArr) {
				if(cartCode.equals(code)) {
					checkedCartList.add(cart);
				}
			}
		}	
		
		Map<String, Integer> returnMap = calculateAmount(checkedCartList);
		
		int accumulationRate = customerService.selectUserAccumulationRate(userId);
		int accAmountAll = calculateAccumulateAmount(checkedCartList, accumulationRate);
		
		returnMap.put("acp", accAmountAll);
		
		return ResponseEntity.ok(returnMap);
	}
	
	@GetMapping("/cart/getProductAmount")
	public ResponseEntity<?> getProductAmount(@RequestParam String pcode, @AuthenticationPrincipal Member member){
		String userId = member.getId();
		
		Map<String, Object> param = new HashMap<>();
		param.put("pcode", pcode);
		param.put("userId", userId);
		
		Map<String, Object> cart = productService.selectOneProductInCart(param);
		
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
			log.debug("pdt = {}", pdt);
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
	
	public int calculateAccumulateAmount(List<Map<String, Object>> pdtList, int accumulationRate) {
		int accAmountAll = 0;
		for(Map<String, Object> list : pdtList) {
			if(String.valueOf(list.get("ACCUMULATION_STATUS")).equals("Y")) {				
				int price = Integer.parseInt(String.valueOf(list.get("PRICE")));
				int count = Integer.parseInt(String.valueOf(list.get("COUNT")));
				if(list.get("DISCOUNT_RATE") != null) {
					int dcRate = Integer.parseInt(String.valueOf(list.get("DISCOUNT_RATE")));
					int dcPrice = price/100 * (100 - dcRate) * count;
					int accAmount = (int) Math.ceil(dcPrice / 100 * accumulationRate);
					accAmountAll += accAmount;					
				} else {
					int accAmount = (int) Math.ceil(price / 100 * accumulationRate * count);
					accAmountAll += accAmount;
				}
			}
		}
		
		return accAmountAll;
	}

	@GetMapping("/cart/findAddress")
	public void findAddress(@AuthenticationPrincipal Member member, Model model) {
		if(member != null) {
			String userId = member.getId();
			Map<String, Object> addressMap = customerService.selectUserDefaultAddress(userId);
			model.addAttribute("address", addressMap);			
		}
	}
	
}
