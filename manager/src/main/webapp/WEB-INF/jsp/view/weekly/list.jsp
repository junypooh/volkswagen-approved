<%--
    통계관리/WeeklyReport/목록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="container" class="container">
    <div class="wrap-contents">
        <div class="page-control">
            <div class="row">
                <div class="col-xs-6">
                    <span class="page-title"> Weekly Report</span>
                </div>
                <div class="col-xs-6 text-right">
                    <c:if test="${authType eq 'VW'}">
                        <button type="button" class="btn btn-primary" id="registe">등록</button>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="contents">
            <div class="card">
                <div class="tools">
                    <div class="row">
                        <div class="col-xs-4">
                            <button type="button" id="excelDown" class="btn btn-default"><i class="fa fa-download"></i> 양식 다운로드</button>
                        </div>
                        <div class="col-xs-8 text-right">
                            <div class="form-inline">
                                <div class="form-group guide">
                                    <span class="item-status reservation"> 예약 </span>
                                    <span class="item-status ing"> 진행중 </span>
                                    <span class="item-status invisible"> 종료 </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <table class="table table-hover table-bordered table-vertical ">
                    <colgroup>
                        <col style="width: 100px;">
                        <col>
                        <col style="width: 300px;">
                        <col style="width: 100px;">
                        <col style="width: 160px;">
                        <col style="width: 150px;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>유형</th>
                            <th>제목</th>
                            <th>업로드 기간</th>
                            <th>상태</th>
                            <th>관리자</th>
                            <th>갱신일시</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="item" varStatus="status">
                            <tr>
                                <td>${item.categoryNm}</td>
                                <td class="text-left"><a href="${pageContext.request.contextPath}/weekly/detail/${item.weekRepSeq}">${item.title}</a></td>
                                <td>${item.strDate} ~ ${item.endDate}</td>
                                <td>
                                    <c:if test="${item.flag == 0}">
                                        <span class="item-status reservation">예약</span>
                                    </c:if>
                                    <c:if test="${item.flag == 1}">
                                        <span class="item-status ing">진행중</span>
                                    </c:if>
                                    <c:if test="${item.flag == 2}">
                                        <span class="item-status end">종료</span>
                                    </c:if>
                                </td>
                                <td>${item.updUser}</td>
                                <td>${item.updDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="row" id="paging">
                    <div class="col-xs-2">
                        Total : <span>${totalCount}</span>
                    </div>
                    <div class="col-xs-10 text-right">
                        <ul class="pagination pagination-sm">
                            ${pageHtml}
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
//등록이동버튼
$(document).on("click","#registe",function(){
     location.href = "${pageContext.request.contextPath}/weekly/registeForm";
});

$(document).on("click","#excelDown",function(){
    var url = "${pageContext.request.contextPath}/resources/weeklySample/Weekly_Report_VWA_Format.xlsx";

    window.open(url, "_blank");
});
</script>
