package com.project.market.customerService.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.market.customerService.model.vo.Proposal;
import com.project.market.customerService.model.vo.Question;
import com.project.market.product.model.vo.Product;
import com.project.market.security.model.vo.Member;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.common.Utils.MarketUtils;
import com.project.market.common.vo.Attachment;
import com.project.market.customerService.model.service.CustomerServiceService;
import com.project.market.customerService.model.vo.Announcement;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/service")
public class CustomerServiceController {

    @Autowired
    private CustomerServiceService customerServiceService;

    @Autowired
    private ServletContext application;

    private final String QUES = "question";
    private final String ANNO = "announcement";
    private final String PRPR = "productProposal";
    private final String ECPR = "echoProposal";
    private final String LAPR = "largeProposal";
    private final String PRRE = "productReview";

    @GetMapping("/view/{boardId}")
    public String boardSelect(@PathVariable(required = true) String boardId
            , @RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request, @AuthenticationPrincipal Member member){
        try{
            int totalContent = 0;
            Map<String, Object> commonThings = new HashMap<>();
            switch (boardId){
                case QUES:
                    totalContent = customerServiceService.countAllMyQuestion(member);
                    log.debug("totalContent = {}", totalContent);

                    commonThings = commonUtils(cPage, totalContent, request);
                    List<Question> questionList = customerServiceService.selectAllMyQuestion((RowBounds) commonThings.get("rowBounds"), member);
                    log.debug("questionList = {}", questionList);

                    model.addAttribute("questionList", questionList);
                    break;
                case ANNO:
                    totalContent = customerServiceService.countAllAnnouncement();
                    log.debug("totalContent = {}", totalContent);

                    commonThings = commonUtils(cPage, totalContent, request);
                    List<Announcement> announceList = customerServiceService.selectAllAnnouncement((RowBounds) commonThings.get("rowBounds"));
                    log.debug("announceList = {}", announceList);

                    model.addAttribute("announceList", announceList);
                    break;
                case PRPR:
                    totalContent = customerServiceService.countAllProductProposal();
                    log.debug("totalContent = {}", totalContent);

                    commonThings = commonUtils(cPage, totalContent, request);
                    List<Proposal> prprList = customerServiceService.selectAllProductProposal((RowBounds) commonThings.get("rowBounds"));
                    log.debug("productProposal = {}", prprList);

                    model.addAttribute("productProposalList", prprList);
                    break;
                case ECPR:
                    totalContent = customerServiceService.countAllEchoProposal();
                    log.debug("totalContent = {}", totalContent);

                    commonThings = commonUtils(cPage, totalContent, request);
                    List<Proposal> ecprList = customerServiceService.selectAllEchoProposal((RowBounds) commonThings.get("rowBounds"));
                    log.debug("echoProposal = {}", ecprList);

                    model.addAttribute("echoProposal", ecprList);
                    break;
                case LAPR:
                    totalContent = customerServiceService.countAllLargeProposal();
                    log.debug("totalContent = {}", totalContent);

                    commonThings = commonUtils(cPage, totalContent, request);
                    List<Proposal> laprList = customerServiceService.selectAllLargeProposal((RowBounds) commonThings.get("rowBounds"));
                    log.debug("largeProposal = {}", laprList);

                    model.addAttribute("largeProposal", laprList);
                    break;
            }
            model.addAttribute("pagebar", (String) commonThings.get("pagebar"));
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return "service/view/" + boardId;
    }

    @GetMapping("/enroll/{boardId}")
    public String enrollBoard(@PathVariable(required = true) String boardId, @RequestParam Map<String, Object> param, Model model){
        try{
            log.debug("param = {}", param);
            switch (boardId){
                case QUES:
                    if("modify".equals((String) param.get("type"))){
                        Question question = customerServiceService.selectOneQuestion(param);
                        model.addAttribute("question", question);
                    }
                    break;
                case ANNO:
                    if("modify".equals((String) param.get("type"))){
                        Announcement announce = customerServiceService.selectOneAnnouncement(param);
                        model.addAttribute("announce", announce);
                    }
                    break;
            }

        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return "service/enroll/" + boardId;
    }

    @PostMapping("/modify/{boardId}")
    public String modifyBoard(@PathVariable(required = true) String boardId, Question question, Proposal proposal, Announcement announcement,
                              @RequestParam(name = "upFile", required = false) MultipartFile[] upFiles, RedirectAttributes redirectAttr) throws IOException {
        String path = "";
        String directory = "";
        Map<String, Object> boardCode = new HashMap<>();
        List<Attachment> newAttachments = new ArrayList<>();
        try{
            log.debug("boardId = {}", boardId);
            switch (boardId){
                case QUES:
                    log.debug("question = {}", question);
                    path = "/resources/upload/question/";
                    directory = application.getRealPath(path);
                    boardCode.put("code", question.getQCode());
                    Question oldQuestion = customerServiceService.selectOneQuestion(boardCode);
                    if(upFiles.length > 0){
                        if(!oldQuestion.getAttachments().isEmpty()){
                            deleteAttachment(oldQuestion.getAttachments(), path);
                            customerServiceService.deleteAttachments(boardCode);
                        }

                        newAttachments = commonAttachment(upFiles, directory);
                    }

                    if(!newAttachments.isEmpty())
                        question.setAttachments(newAttachments);

                    customerServiceService.modifyQuestion(question);

                    redirectAttr.addFlashAttribute("msg", "질문 수정 완료!");
                    break;
                case ANNO:
                    log.debug("announcement = {}", announcement);
                    path = "/resources/upload/announce/";
                    directory = application.getRealPath(path);
                    boardCode.put("code", announcement.getAnCode());
                    Announcement oldAnnounce = customerServiceService.selectOneAnnouncement(boardCode);
                    if(upFiles.length > 0){
                        if(!oldAnnounce.getAttachments().isEmpty()){
                            deleteAttachment(oldAnnounce.getAttachments(), path);
                            customerServiceService.deleteAttachments(boardCode);
                        }

                        newAttachments = commonAttachment(upFiles, directory);
                    }

                    if(!newAttachments.isEmpty())
                        announcement.setAttachments(newAttachments);

                    customerServiceService.modifyAnnouncement(announcement);

                    redirectAttr.addFlashAttribute("msg", "공지 수정 완료!");
                    break;
            }
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return "redirect:/service/view/" + boardId;
    }

    @GetMapping("/detail/{boardId}")
    public String boardDetail(@PathVariable(required = true) String boardId, @RequestParam String code, Model model, @CookieValue(value="announceCount", required = false, defaultValue = "0") String value,
                              HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> boardCode = new HashMap<>();
        boardCode.put("code", code);
        Proposal proposal = new Proposal();
        try{
            switch (boardId){
                case ANNO:
                    log.debug("value = {}", value);
                    if("0".equals(value)){
                        customerServiceService.updateAnnouncementReadCount(boardCode);
                        value = "[" + code + "]";
                    }else if(!value.contains("[" + code + "]")){
                        customerServiceService.updateAnnouncementReadCount(boardCode);
                        value += "[" + code + "]";
                    }
                    Cookie cookie = new Cookie("announceCount", value);
                    cookie.setMaxAge(60 * 60 * 24 * 30);
                    cookie.setPath(request.getContextPath() + "/service/announcementDetail");
                    response.addCookie(cookie);

                    Announcement announcement = customerServiceService.selectOneAnnouncement(boardCode);
                    log.debug("announcement = {}", announcement);
                    model.addAttribute("announce", announcement);
                    break;
                case QUES:
                    Question question = customerServiceService.selectOneQuestion(boardCode);
                    log.debug("question = {}", question);
                    model.addAttribute("question", question);
                    break;
                case PRPR:
                    proposal = customerServiceService.selectOneProductProposal(boardCode);
                    log.debug("productProposal", proposal);
                    model.addAttribute("productProposal", proposal);
                    break;
                case ECPR:
                    proposal = customerServiceService.selectOneEchoProposal(boardCode);
                    log.debug("echoProposal", proposal);
                    model.addAttribute("echoProposal", proposal);
                    break;
                case LAPR:
                    proposal = customerServiceService.selectOneLargeProposal(boardCode);
                    log.debug("largeProposal", proposal);
                    model.addAttribute("largeProposal", proposal);
                    break;
            }
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return "/service/detail/" + boardId;
    }

    @PostMapping("/delete/{boardId}")
    public String deleteBoard(@PathVariable(required = true) String boardId, @RequestParam String code, RedirectAttributes redirectAttr){
        try{
            String path = "";
            Map<String, Object> boardCode = new HashMap<>();
            boardCode.put("code", code);
            List<Attachment> attachments = customerServiceService.selectAllAttachments(boardCode);

            switch (boardId){
                case ANNO:
                    path = "/resources/upload/announce/";
                    deleteAttachment(attachments, path);

                    customerServiceService.deleteAnnouncement(boardCode);

                    redirectAttr.addFlashAttribute("msg", "공지사항 삭제 성공");
                    break;
                case QUES:
                    path = "/resources/upload/question/";
                    deleteAttachment(attachments, path);

                    customerServiceService.deleteMyQuestion(boardCode);

                    redirectAttr.addFlashAttribute("msg", "질문 삭제 성공");
                    break;
                case PRPR:
                    path = "/resources/upload/productProposal/";
                    deleteAttachment(attachments, path);

                    customerServiceService.deleteOneProductProposal(boardCode);

                    redirectAttr.addFlashAttribute("msg", "제안 삭제 성공");
                    break;
                case ECPR:
                    path = "resources/upload/echoProposal/";
                    deleteAttachment(attachments, path);

                    customerServiceService.deleteOneEchoProposal(boardCode);

                    redirectAttr.addFlashAttribute("msg", "에코포장 피드백 삭제 성공");
                    break;
                case LAPR:
                    path = "resources/upload/largeProposal/";
                    deleteAttachment(attachments, path);

                    customerServiceService.deleteOneLargeProposal(boardCode);

                    redirectAttr.addFlashAttribute("msg", "대량구매 문의 삭제 성공");
                    break;
            }
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return "redirect/service/view/" + boardId;
    }

    @PostMapping("/enroll/{boardId}")
    public String enrollBoard(@PathVariable(required = true) String boardId, Proposal proposal, Announcement announcement, Question question, @RequestParam(name="upFile", required = false) MultipartFile[] upFiles,
                              RedirectAttributes redirectAttr) throws IOException {
        log.debug("proposal = {}", proposal);
        log.debug("announcement = {}", announcement);
        log.debug("question = {}", question);

        List<Attachment> attachments = new ArrayList<>();
        String saveDirectory = "";
        try{
            switch (boardId){
                case ANNO:
                    log.debug("announcement = {}", announcement);
                    saveDirectory = application.getRealPath("/resources/upload/announce");

                    if(upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        announcement.setAttachments(attachments);
                    log.debug("announcement + attach = {}", announcement);
                    customerServiceService.insertAnnouncement(announcement);
                    break;
                case QUES:
                    log.debug("question = {}", question);
                    saveDirectory = application.getRealPath("/resources/upload/question");

                    if(upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        question.setAttachments(attachments);
                    log.debug("question + attach = {}", question);
                    customerServiceService.insertQuestion(question);
                    break;
                case PRPR:
                    log.debug("productProposal = {}", proposal);
                    saveDirectory = application.getRealPath("/resources/upload/productProposal");

                    if(upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        proposal.setAttachments(attachments);
                    log.debug("productProposal + attachments = {}", proposal);
                    customerServiceService.insertProductProposal(proposal);
                    break;
                case ECPR:
                    log.debug("echoProposal = {}", proposal);
                    saveDirectory = application.getRealPath("/resources/upload/echoProposal");

                    if(upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        proposal.setAttachments(attachments);
                    log.debug("echoProposal + attachments = {}", proposal);
                    customerServiceService.insertEchoProposal(proposal);
                    break;
                case LAPR:
                    log.debug("largeProposal = {}", proposal);
                    saveDirectory = application.getRealPath("/resources/upload/largeProposal");

                    if(upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        proposal.setAttachments(attachments);
                    log.debug("largeProposal + attachments = {}", proposal);
                    customerServiceService.insertLargeProposal(proposal);
                    break;
            }
            redirectAttr.addFlashAttribute("msg", "게시물 등록 성공!");
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return "redirect:/service/view/" + boardId;
    }

    // common-------------------------------------

    private Map<String, Object> commonUtils(int cPage, int totalContent, HttpServletRequest request){
        Map<String, Object> param = new HashMap<>();
        try{
            int limit = 10;
            int offset = (cPage - 1) * limit;
            RowBounds rowBounds = new RowBounds(offset, limit);
            param.put("rowBounds", rowBounds);

            String url = request.getRequestURI();
            String pagebar = MarketUtils.getAnnouncePagebar(cPage, limit, totalContent, url);
            param.put("pagebar", pagebar);
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return param;
    }

    private List<Attachment> commonAttachment(MultipartFile[] upFiles, String saveDirectory) throws IOException {
        List<Attachment> attachments = new ArrayList<>();
        try{
            for(int i = 0; i < upFiles.length; i++){
                MultipartFile upFile = upFiles[i];
                if(!upFile.isEmpty()){
                    String originalFilename = upFile.getOriginalFilename();
                    String renamedFilename = MarketUtils.renamePolicy(originalFilename);
                    File dest = new File(saveDirectory, renamedFilename);
                    upFile.transferTo(dest);

                    Attachment attach = new Attachment();
                    attach.setOriginalFilename(originalFilename);
                    attach.setRenamedFilename(renamedFilename);
                    attachments.add(attach);
                }
            }
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return attachments;
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
