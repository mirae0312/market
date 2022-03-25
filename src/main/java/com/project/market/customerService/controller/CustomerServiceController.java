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

import com.project.market.customerService.model.vo.FrequentlyQuestion;
import com.project.market.customerService.model.vo.Proposal;
import com.project.market.customerService.model.vo.Question;
import com.project.market.product.model.vo.Product;
import com.project.market.security.model.vo.Member;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
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
@PropertySource("classpath:filePath.properties")
public class CustomerServiceController {

    @Autowired
    private CustomerServiceService customerServiceService;

    @Autowired
    private ServletContext application;

    @Value("${board.anno.path}")
    private String annoPath;

    @Value("${board.ques.path}")
    private String quesPath;

    @Value("${board.prpr.path}")
    private String prprPath;

    @Value("${board.ecpr.path}")
    private String ecprPath;

    @Value("${board.lapr.path}")
    private String laprPath;

    @Value("${board.frqu.path}")
    private String frquPath;

    private final String QUES = "question";
    private final String ANNO = "announcement";
    private final String PRPR = "productProposal";
    private final String ECPR = "echoProposal";
    private final String LAPR = "largeProposal";
    private final String FRQU = "frequentlyQuestion";
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
                case FRQU:
                    totalContent = customerServiceService.countAllFrequentlyQuestion();
                    log.debug("totalContent = {}", totalContent);

                    commonThings = commonUtils(cPage, totalContent, request);
                    List<FrequentlyQuestion> frquList = customerServiceService.selectAllFrequentlyQuestion((RowBounds) commonThings.get("rowBounds"));
                    log.debug("frequently question list = {}", frquList);

