package com.project.market.customerService.model.dao;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.vo.Announcement;
import org.apache.ibatis.annotations.Mapper;
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
}
