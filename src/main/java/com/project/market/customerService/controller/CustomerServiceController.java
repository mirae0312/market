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

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
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

            String category = "all";
            String url = request.getRequestURI();
            String pagebar = MarketUtils.getAnnouncePagebar(cPage, limit, totalContent, url, category);
        }catch(Exception e){
            log.error(e.getMessage(), e);
            throw e;
        }
    }

    @GetMapping("/announceEnrollForm")
    public void announceEnrollForm(){}

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
    public String announcementDetail(@RequestParam String board, Model model, @CookieValue(value="announceCount", required = false, defaultValue = "0") String value,
                                     HttpServletRequest request, HttpServletResponse response){
        try{
            Map<String, Object> boardCode = new HashMap<>();
            boardCode.put("code", board);
            log.debug("value = {}", value);
            if("0".equals(value)){
                customerServiceService.updateAnnouncementReadCount(boardCode);
                value = "[" + board + "]";
            }else if(!value.contains("[" + board + "]")){
                customerServiceService.updateAnnouncementReadCount(boardCode);
                value += "[" + board + "]";
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
        return "service/announcementDetail";
    }

}
