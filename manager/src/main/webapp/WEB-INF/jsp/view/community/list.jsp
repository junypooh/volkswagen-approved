<%--
    커뮤니티관리/목록
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
            url : "${pageContext.request.contextPath}/community/updateCommNo",
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

    //등록버튼 이벤트
    $(document).on("click","#registeButton",function(){
        location.href = "${pageContext.request.contextPath}/community/detail"
    });

    //유형선택 이벤트
    $(document).on("change","#type",function(){
        $("#expsYn").prop("checked", false);
        search();
    });

    //노출버튼 클릭 이벤트
    $(document).on("click","#expsYn",function(){
        search();
    });

    //검색버튼 클릭 이벤트
    $(document).on("click","#search",function(){
        $("#type").val("");
        $("#expsYn").prop("checked", false);
        search();
    });

    //검색어입력 엔터 이벤트
    $(document).on("keypress", "input[name='searchText']",function(key){
        if(key.keyCode==13){
            $("#type").val("");
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
        var community = new Object();
        community.commSeq = $(tr).find("input[name='commSeq']").val();
        community.expsYn = $(tr).find("input[name='expsYn']").prop("checked") ? "Y" : "N";

        $.ajax({
            url : "${pageContext.request.contextPath}/community/expsYnUpdate",
            type: "POST",
            data : community,
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
        url : "${pageContext.request.contextPath}/community/list",
        type: "POST",
        data : $("#searchForm").serialize(),
        dataType : "html",
        success : function(data){
            $("#searchTable").html($(data).find('#searchTable').html());
            $("#paging").html($(data).find('#paging').html());

            if(!$("#expsYn").prop("checked") && $("#type").val() == "" && $("input[name='searchText']").val() == ""){
                $("#updateIndex").show();
            } else {
                $("#updateIndex").hide();
            }
        }
   });
}


function goPage(page){
    search();
}

function upDowButtonDisabled(){
    //모든 버튼 활성화 뒤 맨아래, 맨위 버튼 비활성화
    $("button[name='upButton']").attr("disabled", false);
    $("button[name='downButton']").attr("disabled", false);
    $("#fixYBody tr:first").find("button[name='upButton']").attr("disabled", true);
    $("#fixYBody tr:last").find("button[name='downButton']").attr("disabled", true);
    $("#fixNBody tr:first").find("button[name='upButton']").attr("disabled", true);
    $("#fixNBody tr:last").find("button[name='downButton']").attr("disabled", true);
}


</script>
<div id="body">
    <div id="container" class="container">
        <div class="wrap-contents">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> 커뮤니티관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <button type="button" id="updateIndex" class="btn btn-default">정렬 저장</button>
                        <button type="button" id="registeButton" class="btn btn-primary">등록</button>
                    </div>
                </div>
            </div>
            <div class="contents">
                <div class="card">
                    <div class="tools">
                        <div class="row">
                            <form id="searchForm" action="${pageContext.request.contextPath}/community/list" method="POST">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <div class="col-xs-4">
                                    <div class="form-inline">
                                        <span class="select">
                                            <select name="type"id="type" class="form-control">
                                                <option value="">유형 전체</option>
                                                <option value="공지">공지</option>
                                                <option value="뉴스">뉴스</option>
                                                <option value="후기">후기</option>
                                                <option value="정보">정보</option>
                                            </select>
                                        </span>
                                        <span class="checkbox">
                                            <label>
                                            <input type="checkbox" name="expsYn" id="expsYn" value="Y" <c:if test="${searchParam.expsYn eq 'Y'}"> checked="checked" </c:if>> 노출
                                            </label>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-xs-8 text-right">
                                    <div class="form-inline">
                                        <div class="form-group guide">
                                            <span class="item-status reservation"> 예약 </span>
                                            <span class="item-status ing"> 진행중 </span>
                                            <span class="item-status invisible"> 종료 </span>
                                        </div>
                                        <div class="input-group ">
                                            <input type="text" name="searchText" class="form-control" placeholder="검색어 입력" value="${searchParam.searchText}">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default btn-search" type="button" id="search"><i class="fa fa-search" aria-hidden="true"></i></button>
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
                                <col style="width: 70px;">
                                <col style="width: 70px;">
                                <col style="width: 100px;">
                                <col>
                                <col style="width: 400px;">
                                <col style="width: 100px;">
                                <col style="width: 160px;">
                                <col style="width: 100px;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>정렬</th>
                                    <th>유형</th>
                                    <th>섬네일</th>
                                    <th>제목</th>
                                    <th>노출기간</th>
                                    <th>관리자</th>
                                    <th>최근 갱신 일시</th>
                                    <th>노출 여부</th>
                                </tr>
                            </thead>
                            <tbody id="fixYBody">
                                <c:forEach var="community" items="${communityFixYList}" varStatus="status">
                                    <tr>
                                        <td>
                                            <button type="button" class="btn btn-xs btn-default" name="upButton" <c:if test="${status.first || searchParam.expsYn eq 'Y' || (searchParam.searchText != null && searchParam.searchText ne '') || (searchParam.type != null && searchParam.type ne '')}">disabled="disabled"</c:if>><i class="fa fa-arrow-up"></i></button>
                                            <button type="button" class="btn btn-xs btn-default" name="downButton" <c:if test="${status.last || searchParam.expsYn eq 'Y' || (searchParam.searchText != null && searchParam.searchText ne '') || (searchParam.type != null && searchParam.type ne '')}">disabled="disabled"</c:if>><i class="fa fa-arrow-down"></i></button>
                                        </td>
                                        <td>
                                            <input name="index" type="hidden" value="${status.index}">
                                            <input type="hidden" name="commSeq" value="${community.commSeq}">
                                            ${community.type}
                                        </td>
                                        <td>
                                            <div class="thumbnail">
                                                <img src="${pageContext.request.scheme}://${searchParam.fileUrlPath}${community.file.filePath}${community.file.fileNm}" alt="...">
                                            </div>
                                        </td>
                                        <td class="text-left">
                                            <a href="${pageContext.request.contextPath}/community/detail/${community.commSeq}"><span class="label label-default">BEST</span> ${community.title}</a>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${community.status != null && community.status ne ''}">
                                                    <c:if test="${community.expsYn eq 'Y'}">
                                                        <span class="item-status ${community.status}">
                                                            <span>예약</span>
                                                            ${community.strDate} ~ ${community.endDate}
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${community.expsYn eq 'N'}">
                                                        <span class="item-status end">
                                                            <span>예약</span>
                                                            ${community.strDate} ~ ${community.endDate}
                                                        </span>
                                                    </c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="item-status ing">
                                                        상시
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            ${community.updUser}
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${community.updDate}" pattern="yyyy.MM.dd HH:mm"/>
                                        </td>
                                        <td>
                                            <div class="onoffswitch">
                                                <input type="hidden" name="hiddenExpsYn" value="${community.expsYn}">
                                                <input type="checkbox" class="onoffswitch-checkbox" data-id="${community.commSeq}" name="expsYn" id="isVisibled-${community.commSeq}" <c:if test="${community.expsYn eq 'Y'}">checked="checked"</c:if>>
                                                <label class="onoffswitch-label" for="isVisibled-${community.commSeq}">
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
                            <tbody id="fixNBody">
                                <c:forEach var="community" items="${communityFixNList}" varStatus="status">
                                    <tr>
                                        <td>
                                            <button type="button" class="btn btn-xs btn-default" name="upButton" <c:if test="${status.first || searchParam.expsYn eq 'Y' || (searchParam.searchText != null && searchParam.searchText ne '') || (searchParam.type != null && searchParam.type ne '')}">disabled="disabled"</c:if>><i class="fa fa-arrow-up"></i></button>
                                            <button type="button" class="btn btn-xs btn-default" name="downButton" <c:if test="${status.last || searchParam.expsYn eq 'Y' || (searchParam.searchText != null && searchParam.searchText ne '') || (searchParam.type != null && searchParam.type ne '')}">disabled="disabled"</c:if>><i class="fa fa-arrow-down"></i></button>
                                        </td>
                                        <td>
                                            <input name="index" type="hidden" value="${status.index}">
                                            <input type="hidden" name="commSeq" value="${community.commSeq}">
                                            ${community.type}
                                        </td>
                                        <td>
                                            <div class="thumbnail">
                                                <img src="${pageContext.request.scheme}://${searchParam.fileUrlPath}${community.file.filePath}${community.file.fileNm}" alt="...">
                                            </div>
                                        </td>
                                        <td class="text-left">
                                            <a href="${pageContext.request.contextPath}/community/detail/${community.commSeq}">${community.title}</a>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${community.status != null && community.status ne ''}">
                                                    <c:if test="${community.expsYn eq 'Y'}">
                                                        <span class="item-status ${community.status}">
                                                            <span>예약</span>
                                                            ${community.strDate} ~ ${community.endDate}
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${community.expsYn eq 'N'}">
                                                        <span class="item-status end">
                                                            <span>예약</span>
                                                            ${community.strDate} ~ ${community.endDate}
                                                        </span>
                                                    </c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="item-status ing">
                                                        상시
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            ${community.updUser}
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${community.updDate}" pattern="yyyy.MM.dd HH:mm"/>
                                        </td>
                                        <td>
                                            <div class="onoffswitch">
                                                <input type="hidden" name="hiddenExpsYn" value="${community.expsYn}">
                                                <input type="checkbox" class="onoffswitch-checkbox" data-id="${community.commSeq}" name="expsYn" id="isVisibled-${community.commSeq}" <c:if test="${community.expsYn eq 'Y'}">checked="checked"</c:if>>
                                                <label class="onoffswitch-label" for="isVisibled-${community.commSeq}">
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
                    <div id="paging" class="row">
                        <div class="col-xs-2">
                            Total : <span>${fn:length(communityFixYList) + fn:length(communityFixNList)}</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>