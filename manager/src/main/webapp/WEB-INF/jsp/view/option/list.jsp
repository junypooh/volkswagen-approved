<%--
  Created by IntelliJ IDEA.
  User: hyeongju
  Date: 2018-01-21
  Time: 오후 5:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.tabs-statistics { top: 9px;display: inline-block; }
.tabs-statistics .nav-tabs { text-align: left; }
</style>
<div id="body">
    <div id="container" class="container">
        <div class="wrap-contents">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> 옵션 관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <button id="ordsave" type="button" class="btn btn-default" style="margin-bottom: -80px;">정렬 저장</button>
                    </div>
                </div>
            </div>
            <div class="contents">
                <div class="tabs-statistics">
                    <ul class="nav nav-tabs" role="tablist">
                        <li id="vwa-option" class="<c:if test="${param.vwYn ne 'N'}">active</c:if>" onclick="goVwOption('Y')">
                            <a href="#">폭스바겐 차량 옵션</a>
                        </li>
                        <li id="b-vwa-option" onclick="goVwOption('N')" class="<c:if test="${param.vwYn eq 'N'}">active</c:if>">
                            <a href="#">비폭스바겐 차량 옵션</a>
                        </li>
                    </ul>
                 </div>
                <input type="hidden" value="${fn:length(majorOptionList)}" name="majLen">
                <form id="OptionForm">
                <input type="hidden" value="${param.vwYn}" name="vwYn">
                <c:forEach items="${cList}" var="item" varStatus="status">
                    <div class="card" name="card">
                        <div class="collapse-header" name="collhead">
                            <a data-toggle="collapse" href="#option${status.index}" aria-expanded="true" class="collapsed">옵션유형 : <strong><c:out value='${item.cateName}'/></strong> [<span name="count${status.index}"><c:out value='${fn:length(item.optList)}'/></span>]</a>
                            <!-- 접어놓는 방식 수정시이용-->
                            <c:if test="${status.index == 1000}">
                                <a data-toggle="collapse" href="#option${status.index}" aria-expanded="false" class="collapsed">옵션유형 : <strong><c:out value='${item.cateName}'/></strong> [<span><c:out value='${fn:length(item.optList)}'/></span>]</a>
                            </c:if>

                            <input type="hidden" value="${item.cateName}" name="cateName">
                            <input type="hidden" value="${item.categoryCd}" name="categoryCd">
                            <button name="butt" type="button" class="btn btn-sm btn-primary" data-toggle="modal" data-target=".option-add"><i class="fa fa-plus"></i> 추가</button>
                        </div>
                        <div id="option${status.index}" class="collapse-body collapse in">
                        <!-- 접어놓는 방식 수정시이용-->
                        <c:if test="${status.index == 1000}">
                            <div id="option${status.index}" class="collapse-body collapse">
                        </c:if>

                            <table id="tab${status.index}" class="table table-hover table-bordered table-vertical">
                                <colgroup>
                                    <col style="width: 70px;">
                                    <col style="width: 160px;">
                                    <col>
                                    <col style="width: 70px;">
                                    <col style="width: 100px;">
                                    <col style="width: 160px;">
                                    <col style="width: 100px;">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>정렬</th>
                                        <th>옵션명</th>
                                        <th>설명</th>
                                        <th>주요옵션여부</th>
                                        <th>관리자</th>
                                        <th>최근 갱신 일시</th>
                                        <th>노출 여부</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${item.optList}" var="list" varStatus="state">
                                        <tr name="t${state.index}">
                                            <td>
                                                <button type="button" name="up" class="btn btn-xs btn-default"<c:if test="${state.first}">disabled="disabled"</c:if>><i class="fa fa-arrow-up"></i></button>
                                                <button type="button" name="down" class="btn btn-xs btn-default" <c:if test="${state.last}">disabled="disabled"</c:if>><i class="fa fa-arrow-down"></i></button>
                                            </td>
                                            <td class="text-left">
                                                <strong><a name="optName" data-toggle="modal" data-target=".option-add"><c:out value='${list.optNm}'/></a></strong>
                                            </td>
                                            <td>
                                                <div name="optDisc">${list.disc}</div>
                                            </td>
                                            <td>
                                                <div name="majOptYn">${list.majOptYn}</div>
                                            </td>
                                            <td>
                                                <div name="user"><c:out value='${list.updUser}'/></div>
                                            </td>
                                            <td>
                                                <div name="date"><c:out value='${list.updDate}'/></div>
                                                <input type="hidden" value="${list.optSeq}" name="seq">
                                                <input type="hidden" value="${state.index}" name="index">
                                                <input type="hidden" value="${list.ordNo} " name="ordNo">
                                                <input type="hidden" value="${list.disc}" name="disc">
                                            </td>
                                            <td>
                                                <input type="hidden" name="checkYn" value="${list.expsYn}">
                                                <span class="onoffswitch">
                                                    <c:if test="${list.expsYn eq 'Y'}">
                                                        <input type="checkbox" class="onoffswitch-checkbox" data-id="${list.optSeq}" name="isVisibled" id="isVisibled-${list.optSeq}" checked="checked">
                                                    </c:if>
                                                    <c:if test="${list.expsYn ne 'Y'}">
                                                        <input type="checkbox" class="onoffswitch-checkbox" data-id="${list.optSeq}" name="isVisibled" id="isVisibled-${list.optSeq}" >
                                                    </c:if>
                                                    <label class="onoffswitch-label" for="isVisibled-${list.optSeq}">
                                                        <i class="inner"></i><i class="switch"></i>
                                                    </label>
                                                </span>
                                                <div class="btns" >
                                                    <button style="display : none;" name="cancelButton" type="button" class="btn btn-xs btn-default ">취소</button>
                                                    <button style="display : none;" name="applyButton" type="button" class="btn btn-xs btn-primary ">적용</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:forEach>
                </form>
                <!-- 옵션관리 팝업 -->
                <div class="modal fade option-add" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">옵션 관리</h4>
                            </div>
                            <div class="modal-body">
                                <table class="table table-bordered table-horizontal">
                                    <colgroup>
                                        <col style="width: 150px;">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th>아이디</th>
                                            <td>
                                                <div name="optionid">option001</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>유형<span class="asterisk">*</span></th>
                                            <td>
                                                <div name="category">외장</div><input name="category" value=""  type="hidden">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>옵션명<span class="asterisk">*</span></th>
                                            <input type="hidden" name="flag">
                                            <td>
                                                <input type="text" name="ModalOpName" class="form-control" placeholder="옵션명을 입력하세요." onkeyup="limitByteStr(this)" limitByte="50">
                                                <input type="hidden" name="ModalSeq">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>설명<span class="asterisk">*</span></th>
                                            <td>
                                                <input type="text" name="ModalOptDisc" class="form-control" placeholder="옵션 설명을 입력하세요." onkeyup="limitByteStr(this)" limitByte="500">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>주요옵션<span class="asterisk">*</span></th>
                                            <td>
                                                <input name="oriMajOptYn" type="hidden">
                                                <span class="onoffswitch">
                                                    <input type="checkbox" class="onoffswitch-checkbox" data-id="4032" name="VisibledModal" id="isVisibled-4032" checked="checked">
                                                    <label class="onoffswitch-label" for="isVisibled-4032">
                                                        <i class="inner"></i><i class="switch"></i>
                                                    </label>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>사용여부<span class="asterisk">*</span></th>
                                            <td>
                                                <span class="onoffswitch">
                                                    <input type="checkbox" class="onoffswitch-checkbox" data-id="4033" name="isVisibledModal" id="isVisibled-4033" checked="checked">
                                                    <label class="onoffswitch-label" for="isVisibled-4033">
                                                        <i class="inner"></i><i class="switch"></i>
                                                    </label>
                                                </span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <button id="delete" type="button" class="btn btn-primary" style="display : none;">삭제</button>
                                <button type="button" id="close" class="btn btn-default" data-dismiss="modal">닫기</button>
                                <button id="save" type="button" class="btn btn-primary">저장</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //옵션관리 팝업 -->
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
//인증, 비인증탭이동
function goVwOption(isVw) {
    location.href="list?vwYn="+isVw;
}

