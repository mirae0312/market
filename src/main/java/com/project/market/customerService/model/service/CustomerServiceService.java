package com.project.market.customerService.model.service;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.vo.Announcement;
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
}
