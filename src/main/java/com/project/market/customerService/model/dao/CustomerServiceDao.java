package com.project.market.customerService.model.dao;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.vo.Announcement;
import com.project.market.customerService.model.vo.Question;
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

    @Select("select * from mk_question where writer = #{id}")
    List<Question> selectAllMyQuestion(Member member, RowBounds rowBounds);

    @Select("select count(*) from mk_question where writer = #{id}")
    int countAllMyQuestion(Member member);

    @Select("select * from mk_question where q_code = #{code}")
    Question selectOneQuestion(Map<String, Object> boardCode);

    @Update("update mk_question set title = #{title}, question_category = #{questionCategory}, receive_email = #{receiveEmail}, receive_phone = #{receivePhone}, content = #{content}, reg_date = sysdate where q_code = #{qCode}")
    void updateQuestion(Question question);

    @Insert("insert into mk_question values(concat('qe-', seq_mk_question_no.nextval), #{title}, #{questionCategory}, null, #{writer}, #{phone}, #{email}, #{receiveEmail}, #{receivePhone}, #{content}, default, null, null, null, null)")
    void insertQuestion(Question question);

    @Delete("delete from mk_question where q_code = #{code}")
    void deleteMyQuestion(Map<String, Object> boardCode);
}
