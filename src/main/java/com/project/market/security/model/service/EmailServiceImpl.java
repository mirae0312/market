package com.project.market.security.model.service;

import com.project.market.security.model.vo.CheckType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Map;

@Service
@Slf4j
@PropertySource("classpath:email.properties")
public class EmailServiceImpl implements EmailService {

    @Autowired
    private JavaMailSender emailSender;

    @Value("${admin.mail.id}")
    private String id;

    private MimeMessage createMessage(Map<String, Object> param) throws Exception {
        log.debug("param = {}", param);
        String type = (String) param.get("checkType");
        String to = (String) param.get("email");
        String num = (String) param.get("num");
        MimeMessage message = emailSender.createMimeMessage();

        message.addRecipients(MimeMessage.RecipientType.TO, to);
        if(CheckType.IE.toString().equals(type)){
            message.setSubject("[Market] id찾기 인증번호 이메일");            
        }else if(CheckType.PE.toString().equals(type)){
            message.setSubject("[Market] 비밀번호 찾기 인증번호 이메일");
        }

        String msg = "";
        msg += "<div>";
        msg += "<h1>안녕하세요 Market 입니다.</h1>";
        msg += "<br>";
        msg += "<p>아래 인증번호를 입력해주세요</p>";
        msg += "<br>";
        msg += "<strong>Code : </strong>" + num;
        msg += "</div>";
        message.setText(msg, "utf-8", "html");
        message.setFrom(new InternetAddress(id, "market"));

        return message;
    }

    @Override
    public void sendCheckNum(Map<String, Object> check) throws Exception {
        MimeMessage message = createMessage(check);
        try{
            emailSender.send(message);
            log.debug("send");
        }catch(MailException e){
            log.error(e.getMessage(), e);
            throw e;
        }
    }
}
