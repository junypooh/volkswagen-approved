<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="isAuthenticated()">
    <security:authentication var="username" property="principal.username"/>
</security:authorize>

<header id="header">
    <c:if test="${not empty username}">
    <nav class="navbar navbar-inverse">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index"><img src="${pageContext.request.contextPath}/resources/images/global-logo.png" alt=""></a>
        </div>
        <ul class="nav navbar-nav">
            <c:set var="currentUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
            <security:authorize access="hasRole('ROLE_VW')">
            <li>
                <a href="javascript:" onclick="firstMenuLink(this)">사이트 관리</a>
                <ul class="navbar-2depth">
                    <li<c:if test="${fn:contains(currentUrl, '/banner/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/banner/list">배너 관리</a></li>
                    <li<c:if test="${fn:contains(currentUrl, '/popup/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/popup/list">팝업 관리</a></li>
                    <li<c:if test="${fn:contains(currentUrl, '/community/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/community/list">커뮤니티</a></li>
                    <li<c:if test="${fn:contains(currentUrl, '/faq/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/faq/list">자주하는 질문</a></li>
                    <li<c:if test="${fn:contains(currentUrl, '/event/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/event/list">이벤트</a></li>
                    <li<c:if test="${fn:contains(currentUrl, '/branch/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/branch/list">전시장 관리</a></li>
                </ul>
            </li>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_VW')">
            <li>
                <a href="javascript:" onclick="firstMenuLink(this)">차량 관리</a>
                <ul class="navbar-2depth">
                    <li<c:if test="${fn:contains(currentUrl, '/car/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/car/list">차량 관리</a></li>
                    <li<c:if test="${fn:contains(currentUrl, '/option/') and !fn:contains(currentUrl, '/register/option/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/option/list">옵션 관리</a></li>
                    <li<c:if test="${fn:contains(currentUrl, '/majoropt/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/majoropt/list">주요 옵션 관리</a></li>
                    <li<c:if test="${fn:contains(currentUrl, '/tag/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/tag/list">태그 관리</a></li>
                    <li<c:if test="${fn:contains(currentUrl, '/expose/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/expose/list">기간/주기 설정</a></li>
                </ul>
            </li>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_OPERATOR')">
            <li>
                <a href="javascript:" onclick="firstMenuLink(this)">매물 관리</a>
                <ul class="navbar-2depth">
                    <li<c:if test="${fn:contains(currentUrl, '/item/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/item/list">매물 관리</a></li>
                </ul>
            </li>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_OPERATOR')">
            <li>
                <a href="javascript:" onclick="firstMenuLink(this)">권한 관리</a>
                <ul class="navbar-2depth">
                    <li<c:if test="${fn:contains(currentUrl, '/auth/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/auth/list">관리자</a></li>
                </ul>
            </li>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_ADMIN')">
            <li>
                <a href="javascript:" onclick="firstMenuLink(this)">통계 관리</a>
                <ul class="navbar-2depth">
                    <li<c:if test="${fn:contains(currentUrl, '/weekly/')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/weekly/list">Weekly Report</a></li>
                    <li<c:if test="${fn:contains(currentUrl, '/statics/')}"> class="active"</c:if>>
                        <div class="btn-group">
                            <a href="javascript:" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">사이트 통계 <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li<c:if test="${fn:contains(currentUrl, '/statics/serviceAccess')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/statics/serviceAccess">서비스별 접속수</a></li>
                                <li<c:if test="${fn:contains(currentUrl, '/statics/flow')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/statics/flow">유입 경로</a></li>
                                <li<c:if test="${fn:contains(currentUrl, '/statics/share')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/statics/share">매물 공유수</a></li>
                                <li<c:if test="${fn:contains(currentUrl, '/statics/device')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/statics/device">접속 디바이스</a></li>
                                <li<c:if test="${fn:contains(currentUrl, '/statics/browser')}"> class="active"</c:if>><a href="${pageContext.request.contextPath}/statics/browser">접속 브라우저</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </li>
            </security:authorize>
        </ul>
        <div class="navbar-right">
            <i class="fa fa-user-circle-o"></i> <strong>${username}</strong><span>님</span>
            <a href="javascript:void(0)" onclick="$('#logoutForm').submit()" class=""><i class="fa fa-sign-out"></i> 로그아웃</a>
        </div>
        <form:form id="logoutForm" method="post" action="${pageContext.request.contextPath}/logout">
        </form:form>
    </nav>
    </c:if>
</header>
<script type="text/javascript">

    $('.navbar-nav > li').each(function() {
        $(this).find('li').each(function() {
            if($(this).hasClass('active')) {
                $(this).parent().parent('li').addClass('active');
            }
        })
    })

    $(document).ready(function () {
    });

    function firstMenuLink(obj) {
        var link = $(obj).siblings('ul').children('li').eq(0).children('a').attr('href');
        location.href = link;
    }
</script>