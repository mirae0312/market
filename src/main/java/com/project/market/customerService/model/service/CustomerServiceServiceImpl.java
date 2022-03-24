package com.project.market.customerService.model.service;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.dao.CustomerServiceDao;
import com.project.market.customerService.model.vo.Announcement;
import com.project.market.customerService.model.vo.FrequentlyQuestion;
import com.project.market.customerService.model.vo.Proposal;
import com.project.market.customerService.model.vo.Question;
import com.project.market.security.model.vo.Member;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
@Slf4j
public class CustomerServiceServiceImpl implements CustomerServiceService {

    @Autowired
    private CustomerServiceDao customerServiceDao;

    @Override
    public void insertAnnouncement(Announcement announcement) {
        customerServiceDao.insertAnnouncement(announcement);
        log.debug("an_code = {}", announcement.getAnCode());
        String code = announcement.getAnCode();
        List<Attachment> attachments = announcement.getAttachments();
        commonAttachInsert(code, attachments);
    }

    @Transactional(rollbackFor=Exception.class)
    @Override
    public void insertAttachment(Attachment attach){
        customerServiceDao.insertAttachment(attach);
    }

    @Override
    public void updateAnnouncementReadCount(Map<String, Object> boardCode) {
        customerServiceDao.updateAnnouncementReadCount(boardCode);
    }

    @Override
    public Announcement selectOneAnnouncement(Map<String, Object> boardCode) {
        Announcement announcement = customerServiceDao.selectOneAnnouncement(boardCode);
        List<Attachment> attachments = customerServiceDao.selectAllAttachments(boardCode);
        announcement.setAttachments(attachments);
        return announcement;
    }

    @Override
    public List<Announcement> selectAllAnnouncement(RowBounds rowBounds) {
        return customerServiceDao.selectAllAnnouncement(rowBounds);
    }

    @Override
    public int countAllAnnouncement() {
        return customerServiceDao.countAllAnnouncement();
    }

    @Override
    public List<Attachment> selectAllAttachments(Map<String, Object> boardCode) {
        return customerServiceDao.selectAllAttachments(boardCode);
    }

    @Override
    public void deleteAnnouncement(Map<String, Object> boardCode) {
        customerServiceDao.deleteAttachments(boardCode);
        customerServiceDao.deleteAnnouncement(boardCode);
    }

    @Override
    public void modifyAnnouncement(Announcement announcement) {
        customerServiceDao.updateAnnouncement(announcement);
        if(!announcement.getAttachments().isEmpty()){
            String code = announcement.getAnCode();
            List<Attachment> attachments = announcement.getAttachments();
            commonAttachInsert(code, attachments);
        }
    }

    @Override
    public void deleteAttachments(Map<String, Object> boardCode) {
        customerServiceDao.deleteAttachments(boardCode);
    }

	@Override
	public Map<String, Object> selectUserDefaultAddress(String userId) {
		return customerServiceDao.selectUserDefaultAddress(userId);
	}

	@Override
	public int selectUserAccumulationRate(String userId) {
		return customerServiceDao.selectUserAccumulationRate(userId);
	}

    @Override
    public List<Question> selectAllMyQuestion(RowBounds rowBounds, Member member) {
        return customerServiceDao.selectAllMyQuestion(member, rowBounds);
    }

    @Override
    public int countAllMyQuestion(Member member) {
        return customerServiceDao.countAllMyQuestion(member);
    }

    @Override
    public Question selectOneQuestion(Map<String, Object> boardCode) {
        Question question = customerServiceDao.selectOneQuestion(boardCode);
        List<Attachment> attachments = customerServiceDao.selectAllAttachments(boardCode);
        question.setAttachments(attachments);
        return question;
    }

    @Override
    public void modifyQuestion(Question question) {
        customerServiceDao.updateQuestion(question);
        if(!question.getAttachments().isEmpty()){
            String code = question.getQCode();
            List<Attachment> attachments = question.getAttachments();
            commonAttachInsert(code, attachments);
        }
    }

    @Override
    public void insertQuestion(Question question) {
        customerServiceDao.insertQuestion(question);
        log.debug("q_code = {}", question.getQCode());
        String code = question.getQCode();
        List<Attachment> attachments = question.getAttachments();
        commonAttachInsert(code, attachments);
    }

    @Override
    public void deleteMyQuestion(Map<String, Object> boardCode) {
        customerServiceDao.deleteMyQuestion(boardCode);
    }

    @Override
    public int countAllProductProposal() {
        return customerServiceDao.countAllProductProposal();
    }

    @Override
    public List<Proposal> selectAllProductProposal(RowBounds rowBounds) {
        return customerServiceDao.selectAllProductProposal(rowBounds);
    }

