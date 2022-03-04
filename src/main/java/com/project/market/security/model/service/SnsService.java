package com.project.market.security.model.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.extern.slf4j.Slf4j;

import java.io.*;
import java.net.URL;
import org.springframework.stereotype.Service;

import java.net.HttpURLConnection;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

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
            String pw = UUID.randomUUID().toString().replace("-","");
            pw += id;

            map.put("id", id);
            map.put("password", pw);
        }catch(IOException e){
            log.error(e.getMessage(), e);
        }

        return map;
    }

}
