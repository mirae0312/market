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
public class Proposal implements Serializable {

    private static final long serialVersionUID = 1L;

    private String code;
    private String category;
    private String title;
    private String writer;
    private String content;
    private Date regDate;
    private String name; // 대량 신청자
    private String phone; // 대량 신청자번호
    private String email; // 대량 신청자 이메일
    private Date receiveDate; // 대량 신청자 배송지(여러 곳: M or한 곳: O)
    private String delivery;
    private List<Attachment> attachments;

}
