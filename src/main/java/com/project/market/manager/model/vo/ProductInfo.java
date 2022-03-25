package com.project.market.manager.model.vo;

import com.project.market.product.model.vo.Product;
import com.project.market.product.model.vo.ProductEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class ProductInfo extends Product implements Serializable {
    private static final long serialVersionUID = 1L;

    private int productOptionCount; //옵션개수
    private List<ProductOption> productOptions;
    private List<ProductAttachment> productAttachment;


}
