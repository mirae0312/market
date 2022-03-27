package com.project.market.common.Utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;

import javax.servlet.http.HttpServletRequest;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Slf4j
public class MarketUtils {

    public static String renamePolicy(String originalFilename){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
        DecimalFormat df = new DecimalFormat("000");

        String ext = "";
        int dot = originalFilename.lastIndexOf(".");
        if(dot > -1)
            ext = originalFilename.substring(dot);

        return sdf.format(new Date()) + df.format(Math.random() * 999) + ext;
    }

    public static String getAnnouncePagebar(int cPage, int limit, int totalContent, String url) {

        StringBuilder pagebar = new StringBuilder();
        url = url + "?cPage=";

        int pagebarSize = 5;
        int totalPage = (int) Math.ceil((double) totalContent / limit);
        int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
        int pageEnd = pageStart + pagebarSize - 1;
        pageEnd = totalPage < pageEnd ? totalPage : pageEnd;
        int pageNo = pageStart;

        pagebar.append("<nav aria-label=\"Page navigation example\">\r\n"
                + "  <ul class=\"pagination justify-content-center\">\n");

        // [이전]
        if(cPage == 1) {
            pagebar.append("<li class='page-item disabled'><a class='page-link' href=" + "?cPage=" + (cPage - 1) + ">Previous</a></li>\n");
        } else {
            pagebar.append("<li class='page-item'><a class='page-link' href=" + "javascript:paging(" + (cPage - 1) + ")" + ">Previous</a></li>\n");
        }

        // pageNo
        while(pageNo <= pageEnd) {
            if(pageNo == cPage) {
                pagebar.append("<li class='page-item active'><a class='page-link' href=" + "?cPage=" + pageNo + ">" + pageNo +"</a></li>\n");
            } else {
                pagebar.append("<li class='page-item'><a class='page-link' href=" + "?cPage=" + pageNo + ">" + pageNo +"</a></li>\n");
            }

            pageNo++;
        }

        // [다음]
        if(cPage == totalPage) {
            pagebar.append("<li class='page-item disabled'><a class='page-link' href=" + "?cPage=" + (cPage + 1) + ">Next</a></li>\n");
        } else {
            pagebar.append("<li class='page-item'><a class='page-link' href=" + "javascript:paging(" + pageNo + ")" + ">Next</a></li>\n");
        }

        pagebar.append(" </ul>\r\n"
                + "</nav>"
                + "<script>"
                + "const paging = (pageNo) => {location.href=`" + url + "${pageNo}`;};"
                + "</script>"
        );

        return pagebar.toString();
    }

    public static Map<String, Object> commonUtils(int cPage, int totalContent, HttpServletRequest request){
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
}
