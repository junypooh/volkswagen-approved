<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-01-18
  Time: 오후 4:59
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>VWA Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/scripts/libs/dropzone/dropzone.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/scripts/bootstrap/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/custom.css">
    <tiles:insertAttribute name="jsHeader" />
</head>
    <tiles:insertAttribute name="body" />
</body>
</html>
