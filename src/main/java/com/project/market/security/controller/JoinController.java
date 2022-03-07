package com.project.market.security.controller;

import com.project.market.security.model.service.JoinService;
import com.project.market.security.model.service.SmsService;
import com.project.market.security.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestParam;

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

    @PostMapping("/join")
    public String join(Member member){

        return null;
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
        try{
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
        }

        return ResponseEntity.ok(infoPhone);
    }

}
