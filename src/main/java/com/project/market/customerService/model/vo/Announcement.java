package com.project.market.customerService.model.vo;

import com.project.market.common.vo.Attachment;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Announcement implements Serializable {

    private static final long serialVersionUID = 1L;

    private String anCode;
    private String title;
    private String writer;
    private Date regDate;
    private int readCount;
    private String content;
    private String announce;
    private List<Attachment> attachments;

}
