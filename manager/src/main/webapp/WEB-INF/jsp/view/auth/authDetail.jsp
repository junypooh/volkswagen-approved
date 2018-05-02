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

<div id="body">
    <div id="container" class="container">
        <div class="wrap-contents">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> 관리자 관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <button type="button" id="cancelButton"class="btn btn-default">목록</button>
                        <c:if test="${aVo.flag == 0 || aVo.flag == 2 || aVo.flag == 3}">
                            <button type="button" id="saveButton" class="btn btn-primary">저장</button>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="contents">
                <div class="card">
                    <table class="table table-bordered table-horizontal">
                        <colgroup>
                            <col style="width: 150px;">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>
                                    구분<span class="asterisk">*</span>
                                    <input type="hidden" name="flag" value="${aVo.flag}">
                                </th>
                                <td>
                                    <div class="form-inline">
                                        ${aVo.authType}
                                        <input type="hidden" name="authType" value="${aVo.authType}">
                                        <c:if test="${aVo.flag == 3}">
                                        <span name="select" class="select">
                                            <select name="exhHallSeq" class="form-control">
                                                <option value="">전시장 선택</option>
                                                <c:forEach items="${detail}" var="item" varStatus="state">
                                                    <option value="${item.exhHallSeq}" <c:if test="${aVo.defaultExhHallSeq eq item.exhHallSeq}">selected="selected"</c:if>>${item.storeNm}</option>
                                                </c:forEach>
                                            </select>
                                        </span>
                                        </c:if>
                                        <c:if test="${aVo.flag != 3}">
                                        <span name="select" class="select">
                                            <select name="exhHallSeq" class="form-control" disabled="disabled">
                                                <option value="">전시장 선택</option>
                                                <c:forEach items="${detail}" var="item" varStatus="state">
                                                    <option value="${item.exhHallSeq}" <c:if test="${aVo.defaultExhHallSeq eq item.exhHallSeq}">selected="selected"</c:if>>${item.storeNm}</option>
                                                </c:forEach>
                                            </select>
                                        </span>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>ID</th>
                                <td>
                                    ${aVo.id}
                                    <c:if test="${aVo.flag != 2 && aVo.flag != 5}">
                                        <c:if test="${aVo.flag == 3 || aVo.flag == 0}">
                                            <button type="button" name="pwdreset" class="btn btn-default btn-sm" >비밀번호 초기화</button>
                                        </c:if>
                                        <c:if test="${aVo.flag != 3 && aVo.flag != 4 && aVo.flag != 0}">
                                            <button type="button" name="pwdreset" class="btn btn-default btn-sm" disabled="disabled" >비밀번호 초기화</button>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${aVo.flag == 2 || aVo.flag == 5}">
                                        <button type="button" name="pwdchange" class="btn btn-default btn-sm" data-toggle="modal" data-target="#modifyPassword" >비밀번호 변경</button>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    사용 여부<span class="asterisk">*</span>
                                </th>
                                <td>
                                    <span class="onoffswitch">
                                        <c:if test="${aVo.flag == 0 || aVo.flag == 2 || aVo.flag == 3}">
                                            <input type="checkbox" class="onoffswitch-checkbox" data-id="4033" name="isVisibled" id="isVisibled-4033" <c:if test="${aVo.useYn eq 'Y'}"> checked="checked"</c:if>>
                                        </c:if>
                                        <c:if test="${aVo.flag != 0 && aVo.flag != 2 && aVo.flag != 3}">
                                            <input type="checkbox" class="onoffswitch-checkbox" data-id="4033" name="isVisibled" id="isVisibled-4033" disabled="disabled"<c:if test="${aVo.useYn eq 'Y'}"> checked="checked"</c:if>>
                                        </c:if>
                                        <label class="onoffswitch-label" for="isVisibled-4033">
                                            <i class="inner"></i><i class="switch"></i>
                                        </label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    메모
                                </th>
                                <td>
                                    <input id="len" type="hidden" value="${fn:length(detail)}">
                                    <input name="id" type="hidden" value="${aVo.id}">
                                    <input name="admseq" type="hidden" value="${aVo.admSeq}">
                                    <c:if test="${aVo.flag == 0 || aVo.flag == 2 || aVo.flag == 3}">
                                        <input name="memo" type="text" class="form-control" value="${aVo.memo}" onkeyup="limitByteStr(this)" limitByte="50">
                                    </c:if>
                                    <c:if test="${aVo.flag != 0 && aVo.flag != 2 && aVo.flag != 3}">
                                        <input name="memo" type="text" class="form-control" value="${aVo.memo}" onkeyup="limitByteStr(this)" limitByte="50" disabled="disabled">
                                    </c:if>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <c:if test="${aVo.flag == 3 || aVo.flag == 4 || aVo.flag == 5}">
                    <table name="tab" class="table table-vertical table-bordered">
                        <colgroup>
                            <col style="width: 150px;">
                            <col>
                            <col style="width: 250px;">
                            <col style="width: 150px;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>구분</th>
                                <th>전시장명</th>
                                <th>권한</th>
                                <th>사용여부</th>
                            </tr>
                        </thead>
                        <tbody>
                            <form id="authForm">
                                <c:forEach items="${detail}" var="item" varStatus="status">
                                    <tr>
                                        <td id="type${status.index}">${item.type}</td>
                                        <td id="store${status.index}">${item.storeNm}</td>
                                        <input id="exh${status.index}" type="hidden" value="${item.exhHallSeq}">
                                        <input id="authmap${status.index}" type="hidden" value="${item.auth}">
                                        <td>
                                            <c:if test="${item.auth eq 'ADMIN'}">
                                            <span class="radio-inline">
                                                <label>
                                                    <input type="radio" name="auth${status.index}"  value="ADMIN" checked="" <c:if test="${aVo.flag != 3}">disabled="disabled"</c:if>> ADMIN
                                                </label>
                                            </span>
                                            <span class="radio-inline">
                                                <label>
                                                    <input type="radio" name="auth${status.index}"  value="OPERATOR" <c:if test="${aVo.flag != 3}">disabled="disabled"</c:if>> OPERATOR
                                                </label>
                                            </span>
                                            </c:if>
                                            <c:if test="${item.auth eq 'OPERATOR' || item.auth eq null}">
                                            <span class="radio-inline">
                                                <label>
                                                    <input type="radio" name="auth${status.index}" value="ADMIN" <c:if test="${aVo.flag != 3}">disabled="disabled"</c:if>> ADMIN
                                                </label>
                                            </span>
                                            <span class="radio-inline">
                                                <label>
                                                    <input type="radio" name="auth${status.index}" value="OPERATOR" checked="" <c:if test="${aVo.flag != 3}">disabled="disabled"</c:if>> OPERATOR
                                                </label>
                                            </span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <span class="onoffswitch">
                                                <c:if test="${item.dbSts eq 'A'}">
                                                    <input type="checkbox" class="onoffswitch-checkbox" data-id="${item.exhHallSeq}" name="isVisibled" id="isVisibled-${item.exhHallSeq}"checked="" <c:if test="${aVo.flag != 3}">disabled="disabled"</c:if>>
                                                </c:if>
                                                <c:if test="${item.dbSts eq 'D' || item.dbSts eq null}">
                                                    <input type="checkbox" class="onoffswitch-checkbox" data-id="${item.exhHallSeq}" name="isVisibled" id="isVisibled-${item.exhHallSeq}" <c:if test="${aVo.flag != 3}">disabled="disabled"</c:if>>
                                                </c:if>
                                                <label class="onoffswitch-label" for="isVisibled-${item.exhHallSeq}">
                                                    <i class="inner"></i><i class="switch"></i>
                                                </label>
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </form>
                        </tbody>
                    </table>
                    </c:if>
                </div>

                <!-- 비밀번호 변경 -->
                <div class="modal fade" id="modifyPassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" name="modalOut" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                <h4 class="modal-title">비밀번호 변경</h4>
                            </div>
                            <div class="modal-body">
                                <div>
                                    <input type="password" name="pwd" id="" value="" class="form-control" onkeyup="limitByteStr(this)" limitByte="10">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" name="modalSave" class="btn btn-primary">저장</button>
                                <button type="button" name="modalCancel" class="btn btn-default" data-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //비밀번호 변경 -->
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

