package com.project.market.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.market.product.model.service.ProductService;
import com.project.market.product.model.vo.Product;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	
	@GetMapping("/productList")
	public void productList(Product product, Model model) {
		List<Product> pdtList = productService.selectProductListByCategory(product);
		log.debug("pdtlist = {}", pdtList);
		
		model.addAttribute("pdtList", pdtList);
	}
	
	@GetMapping("/productDetail")
	public void productDetail(@RequestParam String pcode, Model model) {
		Product pdt = productService.selectProductDetail(pcode);
		log.debug("product = {}", pdt);
		
		model.addAttribute("product", pdt);
	}
}
