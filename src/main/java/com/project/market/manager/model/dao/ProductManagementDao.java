package com.project.market.manager.model.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface ProductManagementDao {

    int insertProduct(Map<String, Object> data);

    int insertProductInfo(Map<String, Object> data);

    int insertProductPrice(Map<String, Object> data);

    int insertAttachment(Map<String, Object> data);

    int insertProductStock(Map<String, Object> data);
}
