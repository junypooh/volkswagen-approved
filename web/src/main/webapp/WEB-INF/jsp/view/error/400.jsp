<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-01-25
  Time: 오후 2:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<main class="content-wrapper page-error">
    <section class="section-error">
        <span class="img"><img src="${pageContext.request.contextPath}/resources/images/error-404.png" alt=""></span>
        <div class="content">
            <div class="error-title">
                <p>죄송합니다.<br>요청하신 페이지를 찾을 수 없습니다.</p>
            </div>
            <div class="error-content">
                <p>요청하신 페이지의 주소가 잘못 입력되었거나, 페이지의 주소가 변경 또는 삭제되어 <br>요청하신 페이지를 찾을 수 없습니다.</p><br>
                <p>입력하신 주소가 정확한지 다시 한번 확인해주시기 바랍니다.</p>
            </div>
            <div class="error-footer">
                <a href="javascript:history.back()" class="btn btn-deepdark btn-radius">이전 페이지로</a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-radius">Home</a>
            </div>
        </div>
    </section>
</main>