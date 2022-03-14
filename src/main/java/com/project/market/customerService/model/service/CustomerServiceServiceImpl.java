package com.project.market.customerService.model.service;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.dao.CustomerServiceDao;
import com.project.market.customerService.model.vo.Announcement;
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
        List<Attachment> attachments = announcement.getAttachments();
        if(attachments != null){
            for(Attachment attach : attachments){
                attach.setCode(announcement.getAnCode());
                insertAttachment(attach);
            }
        }
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
            List<Attachment> attachments = announcement.getAttachments();
            if(attachments != null){
                for(Attachment attach : attachments){
                    attach.setCode(announcement.getAnCode());
                    insertAttachment(attach);
                }
            }
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
            List<Attachment> attachments = question.getAttachments();
            if(attachments != null){
                for(Attachment attach : attachments){
                    attach.setCode(question.getQCode());
                    insertAttachment(attach);
                }
            }
        }
    }

    @Override
    public void insertQuestion(Question question) {
        customerServiceDao.insertQuestion(question);
        log.debug("q_code = {}", question.getQCode());
        List<Attachment> attachments = question.getAttachments();
        if(attachments != null){
            for(Attachment attach : attachments){
                attach.setCode(question.getQCode());
                insertAttachment(attach);
            }
        }
    }

    @Override
    public void deleteMyQuestion(Map<String, Object> boardCode) {
        customerServiceDao.deleteMyQuestion(boardCode);
    }


}