                    model.addAttribute("frequentlyQuestion", frquList);
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
                case FRQU:
                    if("modify".equals((String) param.get("type"))){
                        FrequentlyQuestion frequently = customerServiceService.selectOneFrequentlyQuestion(param);
                        model.addAttribute("frequentlyQuestion", frequently);
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
    public String modifyBoard(@PathVariable(required = true) String boardId, Question question, Proposal proposal, Announcement announcement, FrequentlyQuestion frequence,
                              @RequestParam(name = "upFile", required = false) MultipartFile[] upFiles, RedirectAttributes redirectAttr) throws IOException {
        String directory = "";
        Map<String, Object> boardCode = new HashMap<>();
        List<Attachment> newAttachments = new ArrayList<>();
        try{
            log.debug("boardId = {}", boardId);
            switch (boardId){
                case QUES:
                    log.debug("question = {}", question);
                    directory = application.getRealPath(quesPath);
                    boardCode.put("code", question.getQCode());
                    Question oldQuestion = customerServiceService.selectOneQuestion(boardCode);
                    if(upFiles != null && upFiles.length > 0){
                        if(!oldQuestion.getAttachments().isEmpty()){
                            deleteAttachment(oldQuestion.getAttachments(), quesPath);
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
                    directory = application.getRealPath(annoPath);
                    boardCode.put("code", announcement.getAnCode());
                    Announcement oldAnnounce = customerServiceService.selectOneAnnouncement(boardCode);
                    if(upFiles != null && upFiles.length > 0){
                        if(!oldAnnounce.getAttachments().isEmpty()){
                            deleteAttachment(oldAnnounce.getAttachments(), annoPath);
                            customerServiceService.deleteAttachments(boardCode);
                        }

                        newAttachments = commonAttachment(upFiles, directory);
                    }

                    if(!newAttachments.isEmpty())
                        announcement.setAttachments(newAttachments);

                    customerServiceService.modifyAnnouncement(announcement);

                    redirectAttr.addFlashAttribute("msg", "공지 수정 완료!");
                    break;
                case FRQU:
                    log.debug("frequence = {}", frequence);
                    directory = application.getRealPath(frquPath);
                    boardCode.put("code", frequence.getCode());
                    FrequentlyQuestion oldFrequence = customerServiceService.selectOneFrequentlyQuestion(boardCode);
                    if(upFiles != null && upFiles.length > 0){
                        if(!oldFrequence.getAttachments().isEmpty()){
                            deleteAttachment(oldFrequence.getAttachments(), frquPath);
                            customerServiceService.deleteAttachments(boardCode);
                        }

                        newAttachments = commonAttachment(upFiles, directory);
                    }

                    if(!newAttachments.isEmpty())
                        frequence.setAttachments(newAttachments);

                    customerServiceService.modifyFrequentlyQuestion(frequence);

                    redirectAttr.addFlashAttribute("msg", "자주하는 질문 수정 완료!");
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
                case FRQU:
                    FrequentlyQuestion frequence = customerServiceService.selectOneFrequentlyQuestion(boardCode);
                    log.debug("frequence", frequence);
                    model.addAttribute("frequentlyQuestion", frequence);
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
            Map<String, Object> boardCode = new HashMap<>();
            boardCode.put("code", code);
            List<Attachment> attachments = customerServiceService.selectAllAttachments(boardCode);

            switch (boardId){
                case ANNO:
                    deleteAttachment(attachments, annoPath);

                    customerServiceService.deleteAnnouncement(boardCode);

                    redirectAttr.addFlashAttribute("msg", "공지사항 삭제 성공");
                    break;
                case QUES:
                    deleteAttachment(attachments, quesPath);

                    customerServiceService.deleteMyQuestion(boardCode);

                    redirectAttr.addFlashAttribute("msg", "질문 삭제 성공");
                    break;
                case PRPR:
                    deleteAttachment(attachments, prprPath);

                    customerServiceService.deleteOneProductProposal(boardCode);

                    redirectAttr.addFlashAttribute("msg", "제안 삭제 성공");
                    break;
                case ECPR:
                    deleteAttachment(attachments, ecprPath);

                    customerServiceService.deleteOneEchoProposal(boardCode);

                    redirectAttr.addFlashAttribute("msg", "에코포장 피드백 삭제 성공");
                    break;
                case LAPR:
                    deleteAttachment(attachments, laprPath);

                    customerServiceService.deleteOneLargeProposal(boardCode);

                    redirectAttr.addFlashAttribute("msg", "대량구매 문의 삭제 성공");
                    break;
                case FRQU:
                    deleteAttachment(attachments, frquPath);

                    customerServiceService.deleteOneFrequentlyQuestion(boardCode);

                    redirectAttr.addFlashAttribute("msg", "자주하는 문의 삭제 성공");
                    break;
            }
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return "redirect/service/view/" + boardId;
    }

    @PostMapping("/enroll/{boardId}")
    public String enrollBoard(@PathVariable(required = true) String boardId, Proposal proposal, FrequentlyQuestion frequence, Announcement announcement, Question question, @RequestParam(name="upFile", required = false) MultipartFile[] upFiles,
                              RedirectAttributes redirectAttr) throws IOException {
        log.debug("proposal = {}", proposal);
        log.debug("announcement = {}", announcement);
        log.debug("question = {}", question);
        log.debug("upfiles = {}", upFiles);

        List<Attachment> attachments = new ArrayList<>();
        String saveDirectory = "";
        try{
            switch (boardId){
                case ANNO:
                    log.debug("announcement = {}", announcement);
                    saveDirectory = application.getRealPath(annoPath);

                    if(upFiles != null && upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        announcement.setAttachments(attachments);
                    log.debug("announcement + attach = {}", announcement);
                    customerServiceService.insertAnnouncement(announcement);
                    break;
                case QUES:
                    log.debug("question = {}", question);
                    saveDirectory = application.getRealPath(quesPath);

                    if(upFiles != null && upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        question.setAttachments(attachments);
                    log.debug("question + attach = {}", question);
                    customerServiceService.insertQuestion(question);
                    break;
                case PRPR:
                    log.debug("productProposal = {}", proposal);
                    saveDirectory = application.getRealPath(prprPath);

                    if(upFiles != null && upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        proposal.setAttachments(attachments);
                    log.debug("productProposal + attachments = {}", proposal);
                    customerServiceService.insertProductProposal(proposal);
                    break;
                case ECPR:
                    log.debug("echoProposal = {}", proposal);
                    saveDirectory = application.getRealPath(ecprPath);

                    if(upFiles != null && upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        proposal.setAttachments(attachments);
                    log.debug("echoProposal + attachments = {}", proposal);
                    customerServiceService.insertEchoProposal(proposal);
                    break;
                case LAPR:
                    log.debug("largeProposal = {}", proposal);
                    saveDirectory = application.getRealPath(laprPath);

                    if(upFiles != null && upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        proposal.setAttachments(attachments);
                    log.debug("largeProposal + attachments = {}", proposal);
                    customerServiceService.insertLargeProposal(proposal);
                    break;
                case FRQU:
                    log.debug("frequence = {}", frequence);
                    saveDirectory = application.getRealPath(frquPath);

                    if(upFiles != null && upFiles.length > 0)
                        attachments = commonAttachment(upFiles, saveDirectory);
                    if(!attachments.isEmpty())
                        frequence.setAttachments(attachments);
                    log.debug("frequently question + attachments = {}", frequence);
                    customerServiceService.insertFrequentlyQuestion(frequence);
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
