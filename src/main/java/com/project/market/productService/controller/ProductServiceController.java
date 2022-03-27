package com.project.market.productService.controller;

import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.service.CustomerServiceService;
import com.project.market.customerService.model.vo.Announcement;
import com.project.market.customerService.model.vo.FrequentlyQuestion;
import com.project.market.customerService.model.vo.Proposal;
import com.project.market.customerService.model.vo.Question;
import com.project.market.productService.model.service.ProductServiceService;
import com.project.market.productService.model.vo.ProductQuestion;
import com.project.market.productService.model.vo.ProductReview;
import com.project.market.security.model.vo.Member;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.project.market.common.Utils.MarketUtils.commonUtils;
import static com.project.market.customerService.controller.CustomerServiceController.commonAttachment;

@Controller
@Slf4j
@RequestMapping("/product")
@PropertySource("classpath:filePath.properties")
public class ProductServiceController {

    @Value("${board.prre.path}")
    private String prrePath;

    @Value("${board.prqu.path}")
    private String prquPath;

    @Autowired
    private ServletContext application;

    @Autowired
    private CustomerServiceService customerServiceService;

    @Autowired
    private ProductServiceService productServiceService;

    private final String PRRE = "productReview";
    private final String PRQU = "productQuestion";

    @GetMapping("/cookie/productReview")
    public ResponseEntity<?> getCookie(@RequestParam Map<String, Object> boardCode, @CookieValue(value="prreCount", required = false, defaultValue = "0") String value,
                                       HttpServletRequest request, HttpServletResponse response){
        try{
            String code = (String) boardCode.get("code");
            log.debug("value = {}", value);
            if("0".equals(value)){
                productServiceService.updateProductReviewReadCount(boardCode);
                value = "[" + code + "]";
            }else if(!value.contains("[" + code + "]")){
                productServiceService.updateProductReviewReadCount(boardCode);
                value += "[" + code + "]";
            }
            Cookie cookie = new Cookie("prreCount", value);
            cookie.setMaxAge(60 * 60 * 24 * 30);
            response.addCookie(cookie);

        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return ResponseEntity.ok(1);
    }

    @GetMapping("/service/{boardId}")
    public ResponseEntity<?> requestList(@PathVariable(required = true) String boardId, @RequestParam(defaultValue = "1") int cPage,
                                         @RequestParam Map<String, Object> boardCode,
                                         HttpServletRequest request, @AuthenticationPrincipal Member member){
        Map<String, Object> param = new HashMap<>();
        log.debug("boardCode = {}", boardCode);
        try{
            int totalContent = 0;
            Map<String, Object> commonThings = new HashMap<>();

            switch (boardId){
                case PRRE:
                    String readCount = "T";
                    ProductReview best = productServiceService.selectBestProductReview(boardCode);
                    if(best.getReadCount() == 0){
                        readCount = "F";
                    }
                    boardCode.put("bool", readCount);
                    boardCode.put("no", best.getNo());

                    List<ProductReview> announce = productServiceService.selectProductReviewAnnounce();
                    log.debug("announce = {}", announce);

                    int total = 7;
                    int aTotal = announce.size();
                    int totalContentPlus = 0;

                    if("T".equals(readCount)){
                        announce.add(best);
                        aTotal += 1;
                        totalContentPlus += 1;
                    }

                    int bTotal = total - aTotal;
                    boardCode.put("bTotal", bTotal);

                    totalContentPlus += bTotal;

                    List<ProductReview> firstList = productServiceService.selectFirstPageProductReview(boardCode);
                    log.debug("firstList = {}", firstList);

                    List<Integer> firstPageNo = new ArrayList<>();
                    if("T".equals(readCount))
                        firstPageNo.add(best.getNo());
                    for(ProductReview pr : firstList){
                        firstPageNo.add(pr.getNo());
                    }
                    boardCode.put("firstPage", firstPageNo);
                    totalContent = productServiceService.countAllProductReview(boardCode);
                    log.debug("totalContent = {}", totalContent);

                    commonThings = commonUtils(cPage, totalContent, request);

                    if(cPage == 0){
                        for(ProductReview pr : firstList){
                            announce.add(pr);
                        }
                        param.put("productReview", announce);
                    }else if(cPage > 0){
                        List<ProductReview> productReviews = productServiceService.selectAllProductReview((RowBounds) commonThings.get("rowBounds"), boardCode);
                        log.debug("productReviews = {}", productReviews);
                        param.put("productReview", productReviews);
                    }
                    param.put("totalContent", totalContent + totalContentPlus);
                    break;
                case PRQU:
//                    totalContent = productServiceService.countAllFrequentlyQuestion();
//                    log.debug("totalContent = {}", totalContent);
//
//                    commonThings = commonUtils(cPage, totalContent, request);
//                    List<FrequentlyQuestion> frquList = productServiceService.selectAllFrequentlyQuestion((RowBounds) commonThings.get("rowBounds"));
//                    log.debug("frequently question list = {}", frquList);
//
//
//                    param.put("fr", frquList);
                    break;
            }
            param.put("pagebar", (String) commonThings.get("pagebar"));
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return ResponseEntity.ok(param);
    }

    @GetMapping("/enroll/{boardId}")
    public ResponseEntity<?> enrollPage(@PathVariable(required = true) String boardId, @RequestParam Map<String, Object> param){
        log.debug("param = {}", param);
        try{
            switch(boardId){
                case PRRE:
                    if("modify".equals((String) param.get("type"))){
                        ProductReview productReview = productServiceService.selectOneProductReview(param);
                        param.put("productReview", productReview);
                        return ResponseEntity.ok(param);
                    }
                case PRQU:

                    break;
            }

        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return ResponseEntity.ok(1);
    }

    @PostMapping("/enroll/{boardId}")
    public ResponseEntity<?> enrollBoard(@PathVariable(required = true) String boardId, ProductReview productReview, ProductQuestion productQuestion,
                                         @RequestParam(name = "upFile", required = false) MultipartFile[] upFiles) throws IOException {
        String saveDirectory = "";
        List<Attachment> attachments = new ArrayList<>();
        try{
            switch (boardId){
                case PRRE:
                    log.debug("productReview = {}", productReview);
                    saveDirectory = application.getRealPath(prrePath);

                    if(upFiles != null && upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        productReview.setAttachments(attachments);
                    log.debug("productReview + attach = {}", productReview);
                    productServiceService.insertProductReview(productReview);
                    break;
                case PRQU:

                    break;
            }

        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return ResponseEntity.ok(1);
    }

    @PostMapping("/modify/{boardId}")
    public ResponseEntity<?> modifyBoard(@PathVariable(required = true) String boardId, ProductReview productReview, ProductQuestion productQuestion,
                              @RequestParam(name = "upFile", required = false) MultipartFile[] upFiles) throws IOException {
        String directory = "";
        Map<String, Object> boardCode = new HashMap<>();
        List<Attachment> newAttachments = new ArrayList<>();
        try{
            log.debug("boardId = {}", boardId);
            switch (boardId){
                case PRRE:
                    log.debug("productReview = {}", productReview);
                    directory = application.getRealPath(prrePath);
                    boardCode.put("no", productReview.getNo());
                    boardCode.put("code", "prre-" + productReview.getNo());
                    ProductReview oldProductReview = productServiceService.selectOneProductReview(boardCode);
                    if(upFiles != null && upFiles.length > 0){
                        if(!oldProductReview.getAttachments().isEmpty()){
                            deleteAttachment(oldProductReview.getAttachments(), prrePath);
                            customerServiceService.deleteAttachments(boardCode);
                        }
                        newAttachments = commonAttachment(upFiles, directory);
                    }

                    if(!newAttachments.isEmpty())
                        productReview.setAttachments(newAttachments);

                    productServiceService.modifyProductReview(productReview);
                    break;
            }
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return ResponseEntity.ok(1);
    }

    @PostMapping("/delete/{boardId}")
    public ResponseEntity<?> deleteBoard(@PathVariable(required = true) String boardId, @RequestParam Map<String, Object> boardCode){
        try{
            List<Attachment> attachments = new ArrayList<>();

            switch (boardId){
                case PRRE:
                    boardCode.put("code", "prre-" + (int)boardCode.get("no"));
                    attachments = customerServiceService.selectAllAttachments(boardCode);
                    deleteAttachment(attachments, prrePath);

                    productServiceService.deleteProductReview(boardCode);
                    break;
            }
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return ResponseEntity.ok(1);
    }

    @PostMapping("/review/likes")
    public ResponseEntity<?> reviewLikes(@RequestParam Map<String, Object> param, @AuthenticationPrincipal Member member){
        try{
            log.debug("param = {}", param);
            param.put("id", member.getId());
            if("1".equals((String)param.get("type")))
                productServiceService.insertProductReviewLikes(param);
            else
                productServiceService.deleteProductReviewLikes(param);

        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return ResponseEntity.ok(1);
    }

    private void deleteAttachment(List<Attachment> attachments, String path) {
        try{
            if(!attachments.isEmpty()){
                for(Attachment attach : attachments){
                    String directory = application.getRealPath(path + attach.getRenamedFilename());
                    File deleteFile = new File(directory);
                    boolean deleteBool = deleteFile.delete();
                    log.debug("deleteFile = {}", deleteBool);
                }
            }
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
    }

}
