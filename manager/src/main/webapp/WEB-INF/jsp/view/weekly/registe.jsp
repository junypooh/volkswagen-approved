<%--
    통계관리/WeeklyReport/목록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="body">
    <div id="container" class="container">
        <div class="wrap-contents">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> Weekly Report</span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <button type="button" id="cancelButton" class="btn btn-default">목록</button>
                        <button type="button" class="btn btn-primary" id="saveButton">등록</button>
                    </div>
                </div>
            </div>
            <div class="contents">
                <form id="weeklyForm">
                <div class="card">
                    <table class="table table-bordered table-horizontal">
                        <colgroup>
                            <col style="width: 150px;">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>
                                    유형 <span class="asterisk">*</span>
                                </th>
                                <td>
                                    <span class="radio-inline">
                                        <input type="radio" name="categoryCd" value="I1001" checked="checked"> 매입
                                    </span>
                                    <span class="radio-inline">
                                        <input type="radio" name="categoryCd" value="I1002"> 판매
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    제목 <span class="asterisk">*</span>
                                </th>
                                <td>
                                    <input type="text" name="title" onkeyup="limitByteStr(this)" class="form-control" limitByte="50" placeholder="제목을 입력하세요" >
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    업로드 기간 <span class="asterisk">*</span>
                                </th>
                                <td>
                                    <div class="wrap-calendar reservation-calendar form-inline ">
                                        <div class="input-group">
                                            <div class="input-icon">
                                                <i class="fa fa-calendar"></i>
                                                <input type="text" class="form-control datetimepicker" name="strDate" id="WstrDate" placeholder="from">
                                            </div>
                                            <span class="input-group-addon">~</span>
                                            <div class="input-icon">
                                                <i class="fa fa-calendar"></i>
                                                <input type="text" class="form-control datetimepicker" name="endDate" id="WendDate" placeholder="to">
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    상태
                                </th>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    권한지정 <span class="asterisk">*</span>
                                </th>
                                <td>
                                    <button type="button" class="btn btn-default" data-toggle="modal" data-target=".search-manager" id="modalButton"> 그룹 관리자 찾기</button>
                                    <small>&nbsp;※ 그룹 관리자 중 Weekly Report 업로드 권한을 부여한 그룹 관리자만 업로드 가능합니다.</small>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="table table-vertical table-bordered">
                        <colgroup>
                            <col style="width: 150px;">
                            <col style="width: 200px;">
                            <col style="width: 450px;">
                            <col>
                            <col style="width: 50px;">
                            <col style="width: 150px;">
                            <col style="width: 50px;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>그룹관리자</th>
                                <th>전시장</th>
                                <th>업로드 기간 <span class="asterisk">*</span></th>
                                <th>파일 첨부</th>
                                <th>상태</th>
                                <th>업로드 일시</th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody id="weeklyBody">
                            <c:forEach var="authority" items="${authorityList}" varStatus="status">
                                <c:if test="${authority.checkYn}">
                                    <tr>
                                        <td>${authority.id}
                                            <input type="hidden" name="weekRepSeq">
                                            <input type="hidden" name="admSeq" value="${authority.admSeq}">
                                        </td>
                                        <td>
                                            <c:forEach var="authExhibMap" items="${authority.list}">
                                                ${authExhibMap.type} / ${authExhibMap.storeNm} <br>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <div class="wrap-calendar reservation-calendar form-inline ">
                                                <div class="input-group">
                                                    <div class="input-icon">
                                                        <i class="fa fa-calendar"></i>
                                                        <input type="text" class="form-control datetimepicker" name="detailStrDate" id="detailStrDate" value="${strDate}" placeholder="from">
                                                    </div>
                                                    <span class="input-group-addon">~</span>
                                                    <div class="input-icon">
                                                        <i class="fa fa-calendar"></i>
                                                        <input type="text" class="form-control datetimepicker" name="detailEndDate" id="detailEndDate" value="${endDate}" placeholder="to">
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-left">
                                            <input type="file" name="" id="" disabled="disabled">
                                        </td>
                                        <td>
                                            -
                                        </td>
                                        <td>
                                            -
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-xs btn-default "name="trRemove">삭제</button>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            <c:if test="${authorityList == null || fn:length(authorityList) == 0}">
                                <tr>
                                    <td colspan="7">선택된 그룹 관리자가 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-xs-12 text-right">
                        </div>
                    </div>
                </div>
                </form>

                <!-- 그룹 관리자 찾기 팝업 -->
                <form id="modalForm">
                    <div class="modal fade search-manager" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" id="modalBody">
                    </div>
                </form>
                <!-- //그룹 관리자 찾기 팝업 -->
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
var authArray = new Array();
//데이터 피커 형식지정
$(document).on('focus', ".datetimepicker", function(){
    $(".datetimepicker").datetimepicker({
        format: 'YYYY-MM-DD',
        locale: "kr"
    });
});

