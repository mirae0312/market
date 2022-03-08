package com.project.market.common.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Attachment implements Serializable {

    private static final long serialVersionUID = 1L;

    private int no;
    private String code;
    private String originalFilename;
    private String renamedFilename;
    private Date regDate;
}
