<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-04-02
  Time: 오전 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div id="container" class="container">
    <div class="wrap-contents">
        <div class="page-control">
            <div class="row">
                <div class="col-xs-6">
                    <span class="page-title"> 작성중인 매물 [<strong><fmt:formatNumber value="${fn:length(tempList)}" pattern="#,###"/></strong>]</span>
                </div>
            </div>
        </div>
        <div class="contents">
            <div class="card">
                <table class="table table-hover table-bordered table-vertical ">
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>매물번호</th>
                        <th>제조사</th>
                        <th>모델</th>
                        <th>연식</th>
                        <th>가격<br>(만원)</th>
                        <th>VWA</th>
                        <th>딜러사</th>
                        <th>전시장</th>
                        <th>등록자</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${result.tempList}" var="item">
                        <tr>
                            <td><a href="${pageContext.request.contextPath}/item/register/price/${item.sellCarSeq}">${item.carSellNo}</a></td>
                            <td>${item.mak}</td>
                            <td>${item.model} ${item.detailModel}</td>
                            <td>${item.fromYear}</td>
                            <td><fmt:formatNumber value="${item.sellPrice}" pattern="#,###"/></td>
                            <td>${item.certYn}</td>
                            <td>${item.hallType}</td>
                            <td>${item.storeNm}</td>
                            <td>${item.id}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>

        <div class="page-control">
            <div class="row">
                <div class="col-xs-6">
                    <span class="page-title"> 심사대기매물 매물 [<strong><fmt:formatNumber value="${fn:length(evaluateList)}" pattern="#,###"/></strong>]</span>
                </div>
            </div>
        </div>
        <div class="contents">
            <div class="card">
                <table class="table table-hover table-bordered table-vertical ">
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>매물번호</th>
                        <th>제조사</th>
                        <th>모델</th>
                        <th>연식</th>
                        <th>가격<br>(만원)</th>
                        <th>VWA</th>
                        <th>딜러사</th>
                        <th>전시장</th>
                        <th>등록자</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${result.evaluateList}" var="item">
                        <tr>
                            <td><a href="${pageContext.request.contextPath}/item/register/price/${item.sellCarSeq}">${item.carSellNo}</a></td>
                            <td>${item.mak}</td>
                            <td>${item.model} ${item.detailModel}</td>
                            <td>${item.fromYear}</td>
                            <td><fmt:formatNumber value="${item.sellPrice}" pattern="#,###"/></td>
                            <td>${item.certYn}</td>
                            <td>${item.hallType}</td>
                            <td>${item.storeNm}</td>
                            <td>${item.id}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>