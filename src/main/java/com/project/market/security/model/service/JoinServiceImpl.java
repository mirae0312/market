package com.project.market.security.model.service;

import com.project.market.security.model.dao.JoinDao;
import com.project.market.security.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@Transactional
public class JoinServiceImpl implements JoinService {

    @Autowired
    private JoinDao joinDao;

    @Override
    public Member selectDuplicate(Map<String, Object> param) {
        return joinDao.selectDuplicate(param);
    }

    @Override
    public void insertMember(Member member) {
        joinDao.insertMember(member);
        joinDao.insertRole(member);
    }
}