    @Override
    public Proposal selectOneProductProposal(Map<String, Object> boardCode) {
        Proposal productProposal = customerServiceDao.selectOneProductProposal(boardCode);
        List<Attachment> attachments = customerServiceDao.selectAllAttachments(boardCode);
        productProposal.setAttachments(attachments);
        return productProposal;
    }

    @Override
    public void deleteOneProductProposal(Map<String, Object> boardCode) {
        customerServiceDao.deleteOneProductProposal(boardCode);
    }

    @Override
    public void insertProductProposal(Proposal proposal) {
        customerServiceDao.insertProductProposal(proposal);
        log.debug("code = {}", proposal.getCode());
        String code = proposal.getCode();
        List<Attachment> attachments = proposal.getAttachments();
        commonAttachInsert(code, attachments);
    }

    @Override
    public int countAllEchoProposal() {
        return customerServiceDao.countAllEchoProposal();
    }

    @Override
    public List<Proposal> selectAllEchoProposal(RowBounds rowBounds) {
        return customerServiceDao.selectAllEchoProposal(rowBounds);
    }

    @Override
    public Proposal selectOneEchoProposal(Map<String, Object> boardCode) {
        Proposal echoProposal = customerServiceDao.selectOneEchoProposal(boardCode);
        List<Attachment> attachments = customerServiceDao.selectAllAttachments(boardCode);
        echoProposal.setAttachments(attachments);
        return echoProposal;
    }

    @Override
    public void deleteOneEchoProposal(Map<String, Object> boardCode) {
        customerServiceDao.deleteOneEchoProposal(boardCode);
    }

    @Override
    public void insertEchoProposal(Proposal proposal) {
        customerServiceDao.insertEchoProposal(proposal);
        log.debug("code = {}", proposal.getCode());
        String code = proposal.getCode();
        List<Attachment> attachments = proposal.getAttachments();
        commonAttachInsert(code, attachments);
    }

    @Override
    public int countAllLargeProposal() {
        return customerServiceDao.countAllLargeProposal();
    }

    @Override
    public List<Proposal> selectAllLargeProposal(RowBounds rowBounds) {
        return customerServiceDao.selectAllLargeProposal(rowBounds);
    }

    @Override
    public Proposal selectOneLargeProposal(Map<String, Object> boardCode) {
        Proposal largeProposal = customerServiceDao.selectOneLargeProposal(boardCode);
        List<Attachment> attachments = customerServiceDao.selectAllAttachments(boardCode);
        largeProposal.setAttachments(attachments);
        return largeProposal;
    }

    @Override
    public void deleteOneLargeProposal(Map<String, Object> boardCode) {
        customerServiceDao.deleteOneLargeProposal(boardCode);
    }

    @Override
    public void insertLargeProposal(Proposal proposal) {
        customerServiceDao.insertLargeProposal(proposal);
        log.debug("code = {}", proposal.getCode());
        String code = proposal.getCode();
        List<Attachment> attachments = proposal.getAttachments();
        commonAttachInsert(code, attachments);
    }

    @Override
    public int countAllFrequentlyQuestion() {
        return customerServiceDao.countAllFrequentlyQuestion();
    }

    @Override
    public List<FrequentlyQuestion> selectAllFrequentlyQuestion(RowBounds rowBounds) {
        return customerServiceDao.selectAllFrequentlyQuestion(rowBounds);
    }

    @Override
    public FrequentlyQuestion selectOneFrequentlyQuestion(Map<String, Object> boardCode) {
        FrequentlyQuestion frequentlyQuestion = customerServiceDao.selectOneFrequentlyQuestion(boardCode);
        List<Attachment> attachments = customerServiceDao.selectAllAttachments(boardCode);
        frequentlyQuestion.setAttachments(attachments);
        return frequentlyQuestion;
    }

    @Override
    public void modifyFrequentlyQuestion(FrequentlyQuestion frequence) {
        customerServiceDao.updateFrequentlyQuestion(frequence);
        if(!frequence.getAttachments().isEmpty()){
            String code = frequence.getCode();
            List<Attachment> attachments = frequence.getAttachments();
            commonAttachInsert(code, attachments);
        }
    }

    @Override
    public void deleteOneFrequentlyQuestion(Map<String, Object> boardCode) {
        customerServiceDao.deleteOneFrequentlyQuestion(boardCode);
    }

    @Override
    public void insertFrequentlyQuestion(FrequentlyQuestion frequence) {
        customerServiceDao.insertFrequentlyQuestion(frequence);
        log.debug("code = {}", frequence.getCode());
        String code = frequence.getCode();
        List<Attachment> attachments = frequence.getAttachments();
        commonAttachInsert(code, attachments);
    }

    private void commonAttachInsert(String code, List<Attachment> attachments){
        if(attachments != null){
            for(Attachment attach : attachments){
                attach.setCode(code);
                insertAttachment(attach);
            }
        }
    }


}
