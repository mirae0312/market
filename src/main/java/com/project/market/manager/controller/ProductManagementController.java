package com.project.market.manager.controller;

import com.project.market.common.Utils.MarketUtils;
import com.project.market.manager.model.service.ProductManagementService;
import com.project.market.manager.model.vo.ProductAttachment;
import com.project.market.manager.model.vo.ProductOption;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequestMapping("/manager/product")
public class ProductManagementController {

    @Autowired
    private ProductManagementService productManagementService;

    @Autowired
    private ServletContext application;

    @GetMapping("/productManagement")
    public void productManagemant(){}

    @PostMapping("/insertProduct")
    @ResponseBody
    public RedirectView insertProduct(@RequestParam Map<String, Object> data, RedirectAttributes redirectAtt,
                                             HttpServletRequest request,
                                             @RequestParam(required = false)MultipartFile upFile) throws IllegalAccessException, IOException {

        try {
            // 첨부파일경로
            String saveDirectory = application.getRealPath("/resources/upload/product/img");
            List<ProductAttachment> attachments = new ArrayList<>();
            List<ProductOption> options = new ArrayList<>();

            if(!upFile.isEmpty()){
                String originalFilename = upFile.getOriginalFilename();
                String renamedFilename = MarketUtils.renamePolicy(originalFilename);
                File dest = new File(saveDirectory, renamedFilename);
                upFile.transferTo(dest);

                ProductAttachment attach = new ProductAttachment();
                attach.setOriginalFilename(originalFilename);
                attach.setRenamedFilename(renamedFilename);
                attachments.add(attach);
            }
            if(!attachments.isEmpty())
                data.put("attachments", attachments);

            String[] optionTitle = request.getParameterValues("productOptionTitle");
            String[] optionPrice = request.getParameterValues("productOptionPrice");

            log.debug("title ={}, price={}", optionTitle, optionPrice);
            log.debug("data = {}", data);

            int result = productManagementService.insertProduct(data);

            String msg = "상품을 등록했습니다.";
            redirectAtt.addFlashAttribute("msg", msg);
        } catch (Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return new RedirectView ("/market");
    }
}
