package com.project.market.manager.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@NoArgsConstructor
@Data
@AllArgsConstructor
public class ProductAttachment implements Serializable {
    private static final long serialVersionUID = 1L;

    private int no;
    private String pCode;
    private String originalFilename;
    private String renamedFilename;
    private Date regDate;

}
