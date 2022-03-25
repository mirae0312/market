package com.project.market.manager.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductOption implements Serializable {
    private static final long serialVersionUID = 1L;

    private int no;
    private String pCode;
    private String optionTitle;
    private String optionPrice;
}
