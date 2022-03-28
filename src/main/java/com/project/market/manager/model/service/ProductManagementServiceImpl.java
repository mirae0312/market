package com.project.market.manager.model.service;

import com.project.market.manager.model.dao.ProductManagementDao;
import com.project.market.manager.model.vo.ProductAttachment;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
@Slf4j
public class ProductManagementServiceImpl implements ProductManagementService {

    @Autowired
    private ProductManagementDao productManagementDao;

    @Override
    public int insertProduct(Map<String, Object> data) {
        int result = productManagementDao.insertProduct(data);
        log.debug("pCode = {}", data.get("pCode"));
        String pCode = (String) data.get("pCode");
        result = insertProductInfo(data);
        result = insertProductPrice(data);
        result = insertProductStock(data);

        List<ProductAttachment> attach = (List<ProductAttachment>) data.get("attachments");
        attach.get(0).setPCode(pCode);

        Map<String, Object> map = new HashMap<>();
        map.put("pCode", attach.get(0).getPCode());
        map.put("originalFilename", attach.get(0).getOriginalFilename());
        map.put("renamedFilename", attach.get(0).getRenamedFilename());
        log.debug("map = {}", map);
        result = insertAttachment(map);

        return result;
    }

    private int insertProductStock(Map<String, Object> data) {
        return productManagementDao.insertProductStock(data);
    }

    private int insertAttachment(Map<String, Object> data) {
        return productManagementDao.insertAttachment(data);
    }

    private int insertProductPrice(Map<String, Object> data) {
        return productManagementDao.insertProductPrice(data);
    }

    private int insertProductInfo(Map<String, Object> data) {
        return productManagementDao.insertProductInfo(data);
    }
}
