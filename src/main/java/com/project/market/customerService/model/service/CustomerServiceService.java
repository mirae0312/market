package com.project.market.customerService.model.service;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.vo.Announcement;
import com.project.market.customerService.model.vo.FrequentlyQuestion;
import com.project.market.customerService.model.vo.Proposal;
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

    int countAllProductProposal();

    List<Proposal> selectAllProductProposal(RowBounds rowBounds);

    Proposal selectOneProductProposal(Map<String, Object> boardCode);

    void deleteOneProductProposal(Map<String, Object> boardCode);

    void insertProductProposal(Proposal proposal);

    int countAllEchoProposal();

    List<Proposal> selectAllEchoProposal(RowBounds rowBounds);

    Proposal selectOneEchoProposal(Map<String, Object> boardCode);

    void deleteOneEchoProposal(Map<String, Object> boardCode);

    void insertEchoProposal(Proposal proposal);

    int countAllLargeProposal();

    List<Proposal> selectAllLargeProposal(RowBounds rowBounds);

    Proposal selectOneLargeProposal(Map<String, Object> boardCode);

    void deleteOneLargeProposal(Map<String, Object> boardCode);

    void insertLargeProposal(Proposal proposal);

    int countAllFrequentlyQuestion();

    List<FrequentlyQuestion> selectAllFrequentlyQuestion(RowBounds rowBounds);

    FrequentlyQuestion selectOneFrequentlyQuestion(Map<String, Object> param);

    void modifyFrequentlyQuestion(FrequentlyQuestion frequence);

    void deleteOneFrequentlyQuestion(Map<String, Object> boardCode);

    void insertFrequentlyQuestion(FrequentlyQuestion frequence);
}
