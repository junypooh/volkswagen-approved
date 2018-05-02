<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>VWA</title>
    <link rel="stylesheet" href="${vwaFrontUrl}/resources/styles/font.css">
    <link rel="stylesheet" href="${vwaFrontUrl}/resources/styles/reset.css">
    <link rel="stylesheet" href="${vwaFrontUrl}/resources/styles/layout.css">
    <link rel="stylesheet" href="${vwaFrontUrl}/resources/styles/modules.css">
    <link rel="stylesheet" href="${vwaFrontUrl}/resources/styles/contents.css">
    <link rel="stylesheet" href="${vwaFrontUrl}/resources/styles/mediaquery.css">
    <link rel="stylesheet" href="${vwaFrontUrl}/resources/styles/icons.css" media="(min-width:847px)">
    <link rel="stylesheet" href="${vwaFrontUrl}/resources/styles/m.icons.css" media="(max-width:846px)">
    <tiles:insertAttribute name="jsHeader" />
    <script type="text/javascript">
        var contextPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body>
    <div class="page-wrapper type-preview">
        <!-- s:container -->
        <div class="container">
            <!-- s:content-wrapper -->
            <tiles:insertAttribute name="body" />
            <!-- //e:content-wrapper -->
        </div>
        <!-- //e:container -->
    </div>
</body>
</html>