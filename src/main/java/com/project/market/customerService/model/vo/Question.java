package com.project.market.customerService.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Question implements Serializable {

    private static final long serialVersionUID = 1L;
    private String qCode;
    private String title;
    private Category category;
    private String writer;
    private String content;
    private Date regDate;
    private String aQCode;
    private String aWriter;
    private String aContent;
    private Date aRegDate;
}