//취소버튼 이벤트
$("#cancelButton").on("click", function(){
     location.href = "${pageContext.request.contextPath}/auth/list";
});

//저장버튼 이벤트
$("#saveButton").on("click", function(){
    var authMng = new Object();
    var authVo=new Object();
    var len=$("#len").val();
    var authType=$("input[name='authType']").val();

    var memo=$("input[name='memo']").val();
    var admSeq=$("input[name='admseq']").val();
    if($("input[name='isVisibled']").prop("checked")){
       var useYn='Y';
    } else {
       var useYn='N';
    }

    authVo.admSeq=admSeq;
    authVo.useYn=useYn;
    authVo.memo=memo;
    authVo.defaultExhHallSeq = $("select[name='exhHallSeq']").val();

    if(authVo.defaultExhHallSeq == '') {
        alert('디폴트 전시장을 선택해주세요.');
        return;
    }

    $.ajax({
        url : "${pageContext.request.contextPath }/auth/authUpdate",
        type: "POST",
        data : authVo,
        success : function(result){

        }
    });

    if(authType=="VW"){
        alert("저장되었습니다.");
        return;
    }

    for(var i=0;i<len;i++){
        var storeNm=$("#store"+i).text()
        var type=$("#type"+i).text();
        var auth=$("input[name='auth"+i+"']:checked").val();
        var exh=$("#exh"+i).val();
        if($("#isVisibled-" + exh).prop("checked") ){
            var dbSts='A';
        } else {
            var dbSts='D';
        }
        var authmap=$("#authmap"+i).val();

        authMng.admSeq=admSeq;
        authMng.exhHallSeq=exh;
        authMng.auth=auth;
        authMng.dbSts=dbSts;

        if(authmap == ""){
            $.ajax({
                url : "${pageContext.request.contextPath }/auth/registeExhMap",
                type: "POST",
                data : authMng,
                success : function(result){
                }
            });
        } else {
            $.ajax({
                url : "${pageContext.request.contextPath }/auth/updateExhMap",
                type: "POST",
                data : authMng,
                success : function(result){
                }
            });
        }
    }
    alert("저장되었습니다.");
});

//구분의 전시장 선택시 이벤트
$("select[name='exhHallSeq']").on("change", function(){
    var value = $(this).val();
    if($("#isVisibled-" + value).prop("checked") ){
        $("#isVisibled-" + value).prop("checked", false);
    } else {
        $("#isVisibled-" + value).prop("checked", true);
    }
});

//비밀번호 초기화
$("button[name='pwdreset']").on("click",function(){
    var admSeq=$("input[name='admseq']").val();
    var id=$("input[name='id']").val();
    $.ajax({
         url : "${pageContext.request.contextPath }/auth/authPwdReset",
         data : {admSeq:admSeq, id:id},
         type: "POST",
         success : function(result){
            alert("비밀번호가 초기화 되었습니다.\n  비밀번호 : {ID_오늘날짜!}");
         }
    });

});

//비밀번호 변경
$("button[name='modalSave']").on("click",function(){
    var admSeq=$("input[name='admseq']").val();
    var password=$("input[name='pwd']").val();
    $.ajax({
         url : "${pageContext.request.contextPath }/auth/authPwdChange",
         data : {admSeq:admSeq, pwd:password},
         type: "POST",
         success : function(result){
            alert("비밀번호 변경이 완료되었습니다.");
         }
    });

});
</script>
