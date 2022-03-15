package com.project.market.security.model.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.extern.slf4j.Slf4j;

import java.io.*;
import java.net.URL;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.HttpURLConnection;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
@Slf4j
public class SnsService {

    @Value("${kakao.info.url}")
    private String kakaoInfoUrl;

    @Value("${kakao.redirect.uri}")
    private String kakaoRedirectUri;

    @Value("${kakao.token.url}")
    private String kakaoTokenUrl;

    @Value("${google.token.url}")
    private String googleTokenUrl;

    @Value("${google.info.url}")
    private String googleInfoUrl;

    @Value("${google.client.id}")
    private String googleClientId;

    @Value("${google.redirect.uri}")
    private String googleRedirectUri;

    @Value("${google.secret}")
    private String googleSecret;

    @Value("${naver.client.id}")
    private String naverClientId;

    @Value("${naver.info.url}")
    private String naverInfoUrl;

    @Value("${naver.client.secret}")
    private String naverClientSecret;

    @Value("${naver.redirect.uri}")
    private String naverRedirectUri;

    @Value("${naver.token.url}")
    private String naverTokenUrl;

    public Map<String, Object> getSnsAccessToken(String authorize_code, String type){
        String access_Token = "";
        String refresh_Token = "";
        String id_Token = "";
        String reqURL = "";
        switch (type){
            case "kakao": reqURL = kakaoTokenUrl; break;
            case "naver": reqURL = naverTokenUrl; break;
            case "google": reqURL = googleTokenUrl; break;
        }
        try{
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setDoOutput(true);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&code=" + authorize_code);
            if("kakao".equals(type)){
                sb.append("&client_id=2ae5bd0deaf271ba341cbf761624570d");
                sb.append("&redirect_uri=" + kakaoRedirectUri);
            }else if("naver".equals(type)){
                sb.append("&client_id=" + naverClientId);
                sb.append("&client_secret=" + naverClientSecret);
                sb.append("&redirect_uri=" + naverRedirectUri);
            }else if("google".equals(type)){
                log.debug("id = {}", googleClientId);
                log.debug("secret = {}", googleSecret);
                sb.append("&client_id=" + googleClientId);
                sb.append("&client_secret=" + googleSecret);
                sb.append("&redirect_uri=" + googleRedirectUri);
            }
            bw.write(sb.toString());
            bw.flush();

            int responseCode = conn.getResponseCode();
            log.debug("responseCode = {}", responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while((line = br.readLine()) != null){
                result += line;
            }
            log.debug("response body = {}", result);

            JsonElement element = JsonParser.parseString(result);
            if("kakao".equals(type) || "naver".equals(type)){
                access_Token = element.getAsJsonObject().get("access_token").getAsString();
                refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

                log.debug("access_token = {} refresh_token = {}", access_Token, refresh_Token);
            }else{
                access_Token = element.getAsJsonObject().get("access_token").getAsString();
                id_Token = element.getAsJsonObject().get("id_token").getAsString();

                log.debug("access_token = {} id_token = {}", access_Token, id_Token);
            }
            br.close();
            bw.close();
        }catch(Exception e){
            log.error(e.getMessage(), e);
        }
        return getSnsUserInfo(access_Token, type);
    }

    public Map<String, Object> getSnsUserInfo(String access_Token, String type){
        Map<String, Object> map = new HashMap<>();
        String reqURL = "";
        switch (type){
            case "kakao": reqURL = kakaoInfoUrl; break;
            case "naver": reqURL = naverInfoUrl; break;
            case "google": reqURL = googleInfoUrl; break;
        }

        try{
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            log.debug("responseCode = {}", responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while((line = br.readLine()) != null){
                result += line;
            }
            log.debug("response body = {}", result);

            JsonElement element = JsonParser.parseString(result);
            if("kakao".equals(type)){
                String id = element.getAsJsonObject().get("id").getAsString();
                id += "kakao";
                String pw = pwMaker(id);

                map.put("id", id);
                map.put("password", pw);
                map.put("type", "kakao");
            }else if("naver".equals(type)){
                JsonObject properties = element.getAsJsonObject().get("response").getAsJsonObject();

                String email = properties.getAsJsonObject().get("email").getAsString();
                String phone = properties.getAsJsonObject().get("mobile").getAsString().replace("-","");
                String name = properties.getAsJsonObject().get("name").getAsString();
                String id = properties.getAsJsonObject().get("id").getAsString();
                id += "naver";
                String pw = pwMaker(id);

                map.put("email", email);
                map.put("phone", phone);
                map.put("name", name);
                map.put("id", id);
                map.put("password", pw);
                map.put("type", "naver");
            }else if("google".equals(type)){
                String id = element.getAsJsonObject().get("id").getAsString();
                String email = element.getAsJsonObject().get("email").getAsString();
                String name = element.getAsJsonObject().get("name").getAsString();
                id += "google";
                String pw = pwMaker(id);
                map.put("email", email);
                map.put("name", name);
                map.put("id", id);
                map.put("password", pw);
                map.put("type", "google");
            }
            log.debug("user info json = {}", map);
        }catch(Exception e){
            log.error(e.getMessage(), e);
        }
        return map;
    }

    protected String pwMaker(String id){
        String rndStr = UUID.randomUUID().toString().replace("-","");
        String pw = rndStr.substring(0, 10) + id;
        return pw;
    }
}
