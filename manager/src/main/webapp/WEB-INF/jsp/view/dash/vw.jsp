<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-04-02
  Time: 오전 9:54
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
        <div class="row">
            <div class="col-xs-4">
                <div class="card card-status">
                    <div class="icon icon-primary bg-primary">
                        <i class="fa fa-thumb-tack"></i>
                    </div>
                    <strong class="title">판매중인 매물</strong>
                    <div class="count">
                        <a href="javascript:void(0)" onclick="goSellList('D1002')"><fmt:formatNumber value="${result.sellingCount}" pattern="#,###"/></a>
                    </div>
                    <p class="description">현재 홈페이지에 노출되고 있는 매물 수량</p>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="card card-status">
                    <div class="icon icon-sucess bg-success">
                        <i class="fa fa-handshake-o"></i>
                    </div>
                    <strong class="title">판매가 <span class="text-success">완료</span>된 매물</strong>
                    <div class="count">
                        <a href="javascript:void(0)" onclick="goSellList('D1004')"><fmt:formatNumber value="${result.soldOutWeeklyCount}" pattern="#,###"/></a>
                    </div>
                    <p class="description">최근 7일동안 판매완료된 매물 수량</p>
                </div>
            </div>
            <div class="col-xs-4">
                <div class="card card-status">
                    <div class="icon icon-danger bg-danger">
                        <i class="fa fa-ban"></i>
                    </div>
                    <strong class="title">판매가 <span class="text-danger">취소</span>된 매물</strong>
                    <div class="count">
                        <a href="javascript:void(0)" onclick="goSellList('D1005')"><fmt:formatNumber value="${result.cancelWeeklyCount}" pattern="#,###"/></a>
                    </div>
                    <p class="description">최근 7일동안 판매취소된 매물 수량</p>
                </div>
            </div>
        </div>
        <div class="contents">
            <div class="card">
                <div class="tools">
                    <div class="row">
                        <div class="col-xs-12">
                            <strong>매물 현황</strong> : <span>${strDate} ~ ${endDate}</span>
                        </div>
                    </div>
                </div>
                <table class="table table-bordered table-vertical ">
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>구분</th>
                        <th>전시장</th>
                        <th>판매중</th>
                        <th>완료</th>
                        <th>취소</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${result.itemStatusList}" var="item">
                        <tr <c:if test="${item.storeNm eq '계'}">class="tfoot"</c:if>>
                            <td>${item.type}</td>
                            <td>${item.storeNm}</td>
                            <td><fmt:formatNumber value="${item.sellCnt}" pattern="#,###"/></td>
                            <td><fmt:formatNumber value="${item.compCnt}" pattern="#,###"/></td>
                            <td><fmt:formatNumber value="${item.cancelCnt}" pattern="#,###"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="card">
                <div class="tools">
                    <div class="row">
                        <div class="col-xs-12">
                            <strong>Weekly Report 현황</strong>
                        </div>
                    </div>
                </div>
                <table class="table table-bordered table-vertical ">
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>유형</th>
                        <th>제목</th>
                        <th>업로드 기간</th>
                        <th>상태</th>
                        <th>완료 건수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${result.weeklyReportList}" var="item">
                        <tr>
                            <td>${item.categoryNm}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/weekly/detail/${item.weekRepSeq}">${item.title}</a>
                            </td>
                            <td>${item.strDate} ~ ${item.endDate}</td>
                            <td><span class="item-status ${item.status}">
                                <c:choose>
                                    <c:when test="${item.status eq 'reservation'}">예약</c:when>
                                    <c:when test="${item.status eq 'ing'}">진행중</c:when>
                                    <c:when test="${item.status eq 'invisible'}">종료</c:when>
                                </c:choose>
                            </span></td>
                            <td><fmt:formatNumber value="${item.count}" pattern="#,###"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="card">
                <div class="tools">
                    <div class="row">
                        <div class="col-xs-6">
                            <strong>어제 접속자 통계</strong>
                        </div>
                        <div class="col-xs-6 text-right">
                        <c:forEach items="${result.yesterDayVisit}" var="item" varStatus="status">
                            <c:if test="${status.last}">
                                합계 : <a href="${pageContext.request.contextPath}/statics/device"><fmt:formatNumber value="${item.tot}" pattern="#,###"/> 건</a>
                            </c:if>
                        </c:forEach>
                        </div>
                    </div>
                </div>
                <table class="table table-bordered table-vertical table-statistics">
                    <colgroup>
                        <col style="width: 34%">
                        <col style="width: 33%">
                        <col style="width: 33%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>디바이스</th>
                        <th>접속수</th>
                        <th>비율</th>
                    </tr>
                    </thead>
                    <c:forEach items="${result.yesterDayVisit}" var="item" varStatus="status">
                        <c:if test="${status.first}">
                            <tbody>
                        </c:if>
                        <c:if test="${status.last}">
                            </tbody>
                            <tfoot>
                        </c:if>
                                <tr>
                                    <th scope="row">${item.device}</th>
                                    <td><fmt:formatNumber value="${item.tot}" pattern="#,###"/></td>
                                    <td>${item.percent} %</td>
                                </tr>
                        <c:if test="${status.last}">
                            </tfoot>
                        </c:if>
                    </c:forEach>
                </table>
            </div>

        </div>

    </div>
</div>

<script type="text/javascript">

    /** 매물리스트로 이동 */
    function goSellList(carStatCd) {
        var $form = $('<form><input type="hidden" name="_csrf" value="${_csrf.token}"></form>');
        $form.attr('action', '${pageContext.request.contextPath}/item/list');
        $form.attr('method', 'post')

        if(carStatCd != 'D1002') {
            var sellStrDate = '<input type="hidden" name="sellStrDate" value="${strDate}0000">';
            var sellEndDate = '<input type="hidden" name="sellEndDate" value="${endDate}2359">';
            $form.append(sellStrDate).append(sellEndDate);
        }
        var carStatCds = '<input type="hidden" name="carStatCds" value="'+carStatCd+'">';

        $form.append(carStatCds);
        $(document.body).append($form);
        $form.submit();
    }

</script>
