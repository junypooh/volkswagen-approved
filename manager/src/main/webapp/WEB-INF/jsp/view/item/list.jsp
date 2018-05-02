<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-01-25
  Time: 오후 1:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="container" class="container">
    <div class="wrap-contents">
        <div class="page-control">
            <div class="row">
                <div class="col-xs-6">
                    <span class="page-title"> 매물 관리 </span>
                </div>
                <div class="col-xs-6 text-right">
                    <button type="button" class="btn btn-default" onclick="myDiscMng()">내 설명글 관리</button>
                    <c:if test="${result.regPossibleYn eq 'Y'}">
                        <button type="button" class="btn btn-secondary" onclick="location.href = '${pageContext.request.contextPath}/item/register/nvwa'">비폭스바겐 차량 등록</button>
                        <button type="button" class="btn btn-primary" onclick="location.href = '${pageContext.request.contextPath}/item/register/vwa'">폭스바겐 차량 등록</button>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="contents">
            <div class="card">
                <div class="tools">
                    <div class="row">
                        <div class="col-xs-5">
                            <div class="form-inline">
                                <span class="select">
                                    <select name="hallType" id="hallType" class="form-control" onchange="goPage(1)" <c:if test="${fn:length(result.hallTypeList) < 2}">disabled</c:if>>
                                        <c:if test="${fn:length(result.hallTypeList) > 1}">
                                            <option value="">딜러사 전체</option>
                                        </c:if>
                                        <c:forEach items="${result.hallTypeList}" var="hallTypeList">
                                            <option value="${hallTypeList.hallType}">${hallTypeList.type}</option>
                                        </c:forEach>
                                    </select>
                                </span>
                                <span class="select">
                                    <select name="exhHallSeq" id="exhHallSeq" class="form-control" onchange="goPage(1)" <c:if test="${fn:length(result.hallList) < 2}">disabled</c:if>>
                                        <c:if test="${fn:length(result.hallList) > 1}">
                                            <option value="">전시장 전체</option>
                                        </c:if>
                                        <c:forEach items="${result.hallList}" var="hallList">
                                            <option value="${hallList.exhHallSeq}">${hallList.storeNm}</option>
                                        </c:forEach>
                                    </select>
                                </span>
                                <span class="select">
                                    <select name="creAdmSeq" id="creAdmSeq" class="form-control" onchange="goPage(1)" <c:if test="${fn:length(result.userList) < 2}">disabled</c:if>>
                                        <c:if test="${fn:length(result.userList) > 1}">
                                            <option value="">등록자 전체</option>
                                        </c:if>
                                        <c:forEach items="${result.userList}" var="userList">
                                            <option value="${userList.admSeq}">${userList.creUser}</option>
                                        </c:forEach>
                                    </select>
                                </span>
                            </div>
                        </div>
                        <div class="col-xs-7 text-right">
                            <div class="wrap-calendar form-inline ">
                                <div class="input-group">
                                    <div class="input-icon">
                                        <i class="fa fa-calendar"></i>
                                        <input type="text" class="form-control datetimepicker" name="timeStart" value="${param.sellStrDate}" placeholder="from" id="sellStrDate">
                                    </div>
                                    <span class="input-group-addon">~</span>
                                    <div class="input-icon">
                                        <i class="fa fa-calendar"></i>
                                        <input type="text" class="form-control datetimepicker" name="timeEnd" value="${param.sellEndDate}" placeholder="to" id="sellEndDate">
                                    </div>
                                </div>
                                <div class="input-group ">
                                    <input type="text" name="query" class="form-control" placeholder="검색어 입력" id="searchWord">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default btn-search" type="button" id="search" onclick="goPage(1)"><i class="fa fa-search" aria-hidden="true"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-10">
                            <span class="checkbox-inline">
                                <label>
                                    <input type="checkbox" id="allCheck"> 전체
                                </label>
                            </span>
                            <span class="checkbox-inline">
                                <label>
                                    <input type="checkbox" name="sellStatus" value="D1006"> 임시저장
                                </label>
                            </span>
                            <span class="checkbox-inline">
                                <label>
                                    <input type="checkbox" name="sellStatus" value="D1001"> 승인대기
                                </label>
                            </span>
                            <%--<span class="checkbox-inline">
                                <label>
                                    <input type="checkbox" value="D1001"> 승인중
                                </label>
                            </span>--%>
                            <span class="checkbox-inline">
                                <label>
                                    <input type="checkbox" name="sellStatus" value="D1002"> 판매중
                                </label>
                            </span>
                            <span class="checkbox-inline">
                                <label>
                                    <input type="checkbox" name="sellStatus" value="D1003"> 반려
                                </label>
                            </span>
                            <span class="checkbox-inline">
                                <label>
                                    <input type="checkbox" name="sellStatus" value="D1004"> 판매완료
                                </label>
                            </span>
                            <span class="checkbox-inline">
                                <label>
                                    <input type="checkbox" name="sellStatus" value="D1005"> 판매취소
                                </label>
                            </span>
                            <span class="checkbox-inline">
                                <label>
                                    <input type="checkbox" name="sellStatus" value="D1010"> 비공개
                                </label>
                            </span>
                        </div>
                        <div class="col-xs-2 text-right">
                            <button type="button" class="btn btn-default" onclick="downloadExcel()"><i class="fa fa-download"></i> 엑셀 다운로드</button>
                        </div>
                    </div>
                </div>
                <table class="table table-hover table-bordered table-vertical tablesorter">
                    <colgroup>
                        <col style="width: 70px;">
                        <col style="width: 100px;">
                        <col>
                        <col>
                        <col>
                        <col>
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
                        <th data-sorter="false">매물번호</th>
                        <th data-sorter="false">섬네일</th>
                        <th data-sorter="false">제조사</th>
                        <th data-sorter="false">모델</th>
                        <th data-sorter="false">연식</th>
                        <th class="header" id="CAST(SELL_PRICE AS UNSIGNED)">가격<br>(만원)</th>
                        <th data-sorter="false">VWA</th>
                        <th data-sorter="false">상태</th>
                        <th data-sorter="false">딜러사</th>
                        <th data-sorter="false">전시장</th>
                        <th data-sorter="false">등록자</th>
                        <th class="header" id="SELL_TIME">판매기간</th>
                        <th class="header" id="STOCK_TIME">재고기간</th>
                        <th class="header" id="CAST(HITS AS UNSIGNED)">조회수</th>
                        <th data-sorter="false">이력보기</th>
                    </tr>
                    </thead>
                    <tbody id="contentHtml">
                    <c:forEach items="${result.info}" var="list">
                        <tr>
                            <td>
                                <a href="${pageContext.request.contextPath}/item/register/price/${list.sellCarSeq}">${list.carSellNo}</a>
                            </td>
                            <td>
                                <div class="thumbnail">
                                    <img src="${pageContext.request.scheme}://${list.fileUrl}" alt="..." onerror="javascript:this.src='http://via.placeholder.com/350x150'">
                                </div>
                            </td>
                            <td>
                                ${list.mak}
                            </td>
                            <td>
                                ${list.model}
                            </td>
                            <td>
                                ${list.prodYear}
                            </td>
                            <td>
                                <fmt:formatNumber value="${list.sellPrice}" pattern="#,###"/>
                            </td>
                            <td>
                                ${list.vwa}
                            </td>
                            <td>
                                ${list.cdNm}
                            </td>
                            <td>
                                ${list.hallType}
                            </td>
                            <td>
                                ${list.storeNm}
                            </td>
                            <td>
                                ${list.creUser}
                            </td>
                            <td>
                                ${list.sellTime}
                            </td>
                            <td>
                                ${list.stockTime}
                            </td>
                            <td>
                                <fmt:formatNumber value="${list.hits}" pattern="#,###"/>
                            </td>
                            <td>
                                <%--<button type="button" class="btn btn-sm btn-default" data-toggle="modal" data-target="#historyView">보기</button>--%>
                                <button type="button" class="btn btn-sm btn-default" onclick="statHistory('${list.sellCarSeq}', '${list.exhHallSeq}')" >보기</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="row" id="rowHtml">
                    <div class="col-xs-2">
                        Total : <span>${result.infoTotCnt}</span>
                    </div>
                    <div class="col-xs-10 text-right">
                        <ul class="pagination pagination-sm">
                            ${pageHtml}
                        </ul>
                    </div>
                </div>
            </div>
            <!-- 메물 이력보기 팝업 -->
            <div class="modal fade" id="historyView" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">매물 이력보기</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table table-bordered table-vertical">
                                <colgroup>
                                    <col style="width: 70px;">
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>순서</th>
                                    <th>구분</th>
                                    <th>아이디</th>
                                    <th>일시</th>
                                    <th colspan="2">이력</th>
                                    <th>노출</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:set value="${fn:length(sellStatHis)}" var="statTotCnt"/>
                                <c:forEach items="${sellStatHis}" var="sellStatHis" varStatus="status">
                                    <tr>
                                        <td>${statTotCnt - status.index}</td>
                                        <td>${sellStatHis.authType}</td>
                                        <td>${sellStatHis.creUser}</td>
                                        <td>${sellStatHis.creDate}</td>
                                        <td>${sellStatHis.carStatMnu}</td>
                                        <td>${sellStatHis.cdNm}</td>
                                        <td>${sellStatHis.disp}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //매물 이력보기 팝업 -->
            <!-- 내 설명글 관리 팝업 -->
            <div class="modal fade" id="myContents" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">내 설명글 관리</h4>
                        </div>
                        <div class="modal-body">
                            <p><small>판매차량의 상태, 용도, 판매 이유 등과 같은 차량 설명글을 미리 저장하고 편리하게 관리하실 수 있습니다. <br>내설명글은 차량설명 입력 시 불러와서 사용하실 수 있습니다.</small></p>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-10">
                                            <div class="form-inline">
														<span class="select">
															<select name="discSeq" id="discSeq" class="form-control" onchange="selectMyDisc()">
																<option value="">내 설명글 선택 (${fn:length(result.myDiscMngList)})</option>
                                                                <c:forEach items="${result.myDiscMngList}" var="myDiscMngList">
                                                                    <option value="${myDiscMngList.discSeq}">${myDiscMngList.discNm}</option>
                                                                </c:forEach>
															</select>
														</span>
                                                <input type="text" class="form-control" id="discNm" name="discNm">
                                                <button type="button" class="btn btn-default" onclick="updMyDisc()" >이름 변경</button>
                                            </div>
                                        </div>
                                        <div class="col-xs-2 text-right">
                                            <button type="button" class="btn btn-primary" onclick="resetDisc()"><i class="fa fa-refresh"></i> 내용 초기화</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <textarea name="discCtnt" id="discCtnt" cols="30" rows="10" class="form-control">${result.myDisc.discCtnt}</textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer">
                                    <div class="row">
                                        <div class="col-xs-9">
                                            <div class="form-inline">
                                                <input type="text" class="form-control" placeholder="제목을 입력하세요." id="discTitle">
                                                <button type="button" class="btn btn-default" onclick="insMyDisc()" >다른 이름으로 저장</button>
                                            </div>
                                        </div>
                                        <div class="col-xs-3 text-right">
                                            <button type="button" class="btn btn-default" onclick="updMyDisc()"><i class="fa fa-ok"></i> 저장</button>
                                            <button type="button" class="btn btn-default" onclick="delMyDisc()"><i class="fa fa-trash"></i> 삭제</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //내 설명글 관리 팝업 -->

        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/scripts/jquery/plugins/jquery.common.js"></script>
