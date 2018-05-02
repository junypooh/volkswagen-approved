<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-01-18
  Time: 오후 4:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="body">
    <div id="container" class="container">
         <form id="subForm">
            <input type="hidden" name="bannerSeq">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        </form>
        <div class="wrap-contents">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> 배너관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                    <c:if test="${searchParam.expsYn ne 'Y' && (searchParam.query == null || searchParam.query eq '')}">
                        <button type="button" id="ordsave" class="btn btn-default">정렬 저장</button>
                    </c:if>
                        <button type="button" id="registe"class="btn btn-primary">등록</button>
                    </div>
                </div>
            </div>
            <div class="contents">
                <div class="card">
                    <div class="tools">
                        <div class="row">
                            <form id="expsForm" action="${pageContext.request.contextPath}/banner/list" method="POST">
                                <div class="col-xs-4">
                                    <span class="checkbox">
                                        <label>
                                            <input type="checkbox" name="expsYn" id="expsYn" value="Y" <c:if test="${searchParam.expsYn == 'Y'}">checked="checked"</c:if>> 노출
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
                                            <form id="searchForm" method="post">
                                                <input type="text" name="query" class="form-control" placeholder="검색어 입력" value="${searchParam.query}">
                                                <input type='hidden' name='_csrf' value='${_csrf.token}'>
                                            </form>
                                            <span class="input-group-btn">
                                                <button id="searchbtn" class="btn btn-default btn-search" type="button"><i class="fa fa-search" aria-hidden="true"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <table class="table table-hover table-bordered table-vertical " id="searchTable">
                        <colgroup>
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
                                <th>섬네일</th>
                                <th>제목</th>
                                <th>노출기간</th>
                                <th>관리자</th>
                                <th>최근 갱신 일시</th>
                                <th>노출 여부</th>
                            </tr>
                        </thead>
                        <tbody>
                            <form id="BannerForm">
                                <c:forEach items="${list}" var="item" varStatus="status">
                                    <tr name="t${status.index}">
                                        <td>
                                            <button type="button" name="up" class="btn btn-xs btn-default" <c:if test="${status.first || searchParam.expsYn eq 'Y' || (searchParam.query != null && searchParam.query ne '')}">disabled="disabled"</c:if>><i class="fa fa-arrow-up"></i></button>
                                            <button type="button" name="down" class="btn btn-xs btn-default" <c:if test="${status.last || searchParam.expsYn eq 'Y' || (searchParam.query != null && searchParam.query ne '')}">disabled="disabled"</c:if>><i class="fa fa-arrow-down"></i></button>
                                        </td>
                                        <td>
                                            <div name="image" class="thumbnail">
                                                <c:if test="${item.file != null}">
                                                    <img data-dz-thumbnail data-dz-remove src="${pageContext.request.scheme}://${searchParam.fileUrlPath}${item.file.filePath}${item.file.fileNm}">
                                                </c:if>
                                                <c:if test="${item.file == null}">
                                                    <img data-dz-thumbnail data-dz-remove src="${pageContext.request.scheme}://via.placeholder.com/350x150">
                                                </c:if>
                                            </div>
                                        </td>
                                        <td class="text-left">
                                            <a name="title" href="${pageContext.request.contextPath}/banner/detail/${item.bannerSeq}">${item.title}</a>
                                        </td>
                                        <td name="day">
                                            <c:if test="${item.flag != 3}">
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
                                            </c:if>
                                            <c:if test="${item.flag == 3}">
                                                <span class="item-status ing">
                                                    <span>진행중</span>
                                                    상시
                                                </span>
                                            </c:if>
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
                                                <input type="hidden" name="bannerSeq" value="${item.bannerSeq}">
                                                <input type="hidden" name="index" value="${status.index}">
                                                <input type="hidden" name="ordNo" value="${item.ordNo}">
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
                    <div class="row" id="count">
                        <div class="col-xs-2">
                            Total : <span>${fn:length(list)}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
//노출버튼
$(document).on("click","#expsYn",function(){

    search();
});

//검색버튼
$(document).on("click","#searchbtn",function(){
    $("#expsYn").prop("checked", false);
    search();
});

//검색어입력 엔터
$(document).on("keypress", "input[name='query']",function(key){
    if(key.keyCode==13){
        $("#expsYn").prop("checked", false);
        search();
        return false;
    }
});

//등록버튼 이동
$(document).on("click","#registe",function(){
    location.href = "${pageContext.request.contextPath}/banner/registeForm";
});

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
    var bannerSeq=$(td).find("input[name='bannerSeq']").val();
    if($(td).find("input[name='isVisibled']").prop("checked")){
        var expsYn='Y';
    } else {
        var expsYn='N';
    }
    $(td).find("input[name='checkYn']").val(expsYn);

    $(td).find("button[name='applyButton']").hide();
    $(td).find("button[name='cancelButton']").hide();

    $.ajax({
        url : "${pageContext.request.contextPath }/banner/bannerExpsYnUpdate",
        type : "POST",
        data : {bannerSeq:bannerSeq ,expsYn:expsYn},
        dataType : "text",
        success : function(name){

        }
    });
});

