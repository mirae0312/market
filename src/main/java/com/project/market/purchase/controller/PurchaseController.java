package com.project.market.purchase.controller;

import java.beans.PropertyEditor;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.market.purchase.model.service.PurchaseService;
import com.project.market.purchase.model.vo.Coupon;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/purchase")
public class PurchaseController {
	
	@Autowired
	private PurchaseService purchaseService;
	
	
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
	public void orderPage(@RequestParam List<String> orderArr) {
		for(String pdt : orderArr) {
			log.debug("pdt = {}", pdt);
		}
		
		
	}
	
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	PropertyEditor editor = new CustomDateEditor(sdf, true);
    	binder.registerCustomEditor(Date.class, editor);
    }
	
}
