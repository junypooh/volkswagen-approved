<%--
    통계관리/WeeklyReport/목록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
var authArray = new Array();
$(function(){

    //달력
    $(document).on('focus', ".datetimepicker", function(){
        $('.datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: "kr"
        });
    });

    //그룹관리자찾기버튼 이벤트
    $(document).on('click', "#modalButton", function(){
        $.ajax({
            url : "${pageContext.request.contextPath}/weekly/openModal",
            type: "POST",
            data : $("#weeklyForm").serialize(),
            dataType : "html",
            success : function(data){
                $("#modalBody").html($(data).find('#modalBody').html());
                $("#MstrDate0").val($("input[name='strDate']").val());
                $("#MendDate0").val($("input[name='endDate']").val());

                authArray = new Array();
                $("#modalForm").find("input[name='admSeq']:checked").each(function (index) {
                    authArray.push($(this).val());
                });

            }
        });
    });

    //기간변화
    $(document).on("blur","input[name='strDate']",function(){
        $("input[name='detailStrDate']").val($(this).val());
    });
    $(document).on("blur","input[name='endDate']",function(){
        $("input[name='detailEndDate']").val($(this).val());
    });

    //저장버튼 이벤트
    $(document).on('click', "#saveButton", function(){
        //미입력항목 체크
        if(!inputCheck($("input[name='title']"))) return;
        if(!inputCheck($("input[name='strDate']"))) return;
        if(!inputCheck($("input[name='endDate']"))) return;

        $.ajax({
            url : "${pageContext.request.contextPath}/weekly/saveWeekly",
            type: "POST",
            data : $("#weeklyForm").serialize(),
            success : function(data){
                if(data > 0){
                    alert("저장되었습니다.");
                    location.reload();
                } else {
                    alert("저장에 실패했습니다.");
                }
            }
        });
    });

    //삭제버튼 이벤트
    $(document).on("click", "#deleteButton", function(){
        $.ajax({
            url : "${pageContext.request.contextPath}/weekly/deleteWeekly",
            type: "POST",
            data : $("#weeklyForm").serialize(),
            success : function(data){
                location.href="${pageContext.request.contextPath}/weekly/list";
            }
        });
    });

    //취소버튼 이벤트
    $(document).on("click", "#cancelButton", function(){
        location.href = "${pageContext.request.contextPath}/weekly/list";
    });

    //그룹관리자 삭제버튼 이벤트
    $(document).on("click", "button[name='trRemove']", function(){
        $(this).closest("tr").remove();
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

    //모달팝업 저장버튼 이벤트
    $(document).on("click", "#save", function(){
        var weekly = new Object();
        weekly.weekRepSeq = $("#modalForm").find("input[name='weekRepSeq']").val();
        weekly.admSeq = authArray;
        weekly.detailStrDate = $("#MstrDate0").val();
        weekly.detailEndDate = $("#MendDate0").val();

        $.ajax({
            url : "${pageContext.request.contextPath}/weekly/updateModal",
            type: "POST",
            data : weekly,
            success : function(data){
                //성공 후 그룹관리자를 다시 불러온다
                authReload(data);
            }
        });
    });

    //파일 선택 시 이벤트
    $(document).on("change", "input[name='weeklyFile']", function(){
        if($(this).val() == "") return;

        var form = new FormData();
        form.append("weeklyFile", $(this)[0].files[0]);
        form.append("weekRepSeq", $("#weeklyForm").find("input[name='weekRepSeq']").val());
        form.append("admSeq", $(this).closest("tr").find("input[name='admSeq']").val());

        $.ajax({
            url: "${pageContext.request.contextPath}/weekly/readExcel",
            type: 'POST',
            data: form,
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            success: function (response) {
                //성공 후 그룹관리자를 다시 불러온다
                authReload(response.weekRepSeq);
            }
        });
    });

    //파일 x버튼(파일삭제) 이벤트
    $(document).on("click", "button[name='fileDelete']", function(){
        var weekly = new Object();
        weekly.weekRepSeq = $("#weeklyForm").find("input[name='weekRepSeq']").val();
        weekly.admSeq = $(this).closest("tr").find("input[name='admSeq']").val();

        $.ajax({
            url : "${pageContext.request.contextPath}/weekly/deleteFile",
            type: "POST",
            data : weekly,
            success : function(data){
                if(data > 0){
                    authReload(weekly.weekRepSeq);
                }
            }
        });
    });


    //엑셀 다운로드
    $(document).on("click", "#excelDownBtn", function(){
        var form=$("#weeklyForm");
        form.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
        form.attr("method", "POST");
        form.attr("action","${pageContext.request.contextPath}/weekly/detailExcelDown");
        form.submit();
        form.find("input[name='${_csrf.parameterName}']").remove();
    });
});


function inputCheck(obj){
    if($(obj).val().trim() == ""){
        alert("미입력 항목이 있습니다");
        $(obj).focus();
        return false;
    }
    return true;
}

//그룹관리자 reload
function authReload(seq){
    $.ajax({
        url : "${pageContext.request.contextPath}/weekly/detail/" + seq,
        type: "GET",
        dataType : "html",
        success : function(data){
            $("#authBody").html($(data).find('#authBody').html());
            $("#close").click();
        }
    });
}
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
            $("#MstrDate0").val($("input[name='strDate']").val());
            $("#MendDate0").val($("input[name='endDate']").val());
        }
    });
}
</script>

