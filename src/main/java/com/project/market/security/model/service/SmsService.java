package com.project.market.security.model.service;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import net.nurigo.sdk.message.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@Slf4j
@Service
@PropertySource("classpath:sms.properties")
public class SmsService {

    @Value("${cool.sms.from}")
    private String from;

    private DefaultMessageService messageService;

    private Properties prop = new Properties();

    public SmsService() throws IOException {
        File filepage = new File(MessageService.class.getResource("/sms.properties").getPath());
        try{
            prop.load(new FileReader(filepage));
        }catch(IOException e){
            log.error(e.getMessage(), e);
            throw e;
        }
        this.messageService = NurigoApp.INSTANCE.initialize(prop.getProperty("cool.sms.apiKey"), prop.getProperty("cool.sms.apiKeySecret"), prop.getProperty("cool.sms.url"));
    }

    @PostMapping("/send-one")
    public void sendSms(Map<String, Object> param){
        Message sms = new Message();
        sms.setFrom(from);
        sms.setTo((String)param.get("phone"));
        sms.setText((String)param.get("text"));
        log.debug("last param = {}", param);
        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(sms));
        log.debug("sms response = {}", response);
    }

    public void sendCheckNum(Map<String, Object> param){
        String text = "[market] 인증번호입니다. [" + (String) param.get("num") + "]";
        param.put("text", text);
        sendSms(param);
    }

}