//순서정렬 아래버튼
$(document).on("click","button[name='down']",function(){
    var flag1;
    var flag2;
    var tr = $(this).closest("tr");
    var tab=$(tr).closest("table");
    var index=$(tr).find("input[name='index']").val();

    var cur=$(tab).find("tr[name='t"+index+"']");
    var next=$(tab).find("tr[name='t"+(Number(index)+1)+"']");

    var temp1=$(cur).find("a[name='title']").text();
    var temp2=$(next).find("a[name='title']").text();
    var temp3=$(cur).find("input[name='bannerSeq']").val();
    var temp4=$(next).find("input[name='bannerSeq']").val();
    var temp5=$(cur).find("td[name='updUser']").text();
    var temp6=$(next).find("td[name='updUser']").text();
    var temp7=$(cur).find("td[name='updDate']").text();
    var temp8=$(next).find("td[name='updDate']").text();
    var temp9=$(cur).find("td[name='day']").html();
    var temp10=$(next).find("td[name='day']").html();
    var temp11=$(cur).find("input[name='checkYn']").val();
    var temp12=$(next).find("input[name='checkYn']").val();
    var temp13=$(cur).find("div[name='image']").html();
    var temp14=$(next).find("div[name='image']").html();

    if ( $(cur).find("input[name='isVisibled']").prop('checked') ) {
        flag1=1;
    } else {
        flag1=0;
    }

    if ( $(next).find("input[name='isVisibled']").prop('checked') ) {
        flag2=1;
    } else {
        flag2=0;
    }

    if(temp2 != null){
        $(cur).find("a[name='title']").text(temp2);
        $(next).find("a[name='title']").text(temp1);
        $(cur).find("input[name='bannerSeq']").val(temp4);
        $(next).find("input[name='bannerSeq']").val(temp3);
        $(cur).find("td[name='updUser']").text(temp6);
        $(next).find("td[name='updUser']").text(temp5);
        $(cur).find("td[name='updDate']").text(temp8);
        $(next).find("td[name='updDate']").text(temp7);
        $(cur).find("td[name='day']").html(temp10);
        $(next).find("td[name='day']").html(temp9);
        $(cur).find("input[name='checkYn']").val(temp12);
        $(next).find("input[name='checkYn']").val(temp11);
        $(cur).find("div[name='image']").html(temp14);
        $(next).find("div[name='image']").html(temp13);

        if(flag1==1){
            $(next).find("input[name='isVisibled']").prop('checked',true);
        } else {
            $(next).find("input[name='isVisibled']").prop('checked',false);
        }

        if(flag2==1){
            $(cur).find("input[name='isVisibled']").prop('checked',true);
        } else {
            $(cur).find("input[name='isVisibled']").prop('checked',false);
        }
    }
});

//순서정렬 위버튼
$(document).on("click","button[name='up']",function(){
    var flag1;
    var flag2;
    var tr = $(this).closest("tr");
    var tab=$(tr).closest("table");
    var index=$(tr).find("input[name='index']").val();

    var cur=$(tab).find("tr[name='t"+index+"']");
    var next=$(tab).find("tr[name='t"+(Number(index)-1)+"']");

    var temp1=$(cur).find("a[name='title']").text();
    var temp2=$(next).find("a[name='title']").text();
    var temp3=$(cur).find("input[name='bannerSeq']").val();
    var temp4=$(next).find("input[name='bannerSeq']").val();
    var temp5=$(cur).find("td[name='updUser']").text();
    var temp6=$(next).find("td[name='updUser']").text();
    var temp7=$(cur).find("td[name='updDate']").text();
    var temp8=$(next).find("td[name='updDate']").text();
    var temp9=$(cur).find("td[name='day']").html();
    var temp10=$(next).find("td[name='day']").html();
    var temp11=$(cur).find("input[name='checkYn']").val();
    var temp12=$(next).find("input[name='checkYn']").val();
    var temp13=$(cur).find("div[name='image']").html();
    var temp14=$(next).find("div[name='image']").html();


    if ( $(cur).find("input[name='isVisibled']").prop('checked') ) {
        flag1=1;
    } else {
        flag1=0;
    }

    if ( $(next).find("input[name='isVisibled']").prop('checked') ) {
        flag2=1;
    } else {
        flag2=0;
    }

    if(temp2 != null){
        $(cur).find("a[name='title']").text(temp2);
        $(next).find("a[name='title']").text(temp1);
        $(cur).find("input[name='bannerSeq']").val(temp4);
        $(next).find("input[name='bannerSeq']").val(temp3);
        $(cur).find("td[name='updUser']").text(temp6);
        $(next).find("td[name='updUser']").text(temp5);
        $(cur).find("td[name='updDate']").text(temp8);
        $(next).find("td[name='updDate']").text(temp7);
        $(cur).find("td[name='day']").html(temp10);
        $(next).find("td[name='day']").html(temp9);
        $(cur).find("input[name='checkYn']").val(temp12);
        $(next).find("input[name='checkYn']").val(temp11);
        $(cur).find("div[name='image']").html(temp14);
        $(next).find("div[name='image']").html(temp13);
        if(flag1==1){
            $(next).find("input[name='isVisibled']").prop('checked',true);
        } else {
            $(next).find("input[name='isVisibled']").prop('checked',false);
        }

        if(flag2==1){
            $(cur).find("input[name='isVisibled']").prop('checked',true);
        } else {
            $(cur).find("input[name='isVisibled']").prop('checked',false);
        }

    }
});


// 정렬저장버튼
$(document).on("click","#ordsave",function(){
    $.ajax({
        url : "${pageContext.request.contextPath}/banner/updateBannerOrdNo",
        type: "POST",
        data : $("#BannerForm").serialize(),
        success : function(result){
        if(result > 0 ){
            } else {
        alert("순서정렬에 실패했습니다.");
            }
        }
    });
});

//검색
function search(){
    $.ajax({
       url : "${pageContext.request.contextPath}/banner/list",
       type: "POST",
       data : $("#expsForm").serialize(),
       dataType : "html",
       success : function(data){
          $("#searchTable").html($(data).find('#searchTable').html());
          $("#count").html($(data).find('#count').html());
          if($("#expsYn").prop("checked") || $("input[name='query']").val() != ""){
            $("#ordsave").hide();
          } else {
            $("#ordsave").show();
          }
       }
   });
}

</script>