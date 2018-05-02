<%--
    통계관리/WeeklyReport/모달팝업
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="modal fade search-manager" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" id="modalBody">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">그룹 관리자 찾기</h4>
            </div>
            <div class="modal-body">
                <div class="tools">
                    <div class="row">
                        <div class="col-xs-5"></div>
                        <div class="col-xs-7 text-right">
                            <div class="input-group">
                                <input type="text" name="searchText" class="form-control" placeholder="전시장명, 아이디로 검색하세요." value="${searchText}">
                                <span class="input-group-btn">
                                    <button class="btn btn-default btn-search" type="button" id="search"><i class="fa fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <table class="table table-vertical table-bordered ">
                    <colgroup>
                        <col style="width: 50px;">
                        <col style="width: 200px;">
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>그룹관리자</th>
                            <th>전시장</th>
                            <th>메모</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="authority" items="${authorityList}" varStatus="status">
                            <tr>
                                <td>
                                    <span class="checkbox">
                                        <label>
                                            <input name="admSeq" type="checkbox" value="${authority.admSeq}" <c:if test="${authority.checkYn}">checked="checked"</c:if>>
                                        </label>
                                    </span>
                                </td>
                                <td>
                                    ${authority.id}
                                </td>
                                <td>
                                    <c:forEach var="authExhibMap" items="${authority.list}">
                                        ${authExhibMap.type} / ${authExhibMap.storeNm} <br>
                                    </c:forEach>
                                </td>
                                <td>
                                    ${authority.memo}
                                </td>
                                <input name="detailStrDate" id="MstrDate${status.index}" type="hidden">
                                <input name="detailEndDate" id="MendDate${status.index}" type="hidden">
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" id="close" class="btn btn-default" data-dismiss="modal">닫기</button>
                <button type="button" id="save" class="btn btn-primary">저장</button>
            </div>
        </div>
    </div>
</div>
