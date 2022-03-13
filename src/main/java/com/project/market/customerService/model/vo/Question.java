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
public class Question implements Serializable {

    private static final long serialVersionUID = 1L;
    private String qCode;
    private String title;
    private String questionCategory;
    private String pCode;
    private String writer;
    private String phone;
    private String email;
    private String receiveEmail;
    private String receivePhone;
    private String content;
    private Date regDate;
    private String aQCode;
    private String aWriter;
    private String aContent;
    private Date aRegDate;
    private List<Attachment> attachments;
}
