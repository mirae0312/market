<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마켓" name="title"/>
</jsp:include>
    <meta charset="UTF-8">
    <title>Announcement</title>
    
 <style> 
        .boardWrapper{
            padding-bottom: 20px;
            line-height: 1;
            letter-spacing: -.05em;
            color: #4c4c4c;
            font-size: 12px;
            max-width: 100%;
        }
        /* title */
        .detailTitle{
            overflow: hidden;
            width: 1050px;
            margin: 0 auto;
            padding: 50px 0 51px;
        }
        .detailTitle .tit{
            font-weight: 700;
            font-size: 28px;
            color: #333;
            line-height: 35px;
            text-align: center;
            letter-spacing: -1px;
            margin: 0;
        }
        .detailTitle .sub{
            font-family: noto sans;
            font-size: 14px;
            color: #999;
            line-height: 20px;
            letter-spacing: -.3px;
            text-align: center;
            margin: 0;
        }
        
        /* boardDetail */
        .boardTableWrapper{
            width: 1050px;
            height: 100%;
            margin: 0 auto;
        }
         /* table */
         .boardTable, .boardView{
            border-collapse: collapse;
            font-size: 12px;
        }
        /* secondtable */
        .boardTable .boardView{
            table-layout: fixed;
            border-top: 2px solid #333;
            border-bottom: 1px solid #f4f4f4;
            color: #333;
            line-height: 180%;
            margin-top: 20px;
            /* margin: 0 auto; */
        }
        .boardTable .boardView th{
            width: 130px;
            padding: 13px 0 13px 20px;
            background-color: #f7f5f8;
            border-top: 1px solid #f4f4f4;
            text-align: left;
        }
        .boardTable.boardView td{
            width: auto;
            padding: 13px 0 13px 23px;
            border-top: 1px solid #f4f4f4;
        }
        .boardTable .boardView .date-readCount td{
            padding: 0;
            border: 0;
        }
        .boardTable .boardView .date-readCount ul{
            list-style: none;
            padding: 0;
            margin: 0;
            position: relative;
            z-index: 1;
            overflow: hidden;
            width: 100%;
            border-top: 1px solid #f4f4f4;
        }
        .boardTable .boardView .date-readCount li {float: left;}
        .boardTable .boardView .date-readCount .th{
            float: left;
            padding: 13px 0 13px 20px;
            width: 130px;
            background-color: #f7f5f8;
        }
        
        .boardTable .boardView .date-readCount .td{
            float: left;
            padding: 13px 0 13px 20px;
            width: 180px;
        }
        
        .boardTable #contents{padding: 10px;}
        .boardTable .boardDetail-btndiv{
            padding: 20px 0;
            float: right;
        }
        .boardTable .boardDetail-movement{
            border-top: 2px solid #333;
            border-bottom: 2px solid #333;
            margin: 20px 0;
        }
        .boardTable .boardDetail-movement ul{
            list-style-type: none;
            margin: 0;
        }
        .boardTable .boardDetail-movement ul li{
            overflow: hidden;
            padding: 0 20px;
            border-bottom: 1px solid #f4f4f4;
            line-height: 140%;
            color: #333;
        }
        .boardTable .boardDetail-movement li strong, .boardDetail-movement li a{
            float: left;
            padding: 10px;
        }
        .boardTable .boardDetail-movement li strong{
            width: 6%;
            padding-left: 15px;
            border-right: 1px solid #f4f4f4;
            font-weight: 400;
        }
        .boardTable .boardDetail-movement li a {

        }
        .boardTable .board-btn{
            width: 150px;
            display: inline-block;
            line-height: 40px;
            text-align: center;
            background-color: #795b8f;
            border: 1px solid #5f0080;
            color: #fff;
            font-size: 15px;
            margin-left: 2px;
            font-size: 13px;
        }
        .boardTable .board-btn:hover{
            background-color: #5f0080;
        }
    </style>

    

    <!-- questionDetail -->
    <div class="boardWrapper">
        <div class="detailTitle">
            <h2 class="tit">공지사항</h2>
            <p class="sub">컬리의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요.</p>
        </div>
        <div class="boardTableWrapper">
            <table class="boardTable boardDetailView">
                <tbody>
                    <tr>
                        <td>
                            <table width=100%>
                                <tr>
                                    <td>
                                    <table class="boardTable boardView" width=100%>
                                        <tr>
                                            <th scope="row" style="border:none;">제목</th>
                                            <td>[가격인상공지] [쏘피] 안심숙면팬티 2종 외 9건 (2022 3. 17 ~)</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">작성자</th>
                                            <td>MarketKurly</td>
                                        </tr>
                                        <tr class="date-readCount">
                                            <td colspan="2">
                                            <ul>
                                                <li class="date ">
                                                    <strong class="th">작성일</strong> <span class="td">2022-03-16</span>
                                                </li>
                                                <li class="hit ">
                                                    <strong class="th">조회수</strong> <span class="td">46</span>
                                                </li>
                                            </ul>
                                            </td>
                                        </tr>
                                    </table>
                        </td>
                    </tr>
                
                    <tr>
                        <td id="contents">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Itaque impedit ut corrupti error! Recusandae iusto aut optio! Commodi similique atque dolore harum ea laborum laudantium, fuga esse aspernatur consequuntur nostrum?</td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td>
                            
                            <div class="boardDetail-btndiv">
                                <button class="board-btn" name="" value="" onclick="${pageContext.request.contextPath}/service/announcement">목록</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            
                            <div class="boardDetail-movement">
                                <ul>
                                    <li>
                                        <strong>
                                            <i class="fas fa-angle-up"></i>이전글
                                        </strong>
                                        <a href="">이전 제목</a>
                                    </li>
                                    <li>
                                        <strong>
                                            <i class="fas fa-angle-down"></i>다음글
                                        </strong>
                                        <a href="">다음 제목</a>
                                    </li>
                                </ul>
                            </div>
                        </td>
                    </tr>

                </tfoot>
            </table>
        </div>
    </div>

  
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>