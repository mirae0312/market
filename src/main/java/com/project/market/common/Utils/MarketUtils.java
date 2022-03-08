package com.project.market.common.Utils;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

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

    public static String getAnnouncePagebar(int cPage, int limit, int totalContent, String url, String category) {

        StringBuilder pagebar = new StringBuilder();

        return pagebar.toString();
    }
}
