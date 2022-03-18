package com.project.market.customerService.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Getter
public enum QuestionCategory {
    // 배송지연/불만, 컬리패스, 반품문의, a/s, 환불, 주문결제, 회원정보, 취소, 교환, 상품정보, 기타
//    delivery("de"), kurlyPass("kp"), returnProduct("rp"), orderPayment("op"), memberInfo("mi"), cancel("ca"), exchange("ex"), productInfo("pi"), etc("etc");
    DE("배송지연/불만", "delivery"), KP("컬리패스(무료배송)", "kurlyPass"), RP("반품문의", "returnProduct"), OP("주문결제문의", "orderPayment"),
    MI("회원정보문의", "memberInfo"), CA("취소문의", "cancel"), EX("교환문의", "exchange"), PI("상품정보문의", "productInfo"), ETC("기타문의", "etc");

    private String category;
    private String eCategory;

    QuestionCategory(String category, String eCategory){
        this.category = category;
        this.eCategory = eCategory;
    }

//    public static QuestionCategory _valueOf(String category){
//        switch (category){
//            case "de": return delivery;
//            case "kp": return kurlyPass;
//            case "rp": return returnProduct;
//            case "op": return orderPayment;
//            case "mi": return memberInfo;
//            case "ca": return cancel;
//            case "ex": return exchange;
//            case "pi": return productInfo;
//            case "etc": return etc;
//            default: throw new AssertionError("Unknow Type Error : " + category);
//        }
//    }
}
