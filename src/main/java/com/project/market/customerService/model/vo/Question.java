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
    private String uid; // 결제정보
    private Date orderDate; // 주문일자
    private String orderName; // 상품명 ex) 필라델피아 크림치즈_외 6건
    private String orderNum; // 수량
    private String orderPrice; // 주문금액
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
