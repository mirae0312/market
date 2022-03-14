<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param value="마켓" name="title"/>
</jsp:include>
<style>
    form{
        display: flex;
        flex-wrap: nowrap;
        flex-direction: column;
        align-content: flex-start;
        align-items: flex-start;
    }
</style>
<meta charset="UTF-8">
    <title>상품등록페이지</title>
    <h5 class="test">상품 등록폼 (임시)</h5>
    <form id="productInsertFrm" name="productInsertFrm">
        <span>브랜드명 : </span><input type="text" name="brandTitle">
        <label class="largeCategory" for="largeCategory">대분류</label>
        <select class="form-controller" name="largeCategory" id="largeCategory">
            <option>선택</option>
            <option value="A">채소</option>
            <option value="B">과일, 견과, 쌀</option>
            <option value="C">수산, 해산, 건어물</option>
            <option value="D">정육, 계란</option>
            <option value="E">국, 반찬, 메인요리</option>
            <option value="F">샐러드, 반찬식</option>
            <option value="G">면, 양념, 오일</option>
            <option value="H">생수, 음료, 우유, 커피</option>
            <option value="I">간식, 과자, 떡</option>
            <option value="J">베이커리, 치즈, 델리</option>
        </select>
        <label class="smallCategory" for="smallCategory">소분류</label>
        <select class="form-controller" name="smallCategory" id="smallCategory">
            <option>선택</option>
        </select>
        <span>상품명 : </span><input type="text" name="productTitle" placeholder="상품명">
        <span>상품가격 : </span><input type="text" name="price" placeholder="가격">
        <input type="button" onclick="optionAdd()" value="상품옵션추가">
        <div class="productOptionDiv">
        <%--     상품옵션추가       --%>
        </div>
        <span>상품 부제 : </span><input type="text" name="subTitle">
        <span>상품재고 : </span><input type="text" name="productStock">
        <label class="salesUnit" for="salesUnit">판매단위</label>
        <select class="form-controller" name="salesUnit" id="salesUnit">
            <option value="1개">1개</option>
            <option value="1봉">1봉</option>
            <option value="1팩">1팩</option>
            <option value="1망">1망</option>
        </select>
        <span>중량/용량 : </span><input type="text" name="weightCapacity">
        <span>원산지 : </span><input type="text" name="origin">
        <label class="deliveryDiv" for="deliveryDiv">배송타입</label>
        <select class="form-controller" name="deliveryDiv" id="deliveryDiv">
            <option value="샛별배송/스티로폼">샛별배송/스티로폼</option>
            <option value="샛별배송/택배배송">샛별배송/택배배송</option>
        </select>
        <label class="packType" for="packType">포장타입</label>
        <select class="form-controller" name="packType" id="packType">
            <option value="F">냉동/스티로폼</option>
            <option value="R">냉장/스티로폼</option>
            <option value="I">상온/스티로폼</option>
        </select>
        <span>포장타입 상세 : </span><input type="text" name="packTypeSub">
        <span>유통기한 : </span><input type="date" name="expiration">
        <span>알레르기 정보 : </span><input type="text" name="allergyInfo">
        <label class="sugar" for="sugar">당도</label>
        <select class="form-controller" name="sugar" id="sugar">
            <option value="">해당없음</option>
            <option value="high">높음</option>
            <option value="low">낮음</option>
        </select>
        <span>축산물 이력 정보 : </span><input type="text" name="livestockInfo">
        <span>안내사항 : </span><input type="text" name="commonInfo">
        <div id="preview">
        <%--    첨부파일 미리보기    --%>
        </div>
        <div class="uploadBox">
            <label for="productWriteImgInput">상품사진 등록</label>
            <input class="upload-name" value="첨부파일" disabled="disabled">
            <input type="file" class="productWriteImgInput" id="productWriteImgInput" name="upFile" accept=".gif, .jpg, .png, .jpeg" />
        </div>
        <button type="submit">상품등록</button>
    </form>
