package com.project.market.security.model.service;

import java.util.Map;

public interface EmailService {
    void sendCheckNum(Map<String, Object> check) throws Exception;
}
