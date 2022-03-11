package com.project.market.myPage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.market.myPage.model.service.MyPageService;
import com.project.market.myPage.model.vo.Coupon;
import com.project.market.myPage.model.vo.UserCoupon;
import com.project.market.security.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mypage")
public class MyPageController {
	
	@Autowired
	private MyPageService mypageService;
	
	@GetMapping("/myPage")
	public void myPage(){
		
	}
	
	//public ResponseEntity<?> useCoupon(@RequestParam String writeCoupon, @AuthenticationPrincipal Member member)
	//{
		
	//	return ResponseEntity.ok();
	//}

}
