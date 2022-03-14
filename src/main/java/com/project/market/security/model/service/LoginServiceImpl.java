package com.project.market.security.model.service;

import com.project.market.security.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.market.security.model.dao.LoginDao;

import java.util.Map;

@Service
public class LoginServiceImpl implements LoginService{

    @Autowired
    private LoginDao loginDao;

    @Override
    public Member selectOneMemberById(Map<String, Object> kakaoUser) {
        return loginDao.selectOneMemberById(kakaoUser);
    }

    @Override
    public Member selectOneMemberForFind(Map<String, Object> check) {
        return loginDao.selectOneMemberForFind(check);
    }

    @Override
    public void updatePassword(Map<String, Object> param) {
        loginDao.updatePassword(param);
    }
}
