<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    
	<style>
    #main{
        box-sizing: border-box;
    margin: 0;
    padding: 0;
    }
    #content {
        padding-bottom: 60px;
    }
    .section_login {
    width: 340px;
    margin: 0 auto;
    padding-top: 90px;
    }
    .section_login .write_form {
    padding-top: 36px;
	}
	
	/*버튼*/
	.btn_type1, .btn_type2 {
	    display: block;
	    overflow: hidden;
	    width: 100%;
	    height: 54px;
	    border-radius: 3px;
	    text-align: center;
	}
	
	.btn_type1 {
	    border: 1px solid #5f0081;
	    background-color: #5f0080;
	}
	.btn_type1 .txt_type {
	    color: #fff;
	}
	.btn_type2 {
	    border: 1px solid #5f0081;
	    background-color: #fff;
	    margin-top: 10px;
	    line-height: 54px; /*수직 가운데 정렬*/
	    box-sizing: border-box;
	}
	.btn_type2 .txt_type {
	    color: #5f0080;
	    
	}
	
	/*로그인 폼*/
	.section_login input[type=text], .section_login input[type=password] {
	    width: 100%;
	    height: 54px;
	    border: 1px solid #ccc;
	    border-radius: 3px;
	    background-color: #fff;
	    font-size: 14px;
	    line-height: 20px;
	    outline: none;
	    padding: 0 14px;
	    box-sizing: border-box;
	}
	.section_login input[type=password]{
	    margin-top: 10px;
	}
	.section_login .tit_login {
	    font-weight: 800;
	    font-size: 20px;
	    line-height: 20px;
	    text-align: center;
	}
	.section_login .checkbox_save {
	    overflow: hidden;
	    padding-bottom: 28px;
	}
	
	.section_login .label_checkbox.checked:before {
	    background: url(https://res.kurly.com/pc/service/order/1908/ico_checkbox_on_x2.png) no-repeat 50% 50%;
	    background-size: 16px 17px;
	}
	
	.section_login .login_search .link {
	    float: left;
	    font-size: 13px;
	}
	.section_login .login_search {
	    float: right;
	    padding-top: 13px;
	}
	.section_login .checkbox_save .label_checkbox {
	    float: left;
	    margin-top: 9px;
	}
	.section_login .login_search .bar {
	    float: left;
	    width: 1px;
	    height: 10px;
	    margin: 3px 6px 0;
	    background-color: #333;
	}

    </style>
</head>

<body>
    <div id="main">
        <div id="content">
            <div class="section_login">
                <h3 class="tit_login">로그인</h3>
                <div class="write_form">
                    <div class="write_view login_view">
                        <form method="post" name="form" id="form" action="">
                            <input type="text" name="username" size="20" tabindex="1" value="" placeholder="아이디를 입력해주세요">
                            <input type="password" name="password" size="20" tabindex="2" placeholder="비밀번호를 입력해주세요">
                            
					        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					        
                            
                            <div class="checkbox_save">
                                <label class="label_checkbox checked">
                                    <input type="checkbox" id="chk_security" name="chk_security" value="y">
                                    보안접속
                                </label>

                                <div class="login_search">
                                    <a class="link">
                                        아이디 찾기
                                    </a>
                                    <span class="bar"></span>
                                    <a class="link">
                                        비밀번호 찾기
                                    </a>
                                </div>
                            </div>
                            <button class="btn_type1" type="submit">
                                <span class="txt_type">로그인</span>
                            </button>
                        </form>
                        <a class="btn_type2 btn_member">
                            <span class="txt_type">회원가입</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>