<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String originalURL = (new org.springframework.web.util.UrlPathHelper()).getOriginatingRequestUri(request);
pageContext.setAttribute("originalURL", originalURL);
%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <c:set var="titleNm" value="" />
    <c:set var="originalURL" value="${originalURL}" />
    <c:set var="vwaDesc" value="폭스바겐, Volkswagen, VWA, approved, 공식사이트, 중고차, 인증중고차, 수입차,공식인증, 88가지, 연장보증, 보상판매, 비틀, 파사트, 뉴제타" />
    <c:choose>
        <c:when test="${itemView eq 'Y'}">
            <c:set var="titleNm" value="${result.info.mak} ${result.info.detailModel} ${result.info.rating} ${result.info.detailRating} > 차량정보 | 폭스바겐 공식 인증 중고차" />
            <meta property="og:type" content="article" />
            <meta property="og:title" content="${titleNm}" />
            <meta property="og:url" content="${shareUrl}" />
            <meta property="og:description" content="Volkswagen Approved | 내 차 폭스바겐에서 시작하세요." />
            <meta property="og:image" content="${pageContext.request.scheme}://${fn:replace(result.info.fileUrl, "thumbnail/", "thumbnail/facebook/")}" />
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${fn:indexOf(originalURL, '/benefit/view') != -1}"><c:set var="titleNm" value="혜택 | 폭스바겐 공식 인증 중고차" /></c:when>
                <c:when test="${fn:indexOf(originalURL, '/sellcars/view') != -1}"><c:set var="titleNm" value="내차 팔기 | 폭스바겐 공식 인증 중고차" /></c:when>
                <c:when test="${fn:indexOf(originalURL, '/comparison/view/') != -1}"><c:set var="titleNm" value="비교하기 | 폭스바겐 공식 인증 중고차" /></c:when>
                <c:when test="${fn:indexOf(originalURL, '/event/') != -1}"><c:set var="titleNm" value="이벤트 | 폭스바겐 공식 인증 중고차" /></c:when>
                <c:when test="${fn:indexOf(originalURL, '/faq/list') != -1}"><c:set var="titleNm" value="자주 묻는 질문 | 폭스바겐 공식 인증 중고차" /></c:when>
                <c:when test="${fn:indexOf(originalURL, '/branch/list') != -1}"><c:set var="titleNm" value="전시장 안내 | 폭스바겐 공식 인증 중고차" /></c:when>
                <c:when test="${fn:indexOf(originalURL, '/item/list') != -1}"><c:set var="titleNm" value="차량 검색 | 폭스바겐 공식 인증 중고차" /></c:when>
                <c:when test="${fn:indexOf(originalURL, '/community/') != -1}"><c:set var="titleNm" value="커뮤니티 | 폭스바겐 공식 인증 중고차" /></c:when>
                <c:otherwise>
                    <c:set var="titleNm" value="폭스바겐 공식 인증 중고차 | Volkswagen Approved" />
                </c:otherwise>
            </c:choose>

            <meta property="og:title" content="${titleNm}">
            <meta property="og:description" content="${vwaDesc}">
            <meta property="og:url" content="https://www.volkswagenapproved.co.kr/">
        </c:otherwise>
    </c:choose>
    <meta name="description" content="${vwaDesc}">
    <meta name="naver-site-verification" content="2e22c02569d921058a6cced2dd56e9809ba44dee"/>
    <title>${titleNm}</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/modules.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/contents.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/mediaquery.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/icons.css" media="(min-width:847px)">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/m.icons.css" media="(max-width:846px)">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/vwa.dev.css">
    <tiles:insertAttribute name="jsHeader" />
    <script type="text/javascript">
        var contextPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body>
<%-- 모바일 매물 상세 페이지에서 layout 변경 이슈로 base-layout.jsp 의 div page-wrapper 영역에 type-detail class 추가. --%>
<div class="page-wrapper <c:if test="${page eq 'itemView' and mobileCheck}">type-detail</c:if>">

    <!-- s:global-nav -->
    <tiles:insertAttribute name="header" />
    <!-- //e:global-nav -->

    <!-- s:container -->
    <div class="container">

        <!-- s:content-wrapper -->
        <tiles:insertAttribute name="body" />
        <!-- //e:content-wrapper -->

        <span class="btn-top"><a href="#none"><i class="icon icon-arrow-top">맨 위로 가기</i></a></span>
        <!-- s:footer -->
        <tiles:insertAttribute name="footer" />
        <!-- //e:footer -->

    </div>
    <!-- //e:container -->
</div>
</body>
</html>