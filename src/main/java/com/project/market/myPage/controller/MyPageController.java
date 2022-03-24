package com.project.market.myPage.controller;

import java.beans.PropertyEditor;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.market.myPage.model.service.MyPageService;
import com.project.market.myPage.model.vo.UserCoupon;
import com.project.market.purchase.model.vo.Coupon;
import com.project.market.security.model.service.LoginService;
import com.project.market.security.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mypage")
public class MyPageController {
	
	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private AuthenticationManager authenticationManager;
	 
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
    private LoginService loginService;
	
	@GetMapping("/myPage")
	public void myPage(@AuthenticationPrincipal Member member,Model model) throws ParseException{
		String userId = member.getId();
		log.debug("userId = {}", userId);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date currentTime = new Date();
		String date = format.format(currentTime);
		Date nowDate = format.parse(date);
		
		List<Map<String, Object>> couponList = myPageService.selectuserCoupon(userId);
		List<Map<String, Object>> addressList = myPageService.selectmkAddress(userId);
		log.debug("couponList = {}", couponList);
		log.debug("addressList = {}", addressList);
		model.addAttribute("couponList", couponList);
		model.addAttribute("addressList", addressList);
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
	
	@GetMapping("/addAddr")
	public ResponseEntity<?> addAddr(@RequestParam String member_post, @RequestParam String member_addr, @RequestParam String member_detail_addr, @AuthenticationPrincipal Member member) throws ParseException
	{
		int result = 0;
		String id = member.getId();
		String phone = member.getPhone();
		String receiver = member.getName();
		String deliveryType1 = "샛별배송";
		String deliveryType2 = "택배배송";
		char defAdd1 = 'X';
		char defAdd2 = 'D';
		
		Map<String, Object> checkParam = new HashMap<>();
		checkParam.put("id", id);
		checkParam.put("defaultAddress", defAdd2);
		
		int addressCheck = myPageService.selectmkAddressCheck(checkParam);
		
		log.debug("addressCheck = {}", addressCheck);
		
		LinkedHashMap<String, Object> param = new LinkedHashMap<>();
		
	
		
		param.put("id", id);
		param.put("zipCode", member_post);
		param.put("address", member_addr);
		param.put("detailAddress", member_detail_addr);
		
		if(member_addr.substring(0,2).equals("서울")) 
		{
			param.put("deliveryType", deliveryType1);
		}
		else 
		{
			param.put("deliveryType", deliveryType2);
		}
		
		param.put("receiver", receiver);
		param.put("phone", phone);
		if(addressCheck == 0) {
			param.put("defaultAddress", defAdd2);
		}
		else if(addressCheck == 1) {
			
			param.put("defaultAddress", defAdd1);
		}
		
		log.debug("param = {}", param);
		int insertresult = myPageService.insertAddress(param);
		log.debug("insertresult = {}", insertresult);
		
		return ResponseEntity.ok(insertresult);
	}
	
	@GetMapping("/updateAddr")
	public ResponseEntity<?> updateAddr(@RequestParam String changeaddr, @AuthenticationPrincipal Member member) throws ParseException
	{
		int result = 0;
		log.debug("changeaddr = {}", changeaddr);
		
		return ResponseEntity.ok(result);
	}
	
	@PostMapping("/changePw")
	public ResponseEntity<?> changePw(@RequestParam String changePw, @AuthenticationPrincipal Member member) throws ParseException
	{
		int result = 0;
		log.debug("changePw = {}", changePw);
		  try{
	          
	            String password = bCryptPasswordEncoder.encode(changePw);
	            param.put("password", password);
	            loginService.updatePassword(param);
	          
	        }catch(Exception e){
	            log.error(e.getMessage(), e);
	            throw e;
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
