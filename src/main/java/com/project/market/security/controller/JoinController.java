package com.project.market.security.controller;

import com.project.market.security.model.service.JoinService;
import com.project.market.security.model.service.LoginService;
import com.project.market.security.model.service.SmsService;
import com.project.market.security.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import lombok.extern.slf4j.Slf4j;

import java.beans.PropertyEditor;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@Slf4j
@RequestMapping("/join")
public class JoinController {
	
    @GetMapping("/join")
    public void join(){}

    @GetMapping("/join2")
    public void join2(){}

    @Autowired
    private JoinService joinService;

    @Autowired
    private SmsService smsService;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @PostMapping("/join")
    public String join(Member member){
        try{
            log.debug("member = {}", member);
            String encodedPassword = bCryptPasswordEncoder.encode(member.getPassword());
            member.setPassword(encodedPassword);

            joinService.insertMember(member);

        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return "redirect:/login/login";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder){
        try{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            PropertyEditor editor = new CustomDateEditor(sdf, true);
            binder.registerCustomEditor(Date.class, editor);
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
    }

    @GetMapping("/checkDuplicate")
    public ResponseEntity<?> checkDuplicate(@RequestParam Map<String, Object> checkDuplicate){
        try{
            log.debug("duplicate param = {}", checkDuplicate);

            Member member = joinService.selectDuplicate(checkDuplicate);
            boolean available = member == null;
            checkDuplicate.put("available", available);
            log.debug("available = {}", checkDuplicate);
        }catch (Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }

        return ResponseEntity.ok(checkDuplicate);
    }

    @GetMapping("/checkPhone")
    public ResponseEntity<?> checkPhone(@RequestParam Map<String, Object> infoPhone){
        /*try{
            log.debug("phone = {}", infoPhone);

            infoPhone.put("type", "phone");
            Member member = joinService.selectDuplicate(infoPhone);
            if(member != null){
                infoPhone.put("available", false);
                return ResponseEntity.ok(infoPhone);
            }

            String rnd = UUID.randomUUID().toString().replaceAll("[^0-9]","").substring(0,6);
            infoPhone.put("num", rnd);
            smsService.sendCheckNum(infoPhone);
            infoPhone.put("available", true);
        }catch (Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }*/

        return ResponseEntity.ok(infoPhone);
    }

}
