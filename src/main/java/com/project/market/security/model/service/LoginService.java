package com.project.market.security.model.service;

import com.project.market.security.model.vo.Member;

import java.util.Map;

public interface LoginService {

    Member selectOneMemberById(Map<String, Object> kakaoUser);

    Member selectOneMemberForFind(Map<String, Object> check);

    void updatePassword(Map<String, Object> param);
}