//삭제버튼
$(document).on('click', '#delete', function(){
    if (confirm("정말 삭제하시겠습니까??") == true){    //확인

    }else{   //취소
        return;
    }

    var seq=$("input[name='ModalSeq']").val();
    var table=$(this).closest(".modal-content");
    var code=$(table).find("input[name='category']").val();
    var vwYn=$("input[name='vwYn']").val();

    $.ajax({
        url : "${pageContext.request.contextPath }/option/optDelete",
        type : "POST",
        data : {optSeq:seq},
        dataType : "text",
        success : function(result){
            if(result == 1 ){
                alert("삭제되었습니다.");
                $("#close").click();
                category(code, vwYn);

            } else {
                alert("삭제에 실패했습니다.");
            }
        }
    });
});


//저장버튼
$(document).on('click', '#save', function(){
    var exps;
    var majOptYn;
    var oriMajOptYn=$("input[name='oriMajOptYn']").val();
    var majLen=$("input[name='majLen']").val();
    var flag=$("input[name='flag']").val();
    var code=$("input[name='category']").val();
    var name=$("input[name='ModalOpName']").val();
    var disc=$("input[name='ModalOptDisc']").val();
    var vwYn=$("input[name='vwYn']").val();

    if(name=="" || name==null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if(disc=="" || disc==null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if ( $("input[name='isVisibledModal']").prop('checked') ) {
        exps='Y';
    } else {
        exps='N';
    }

    if ( $("input[name='VisibledModal']").prop('checked') ) {
        majOptYn='Y';
    } else {
        majOptYn='N';
    }

    if(flag==0){
        if(majOptYn != oriMajOptYn && majOptYn=="Y" && majLen>7){
            alert("주요옵션이 8개를 초과합니다.");
            return;
        }
        var seq=$("input[name='ModalSeq']").val();
        $.ajax({
            url : "${pageContext.request.contextPath }/option/updateOptMng",
            type : "POST",
            data : {categoryCd:code ,optNm:name, expsYn:exps, optSeq:seq, majOptYn:majOptYn, disc:disc, vwYn:vwYn},
            dataType : "text",
            success : function(result){
                if(result == 1 ){
                    alert("저장되었습니다.");
                    if(majOptYn=="N" && majOptYn != oriMajOptYn){
                        $("input[name='majLen']").val(Number(majLen)-1);
                        $("input[name='oriMajOptYn']").val(majOptYn);
                    }
                    if(majOptYn=="Y" && majOptYn != oriMajOptYn){
                        $("input[name='majLen']").val(Number(majLen)+1);
                        $("input[name='oriMajOptYn']").val(majOptYn);
                    }

                    category(code, vwYn);
                } else {
                    alert("저장에 실패했습니다.");
                }
            }
        });
    }else {
        if(majOptYn=='Y' && majLen>7){
            alert("주요옵션이 8개를 초과합니다.");
            return;
        }

        $.ajax({
            url : "${pageContext.request.contextPath }/option/registeOptMng",
            type : "POST",
            data : {categoryCd:code ,optNm:name, expsYn:exps, majOptYn:majOptYn, disc:disc, vwYn:vwYn},
            dataType : "text",
            success : function(result){
                if(result == 1 ){
                    alert("저장되었습니다.");
                    if(majOptYn=='Y'){
                        $("input[name='majLen']").val(Number(majLen)+1);
                    }

                    category(code, vwYn);
                } else {
                    alert("저장에 실패했습니다.");
                }
            }
        });
    }
});

//옵션명 클릭시
$(document).on('click', "a[name='optName']", function(){
    $("#delete").show();
    var div=$(this).closest("div[name='card']");
    var tr = $(this).closest("tr");

    var catename=$(div).find("input[name='cateName']").val();
    var code=$(div).find("input[name='categoryCd']").val();
    var optname=$(this).text();
    var seq=$(tr).find("input[name='seq']").val();
    var disc=$(tr).find("input[name='disc']").val();

    if( $(tr).find("input[name='checkYn']").val()=='Y'){
        $("input[name='isVisibledModal']").prop('checked',true);

    } else {
        $("input[name='isVisibledModal']").prop('checked',false);
    }

    if( $(tr).find("div[name='majOptYn']").text()=='Y'){
        $("input[name='VisibledModal']").prop('checked',true);
        $("input[name='oriMajOptYn']").val("Y");
    } else {
        $("input[name='VisibledModal']").prop('checked',false);
        $("input[name='oriMajOptYn']").val("N");
    }


    $("input[name='flag']").val(0);
    $("div[name='category']").text(catename);
    $("input[name='category']").val(code);
    $("input[name='ModalOpName']").val(optname);
    $("input[name='ModalSeq']").val(seq);
    $("div[name='optionid']").text(seq);
    $("input[name='ModalOptDisc']").val(disc);
});

//스위치 버튼 이벤트
$(document).on('click', "input[name='isVisibled']", function(){
    var tr=$(this).closest("tr");
    var checkYn=$(tr).find("input[name='checkYn']").val();
    var currentYn;
    if($(this).prop("checked")){
        currentYn='Y';
    } else {
        currentYn='N';
    }
    if(checkYn == currentYn){
        $(tr).find("button[name='applyButton']").hide();
        $(tr).find("button[name='cancelButton']").hide();
    } else {
        $(tr).find("button[name='applyButton']").show();
        $(tr).find("button[name='cancelButton']").show();
    }
});

//스위치 버튼 취소이벤트
$(document).on('click', "button[name='cancelButton']", function(){
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
$(document).on('click', "button[name='applyButton']", function(){
    var td=$(this).closest("td");
    var tr=$(this).closest("tr");
    var optSeq=$(tr).find("input[name='seq']").val();
    if($(td).find("input[name='isVisibled']").prop("checked")){
        var expsYn='Y';
    } else {
        var expsYn='N';
    }
    $(td).find("input[name='checkYn']").val(expsYn);

    $.ajax({
        url : "${pageContext.request.contextPath }/option/optExpUpdate",
        type : "POST",
        data : {optSeq:optSeq ,expsYn:expsYn},
        dataType : "text",
        success : function(result){
            if(result == 1 ){

            } else {
                alert("수정에 실패했습니다.");
            }
        }
    });
    $(td).find("button[name='applyButton']").hide();
    $(td).find("button[name='cancelButton']").hide();
});


//추가 눌렀을시
$("button[name='butt']").on("click", function(){
    $("#delete").hide();
    var div=$(this).closest("div[name='card']");
    var code=$(div).find("input[name='categoryCd']").val();
    var name=$(div).find("input[name='cateName']").val();

    $("div[name='category']").text(name);
    $("input[name='category']").val(code);
    $("input[name='ModalOpName']").val("");
    $("input[name='flag']").val(1);
    $("input[name='VisibledModal']").prop('checked',false);
    $("input[name='isVisibledModal']").prop('checked',true);
    $("div[name='optionid']").text("");
    $("input[name='ModalOptDisc']").val("");
    $("input[name='oriMajOptYn']").val("");
});


//순서정렬 아래버튼
$(document).on('click', "button[name='down']", function(){
    var flag1;
    var flag2;
    var tr = $(this).closest("tr");
    var tab=$(tr).closest("table");
    var index=$(tr).find("input[name='index']").val();

    var cur=$(tab).find("tr[name='t"+index+"']");
    var next=$(tab).find("tr[name='t"+(Number(index)+1)+"']");

    var temp1=$(cur).find("a[name='optName']").text();
    var temp2=$(next).find("a[name='optName']").text();
    var temp3=$(cur).find("input[name='seq']").val();
    var temp4=$(next).find("input[name='seq']").val();
    var temp5=$(cur).find("div[name='date']").text();
    var temp6=$(next).find("div[name='date']").text();
    var temp7=$(cur).find("div[name='user']").text();
    var temp8=$(next).find("div[name='user']").text();
    var temp9=$(cur).find("input[name='checkYn']").val();
    var temp10=$(next).find("input[name='checkYn']").val();
    var temp11=$(cur).find("div[name='majOptYn']").text();
    var temp12=$(next).find("div[name='majOptYn']").text();
    var temp13=$(cur).find("input[name='disc']").val();
    var temp14=$(next).find("input[name='disc']").val();
    var temp15=$(cur).find("div[name='optDisc']").text();
    var temp16=$(next).find("div[name='optDisc']").text();


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
        $(cur).find("a[name='optName']").text(temp2);
        $(next).find("a[name='optName']").text(temp1);
        $(cur).find("input[name='seq']").val(temp4);
        $(next).find("input[name='seq']").val(temp3);
        $(cur).find("div[name='date']").text(temp6);
        $(next).find("div[name='date']").text(temp5);
        $(cur).find("div[name='user']").text(temp8);
        $(next).find("div[name='user']").text(temp7);
        $(cur).find("input[name='checkYn']").val(temp10);
        $(next).find("input[name='checkYn']").val(temp9);
        $(cur).find("div[name='majOptYn']").text(temp12);
        $(next).find("div[name='majOptYn']").text(temp11);
        $(cur).find("input[name='disc']").val(temp14);
        $(next).find("input[name='disc']").val(temp13);
        $(cur).find("div[name='optDisc']").text(temp16);
        $(next).find("div[name='optDisc']").text(temp15);

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
$(document).on('click', "button[name='up']", function(){
    var tr = $(this).closest("tr");
    var tab=$(tr).closest("table");
    var flag1;
    var flag2;
    var index=$(tr).find("input[name='index']").val();

    var cur=$(tab).find("tr[name='t"+index+"']");
    var next=$(tab).find("tr[name='t"+(Number(index)-1)+"']");

    var temp1=$(cur).find("a[name='optName']").text();
    var temp2=$(next).find("a[name='optName']").text();
    var temp3=$(cur).find("input[name='seq']").val();
    var temp4=$(next).find("input[name='seq']").val();
    var temp5=$(cur).find("div[name='date']").text();
    var temp6=$(next).find("div[name='date']").text();
    var temp7=$(cur).find("div[name='user']").text();
    var temp8=$(next).find("div[name='user']").text();
    var temp9=$(cur).find("input[name='checkYn']").val();
    var temp10=$(next).find("input[name='checkYn']").val();
    var temp11=$(cur).find("div[name='majOptYn']").text();
    var temp12=$(next).find("div[name='majOptYn']").text();
    var temp13=$(cur).find("input[name='disc']").val();
    var temp14=$(next).find("input[name='disc']").val();
    var temp15=$(cur).find("div[name='optDisc']").text();
    var temp16=$(next).find("div[name='optDisc']").text();

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
        $(cur).find("a[name='optName']").text(temp2);
        $(next).find("a[name='optName']").text(temp1);
        $(cur).find("input[name='seq']").val(temp4);
        $(next).find("input[name='seq']").val(temp3);
        $(cur).find("div[name='date']").text(temp6);
        $(next).find("div[name='date']").text(temp5);
        $(cur).find("div[name='user']").text(temp8);
        $(next).find("div[name='user']").text(temp7);
        $(cur).find("input[name='checkYn']").val(temp10);
        $(next).find("input[name='checkYn']").val(temp9);
        $(cur).find("div[name='majOptYn']").text(temp12);
        $(next).find("div[name='majOptYn']").text(temp11);
        $(cur).find("input[name='disc']").val(temp14);
        $(next).find("input[name='disc']").val(temp13);
        $(cur).find("div[name='optDisc']").text(temp16);
        $(next).find("div[name='optDisc']").text(temp15);

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
$(document).on('click', "#ordsave", function(){
    $.ajax({
        url : "${pageContext.request.contextPath}/option/updateOptMngOrdNo",
        type: "POST",
        data : $("#OptionForm").serialize(),
        success : function(result){
            if(result == 1 ){

            } else {
                alert("정렬에 실패했습니다.");
            }
        }
    });
});

//코드값을 받아서 필요한 값을 세팅하는 곳
function category(categoryCd, vwYn){
    $.ajax({
        url : "${pageContext.request.contextPath}/option/optMngVo",
        type: "POST",
        data : {categoryCd:categoryCd,vwYn:vwYn},

        success : function(result){
            var tr;
            var count;
            if(categoryCd=="B1001"){
                tr='tab0';
                count='count0';
            } else if(categoryCd=="B1002"){
                tr='tab1';
                count='count1';
            }else if(categoryCd=="B1003"){
                tr='tab2';
                count='count2';
            } else if(categoryCd=="B1004"){
                tr='tab3';
                count='count3';
            } else if(categoryCd=="B1005"){
                tr='tab4';
                count='count4';
            }

            var tbody=$("#"+tr).find("tbody");
            $("span[name='"+count+"']").text(result.length);
            tbody.empty();
            for(var i=0;i<result.length;i++){
                render(result[i],i,result.length,tbody);
            }
        }
    });
}

//새로 생기는 부분에 한해서 그리는 부분
function render(list,index,len,fn){
str='';
str+='  <tr name="t'+index+'">';
str+='  <td>';
if(index==0){
    str+='      <button type="button" name="up" class="btn btn-xs btn-default" disabled="disabled"><i class="fa fa-arrow-up"></i></button>';
} else {
    str+='      <button type="button" name="up" class="btn btn-xs btn-default"><i class="fa fa-arrow-up"></i></button>';
}

if(index==(len-1)){
    str+='      <button type="button" name="down" class="btn btn-xs btn-default" disabled="disabled"><i class="fa fa-arrow-down"></i></button>';
} else {
    str+='      <button type="button" name="down" class="btn btn-xs btn-default"><i class="fa fa-arrow-down"></i></button>';
}
 var ordNo = list.ordNo == null ? "" : list.ordNo;
str+='  </td>';
str+='  <td class="text-left">';
str+='      <strong><a name="optName" data-toggle="modal" data-target=".option-add">'+list.optNm+'</a></strong>';
str+='  </td>';
str+='  <td>';
str+='      <div name="optDisc">'+list.disc+'</div>';
str+='  </td>';
str+='  <td>';
str+='      <div name="majOptYn">'+list.majOptYn+'</div>';
str+='  </td>';
str+='  <td>';
str+='      <div name="user">'+list.updUser+'</div>';
str+='  </td>';
str+='  <td>';
str+='      <div name="date">'+list.updDate+'</div>';
str+='      <input type="hidden" value="'+list.optSeq+'" name="seq">';
str+='      <input type="hidden" value="'+index+'" name="index">';
str+='      <input type="hidden" value="'+ordNo+'" name="ordNo">';
str+='      <input type="hidden" value="'+list.disc+'" name="disc">';
str+='  </td>';
str+='  <td>';
str+='      <input type="hidden" name="checkYn" value="'+list.expsYn+'">';
str+='      <span class="onoffswitch">';
if(list.expsYn =='Y'){
    str+='           <input type="checkbox" class="onoffswitch-checkbox" data-id="'+list.optSeq+'" name="isVisibled" id="isVisibled-'+list.optSeq+'" checked="checked">';
    } else {
    str+='           <input type="checkbox" class="onoffswitch-checkbox" data-id="'+list.optSeq+'" name="isVisibled" id="isVisibled-'+list.optSeq+'">';
    }
str+='          <label class="onoffswitch-label" for="isVisibled-'+list.optSeq+'">';
str+='              <i class="inner"></i><i class="switch"></i>';
str+='          </label>';
str+='      </span>';
str+='      <div class="btns">';
str+='          <button name="cancelButton" style="display : none;" type="button" class="btn btn-xs btn-default">취소</button>';
str+='          <button name="applyButton" style="display : none;" type="button" class="btn btn-xs btn-primary">적용</button>';
str+='      </div>';
str+='  </td>';
str+='</tr>';
fn.append(str);

}
</script>





