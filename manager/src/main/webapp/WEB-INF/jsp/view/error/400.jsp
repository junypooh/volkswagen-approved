<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-01-25
  Time: 오후 2:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="container" class="container">
    <div class="wrap-contents">
        <div class="contents">
            <div class="card error-page">
                <p class="title">
                    요청하신 페이지를 찾을 수 없습니다.<br>
                    서비스 이용에 불편을 드려 죄송합니다.
                </p>
                <p class="image"><img src="${pageContext.request.contextPath}/resources/images/error-page.png" alt=""></p>
                <p class="description">
                    찾으시려는 페이지의 주소가 잘못 입력되었거나,<br>
                    페이지의 주소 변경 혹은 삭제로 사용하실 수 없습니다.<br>
                    아래 바로가기 버튼을 통해 이동해주시기 바랍니다.
                </p>
                <p class="buttons">
                    <button type="button" class="btn btn-lg btn-default" onclick="history.back()"><i class="fa fa-angle-left" aria-hidden="true"></i> 이전</button>
                    <button type="button" class="btn btn-lg btn-primary" onclick="location.href = '${pageContext.request.contextPath}/index'"><i class="fa fa-home" aria-hidden="true"></i> 홈</button>
                </p>
            </div>
        </div>
    </div>
</div>