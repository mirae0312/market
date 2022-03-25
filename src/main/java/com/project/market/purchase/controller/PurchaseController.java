package com.project.market.purchase.controller;

import java.beans.PropertyEditor;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.market.customerService.model.service.CustomerServiceService;
import com.project.market.product.model.service.ProductService;
import com.project.market.purchase.model.service.PurchaseService;
import com.project.market.purchase.model.vo.Coupon;
import com.project.market.security.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/purchase")
public class PurchaseController {
	
	@Autowired
	private PurchaseService purchaseService;
	
	@Autowired
	private ProductService productService;

	@Autowired
	private CustomerServiceService customerService;
	
	@GetMapping("/tarr4hMain")
	public void tarr4hMain() {
		
	}
	
	@GetMapping("/createCoupon")
	public ResponseEntity<?> createCoupon(Coupon coupon) {
		int result = purchaseService.insertCoupon(coupon);
		log.debug("insertCouponResult = {}", result);
		
		return ResponseEntity.ok(coupon.getCode());
	}
	
	@GetMapping("/orderPage")
	public void orderPage(@RequestParam List<String> orderArr, @AuthenticationPrincipal Member member, Model model) {
		String userId = member.getId();
		
		List<Map<String, Object>> cartList = new ArrayList<>();
		
		for(String pdt : orderArr) {
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("pcode", pdt);
					
			Map<String, Object> cartMap = productService.selectOneProductInCart(param);
			log.debug("cart = {}", cartMap);
			cartList.add(cartMap);
		}
		
		model.addAttribute("cartList", cartList);
		log.debug("cartList = {}", cartList);
		
		Map<String, Object> addressMap = customerService.selectUserDefaultAddress(userId);
		model.addAttribute("address", addressMap);	
		log.debug("address = {}", addressMap);
		
		List<Coupon> couponList = purchaseService.getUserCouponList(userId);
		log.debug("couponList = {}", couponList);
		model.addAttribute("couponList", couponList);
	}
	
	@PostMapping("/updateCouponStatus")
	public ResponseEntity<?> updateCouponStatus(@RequestParam String couponCode) {
		
		int result = purchaseService.updateCouponStatus(couponCode);
		
		return ResponseEntity.ok(result);
	}
	
	@PostMapping("/addAcc")
	public ResponseEntity<?> addAcc(@RequestParam String userId, @RequestParam String puid, @RequestParam int amount, @RequestParam String div){
		log.debug("userId, puid = {}, {}", userId, puid);
		log.debug("amount, div = {}, {}", amount, div);
		
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("puid", puid);
		param.put("amount", amount);
		param.put("div", div);
		
		int result = purchaseService.addAcc(param);
		
		return ResponseEntity.ok(result);
	}
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	PropertyEditor editor = new CustomDateEditor(sdf, true);
    	binder.registerCustomEditor(Date.class, editor);
    }
	
}
