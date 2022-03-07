package com.project.market.security.model.service;

import com.project.market.security.model.vo.Member;

import java.util.Map;

public interface JoinService {
    Member selectDuplicate(Map<String, Object> param);
}
