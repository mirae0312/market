package com.project.market.purchase.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PaymentsPurchase extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@PostMapping("/purchase/payments")
	private ResponseEntity<?> doPost(@RequestParam String impUid, @RequestParam String merchantUid, @RequestParam int amountToBePaid) throws ServletException, IOException {
		URL url = new URL("https://api.iamport.kr/users/getToken");
		HttpURLConnection con = (HttpURLConnection)url.openConnection();

		con.setRequestMethod("POST");
		con.setRequestProperty("Content-Type", "application/json; utf-8");
		con.setRequestProperty("Accept", "application/json");
		con.setDoOutput(true);
		
		String jsonInputString = "{\"imp_key\": \"3102689863625731\", \"imp_secret\": \"e4568ee8b5be247f55457ea7ae9d453569fc24ed358481bbcfc8ed4fcfefe6ec2a3f114e0988fe40\"}";
		
		try(OutputStream os = con.getOutputStream()){
			byte[] input = jsonInputString.getBytes("utf-8");
			os.write(input, 0, input.length);
		}

		String requestString = "";
		StringBuilder responseData = new StringBuilder();
		try(BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"))) {
			String responseLine = null;
			while((responseLine = br.readLine()) != null) {
				responseData.append(responseLine.trim());
			}
			requestString = responseData.toString();
		}
		
		con.disconnect();
		
		JSONParser jsonParser = new JSONParser();
		String token = "";
		try {
			JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
			JSONObject getToken = (JSONObject) jsonObj.get("response");
			token = (String) getToken.get("access_token");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		url = new URL("https://api.iamport.kr/payments/"+impUid);
		con = (HttpURLConnection)url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Authorization", token);
		con.setDoOutput(true);
		
		StringBuilder responseData2 = new StringBuilder();
		try(BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"))) {
			String responseLine = null;
			while((responseLine = br.readLine()) != null) {
				responseData2.append(responseLine.trim());
			}
			requestString = responseData2.toString();
		}
		con.disconnect();
		
		Map<String, Object> map = new HashMap<>();
		try {
			JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
			JSONObject getRes = (JSONObject) jsonObj.get("response");
			long amount = (long)getRes.get("amount");
			String status = (String) getRes.get("status");
			
			if(amount == (long)amountToBePaid && status.equals("paid")) {
				map.put("msg", "결제 성공");
			} else {
				map.put("msg", "결제 실패(위변조 데이터)");
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return ResponseEntity.ok(map);
	}
}
