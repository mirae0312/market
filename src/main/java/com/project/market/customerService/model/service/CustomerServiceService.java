package com.project.market.customerService.model.service;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.vo.Announcement;
import com.project.market.customerService.model.vo.Question;
import com.project.market.security.model.vo.Member;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

public interface CustomerServiceService {
    void insertAnnouncement(Announcement announcement);

    void insertAttachment(Attachment attach);

    void updateAnnouncementReadCount(Map<String, Object> boardCode);

    Announcement selectOneAnnouncement(Map<String, Object> boardCode);

    List<Announcement> selectAllAnnouncement(RowBounds rowBounds);

    int countAllAnnouncement();

    List<Attachment> selectAllAttachments(Map<String, Object> boardCode);

    void deleteAnnouncement(Map<String, Object> boardCode);

    void modifyAnnouncement(Announcement announcement);

    void deleteAttachments(Map<String, Object> boardCode);

	Map<String, Object> selectUserDefaultAddress(String userId);

	int selectUserAccumulationRate(String userId);

    List<Question> selectAllMyQuestion(RowBounds rowBounds, Member member);

    int countAllMyQuestion(Member member);

    Question selectOneQuestion(Map<String, Object> map);

    void modifyQuestion(Question question);

    void insertQuestion(Question question);

    void deleteMyQuestion(Map<String, Object> boardCode);
}
