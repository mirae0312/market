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

import com.project.market.customerService.model.vo.Question;
import com.project.market.security.model.vo.Member;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

    @GetMapping("/announcement")
    public void announcement(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request){
        try{
            int limit = 10;
            int offset = (cPage - 1) * limit;
            RowBounds rowBounds = new RowBounds(offset, limit);
            List<Announcement> announceList = customerServiceService.selectAllAnnouncement(rowBounds);
            log.debug("announceList = {}", announceList);

            int totalContent = customerServiceService.countAllAnnouncement();
            log.debug("totalContent = {}", totalContent);

            String url = request.getRequestURI();
            String pagebar = MarketUtils.getAnnouncePagebar(cPage, limit, totalContent, url);

            model.addAttribute("pagebar", pagebar);
            model.addAttribute("announceList", announceList);
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
    }

    @GetMapping("/announceEnrollForm")
    public void announceEnrollForm(@RequestParam Map<String, Object> map, Model model){
        try{
            log.debug("map = {}", map);
            if("modify".equals((String) map.get("type"))){
                Announcement announce = customerServiceService.selectOneAnnouncement(map);
                model.addAttribute("announce", announce);
            }
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
    }

    @PostMapping("/modifyAnnouncement")
    public String modifyAnnouncement(Announcement announcement, @RequestParam(name="upFile", required = false) MultipartFile[] upFiles,
                                     RedirectAttributes redirectAttr) throws IOException {
        try{
            log.debug("announcement = {}", announcement);
            Map<String, Object> boardCode = new HashMap<>();
            boardCode.put("code", announcement.getAnCode());
            String directory = "";
            Announcement oldAnnounce = customerServiceService.selectOneAnnouncement(boardCode);
            List<Attachment> newAttachments = new ArrayList<>();
            if(upFiles.length > 0){
                if(!oldAnnounce.getAttachments().isEmpty()){
                    for(Attachment attach : oldAnnounce.getAttachments()){
                        directory = application.getRealPath("/resources/upload/announce/" + attach.getRenamedFilename());
                        File deleteFile = new File(directory);
                        boolean deleteBool = deleteFile.delete();
                        log.debug("deleteFile = {}", deleteBool);
                    }
                    customerServiceService.deleteAttachments(boardCode);
                }


                for(int i = 0; i < upFiles.length; i++){
                    MultipartFile upFile = upFiles[i];
                    if(!upFile.isEmpty()){
                        directory = application.getRealPath("/resources/upload/announce");
                        String originalFilename = upFile.getOriginalFilename();
                        String renamedFilename = MarketUtils.renamePolicy(originalFilename);
                        File dest = new File(directory, renamedFilename);
                        upFile.transferTo(dest);

                        Attachment attach = new Attachment();
                        attach.setOriginalFilename(originalFilename);
                        attach.setRenamedFilename(renamedFilename);
                        newAttachments.add(attach);
                    }
                }
            }

            if(!newAttachments.isEmpty())
                announcement.setAttachments(newAttachments);

            customerServiceService.modifyAnnouncement(announcement);

            redirectAttr.addFlashAttribute("msg", "공지 수정 완료!");
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }

        return "redirect:/service/announcement";
    }

    @PostMapping("/enrollAnnouncement")
    public String enrollAnnouncement(Announcement announcement, @RequestParam(name="upFile", required = false) MultipartFile[] upFiles,
                                     RedirectAttributes redirectAttr) throws IOException {
        try{
            log.debug("announcement = {}", announcement);

            String saveDirectory = application.getRealPath("/resources/upload/announce");
            List<Attachment> attachments = new ArrayList<>();

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

            if(!attachments.isEmpty())
                announcement.setAttachments(attachments);
            log.debug("announcement + attach = {}", announcement);
            customerServiceService.insertAnnouncement(announcement);

            redirectAttr.addFlashAttribute("msg", "게시물 등록 성공!");
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return "redirect:/service/announcement";
    }

    @GetMapping("/announcementDetail")
    public void announcementDetail(@RequestParam String code, Model model, @CookieValue(value="announceCount", required = false, defaultValue = "0") String value,
                                     HttpServletRequest request, HttpServletResponse response){
        try{
            Map<String, Object> boardCode = new HashMap<>();
            boardCode.put("code", code);
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
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
    }

    @PostMapping("/deleteAnnouncement")
    public String deleteAnnouncement(@RequestParam String code, RedirectAttributes redirectAttr){
        try{
            String directory = "";
            log.debug("code = {}", code);
            Map<String, Object> boardCode = new HashMap<>();
            boardCode.put("code", code);
            List<Attachment> attachments = customerServiceService.selectAllAttachments(boardCode);
            if(attachments != null && !attachments.isEmpty()){
                for(Attachment attachment : attachments){
                    directory = application.getRealPath("/resources/upload/announce/" + attachment.getRenamedFilename());
                    File file = new File(directory);
                    boolean deleteFile = file.delete();
                    log.debug("deleteFile = {}", deleteFile);
                }
            }

            customerServiceService.deleteAnnouncement(boardCode);

            redirectAttr.addFlashAttribute("msg", "공지사항 삭제 성공");
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }

        return "redirect:/service/announcement";
    }

    // --------------------------------------- question

    @GetMapping("/myQuestion")
    public void myQuestion(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request, @AuthenticationPrincipal Member member){
        try{
            int limit = 10;
            int offset = (cPage - 1) * limit;
            RowBounds rowBounds = new RowBounds(offset, limit);
            List<Question> questionList = customerServiceService.selectAllMyQuestion(rowBounds, member);
            log.debug("questionList = {}", questionList);

            int totalContent = customerServiceService.countAllMyQuestion(member);
            log.debug("totalContent = {}", totalContent);

            String url = request.getRequestURI();
            String pagebar = MarketUtils.getAnnouncePagebar(cPage, limit, totalContent, url);

            model.addAttribute("pagebar", pagebar);
            model.addAttribute("questionList", questionList);
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
    }

    @GetMapping("/questionEnrollForm")
    public void questionEnrollForm(@RequestParam Map<String, Object> map, Model model){
        try{
            log.debug("map = {}", map);
            if("modify".equals((String) map.get("type"))){
                Question question = customerServiceService.selectOneQuestion(map);
                model.addAttribute("question", question);
            }
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
    }

    @PostMapping("/modifyQuestion")
    public String modifyQuestion(Question question, @RequestParam(name="upFile", required = false) MultipartFile[] upFiles,
                                     RedirectAttributes redirectAttr) throws IOException {
        try{
            log.debug("question = {}", question);
            Map<String, Object> boardCode = new HashMap<>();
            boardCode.put("code", question.getQCode());
            String directory = "";
            Question oldQuestion = customerServiceService.selectOneQuestion(boardCode);
            List<Attachment> newAttachments = new ArrayList<>();
            if(upFiles.length > 0){
                if(!oldQuestion.getAttachments().isEmpty()){
                    for(Attachment attach : oldQuestion.getAttachments()){
                        directory = application.getRealPath("/resources/upload/question/" + attach.getRenamedFilename());
                        File deleteFile = new File(directory);
                        boolean deleteBool = deleteFile.delete();
                        log.debug("deleteFile = {}", deleteBool);
                    }
                    customerServiceService.deleteAttachments(boardCode);
                }


                for(int i = 0; i < upFiles.length; i++){
                    MultipartFile upFile = upFiles[i];
                    if(!upFile.isEmpty()){
                        directory = application.getRealPath("/resources/upload/question");
                        String originalFilename = upFile.getOriginalFilename();
                        String renamedFilename = MarketUtils.renamePolicy(originalFilename);
                        File dest = new File(directory, renamedFilename);
                        upFile.transferTo(dest);

                        Attachment attach = new Attachment();
                        attach.setOriginalFilename(originalFilename);
                        attach.setRenamedFilename(renamedFilename);
                        newAttachments.add(attach);
                    }
                }
            }

            if(!newAttachments.isEmpty())
                question.setAttachments(newAttachments);

            customerServiceService.modifyQuestion(question);

            redirectAttr.addFlashAttribute("msg", "질문 수정 완료!");
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }

        return "redirect:/service/myQuestion";
    }

    @PostMapping("/enrollQuestion")
    public String enrollQuestion(Question question, @RequestParam(name="upFile", required = false) MultipartFile[] upFiles,
                                     RedirectAttributes redirectAttr) throws IOException {
        try{
            log.debug("question = {}", question);

            String saveDirectory = application.getRealPath("/resources/upload/question");
            List<Attachment> attachments = new ArrayList<>();

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

            if(!attachments.isEmpty())
                question.setAttachments(attachments);
            log.debug("question + attach = {}", question);
            customerServiceService.insertQuestion(question);

            redirectAttr.addFlashAttribute("msg", "게시물 등록 성공!");
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
        return "redirect:/service/myQuestion";
    }

    @GetMapping("/questionDetail")
    public void questionDetail(@RequestParam String code, Model model){
        try{
            Map<String, Object> boardCode = new HashMap<>();
            boardCode.put("code", code);

            Question question = customerServiceService.selectOneQuestion(boardCode);
            log.debug("question = {}", question);
            model.addAttribute("question", question);
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
    }

    @PostMapping("/deleteMyQuestion")
    public String deleteMyQuestion(@RequestParam String code, RedirectAttributes redirectAttr){
        try{
            String directory = "";
            log.debug("code = {}", code);
            Map<String, Object> boardCode = new HashMap<>();
            boardCode.put("code", code);
            List<Attachment> attachments = customerServiceService.selectAllAttachments(boardCode);
            if(attachments != null && !attachments.isEmpty()){
                for(Attachment attachment : attachments){
                    directory = application.getRealPath("/resources/upload/question/" + attachment.getRenamedFilename());
                    File file = new File(directory);
                    boolean deleteFile = file.delete();
                    log.debug("deleteFile = {}", deleteFile);
                }
            }

            customerServiceService.deleteMyQuestion(boardCode);

            redirectAttr.addFlashAttribute("msg", "질문 삭제 성공");
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }

        return "redirect:/service/myQuestion";
    }

}
