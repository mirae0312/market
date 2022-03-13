package com.project.market.customerService.model.vo;

public enum QuestionCategory {
    // 배송지연/불만, 컬리패스, 반품문의, a/s, 환불, 주문결제, 회원정보, 취소, 교환, 상품정보, 기타
    DE("배송지연/불만"), kurlyPass("kp"), returnProduct("rp"), orderPayment("op"), memberInfo("mi"), cancel("ca"), exchange("ex"), productInfo("pi"), etc("etc");

    private String category;

    QuestionCategory(String category){
        this.category = category;
    }

    public static QuestionCategory _valueOf(String category){
        switch (category){
            case "de": return DE;
            case "kp": return kurlyPass;
            case "rp": return returnProduct;
            case "op": return orderPayment;
            case "mi": return memberInfo;
            case "ca": return cancel;
            case "ex": return exchange;
            case "pi": return productInfo;
            case "etc": return etc;
            default: throw new AssertionError("Unknow Type Error : " + category);
        }
    }
}
