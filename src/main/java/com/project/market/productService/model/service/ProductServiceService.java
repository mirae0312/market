package com.project.market.productService.model.service;

import com.project.market.productService.model.vo.ProductReview;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

public interface ProductServiceService {

    List<ProductReview> selectFirstPageProductReview(Map<String, Object> boardCode);

    ProductReview selectBestProductReview(Map<String, Object> boardCode);

    List<ProductReview> selectProductReviewAnnounce();

    int countAllProductReview(Map<String, Object> boardCode);

    List<ProductReview> selectAllProductReview(RowBounds rowBounds, Map<String, Object> boardCode);

    void updateProductReviewReadCount(Map<String, Object> boardCode);

    ProductReview selectOneProductReview(Map<String, Object> param);

    void insertProductReview(ProductReview productReview);

    void modifyProductReview(ProductReview productReview);

    void deleteProductReview(Map<String, Object> boardCode);

    void updateProductReviewPlusLikes(Map<String, Object> param);
}
