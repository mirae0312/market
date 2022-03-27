package com.project.market.productService.model.dao;

import com.project.market.productService.model.vo.ProductReview;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProductServiceDao {

    ProductReview selectBestProductReview(Map<String, Object> boardCode);

    List<ProductReview> selectFirstPageProductReview(Map<String, Object> boardCode);

    int countAllProductReview(Map<String, Object> boardCode);

    @Select("select name from mk_member where id = #{writer}")
    String selectWriterName(Map<String, Object> param);

    @Select("select grade from mk_grade where id = #{writer}")
    String selectWriterGrade(Map<String, Object> param);

    List<ProductReview> selectAllProductReview(Map<String, Object> boardCode, RowBounds rowBounds);

    @Update("update mk_product_review set read_count = read_count + 1 where no = #{code}")
    void updateProductReviewReadCount(Map<String, Object> boardCode);

    @Select("select * from mk_product_review where announce = 'A' order by reg_date desc")
    List<ProductReview> selectProductReviewAnnounce();

    @Select("select * from mk_product_review where no = #{no}")
    ProductReview selectOneProductReview(Map<String, Object> param);

    void insertProductReview(ProductReview productReview);

    @Update("update mk_product_review set title = #{title}, content = #{content}, reg_date = sysdate where no = #{no}")
    void updateProductReview(ProductReview productReview);

    @Delete("delete from mk_product_review where no = #{no}")
    void deleteProductReview(Map<String, Object> boardCode);

    @Update("update mk_product_review set likes = likes + 1 where no = #{no}")
    void updateProductReviewPlusLikes(Map<String, Object> param);

    @Select("select count(*) from mk_review_likes where no = #{no}")
    int countBoardLikes(int no);
}
