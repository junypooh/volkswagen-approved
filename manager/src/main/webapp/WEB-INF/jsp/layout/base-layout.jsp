<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>VWA Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/scripts/libs/dropzone/dropzone.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/scripts/bootstrap/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/custom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/vwa.dev.css">
    <tiles:insertAttribute name="jsHeader" />
    <script type="text/javascript">
        var contextPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body>
    <div class="wrap-page">
        <!-- header -->
        <tiles:insertAttribute name="header" />
        <!-- //header -->

        <!-- content -->
        <tiles:insertAttribute name="body" />

        <!-- footer -->
        <tiles:insertAttribute name="footer" />
        <!-- footer -->
    </div>

</body>
</html>