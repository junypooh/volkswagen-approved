<%--
    전시장관리/목록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(function(){

    //정렬저장버튼 이벤트
    $(document).on("click","#updateIndex",function(){

        $.ajax({
            url : "${pageContext.request.contextPath}/branch/updateExpsdNo",
            type: "POST",
            data : $("#updateIndexForm").serialize(),
            success : function(result){
               if(result > 0 ){
               } else {
                   alert("순서정렬에 실패했습니다.");
               }
            }
        });
    });

    //노출버튼
    $(document).on("click","#expsYn",function(){
        search();
    });

    //검색버튼
    $(document).on("click","#search",function(){
        $("#expsYn").prop("checked", false);
        search();
    });

    //검색어입력 엔터
    $(document).on("keypress", "input[name='searchText']",function(key){
        if(key.keyCode==13){
            $("#expsYn").prop("checked", false);
            search();
            return false;
        }
    });

    //노출여부 버튼 이벤트
    $(document).on("change","input[id^='isVisibled']",function(){
        var tr = $(this).closest("tr");
        var checkYn=$(tr).find("input[name='hiddenExpsYn']").val();
        var currentYn = $(this).prop("checked") ? "Y" : "N";

        if(checkYn == currentYn){
            $(tr).find(".btns").hide();
        } else {
            $(tr).find(".btns").show();
        }
    });

    //취소버튼 이벤트
    $(document).on("click","button[name='cancelButton']",function(){
        var tr = $(this).closest("tr");
        var checkValue = $(tr).find("input[name='hiddenExpsYn']").val();
        $(tr).find("input[name='expsYn']").prop("checked", checkValue == "Y");
        $(tr).find(".btns").hide();
    });

    //적용버튼 이벤트
    $(document).on("click","button[name='updateButton']",function(){
        var tr = $(this).closest("tr");
        var branch = new Object();
        branch.exhHallSeq = $(tr).find("input[name='exhHallSeq']").val();
        branch.expsYn = $(tr).find("input[name='expsYn']").prop("checked") ? "Y" : "N";

        $.ajax({
               url : "${pageContext.request.contextPath}/branch/updateExpsYn",
               type: "POST",
               data : branch,
               success : function(result){
                   if(result == 1 ){
                       location.reload();
                   } else {
                       alert("적용에 실패했습니다.");
                   }
               }
           });
    });

    //위로버튼 이벤트
    $(document).on("click","button[name='upButton']",function(){
        var tr = $(this).closest("tr");

        if($(tr).prev().find("input[name='index']").val() == undefined) return;


        var beforeIndex = $(tr).prev().find("input[name='index']").val();
        var myIndex = $(tr).find("input[name='index']").val();

        //정렬값 바꾸기
        $(tr).prev().find("input[name='index']").val(myIndex);
        $(tr).find("input[name='index']").val(beforeIndex);

        $(tr).prev().before($(tr));
        console.log($(tr).prev().find("input[name='index']").val());

        //맨아래, 맨위에 버튼들 비활성화
        upDowButtonDisabled();
    });

    //아래로버튼 이벤트
    $(document).on("click","button[name='downButton']",function(){
        var tr = $(this).closest("tr");

        if($(tr).next().find("input[name='index']").val() == undefined) return;

        var afterIndex = $(tr).next().find("input[name='index']").val();
        var myIndex = $(tr).find("input[name='index']").val();

        //정렬값 바꾸기
        $(tr).next().find("input[name='index']").val(myIndex);
        $(tr).find("input[name='index']").val(afterIndex);

        $(tr).next().after($(tr));
        console.log($(tr).next().find("input[name='index']").val());

        //맨아래, 맨위에 버튼들 비활성화
        upDowButtonDisabled();
    });

});

function search(){
    $.ajax({
       url : "${pageContext.request.contextPath}/branch/list",
       type: "POST",
       data : $("#expsForm").serialize(),
       dataType : "html",
       success : function(data){
          $("#searchTable").html($(data).find('#searchTable').html());
          if($("#expsYn").prop("checked") || $("input[name='searchText']").val() != ""){
            $("#updateIndex").hide();
          } else {
            $("#updateIndex").show();
          }
       }
   });
}

function upDowButtonDisabled(){
    //모든 버튼 활성화 뒤 맨아래, 맨위 버튼 비활성화
    $("button[name='upButton']").attr("disabled", false);
    $("button[name='downButton']").attr("disabled", false);
    $("#optionBody tr:first").find("button[name='upButton']").attr("disabled", true);
    $("#optionBody tr:last").find("button[name='downButton']").attr("disabled", true);
}

</script>

