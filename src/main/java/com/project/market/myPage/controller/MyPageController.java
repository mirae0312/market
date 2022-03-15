package com.project.market.myPage.controller;

import java.beans.PropertyEditor;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.market.myPage.model.service.MyPageService;
import com.project.market.myPage.model.vo.UserCoupon;
import com.project.market.purchase.model.vo.Coupon;
import com.project.market.security.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mypage")
public class MyPageController {
	
	@Autowired
	private MyPageService myPageService;
	
	@GetMapping("/myPage")
	public void myPage(@AuthenticationPrincipal Member member,Model model) throws ParseException{
		String userId = member.getId();
		log.debug("userId = {}", userId);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date currentTime = new Date();
		String date = format.format(currentTime);
		Date nowDate = format.parse(date);
		
		List<Map<String, Object>> couponList = myPageService.selectuserCoupon(userId);
		log.debug("couponList = {}", couponList);
		model.addAttribute("couponList", couponList);
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("userId", userId);
	}
	
	
	@GetMapping("/useCoupon")
	public ResponseEntity<?> useCoupon(@RequestParam String writeCoupon, @AuthenticationPrincipal Member member) throws ParseException
	{
		int result = 0;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date currentTime = new Date();
		String date = format.format(currentTime);
		Date nowDate = format.parse(date);
		
		String userId = member.getId();
		log.debug("userId = {}", userId);
		
		Coupon coupon = myPageService.selectCoupon(writeCoupon);
		
		if(coupon != null) {
			String checkcoupon = coupon.getCode();
			Date checkexpiration = coupon.getExpiration();
			log.debug("checkcoupon = {}", checkcoupon);
			log.debug("checkexpiration = {}", checkexpiration);
			Map<String, Object> param = new HashMap<>();
			param.put("id",userId);
			param.put("code",checkcoupon);
			int compare = checkexpiration.compareTo(nowDate);
			if(compare >= 0)
			{
				log.debug("compare = {}", compare);
				int insertresult = myPageService.insertUserCoupon(param);
				log.debug("insertresult = {}", insertresult);
				result = 2;
			}
			else {
				log.debug("compare = {}", "실패");
				result = 1;
			}
			
			
		}
		
		
		return ResponseEntity.ok(result);
	}
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	PropertyEditor editor = new CustomDateEditor(sdf, true);
    	binder.registerCustomEditor(Date.class, editor);
    }

}