<script>
    var cnt = 1;
    function optionAdd() {
        $('.productOptionDiv').append (
            `<span>옵션\${cnt} : </span><input type="text" name="productOptionTitle" placeholder="상품명">
<input type="text" name="productOptionPrice" placeholder="가격"> <input type="button" class="btnRemove" value="X"><br>`
        );
        ++cnt;
        $('.btnRemove').on('click', function () {
            $(this).prev().prev().prev("span").remove ();
            $(this).prev().prev().remove ();
            $(this).prev().remove ();
            $(this).next ().remove ();
            $(this).remove ();
        });
    }

    $(productInsertFrm).submit((e) => {
        e.preventDefault();

        const product = {
            brandCode: $("[name=brandTitle]", e.target).val(),
            largeCategory: $("[name=largeCategory]", e.target).val(),
            smallCategory: $("[name=smallCategory]", e.target).val()
        }
        const productInfo = {
            price: $("[name=price]", e.target).val(),
            title: $("[name=productTitle]", e.target).val(),
            subTitle: $("[name=subTitle]", e.target).val(),
            salesUnit: $("[name=salesUnit]", e.target).val(),
            weightCapacity: $("[name=weightCapacity]", e.target).val(),
            deliveryDiv: $("[name=deliveryDiv]", e.target).val(),
            origin: $("[name=origin]", e.target).val(),
            packType: $("[name=packType]", e.target).val(),
            packTypeSub: $("[name=packTypeSub]", e.target).val(),
            expiration: $("[name=expiration]", e.target).val(),
            allergyInfo: $("[name=allergyInfo]", e.target).val(),
            sugar: $("[name=sugar]", e.target).val(),
            livestockInfo: $("[name=livestockInfo]", e.target).val(),
            commonInfo: $("[name=commonInfo]", e.target).val()
        }
        const productStock = {
            stock: $("[name=productStock]", e.target).val()
        }
        const productAttach = {
            attachment : $("[name=upFile]", e.target).val()
        }
        var jArray = [];
        var option = $("input[name=productOptionTitle]").length;
        for (var i = 0; i < option; i++){
            const productOption = {};
            productOption.optionTitle = $("[name=productOptionTitle]", e.target).eq(i).val();
            productOption.optionprice = $("[name=productOptionPrice]", e.target).eq(i).val();
            jArray.push(productOption);
        }

        jArray.push(product);
        jArray.push(productInfo);
        jArray.push(productStock);
        jArray.push(productAttach);

        const jsonStr = JSON.stringify(jArray);

        // 403에러방지 csrf토큰 headers
        const csrfToken = $("meta[name='_csrf']").attr("content");
        const csrfHeader = $("meta[name='_csrf_header']").attr("content");
        const headers = {};
        headers[csrfHeader] = csrfToken;

        $.ajax({
            url: '/market/manager/product/insertProduct',
            method: "POST",
            headers: headers,
            contentType: "application/json; charset=utf-8",
            data: jsonStr,
            dataType: 'JSON',
            traditional: true,
            success(resp){
                console.log(resp);
                alert("상품등록성공");
            },
            error: console.log
        });
    });



    // 대분류 선택에 따른 소분류 변경
    $(function(){
        $('select[name="largeCategory"] ').on('change', function()  {
            let arrType = getSmallType();
            let optionType = $('select[name="smallCategory"]');
            optionType.empty(); //소분류 비움처리

            if($(this).val() == 'A'){
                for(prop in arrType['A']){
                    optionType.append('<option value='+prop+' >'+arrType['A'][prop]+'</option>');
                }
            }
            if($(this).val() == 'B'){
                for(prop in arrType['B']){
                    optionType.append('<option value='+prop+' >'+arrType['B'][prop]+'</option>');
                }
            }
            if($(this).val() == 'C'){
                for(prop in arrType['C']){
                    optionType.append('<option value='+prop+' >'+arrType['C'][prop]+'</option>');
                }
            }
            if($(this).val() == 'D'){
                for(prop in arrType['D']){
                    optionType.append('<option value='+prop+' >'+arrType['D'][prop]+'</option>');
                }
            }
            if($(this).val() == 'E'){
                for(prop in arrType['E']){
                    optionType.append('<option value='+prop+' >'+arrType['E'][prop]+'</option>');
                }
            }
            if($(this).val() == 'F'){
                for(prop in arrType['F']){
                    optionType.append('<option value='+prop+' >'+arrType['F'][prop]+'</option>');
                }
            }
            if($(this).val() == 'G'){
                for(prop in arrType['G']){
                    optionType.append('<option value='+prop+' >'+arrType['G'][prop]+'</option>');
                }
            }
            if($(this).val() == 'H'){
                for(prop in arrType['H']){
                    optionType.append('<option value='+prop+' >'+arrType['H'][prop]+'</option>');
                }
            }
            if($(this).val() == 'I'){
                for(prop in arrType['I']){
                    optionType.append('<option value='+prop+' >'+arrType['I'][prop]+'</option>');
                }
            }
            if($(this).val() == 'J'){
                for(prop in arrType['J']){
                    optionType.append('<option value='+prop+' >'+arrType['J'][prop]+'</option>');
                }
            }
        });
    });

    function getSmallType() {
        var obj = {
            "A" : {
                '01a' : '고구마, 감자, 당근',
                '02a' : '시금치, 쌈채소, 나물',
                '03a' : '브로콜리, 파프리카, 양배추',
                '04a' : '양파, 대파, 마늘, 배추',
                '05a' : '오이, 호박, 고추',
                '06a' : '콩나물, 버섯',
            },
            "B" : {
                '01b' : '국산과일',
                '02b' : '수입과일',
                '03b' : '간편과일',
                '04b' : '냉동, 건과일',
                '05b' : '견과류',
                '06b' : '쌀, 잡곡',
            },
            "C" : {
                '01c' : '생선류',
                '02c' : '굴비, 반건류',
                '03c' : '오징어, 낙지, 문어',
                '04c' : '새우, 게, 랍스터',
                '05c' : '해산물, 조개류',
                '06c' : '김, 미역, 해조류',
            },
            "D" : {
                '01d' : '소고기',
                '02d' : '돼지고기',
                '03d' : '계란류',
                '04d' : '닭, 오리고기',
                '05d' : '양념육, 돈가스',
                '06d' : '양고기',
            },
            "E" : {
                '01e' : '국, 탕, 찌개',
                '02e' : '밀키트, 메인요리',
                '03e' : '밑반찬',
                '04e' : '김치, 젓갈, 장류',
                '05e' : '두부, 어묵, 부침개',
                '06e' : '베이컨, 햄, 통조림',
            },
            "F" : {
                '01f' : '샐러드, 닭가슴살',
                '02f' : '도시락, 밥류',
                '03f' : '떡볶이, 튀김, 순대',
                '04f' : '피자, 핫도그, 만두',
                '05f' : '폭립, 떡갈비, 안주',
                '06f' : '죽, 스프, 카레',
            },
            "G" : {
                '01g' : '파스타, 면류',
                '02g' : '식초, 소스, 드레싱',
                '03g' : '양념, 액젓, 장류',
                '04g' : '식용유, 참기름, 오일',
                '05g' : '소금, 설탕, 향신료',
                '06g' : '밀가루, 가루, 믹스',
            },
            "H" : {
                '01h' : '생수, 탄산수',
                '02h' : '음료, 주스',
                '03h' : '우유, 두유, 요거트',
                '04h' : '커피',
                '05h' : '차',
            },
            "I" : {
                '01i' : '과자, 스낵, 쿠키',
                '02i' : '초콜렛, 젤리, 캔디',
                '03i' : '떡, 한과',
                '04i' : '아이스크림',
            },
            "J" : {
                '01j' : '식빵, 빵류',
                '02j' : '잼, 버터, 스프레드',
                '03j' : '케이크, 파이, 디저트',
                '04j' : '치즈',
                '05j' : '델리',
                '06j' : '올리브, 피클',
            },

        }
        return obj;
    }
    // 사진 미리보기
    $(document).ready(function (e){
        $("input[type='file']").change(function(e){
            //div 내용 비워주기
            $('#preview').empty();
            var files = e.target.files;
            var arr =Array.prototype.slice.call(files);

            //업로드 가능 파일인지 체크
            for(var i=0;i<files.length;i++){
                if(!checkExtension(files[i].name,files[i].size)){
                    return false;
                }
            }
            preview(arr);
        });

        function checkExtension(fileName,fileSize){
            var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
            var maxSize = 20971520;  //20MB

            if(fileSize >= maxSize){
                alert('파일 사이즈 초과');
                $("input[type='file']").val("");  //파일 초기화
                return false;
            }
            if(regex.test(fileName)){
                alert('업로드 불가능한 파일이 있습니다.');
                $("input[type='file']").val("");  //파일 초기화
                return false;
            }
            return true;
        }
        function preview(arr){
            arr.forEach(function(f){
                //파일명이 길면 파일명...으로 처리
                var fileName = f.name;
                if(fileName.length > 10){
                    fileName = fileName.substring(0,7) + "...";
                }
                //div에 이미지 추가
                var str = '<div style="display: inline-flex; padding: 10px; list-style: none;"><li>';

                //이미지 파일 미리보기
                if(f.type.match('image.*')){
                    var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                    reader.onload = function (e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                        str += '<img src="'+e.target.result+'" title="'+f.name+'" width=200 />';
                        str += '</li></div>';
                        $(str).appendTo('#preview');
                    }
                    reader.readAsDataURL(f);
                }else{
                    str += '<img src="/resources/images/fileImg.png" title="'+f.name+'" width=200 />';
                    $(str).appendTo('#preview');
                }
            });
        }
    });

    $(document).ready(function(){
        var fileTarget = $('#productWriteImgInput');
        fileTarget.on('change', function(){ // 값이 변경되면
            var cur=$(".uploadBox input[type='file']").val();
            $(".upload-name").val(cur);
        });
    });
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>