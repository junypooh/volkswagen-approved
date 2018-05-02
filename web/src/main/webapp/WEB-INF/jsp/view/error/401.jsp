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
        <span class="img"><img src="${pageContext.request.contextPath}/resources/images/error-500.png" alt=""></span>
        <div class="content">
            <div class="error-title">
                <p>내부 서버 오류가 발생했기 때문에<br>페이지를 표시할 수 없습니다.</p>
            </div>
            <div class="error-content">
                <p>서비스가 일시적으로 중단되었습니다.</p>
                <p>동일한 문제가 지속될 경우, 고객지원실로 연락주십시오.</p>
            </div>
            <div class="error-footer">
                <a href="javascript:history.back()" class="btn btn-deepdark btn-radius">이전 페이지로</a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-radius">Home</a>
            </div>
        </div>
    </section>
</main>