<div id="body">
    <div id="container" class="container">
        <div class="wrap-contents">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> Weekly Report</span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <button type="button" id="deleteButton" class="btn btn-default btn-delete" <c:if test="${authType ne 'VW'}">disabled="disabled"</c:if>>삭제</button>
                        <button type="button" id="cancelButton" class="btn btn-default">목록</button>
                        <button type="button" id="saveButton" class="btn btn-primary" <c:if test="${authType ne 'VW'}">disabled="disabled"</c:if>>저장</button>
                    </div>
                </div>
            </div>
            <div class="contents">
                <form id="weeklyForm">
                    <input type="hidden" name="weekRepSeq" value="${weekly.weekRepSeq}">
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
                                            <input type="radio" name="categoryCd" value="I1001" <c:if test="${weekly.categoryCd eq 'I1001'}">checked="checked"</c:if> <c:if test="${authType ne 'VW'}">disabled="disabled"</c:if>> 매입
                                        </span>
                                        <span class="radio-inline">
                                            <input type="radio" name="categoryCd" value="I1002" <c:if test="${weekly.categoryCd eq 'I1002'}">checked="checked"</c:if> <c:if test="${authType ne 'VW'}">disabled="disabled"</c:if>> 판매
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        제목 <span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <input type="text" name="title" value="${weekly.title}" onkeyup="limitByteStr(this)" limitByte="50" class="form-control" placeholder="제목을 입력하세요" <c:if test="${authType ne 'VW'}">disabled="disabled"</c:if>>
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
                                                    <input type="text" class="form-control datetimepicker" name="strDate" id="strDate" value="${weekly.strDate}" placeholder="from" <c:if test="${authType ne 'VW'}">disabled="disabled"</c:if>>
                                                </div>
                                                <span class="input-group-addon">~</span>
                                                <div class="input-icon">
                                                    <i class="fa fa-calendar"></i>
                                                    <input type="text" class="form-control datetimepicker" name="endDate" id="endDate" value="${weekly.endDate}" placeholder="to" <c:if test="${authType ne 'VW'}">disabled="disabled"</c:if>>
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
                                        <c:if test="${weekly.status eq 'reservation'}">
                                            <span class="item-status reservation"> 예약</span>
                                        </c:if>
                                        <c:if test="${weekly.status eq 'ing'}">
                                            <span class="item-status ing"> 진행중</span>
                                        </c:if>
                                        <c:if test="${weekly.status eq 'end'}">
                                            <span class="item-status end"> 종료</span>
                                        </c:if>
                                    </td>
                                </tr>
                                <c:if test="${authType eq 'VW'}">
                                    <tr>
                                        <th>
                                            권한지정 <span class="asterisk">*</span>
                                        </th>
                                        <td>
                                            <button type="button" class="btn btn-default" data-toggle="modal" data-target=".search-manager" id="modalButton"> 그룹 관리자 찾기</button>
                                            <small>&nbsp;※ 그룹 관리자 중 Weekly Report 업로드 권한을 부여한 그룹 관리자만 업로드 가능합니다.</small>
                                        </td>
                                    </tr>
                                </c:if>
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
                            <tbody id="authBody">
                                <c:if test="${weekly.weeklyDetailList == null || fn:length(weekly.weeklyDetailList) == 0}">
                                    <tr>
                                        <td colspan="7">선택된 그룹 관리자가 없습니다.</td>
                                    </tr>
                                </c:if>
                                <c:forEach var="weeklyDetail" items="${weekly.weeklyDetailList}">
                                    <c:if test="${authType eq 'VW' || userSeq == weeklyDetail.admSeq}">
                                        <tr>
                                            <td>
                                                <input type="hidden" name="admSeq" value="${weeklyDetail.admSeq}">
                                                ${weeklyDetail.id}
                                            </td>
                                            <td>
                                                <c:forEach var="authExhibMap" items="${weeklyDetail.authExhibMapList}">
                                                    ${authExhibMap.type} / ${authExhibMap.storeNm} <br>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                <div class="wrap-calendar reservation-calendar form-inline ">
                                                    <div class="input-group">
                                                        <div class="input-icon">
                                                            <i class="fa fa-calendar"></i>
                                                            <input type="text" class="form-control datetimepicker" name="detailStrDate" id="detailStrDate" value="${weeklyDetail.strDate}" placeholder="from" <c:if test="${authType ne 'VW'}">disabled="disabled"</c:if>>
                                                        </div>
                                                        <span class="input-group-addon">~</span>
                                                        <div class="input-icon">
                                                            <i class="fa fa-calendar"></i>
                                                            <input type="text" class="form-control datetimepicker" name="detailEndDate" id="detailEndDate" value="${weeklyDetail.endDate}" placeholder="to" <c:if test="${authType ne 'VW'}">disabled="disabled"</c:if>>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-left">
                                                <span class="file-wrap">
                                                    <span class="btn btn-xs btn-default">파일 선택</span>
                                                    <input type="file" name="weeklyFile" id="" <c:if test="${weeklyDetail.status ne 'ing' || weekly.status ne 'ing'}">disabled="disabled"</c:if>>
                                                </span>
                                                <c:if test="${weeklyDetail.fileNm != null && weeklyDetail.fileNm ne ''}">
                                                    <p class="file-name">
                                                        ${weeklyDetail.fileNm}
                                                        <button type="button" name="fileDelete" <c:if test="${weeklyDetail.status ne 'ing' || weekly.status ne 'ing'}">disabled="disabled"</c:if>><em>x</em></button>
                                                    </p>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${weeklyDetail.fileNm == null}">
                                                    -
                                                </c:if>
                                                <c:if test="${weeklyDetail.fileNm != null}">
                                                    완료
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${weeklyDetail.uploadDate == null}">
                                                    -
                                                </c:if>
                                                <c:if test="${weeklyDetail.uploadDate != null}">
                                                    <fmt:formatDate value="${weeklyDetail.uploadDate}" pattern="yyyy.MM.dd HH:mm"/>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${authType eq 'VW'}">
                                                    <button type="button" name="trRemove" class="btn btn-xs btn-default ">삭제</button>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${authType eq 'VW'}">
                            <div class="row">
                                <div class="col-xs-12 text-right">
                                    <button type="button" class="btn btn-primary" id="excelDownBtn"><i class="fa fa-download"></i> 엑셀 다운로드</button>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </form>

                <!-- 그룹 관리자 찾기 팝업 -->
                <form id="modalForm">
                    <input type="hidden" name="weekRepSeq" value="${weekly.weekRepSeq}">
                    <div class="modal fade search-manager" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" id="modalBody">
                    </div>
                </form>
                <!-- //그룹 관리자 찾기 팝업 -->
            </div>
        </div>
    </div>
</div>