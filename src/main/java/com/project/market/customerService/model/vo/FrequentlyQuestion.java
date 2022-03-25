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
public class FrequentlyQuestion implements Serializable {

    private static final long serialVersionUID = 1L;

    private String code;
    private String writer;
    private String category;
    private String title;
    private String content;
    private Date regDate;
    private List<Attachment> attachments;


}
