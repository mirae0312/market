package com.project.market.security.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.security.core.parameters.P;

import java.util.Properties;

@Configuration
@PropertySource("classpath:email.properties")
public class EmailConfig {

    @Value("${mail.smtp.auth}")
    private boolean auth;

    @Value("${mail.smtp.starttls.required}")
    private boolean startllsRequired;

    @Value("${mail.smtp.starttls.enable}")
    private boolean starttls;

    @Value("${mail.smtp.socketFacotry.fallback}")
    private boolean fallback;

    @Value("${mail.smtp.port}")
    private int port;

    @Value("${mail.smtp.socketFactory.port}")
    private int socketPort;

    @Value("${admin.mail.id}")
    private String id;

    @Value("${admin.mail.password}")
    private String password;

    @Bean
    public JavaMailSender javaMailSender(){
        JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
        javaMailSender.setHost("smtp.gmail.com");
        javaMailSender.setUsername(id);
        javaMailSender.setPassword(password);
        javaMailSender.setPort(port);
        javaMailSender.setJavaMailProperties(getMailProperties());
        javaMailSender.setDefaultEncoding("UTF-8");
        return javaMailSender;
    }

    private Properties getMailProperties(){
        Properties prop = new Properties();
        prop.put("mail.smtp.socketFactory.port", socketPort);
        prop.put("mail.smtp.auth", auth);
        prop.put("mail.smtp.starttls.enable", starttls);
        prop.put("mail.smtp.starttls.required", startllsRequired);
        prop.put("mail.smtp.socketFactory.fallback", fallback);
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        return prop;
    }
}
