package com.project.market.customerService.model.dao;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.vo.*;
import com.project.market.security.model.vo.Member;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface CustomerServiceDao {
    void insertAnnouncement(Announcement announcement);

    void updateAnnouncementReadCount(Map<String, Object> boardCode);

    Announcement selectOneAnnouncement(Map<String, Object> boardCode);

    List<Attachment> selectAllAttachments(Map<String, Object> boardCode);

    List<Announcement> selectAllAnnouncement(RowBounds rowBounds);

    int countAllAnnouncement();

    void insertAttachment(Attachment attach);

    void deleteAnnouncement(Map<String, Object> boardCode);

    void deleteAttachments(Map<String, Object> boardCode);

    void updateAnnouncement(Announcement announcement);

	Map<String, Object> selectUserDefaultAddress(String userId);

	int selectUserAccumulationRate(String userId);

    @Select("select * from mk_question where writer = #{id} order by reg_date desc")
    List<Question> selectAllMyQuestion(Member member, RowBounds rowBounds);

    @Select("select count(*) from mk_question where writer = #{id}")
    int countAllMyQuestion(Member member);

    @Select("select * from mk_question where q_code = #{code}")
    Question selectOneQuestion(Map<String, Object> boardCode);

    @Update("update mk_question set title = #{title}, question_category = #{questionCategory}, receive_email = #{receiveEmail}, receive_phone = #{receivePhone}, content = #{content}, reg_date = sysdate where q_code = #{qCode}")
    void updateQuestion(Question question);

    @Insert("insert into mk_question values(concat('ques-', seq_mk_question_no.nextval), #{title}, #{questionCategory}, null, #{writer}, #{phone}, #{email}, #{receiveEmail}, #{receivePhone}, #{content}, default, null, null, null, null)")
    void insertQuestion(Question question);

    @Delete("delete from mk_question where q_code = #{code}")
    void deleteMyQuestion(Map<String, Object> boardCode);

    @Select("select count(*) from mk_product_proposal")
    int countAllProductProposal();

    @Select("select * from mk_product_proposal order by reg_date desc")
    List<Proposal> selectAllProductProposal(RowBounds rowBounds);

    @Select("select * from mk_product_proposal where code = #{code}")
    Proposal selectOneProductProposal(Map<String, Object> boardCode);

    @Delete("delete from mk_product_proposal where code = #{code}")
    void deleteOneProductProposal(Map<String, Object> boardCode);

    @Insert("insert into mk_product_proposal values(concat('prpr-', seq_mk_product_proposal_no.nextval), #{category}, #{title}, #{writer}, #{content}, default)")
    void insertProductProposal(Proposal productProposal);

    @Select("select count(*) from mk_echo_proposal")
    int countAllEchoProposal();

    @Select("select * from mk_echo_proposal order by reg_date desc")
    List<Proposal> selectAllEchoProposal(RowBounds rowBounds);

    @Select("select * from mk_echo_proposal where code = #{code}")
    Proposal selectOneEchoProposal(Map<String, Object> boardCode);

    @Delete("delete from mk_echo_proposal where code = #{code}")
    void deleteOneEchoProposal(Map<String, Object> boardCode);

    @Insert("insert into mk_echo_proposal values(concat('ecpr-', seq_mk_echo_proposal_no.nextval), #{category}, #{title}, #{writer}, #{content}, default)")
    void insertEchoProposal(Proposal proposal);

    @Select("select count(*) from mk_large_proposal")
    int countAllLargeProposal();

    @Select("select * from mk_large_proposal order by reg_date desc")
    List<Proposal> selectAllLargeProposal(RowBounds rowBounds);

    @Select("select * from mk_large_proposal where code = #{code}")
    Proposal selectOneLargeProposal(Map<String, Object> boardCode);

    @Delete("delete from mk_large_proposal where code = #{code}")
    void deleteOneLargeProposal(Map<String, Object> boardCode);

    @Insert("insert into mk_large_proposal values(concat('lapr-', seq_mk_large_proposal_no.nextval), #{writer}, #{name}, #{phone}, #{email}, #{receiveDate}, #{delivery}, #{content}, default)")
    void insertLargeProposal(Proposal proposal);

    @Select("select count(*) from mk_frequently_question")
    int countAllFrequentlyQuestion();

    @Select("select * from mk_frequently_question order by reg_date desc")
    List<FrequentlyQuestion> selectAllFrequentlyQuestion(RowBounds rowBounds);

    @Select("select * from mk_frequently_question where code = #{code}")
    FrequentlyQuestion selectOneFrequentlyQuestion(Map<String, Object> boardCode);

    @Select("update mk_frequently_question set writer = #{writer}, category = #{category}, title = #{title}, content = #{content} reg_date = sysdate where code = #{code}")
    void updateFrequentlyQuestion(FrequentlyQuestion frequence);

    @Delete("delete from mk_frequently_question where code = #{code}")
    void deleteOneFrequentlyQuestion(Map<String, Object> boardCode);

    @Insert("insert into mk_frequently_question values(concat('frqu-', seq_mk_frequently_question_no.nextval), #{writer}, #{category}, #{title}, #{content}, default)")
    void insertFrequentlyQuestion(FrequentlyQuestion frequence);

    @Update("update mk_product_proposal set category = #{category}, title = #{title}, content = #{content} reg_date = sysdate where code = #{code}")
    void updateProductProposal(Proposal proposal);

    @Update("update mk_echo_proposal set category = #{category}, title = #{title}, content = #{content} reg_date = sysdate where code = #{code}")
    void updateEchoProposal(Proposal proposal);

    @Select("select * from mk_product_proposal where writer = #{id} order by reg_date desc")
    List<Proposal> selectAllMyProductProposal(Member member, RowBounds rowBounds);

    @Select("select * from mk_echo_proposel where writer = #{id} order by reg_date desc")
    List<Proposal> selectAllMyEchoProposal(Member member, RowBounds rowBounds);

    @Select("select * from mk_announcement where announce = 'A' order by reg_date desc")
    List<Announcement> selectAllAnnounceAnnouncement(RowBounds rowBounds);

    @Select("select count(*) from mk_product_proposal where writer = #{id}")
    int countAllMyProductProposal(Member member);

    @Select("select count(*) from mk_echo_proposal where writer = #{id}")
    int countAllMyEchoProposal(Member member);

    @Select("select * from mk_product_review where announce = 'A' order by reg_date desc")
    List<ProductReview> selectProductReviewAnnounce();

    ProductReview selectBestProductReview(Map<String, Object> boardCode);

    List<ProductReview> selectFirstPageProductReview(Map<String, Object> boardCode);

    int countAllProductReview(Map<String, Object> boardCode);
}
