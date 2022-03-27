package com.project.market.productService.model.vo;

import com.project.market.common.vo.Attachment;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductReview implements Serializable {

    private static final long serialVersionUID = 1L;

    private int no;
    private String pCode;
    private String writer;
    private String name;
    private String grade;
    private String announce;
    private String title;
    private String content;
    private int likes;
    private int readCount;
    private Date regDate;
    private List<Attachment> attachments;
}
