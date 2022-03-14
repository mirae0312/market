package com.project.market.security.controller;

import com.project.market.security.model.service.LoginService;
import com.project.market.security.model.service.SecurityService;
import com.project.market.security.model.service.SnsService;
import com.project.market.security.model.vo.Member;
import lombok.extern.slf4j.Slf4j;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
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
import java.util.UUID;

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
    
    @GetMapping("/findId")
    public void findId(){}
    
    @GetMapping("/findPwd")
    public void findPwd(){}

    @Value("${kakao.login.url}")
    private String kakaoLoginUrl;

    @Value("${kakao.client.id}")
    private String kakaoClientId;

    @Value("${kakao.redirect.uri}")
    private String kakaoRedirectUri;

    @Value("${google.login.url}")
    private String googleLoginUrl;

    @Value("${google.client.id}")
    private String googleClientId;

    @Value("${google.redirect.uri}")
    private String googleRedirectUri;

    @Value("${naver.login.url}")
    private String naverLoginUrl;

    @Value("${naver.client.id}")
    private String naverClientId;

    @Value("${naver.redirect.uri}")
    private String naverRedirectUri;

    @GetMapping("/login2")
    public void login2(){}

    @GetMapping("/snsLogin/{type}")
    public String snsLogin(@PathVariable(name = "type") String type){

        String state = UUID.randomUUID().toString().replace("-","").substring(0, 10);

        String reqUrl = "";
        switch(type){
            case "google": reqUrl = googleLoginUrl + "/o/oauth2/v2/auth?client_id=" + googleClientId + "&redirect_uri=" + googleRedirectUri +
                    "&response_type=code&scope=email%20profile%20openid&access_type=offline"; break;
            case "kakao": reqUrl = kakaoLoginUrl + "?client_id=" + kakaoClientId + "&redirect_uri=" + kakaoRedirectUri + "&response_type=code"; break;
            case "naver": reqUrl = naverLoginUrl + "?response_type=code&client_id=" + naverClientId + "&state = " + state + "&redirect_uri=" + naverRedirectUri; break;
        }

        return "redirect:" + reqUrl;
    }

    @GetMapping("/kakaoLogin")
    public String kakaoLogin(@RequestParam(value = "code", required = false) String code, RedirectAttributes redirectAttr){
        log.debug("kakao code = {}", code);
        String type = "kakao";
        Map<String, Object> kakaoUser = snsService.getSnsAccessToken(code, type);
        log.debug("kakaoUser info = {}", kakaoUser);
        return snsLoginCommons(kakaoUser, redirectAttr);
    }

    @GetMapping("/naverLogin")
    public String naverLogin(@RequestParam(value = "code", required = false) String code, RedirectAttributes redirectAttr){
        log.debug("naver code = {}", code);
        String type = "naver";
        Map<String, Object> naverUser = snsService.getSnsAccessToken(code, type);
        log.debug("naverUser info = {}", naverUser);
        return snsLoginCommons(naverUser, redirectAttr);
    }

    @GetMapping("/googleLogin")
    public String googleLogin(@RequestParam(value = "code", required = false) String code, RedirectAttributes redirectAttr){
        log.debug("google code = {}", code);
        String type = "google";
        Map<String, Object> googleUser = snsService.getSnsAccessToken(code, type);
        log.debug("googleUser = {}", googleUser);
        return snsLoginCommons(googleUser, redirectAttr);
    }

    @GetMapping("/certifiedNum")
    public ResponseEntity<?> certifiedNum(@RequestParam Map<String, Object> check){
        log.debug("check = {}", check);
        Member member = loginService.selectOneMemberForFind(check);
        if(member != null){
            String rNum = UUID.randomUUID().toString().replace("-","").substring(0, 6);
            check.put("num", rNum);
            snsService.sendCertifiedNum(check);
        }else{
            check.put("msg", "등록되지 않은 정보입니다.");
            return ResponseEntity.ok(check);
        }
        return ResponseEntity.ok(1);
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