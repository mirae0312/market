package com.project.market.myPage.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddressSub implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int no;
	private String id;
	private String zipCode;
	private String address;
	private String detailAddress;
	private String deliveryType;
	private String receiver;
	private String phone;
	private String checkAddress;
	private char defaultAddress;
	
}
