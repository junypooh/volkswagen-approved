<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2017-12-19
  Time: 오후 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<main class="content-wrapper page-branch">
    <section class="section section-visual">
        <div class="inner">
            <div class="item">
                <h2 class="page-header">BRANCH</h2>
                <i class="image" style="background-image:url('../resources/images/branch-top-visual.jpg');"></i>
            </div>
        </div>
    </section>
    <section class="section section-list">
        <div class="inner">
            <div class="control">
                <span class="count" id="count">전체<strong>${fn:length(branchList)} </strong>개</span>
                <div class="sort">
                    <fieldset>
                        <legend>정렬</legend>
                        <div class="form">
                            <form id="searchForm" action="${pageContext.request.contextPath}/branch/list" method="POST">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <select class="design-select gray-select small-select" name="sigun" id="categoryCd">
                                    <option value="">지역 전체</option>
                                    <c:forEach var="branch" items="${branchGroup}" varStatus="status">
                                        <option name="sigun" value="${branch.sigun}">${branch.sigun}</option>
                                    </c:forEach>
                                </select>
                            </form>
                        </div>
                    </fieldset>
                </div>
            </div>
            <div class="list" id="searchTable">
                <c:forEach var="branch" items="${branchList}" varStatus="status">
                <!-- item -->
                <div class="item">
                    <div class="info">
                        <span><em>Volkswagen Approved</em> 폭스바겐 인증 중고차</span>
                        <strong>${branch.storeNm}</strong>
                        <ul>
                            <li class="icon icon-location">${branch.detailAddr}</li>
                            <li class="icon icon-tel">${branch.tel}</li>
                        </ul>
                    </div>
                    <div class="map">
                        <a href="http://map.naver.com/index.nhn?enc=utf8&level=2&lng=${branch.xcoordinate}&lat=${branch.ycoordinate}&pinTitle=${branch.addr}" target="_blank">
                            <img src="https://openapi.naver.com/v1/map/staticmap.bin?clientId=${searchParam.clientId}&url=${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}&crs=EPSG:4326&center=${branch.xcoordinate},${branch.ycoordinate}&level=11&w=700&h=225&baselayer=default&markers=${branch.xcoordinate},${branch.ycoordinate}">
                        </a>
                    </div>
                </div>
                <!-- // item -->
                </c:forEach>
            </div>
        </div>
    </section>
</main>
<!-- //e:content-wrapper -->
<script type="text/javascript">
//유형선택 이벤트
$(document).on("change","#categoryCd",function(){
    $.ajax({
        url : "${pageContext.request.contextPath}/branch/list",
        type: "POST",
        data : $("#searchForm").serialize(),
        dataType : "html",
        success : function(data){
            $("#searchTable").html($(data).find('#searchTable').html());
            $("#count").html($(data).find('#count').html());
        }
   });
});
</script>