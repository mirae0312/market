package com.project.market.product.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString(callSuper=true)
public class Product extends ProductEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String title;
	private String subTitle;
	private String salesUnit;
	private String weightCapacity;
	private String deliveryDiv;
	private String origin;
	private String packType;
	private String packTypeSub;
	private String expiration;
	private String allergyInfo;
	private String sugar;
	private String livestockInfo;
	private String commonInfo;
	
	private String brandTitle;
	private String brandSubTitle;
	private String brandcontent;
	
	private int discountRate;
	private int price;
	private String accumulationStatus;
	
	private String originalFilename;
	private String renamedFilename;
	private Date regDate;
}
