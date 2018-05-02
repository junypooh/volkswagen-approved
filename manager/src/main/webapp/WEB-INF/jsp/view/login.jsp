<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-01-18
  Time: 오후 4:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="isAuthenticated()">
    <security:authentication var="username" property="principal.username"/>
</security:authorize>
<script type="text/javascript">
    <c:if test="${not empty username}">
    location.href = '${pageContext.request.contextPath}/index';
    </c:if>
</script>
<div class="login">
    <form:form id="loginFrm" method="POST" class="form-signin" >
        <div class="form-signin-header">
            <span class="logo"><img src="${pageContext.request.contextPath}/resources/images/global-logo.png" alt=""></span>
            <h2 class="form-signin-heading">Volkswagen <br>ADMIN LOGIN</h2>
            <small>본 사이트는 관리자 전용 페이지입니다. 관리자만 접근 가능합니다.</small>
        </div>
        <label for="inputId" class="sr-only">ID</label>
        <input type="text" id="inputId" name="username" class="form-control" placeholder="아이디를 입력하세요" required="" autofocus="" value="${param.username}">
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" name="password" class="form-control" placeholder="비밀번호를 입력하세요" required="">
        <span class="checkbox">
			<label>
				<input type="checkbox" id="idchk" value="remember-me"> 아이디 저장
			</label>
        </span>
        <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
    </form:form>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        <c:choose>
        <c:when test="${not empty error and not empty SPRING_SECURITY_LAST_EXCEPTION}">
            alert('${SPRING_SECURITY_LAST_EXCEPTION.message}');
        </c:when>
        <c:otherwise>
        $('#login_id').focus();
        </c:otherwise>
        </c:choose>
        //최초 쿠키에 login_id라는 쿠키값이 존재하면
        var login_id = $.cookie('inputId');
        if (login_id != undefined) {
            //아이디에 쿠키값을 담는다
            $("#inputId").val(login_id);
            //아이디저장 체크박스 체크를 해놓는다
            $("#idchk").prop("checked", true);
        }
    });

    /**
     * 로그인 submit
     */
    $('#loginFrm').submit(function() {

        //아이디저장 체크되어있으면 쿠키저장
        if ($("#idchk").prop("checked")) {
            $.cookie('inputId', $("#inputId").val(), {expires: 7, path: '/'});
            //아이디저장 미체크면 쿠키에 정보가 있던간에 삭제
        } else {
            $.cookie("inputId", "", {expires: -1, path: '/'});
        }

    });
</script>