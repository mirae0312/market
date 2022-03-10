package com.project.market.customerService.model.service;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.dao.CustomerServiceDao;
import com.project.market.customerService.model.vo.Announcement;
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

    
    
}
