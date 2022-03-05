package com.project.market.security.controller;

import com.project.market.security.model.service.LoginService;
import com.project.market.security.model.service.SecurityService;
import com.project.market.security.model.service.SnsService;
import com.project.market.security.model.vo.Member;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private LoginService loginService;

    @Autowired
    private SnsService snsService;

    @GetMapping("/snsEnroll")
    public void snsEnroll(){}

    @GetMapping("/login")
    public void login(){}

    @GetMapping("/kakaoLogin")
    public String kakaoLogin(@RequestParam(value = "code", required = false) String code, RedirectAttributes redirectAttr){
        log.debug("kakao code = {}", code);
        Map<String, Object> kakaoUser = snsService.getKakaoAccessToken(code);
        log.debug("kakaoUser id = {}", kakaoUser);
        String id = (String) kakaoUser.get("id");

        // db 확인
        Member member = loginService.selectOneMemberById(kakaoUser);
        log.debug("member = {}", member);
        if(member == null){
            // null인 경우 회원가입
            // flashAttribute는 세션을 통해 전달하므로 주소창에 파라미터가 보이지 않는다.
            redirectAttr.addFlashAttribute("id", id);
            redirectAttr.addFlashAttribute("type", "kakao");
            return "redirect:/login/snsEnroll";
        }else{
            Authentication kakaoUserInfo = new UsernamePasswordAuthenticationToken(member.getId(), (String) kakaoUser.get("password"));
            Authentication authentication = authenticationManager.authenticate(kakaoUserInfo);
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        log.debug("success");
        return "redirect:/";
    }

}
