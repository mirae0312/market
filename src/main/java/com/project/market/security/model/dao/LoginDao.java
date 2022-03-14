package com.project.market.security.model.dao;

import com.project.market.security.model.vo.Member;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import java.util.Map;

@Mapper
public interface LoginDao {
    Member selectOneMemberById(Map<String, Object> kakaoUser);

    Member selectOneMemberForFind(Map<String, Object> check);

    @Update("update mk_member set password = #{password} where id = #{id}")
    void updatePassword(Map<String, Object> param);
}
