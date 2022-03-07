package com.project.market.security.model.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.extern.slf4j.Slf4j;

import java.io.*;
import java.net.URL;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.net.HttpURLConnection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Slf4j
public class SnsService {

    public Map<String, Object> getKakaoAccessToken(String authorize_code){

        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=2ae5bd0deaf271ba341cbf761624570d");
            sb.append("&redirect_uri=http://localhost:10000/market/login/kakaoLogin");
            sb.append("&code=" + authorize_code);
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

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            log.debug("access_token = {} refresh_token = {}", access_Token, refresh_Token);

            br.close();
            bw.close();
        }catch (IOException e){
            log.error(e.getMessage(), e);
        }

        return getKakaoUserInfo(access_Token);
    }

    public Map<String, Object> getKakaoUserInfo(String access_Token){
        Map<String, Object> map = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";

        try{
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
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

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            String id = element.getAsJsonObject().get("id").getAsString();
            id += "kakao";
            String pw = pwMaker(id);

            map.put("id", id);
            map.put("password", pw);
            map.put("type", "kakao");
        }catch(IOException e){
            log.error(e.getMessage(), e);
        }

        return map;
    }

    public Map<String, Object> getGoogleUser(String authorize_code, String googleClientId, String googleSecret, String googleAuthUrl){
        try {
            URL url = new URL(googleAuthUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setDoOutput(true);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=" + googleClientId);
            sb.append("&client_secret=" + googleSecret);
            sb.append("&redirect_uri=http://localhost:10000/market/login/googleLogin");
            sb.append("&code=" + authorize_code);
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

//            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
//            Map<String, Object> params = new HashMap<>();
//            params.put("code", Collections.singletonList(authorize_code));
//            params.put("client_id", Collections.singletonList(googleClientId));
//            params.put("client_secret", Collections.singletonList(googleSecret));
//            params.put("redirect_uri", Collections.singletonList("http://localhost:10000/market/login/googleLogin"));
//            params.put("grant_type", Collections.singletonList("authorization_code"));
//
//            String parameterString = params.entrySet().stream()
//                    .map(x -> x.getKey() + "=" + x.getValue())
//                    .collect(Collectors.joining("&"));
//
//            BufferedOutputStream bous = new BufferedOutputStream(conn.getOutputStream());
//            bous.write(parameterString.getBytes());
//            bous.flush();
//            bous.close();
//
//            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//
//            StringBuilder sb = new StringBuilder();
//            String line;
//
//            while ((line = br.readLine()) != null) {
//                sb.append(line);
//            }
//
//            if (conn.getResponseCode() == 200) {
//                log.debug("success = {}", sb.toString());
//            }
//            log.debug("fail");
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }

        return null;
    }

    protected String pwMaker(String id){
        String rndStr = UUID.randomUUID().toString().replace("-","");
        String pw = rndStr.substring(0, 10) + id;
        return pw;
    }

}
