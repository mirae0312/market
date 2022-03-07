package com.project.market.security.controller;

import com.project.market.security.model.service.LoginService;
import com.project.market.security.model.service.SecurityService;
import com.project.market.security.model.service.SnsService;
import com.project.market.security.model.vo.Member;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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

    @Value("${kakao.login.url}")
    private String kakaoLoginUrl;

    @Value("${kakao.client.id}")
    private String kakaoClientId;

    @Value("${kakao.redirect.uri}")
    private String kakaoRedirectUri;

    @Value("${google.auth.url}")
    private String googleAuthUrl;

    @Value("${google.login.url}")
    private String googleLoginUrl;

    @Value("${google.client.id}")
    private String googleClientId;

    @Value("${google.redirect.uri}")
    private String googleRedirectUri;

    @Value("${google.secret}")
    private String googleSecret;

    @GetMapping("/snsLogin/{type}")
    public String snsLogin(@PathVariable(name = "type") String type){
        String reqUrl = "";
        switch(type){
            case "google": reqUrl = googleLoginUrl + "/o/oauth2/v2/auth?client_id=" + googleClientId + "&redirect_uri=" + googleRedirectUri +
                    "&response_type=code&scope=email%20profile%20openid&access_type=offline"; break;
            case "kakao": reqUrl = kakaoLoginUrl + "?client_id=" + kakaoClientId + "&redirect_uri=" + kakaoRedirectUri + "&response_type=code"; break;
        }

        return "redirect:" + reqUrl;
    }

    @GetMapping("/kakaoLogin")
    public String kakaoLogin(@RequestParam(value = "code", required = false) String code, RedirectAttributes redirectAttr){
        log.debug("kakao code = {}", code);
        Map<String, Object> kakaoUser = snsService.getKakaoAccessToken(code);
        log.debug("kakaoUser info = {}", kakaoUser);
        return snsLoginCommons(kakaoUser, redirectAttr);
    }

    @GetMapping("/googleLogin")
    public String googleLogin(@RequestParam(value = "code", required = false) String code, RedirectAttributes redirectAttr){
        log.debug("google code = {}", code);
        Map<String, Object> googleUser = snsService.getGoogleUser(code, googleSecret, googleClientId, googleAuthUrl);
        log.debug("googleUser = {}", googleUser);
        return snsLoginCommons(googleUser, redirectAttr);
    }

    protected void authenticationPlace(Map<String, Object> userInfoMap){
        Authentication userInfo = new UsernamePasswordAuthenticationToken((String) userInfoMap.get("id"), (String) userInfoMap.get("password"));
        Authentication authentication = authenticationManager.authenticate(userInfo);
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

    public String snsLoginCommons(Map<String, Object> userInfoMap, RedirectAttributes redirectAttr){
        // db 확인
        Member member = loginService.selectOneMemberById(userInfoMap);
        log.debug("member = {}", member);
        if(member == null){
            // null인 경우 회원가입
            // flashAttribute는 세션을 통해 전달하므로 주소창에 파라미터가 보이지 않는다.
            redirectAttr.addFlashAttribute("userInfo", userInfoMap);
            return "redirect:/login/snsEnroll";
        }else{
            authenticationPlace(userInfoMap);
        }
        log.debug("success");
        return "redirect:/";
    }

}
