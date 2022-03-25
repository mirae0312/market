package com.project.market.security.model.dao;

import com.project.market.security.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

import java.util.Map;

@Mapper
public interface JoinDao {

    Member selectDuplicate(Map<String, Object> param);

    void insertMember(Member member);

    void insertRole(Member member);

    void insertGrade(Member member);

    void insertWelcomCoupon(Member member);
}
