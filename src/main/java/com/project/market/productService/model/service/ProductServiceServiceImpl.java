package com.project.market.productService.model.service;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.dao.CustomerServiceDao;
import com.project.market.productService.model.dao.ProductServiceDao;
import com.project.market.productService.model.vo.ProductReview;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
@Transactional
public class ProductServiceServiceImpl implements ProductServiceService {

    @Autowired
    private ProductServiceDao productServiceDao;

    @Autowired
    private CustomerServiceDao customerServiceDao;

    @Override
    public List<ProductReview> selectFirstPageProductReview(Map<String, Object> boardCode) {
        List<ProductReview> prList = productServiceDao.selectFirstPageProductReview(boardCode);
        for(ProductReview pr : prList){
            pr.setLikes(countLikes(pr.getNo()));
            Map<String, Object> param = selectNameAndGrade(pr.getWriter());
            if(param.get("name") != null && param.get("grade") != null){
                pr.setName((String) param.get("name"));
                pr.setGrade((String) param.get("grade"));
            }
            param.put("code", makeCode(pr.getNo()));
            List<Attachment> attachments = customerServiceDao.selectAllAttachments(param);
            pr.setAttachments(attachments);
        }
        return prList;
    }

    @Override
    public ProductReview selectBestProductReview(Map<String, Object> boardCode) {
        ProductReview pr = productServiceDao.selectBestProductReview(boardCode);
        pr.setLikes(countLikes(pr.getNo()));
        Map<String, Object> param = selectNameAndGrade(pr.getWriter());
        if(param.get("name") != null && param.get("grade") != null){
            pr.setName((String) param.get("name"));
            pr.setGrade((String) param.get("grade"));
        }
        param.put("code", makeCode(pr.getNo()));
        List<Attachment> attachments = customerServiceDao.selectAllAttachments(param);
        pr.setAttachments(attachments);
        return pr;
    }

    @Override
    public List<ProductReview> selectProductReviewAnnounce() {
        return productServiceDao.selectProductReviewAnnounce();
    }

    @Override
    public int countAllProductReview(Map<String, Object> boardCode) {
        return productServiceDao.countAllProductReview(boardCode);
    }

    @Override
    public List<ProductReview> selectAllProductReview(RowBounds rowBounds, Map<String, Object> boardCode) {
        List<ProductReview> prList = productServiceDao.selectAllProductReview(boardCode, rowBounds);
        for(ProductReview pr : prList){
            pr.setLikes(countLikes(pr.getNo()));
            Map<String, Object> param = selectNameAndGrade(pr.getWriter());
            if(param.get("name") != null && param.get("grade") != null){
                pr.setName((String) param.get("name"));
                pr.setGrade((String) param.get("grade"));
            }
            param.put("code", makeCode(pr.getNo()));
            List<Attachment> attachments = customerServiceDao.selectAllAttachments(param);
            pr.setAttachments(attachments);
        }
        return prList;
    }

    @Override
    public void updateProductReviewReadCount(Map<String, Object> boardCode) {
        productServiceDao.updateProductReviewReadCount(boardCode);
    }

    @Override
    public ProductReview selectOneProductReview(Map<String, Object> boardCode) {
        ProductReview productReview = productServiceDao.selectOneProductReview(boardCode);
        productReview.setLikes(countLikes(productReview.getNo()));
        Map<String, Object> param = selectNameAndGrade(productReview.getWriter());
        if(param.get("name") != null && param.get("grade") != null){
            productReview.setName((String) param.get("name"));
            productReview.setGrade((String) param.get("grade"));
        }
        param.put("code", makeCode(productReview.getNo()));
        List<Attachment> attachments = customerServiceDao.selectAllAttachments(param);
        productReview.setAttachments(attachments);
        return productReview;
    }

    @Override
    public void insertProductReview(ProductReview productReview) {
        productServiceDao.insertProductReview(productReview);
        List<Attachment> attachments = productReview.getAttachments();
        commonAttachInsert(makeCode(productReview.getNo()), attachments);
    }

    @Override
    public void modifyProductReview(ProductReview productReview) {
        productServiceDao.updateProductReview(productReview);
        if(!productReview.getAttachments().isEmpty()){
            List<Attachment> attachments = productReview.getAttachments();
            commonAttachInsert(makeCode(productReview.getNo()), attachments);
        }
    }

    @Override
    public void deleteProductReview(Map<String, Object> boardCode) {
        productServiceDao.deleteProductReview(boardCode);
    }

    @Override
    public void updateProductReviewPlusLikes(Map<String, Object> param) {
        productServiceDao.updateProductReviewPlusLikes(param);
    }

    private void commonAttachInsert(String code, List<Attachment> attachments){
        if(attachments != null){
            for(Attachment attach : attachments){
                attach.setCode(code);
                insertAttachment(attach);
            }
        }
    }

    private int countLikes(int no){
        return productServiceDao.countBoardLikes(no);
    }

    private Map<String, Object> selectNameAndGrade(String writer){
        Map<String, Object> param = new HashMap<>();
        param.put("writer", writer);
        String name = productServiceDao.selectWriterName(param);
        String grade = productServiceDao.selectWriterGrade(param);
        param.put("name", name);
        param.put("grade", grade);
        return param;
    }

    public void insertAttachment(Attachment attach){
        customerServiceDao.insertAttachment(attach);
    }

    private String makeCode(int no){
        return "prre-" + no;
    }
}
