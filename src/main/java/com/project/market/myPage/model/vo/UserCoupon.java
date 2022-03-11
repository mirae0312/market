package com.project.market.myPage.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserCoupon implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String code;
	
}
