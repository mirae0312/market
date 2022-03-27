package com.project.market.customerService.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductQuestion implements Serializable {

    private static final long serialVersionUID = 1L;

    private String code;
    private String pCode;
    private String writer;
    private String name;
    private String grade;
    private String announce;
    private String title;
    private String content;
    private Date regDate;
    private String aTitle;
    private String aContent;
    private Date aRegDate;
    private String secret;

}