<div id="body">
    <div id="container" class="container">
        <div class="wrap-contents">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> 전시장 관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <c:if test="${searchParam.expsYn ne 'Y' && (searchParam.searchText == null || searchParam.searchText eq '')}">
                            <button type="button" id="updateIndex" class="btn btn-default">정렬 저장</button>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/branch/detail"><button type="button" id="registe" class="btn btn-primary">등록</button></a>
                    </div>
                </div>
            </div>
            <div class="contents">
                <div class="card">
                    <div class="tools">
                        <div class="row">
                            <form id="expsForm" action="${pageContext.request.contextPath}/branch/list" method="POST">
                                <div class="col-xs-4">
                                    <span class="checkbox">
                                        <label>
                                        <input type="checkbox" name="expsYn" id="expsYn" value="Y" <c:if test="${searchParam.expsYn == 'Y'}">checked="checked"</c:if>> 노출
                                        </label>
                                    </span>
                                </div>
                                <div class="col-xs-8 text-right">
                                    <div class="form-inline">
                                        <div class="input-group ">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                            <input type="text" name="searchText" class="form-control" placeholder="검색어 입력" value="${searchParam.searchText}">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default btn-search" type="button" id="search" onclick=""><i class="fa fa-search" aria-hidden="true"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <form id="updateIndexForm">
                        <table id="searchTable" class="table table-hover table-bordered table-vertical ">
                            <colgroup>
                                <col style="width: 100px;">
                                <col style="width: 100px;">
                                <col style="width: 100px;">
                                <col style="width: 100px;">
                                <col style="width: 200px;">
                                <col>
                                <col style="width: 100px;">
                                <col style="width: 160px;">
                                <col style="width: 100px;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>정렬</th>
                                    <th>구분</th>
                                    <th>상호</th>
                                    <th>번호</th>
                                    <th>이메일</th>
                                    <th>주소</th>
                                    <th>관리자</th>
                                    <th>최근 갱신 일시</th>
                                    <th>노출 여부</th>
                                </tr>
                            </thead>
                            <tbody id="optionBody">
                                <c:forEach var="branch" items="${branchList}" varStatus="status">
                                    <tr>
                                        <td>
                                            <button type="button" class="btn btn-xs btn-default" name="upButton" <c:if test="${status.first || searchParam.expsYn eq 'Y' || (searchParam.searchText != null && searchParam.searchText ne '')}">disabled="disabled"</c:if>><i class="fa fa-arrow-up"></i></button>
                                            <button type="button" class="btn btn-xs btn-default" name="downButton" <c:if test="${status.last || searchParam.expsYn eq 'Y' || (searchParam.searchText != null && searchParam.searchText ne '')}">disabled="disabled"</c:if>><i class="fa fa-arrow-down"></i></button>
                                        </td>
                                        <td>
                                            <input name="index" type="hidden" value="${status.index}">
                                            <input type="hidden" name="exhHallSeq" value="${branch.exhHallSeq}">
                                            ${branch.type}
                                        </td>
                                        <td class="text-left">
                                            <a href="${pageContext.request.contextPath}/branch/detail/${branch.exhHallSeq}">${branch.storeNm}</a>
                                        </td>
                                        <td>
                                            ${branch.tel}
                                        </td>
                                        <td class="text-left">
                                            <c:if test="${branch.emailList != null && fn:length(branch.emailList) > 0}">
                                                ${branch.emailList[0].email}
                                            </c:if>
                                        </td>
                                        <td class="text-left">
                                            ${branch.detailAddr}
                                        </td>
                                        <td>
                                            ${branch.updUser}
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${branch.updDate}" pattern="yyyy.MM.dd HH:mm"/>
                                        </td>
                                        <td>
                                            <input type="hidden" name="hiddenExpsYn" value="${branch.expsYn}">
                                            <div class="onoffswitch">
                                                <input type="checkbox" class="onoffswitch-checkbox" data-id="${branch.exhHallSeq}" name="expsYn" id="isVisibled-${branch.exhHallSeq}" value="Y" <c:if test="${branch.expsYn eq 'Y'}">checked="checked"</c:if>>
                                                <label class="onoffswitch-label" for="isVisibled-${branch.exhHallSeq}">
                                                    <i class="inner"></i><i class="switch"></i>
                                                </label>
                                            </div>
                                            <div class="btns" style="display: none;">
                                                <button type="button" name="cancelButton" class="btn btn-xs btn-default ">취소</button>
                                                <button type="button" name="updateButton" class="btn btn-xs btn-primary ">적용</button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </form>
                    <div class="row">
                        <div class="col-xs-2">
                            Total : <span>${fn:length(branchList)}</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</div>