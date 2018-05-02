<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2017-12-19
  Time: 오후 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="container" class="container">
     <form id="subForm">
        <input type="hidden" name="eventSeq">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    </form>
    <div class="wrap-contents">
        <div class="page-control">
            <div class="row">
                <div class="col-xs-6">
                    <span class="page-title"> 이벤트 관리 </span>
                </div>
                <div class="col-xs-6 text-right">
                    <button type="button" id="registe" class="btn btn-primary">등록</button>
                </div>
            </div>
        </div>
        <div class="contents">
            <div class="card">
                <div class="tools">
                    <div class="row">
                        <form id="searchForm" action="${pageContext.request.contextPath}/event/list" method="POST">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="currPage" id="currPage" value="${searchParam.currPage}">
                            <div class="col-xs-4" id="head">
                                <span class="checkbox">
                                    <label>
                                    <input type="checkbox" name="expsYn" id="expsYn" <c:if test="${searchParam.expsYn != '' && searchParam.expsYn != null}">value='Y' checked="checked"</c:if>> 노출
                                    </label>
                                </span>
                            </div>

                            <div class="col-xs-8 text-right">
                                <div class="form-inline">
                                    <div class="form-group guide">
                                        <span class="item-status reservation"> 예약 </span>
                                        <span class="item-status ing"> 진행중 </span>
                                        <span class="item-status invisible"> 종료 </span>
                                    </div>
                                    <div class="input-group ">
                                            <input type="text" name="query" class="form-control" placeholder="검색어 입력" value="${searchParam.query}">
                                            <input type="hidden" name="currPage" id="currPage" value="${searchParam.currPage}">
                                            <input type='hidden' name='_csrf' value='${_csrf.token}'>
                                        <span class="input-group-btn">
                                            <button class="btn btn-default btn-search" type="button" id="searchbtn" ><i class="fa fa-search" aria-hidden="true"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <table class="table table-hover table-bordered table-vertical " id="searchTable">
                    <colgroup>
                        <col style="width: 100px;">
                        <col>
                        <col style="width: 400px;">
                        <col style="width: 100px;">
                        <col style="width: 160px;">
                        <col style="width: 100px;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>섬네일</th>
                            <th>제목</th>
                            <th>노출기간</th>
                            <th>관리자</th>
                            <th>최근 갱신 일시</th>
                            <th>노출 여부</th>
                        </tr>
                    </thead>
                    <tbody id="tt">
                        <form id="EventForm">
                            <c:forEach items="${list}" var="item" varStatus="status">
                                <tr>
                                    <td>
                                        <div class="thumbnail">
                                            <c:if test="${item.file != null}">
                                                <img data-dz-thumbnail data-dz-remove src="${pageContext.request.scheme}://${searchParam.fileUrlPath}${item.file.filePath}${item.file.fileNm}">
                                            </c:if>
                                            <c:if test="${item.file == null}">
                                                <img data-dz-thumbnail data-dz-remove src="${pageContext.request.scheme}://via.placeholder.com/350x150">
                                            </c:if>
                                        </div>
                                    </td>
                                    <td class="text-left">
                                        <a name="title" href="${pageContext.request.contextPath}/event/detail/${item.eventSeq}">${item.title}</a>
                                    </td>
                                    <td>
                                        <c:if test="${item.flag == 0}">
                                            <span class="item-status reservation">
                                            <span>예약</span>
                                        </c:if>
                                        <c:if test="${item.flag == 1}">
                                            <span class="item-status ing">
                                            <span>진행중</span>
                                        </c:if>
                                        <c:if test="${item.flag == 2}">
                                            <span class="item-status end">
                                            <span>종료</span>
                                        </c:if>
                                            ${item.strDate}~ ${item.endDate}
                                        </span>
                                    </td>
                                    <td name="updUser">
                                        ${item.updUser}
                                    </td>
                                    <td name="updDate">
                                        ${item.updDate}
                                    </td>
                                    <td>
                                        <div class="onoffswitch">
                                            <input type="hidden" name="checkYn" value="${item.expsYn}">
                                            <input type="hidden" name="eventSeq" value="${item.eventSeq}">
                                            <input type="checkbox" class="onoffswitch-checkbox" data-id="${status.index}" name="isVisibled" id="isVisibled-${status.index}" <c:if test="${item.expsYn eq 'Y'}"> checked="checked"</c:if>>
                                            <label class="onoffswitch-label" for="isVisibled-${status.index}">
                                                <i class="inner"></i><i class="switch"></i>
                                            </label>
                                        </div>
                                        <div class="btns">
                                            <button type="button" style="display : none;" name="cancelButton" class="btn btn-xs btn-default ">취소</button>
                                            <button type="button" style="display : none;" name="applyButton" class="btn btn-xs btn-primary ">적용</button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </form>
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
//노출버튼 이벤트
$(document).on("click","#expsYn",function(){
    $("#currPage").val("1");
    search();
});