<script type="text/javascript">

    var _params = {};
    var _orderColumn = "";
    var _orderType = "";


    $(document).ready(function () {
        $('.tablesorter th.header').on('sort', function(type, arguments){
            _orderColumn = $(this).attr('id');
            _orderType = arguments;
            goPage(1);
        });

        // 달력
        $('.datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            locale: "kr"
        });


        // 상태값 체크
        $.each(${result.statList}, function (idx, statCd) {
            $('input[name=sellStatus]').each(function() {
                if (statCd == $(this).val()) {
                    $(this).prop('checked', true);
                }
            });
        });

        // 상태값 변경시
        $('input[name=sellStatus]').change(function() {
            if ($('input[name=sellStatus]').length != $('input[name=sellStatus]:checked').length) {
                $('#allCheck').prop('checked', false);
            }
            goPage(1);

        });

        // 전체 선택 클릭
        $('#allCheck').click(function() {
            if ($('#allCheck').prop('checked')) {
                $('input[name=sellStatus]').prop('checked', true);
            } else {
                $('input[name=sellStatus]').prop('checked', false);
            }
            goPage(1);

        });


        enterFunc($('#searchWord'), goPage);

        $(".tablesorter").tablesorter();


    });


    /** 페이징 */
    function goPage(currPage) {

        // 상태값이 선택 안되었을때..
        /*
        if ($('input[name=sellStatus]:checked').length < 1) {
            $('#contentHtml').empty();
            $('#rowHtml .col-xs-2').html('Total : <span>0</span>');
            $('#rowHtml .col-xs-10 .pagination').empty();
            _params = {};
            return false;
        }
        */

        var _data = {};
        _data.currPage       = currPage;
        _data.hallType       = $('#hallType').val();
        _data.exhHallSeq     = $('#exhHallSeq').val();
        _data.creAdmSeq      = $('#creAdmSeq').val();
        _data.sellStrDate    = $('#sellStrDate').val().split(' ').join('');
        _data.sellEndDate    = $('#sellEndDate').val().split(' ').join('');
        _data.searchWord     = $('#searchWord').val();

        _data.orderColumn    = _orderColumn;
        _data.orderType      = _orderType;

        var carStatCds = new Array();
        $('input[name=sellStatus]:checked').each(function() {
            carStatCds.push($(this).val());
        });

        _data.carStatCds = carStatCds;
        _data.checkType = 'checkBox';

        $.ajax({
            url: "${pageContext.request.contextPath}/item/list",
            type: "POST",
            data : _data,
            success: function(result) {
                $('#contentHtml').empty().append($(result).find('#contentHtml').html());
                $('#rowHtml').empty().append($(result).find('#rowHtml').html());
                _params = _data;
            }
        });
    }


    /** 이력보기 클릭 */
    function statHistory(sellCarSeq, exhHallSeq) {

        $.ajax({
            url: "${pageContext.request.contextPath}/item/sellStatHis",
            type: "POST",
            data : {sellCarSeq: sellCarSeq, exhHallSeq: exhHallSeq},
            success: function(result) {
                $('#historyView').empty().append($(result).find('#historyView').html());
            }
        });

        $('#historyView').modal('show');
    }


    /** 내설명글관리 */
    function myDiscMng() {
        $.ajax({
            url: "${pageContext.request.contextPath}/item/sellMyDiscMng",
            type: "POST",
            success: function(result) {
                $('#myContents').empty().append($(result).find('#myContents').html());
            }
        });
        $('#myContents').modal('show');
    }


    /** 내 설명글 선택 */
    function selectMyDisc() {
        var discSeq = $('#discSeq').val();

        if (discSeq != '') {
            $('#discNm').val($('#discSeq option:selected').text());
        } else {
            $('#discNm').val('');
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/item/sellMyDiscMng",
            type: "POST",
            data : {discSeq: discSeq},
            success: function(result) {
                $('#discCtnt').empty().append($(result).find('#discCtnt').html());
            }
        });
    }

    /** 내 설명글 등록 */
    function insMyDisc() {
        $.ajax({
            url: "${pageContext.request.contextPath}/item/insDiscMng",
            type: "POST",
            data : {discNm: $('#discTitle').val(), discCtnt: $('#discCtnt').val()},
            success: function(result) {
                if (result == 'SUCC') {
                    alert('등록되었습니다.');
                    myDiscMng();
                }
            }
        });
    }

    /** 내 설명글 수정 */
    function updMyDisc() {
        $.ajax({
            url: "${pageContext.request.contextPath}/item/updDiscMng",
            type: "POST",
            data : {discSeq: $('#discSeq').val(), discNm: $('#discNm').val(), discCtnt: $('#discCtnt').val()},
            success: function(result) {
                if (result == 'SUCC') {
                    alert('수정되었습니다.');
                    myDiscMng();
                }

            }
        });
    }

    /** 내 설명글 삭제 */
    function delMyDisc() {
        $.ajax({
            url: "${pageContext.request.contextPath}/item/delDiscMng",
            type: "POST",
            data : {discSeq: $('#discSeq').val()},
            success: function(result) {
                if (result == 'SUCC') {
                    alert('삭제되었습니다.');
                    myDiscMng();
                }
            }
        });
    }

    /** 내 설명글 내용 초기화 */
    function resetDisc() {
        $('#discCtnt').val('');
    }


    /** 엑셀 다운로드 */
    function downloadExcel(){

        var url = "${pageContext.request.contextPath}/item/listExcel";
        var inputs = "";
        var paramData = $.param(_params, true);
        $.each(paramData.split('&'), function () {
            var pair = this.split('=');
            inputs += "<input type='hidden' name='" + pair[0] + "' value='" + pair[1] + "' />";
        });
        inputs += "<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>";

        var sForm = "<form action='" + url + "' method='POST'>" + inputs + "</form>";

        $(sForm).appendTo("body").submit().remove();

    }
</script>