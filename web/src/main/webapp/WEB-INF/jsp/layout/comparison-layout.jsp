<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta property="og:type" content="article" />
    <meta property="og:title" content="비교하기" />
    <meta property="og:url" content="${shareUrl}" />
    <meta property="og:description" content="Volkswagen Approved | 내 차 폭스바겐에서 시작하세요." />
    <meta property="og:image" content="${vwaFrontUrl}/resources/images/share-thumb.png" />
    <meta name="description" content="Volswagen Approved | 폭스바겐 공식 인증 중고차">
    <meta name="naver-site-verification" content="2e22c02569d921058a6cced2dd56e9809ba44dee"/>
    <title>Volswagen Approved | 폭스바겐 공식 인증 중고차</title>
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

    <!-- s:content-wrapper -->
    <tiles:insertAttribute name="body" />
    <!-- //e:content-wrapper -->

</div>
</body>
</html>