//검색버튼 이벤트
$(document).on("click","#searchbtn",function(){
    $("#currPage").val("1");
    $("#expsYn").prop("checked", false);
    search();
});

//검색어입력 엔터 이벤트
$(document).on("keypress","input[name='query']",function(key){
    if(key.keyCode==13){
        $("#currPage").val("1");
        $("#expsYn").prop("checked", false);
        search();
        return false;
    }
});

//등록버튼 이동
$(document).on("click","#registe",function(){
    location.href = "${pageContext.request.contextPath}/event/registeForm";
});

//편집버튼 이동
function edit(eventSeq){
    $("#subForm").attr("action", "${pageContext.request.contextPath}/event/detail");
    $("#subForm").attr("method", "POST");
    $("#subForm").find("input[name='eventSeq']").val(eventSeq);
    $("#subForm").submit();
}

//스위치 버튼 이벤트
$(document).on("click","input[name='isVisibled']",function(){
    var td=$(this).closest("td");
    var checkYn=$(td).find("input[name='checkYn']").val();
    var currentYn;
    if($(this).prop("checked")){
        currentYn='Y';
    } else {
        currentYn='N';
    }

    if(checkYn == currentYn){
        $(td).find("button[name='applyButton']").hide();
        $(td).find("button[name='cancelButton']").hide();
    } else {
        $(td).find("button[name='applyButton']").show();
        $(td).find("button[name='cancelButton']").show();
    }
});

//스위치 버튼 취소이벤트
$(document).on("click","button[name='cancelButton']",function(){
    var td=$(this).closest("td");
    var checkYn=$(td).find("input[name='checkYn']").val();
    if(checkYn=='Y'){
        $(td).find("input[name='isVisibled']").prop("checked",true);
    } else {
        $(td).find("input[name='isVisibled']").prop("checked",false);
    }
    $(td).find("button[name='applyButton']").hide();
    $(td).find("button[name='cancelButton']").hide();
});

//스위치 버튼 적용이벤트
$(document).on("click","button[name='applyButton']",function(){
    var td=$(this).closest("td");
    var eventSeq=$(td).find("input[name='eventSeq']").val();
    if($(td).find("input[name='isVisibled']").prop("checked")){
        var expsYn='Y';
    } else {
        var expsYn='N';
    }
    $(td).find("input[name='checkYn']").val(expsYn);

    $(td).find("button[name='applyButton']").hide();
    $(td).find("button[name='cancelButton']").hide();

    $.ajax({
        url : "${pageContext.request.contextPath }/event/eventExpsYnUpdate",
        type : "POST",
        data : {eventSeq:eventSeq ,expsYn:expsYn},
        dataType : "text",
        success : function(name){

        }
    });
});

//검색
function search(){
    $.ajax({
        url : "${pageContext.request.contextPath}/event/list",
        type: "POST",
        data : $("#searchForm").serialize(),
        dataType : "html",
        success : function(data){
            $("#searchTable").html($(data).find('#searchTable').html());
            $("#paging").html($(data).find('#paging').html());
        }
   });
}

//페이지 이동
function goPage(page){
    $("#currPage").val(page);
    search();
}
</script>