//모달버튼 클릭
$(document).on('click', "#modalButton", function(){
    $.ajax({
        url : "${pageContext.request.contextPath}/weekly/openModal",
        type: "POST",
        data : $("#weeklyForm").serialize(),
        dataType : "html",
        success : function(data){
            $("#modalBody").html($(data).find('#modalBody').html());
            $("#MstrDate0").val($("#WstrDate").val());
            $("#MendDate0").val($("#WendDate").val());
            authArray = new Array();
            $("#modalForm").find("input[name='admSeq']:checked").each(function (index) {
                authArray.push($(this).val());
            });
        }
    });
});

//모달팝업 검색어엔터
$(document).on("keypress", "input[name='searchText']",function(key){
    if(key.keyCode==13){
        search();
        return false;
    }
});
//모달팝업 검색버튼
$(document).on("click","#search",function(){
    search();
});

//저장버튼
$(document).on('click', "#saveButton", function(){

    if($("input[name='title']").val()=='' || $("input[name='title']").val()==null){
       alert("미입력 항목이 있습니다.");
       return;
    }

    if($("input[name='strDate']").val()=='' || $("input[name='strDate']").val()==null){
       alert("미입력 항목이 있습니다.");
       return;
    }

    if($("input[name='endDate']").val()=='' || $("input[name='endDate']").val()==null){
       alert("미입력 항목이 있습니다.");
       return;
    }

    if($("input[name='weekRepSeq']").length==0){
       alert("선택된 그룹 관리자가 없습니다.");
       return;
    }

    $.ajax({
        url : "${pageContext.request.contextPath}/weekly/registeWeekly",
        type: "POST",
        data : $("#weeklyForm").serialize(),
        success : function(result){
            location.href = "${pageContext.request.contextPath}/weekly/detail/"+result;
        }
    });
});

//테이블 로우 삭제
$(document).on("click", "button[name='trRemove']", function(){
    $(this).closest("tr").remove();
});

//취소버튼 이동
$(document).on("click", "#cancelButton", function(){
    location.href = "${pageContext.request.contextPath}/weekly/list";
});

//모달 체크박스 이벤트
$(document).on('change', "#modalForm input[name='admSeq']", function(){
    var value = $(this).val();
    if($(this).is(":checked")){
        authArray.push(value);
    } else {
        authArray = authArray.filter(function(item) {
            return item !== value;
        });
    }
});

//모달창 저장버튼
$(document).on("click", "#save", function(){
    var weekly = new Object();
    weekly.admSeq = authArray;
    weekly.detailStrDate = $("#MstrDate0").val();
    weekly.detailEndDate = $("#MendDate0").val();

    $.ajax({
        url : "${pageContext.request.contextPath}/weekly/modalSave",
        type: "POST",
        data : weekly,
        dataType : "html",
        success : function(data){
            $("#weeklyBody").html($(data).find('#weeklyBody').html());
            $("#close").click();
        }
    });
});

//기간변화
$(document).on("blur","input[name='strDate']",function(){
    $("input[name='detailStrDate']").val($("#WstrDate").val());
});

//대표 날짜 변경시 이벤트
$(document).on("blur","input[name='endDate']",function(){
    $("input[name='detailEndDate']").val($("#WendDate").val());
});

//모달팝업 검색
function search(){
    var searchText = $("input[name='searchText']").val();
    var form = $("#weeklyForm");
    form.append("<input type='hidden' name='searchText' value='" + searchText + "'/>");

    $.ajax({
        url : "${pageContext.request.contextPath}/weekly/openModal",
        type: "POST",
        data : $("#weeklyForm").serialize(),
        dataType : "html",
        success : function(data){
            $("#modalBody").html($(data).find('#modalBody').html());
            form.find("input[name='searchText']").remove();
            $("#MstrDate0").val($("#WstrDate").val());
            $("#MendDate0").val($("#WendDate").val());
        }
    });
}

</script>