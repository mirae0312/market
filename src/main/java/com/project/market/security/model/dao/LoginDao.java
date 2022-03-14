package com.project.market.security.model.dao;

import com.project.market.security.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface LoginDao {
    Member selectOneMemberById(Map<String, Object> kakaoUser);

    Member selectOneMemberForFind(Map<String, Object> check);
}
