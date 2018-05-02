<%--
  주요옵션관리
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">
//인증, 비인증탭이동
function goVwOption(isVw) {
    location.href="list?vwYn="+isVw;
}

$(function(){

    //정렬저장버튼 이벤트트
    $(document).on("click","#updateIndex",function(){

        $.ajax({
            url : "${pageContext.request.contextPath}/majoropt/updateMajOrdNo",
            type: "POST",
            data : $("#majorOptionForm").serialize(),
            success : function(result){
               if(result > 0 ){
               } else {
                   alert("순서정렬에 실패했습니다.");
               }
            }
        });
    });

    //편집버튼 이벤트
    $(document).on("click","button[name='editButton']",function(){
        var tr = $(this).closest("tr");
        $(tr).find("div[name='textDisplay']").hide();
        $(tr).find("button[name='editButton']").hide();
        $(tr).find("button[name='editCancelButton']").show();
        $(tr).find("button[name='editUpdateButton']").show();
        $(tr).find("input").show();
        $(tr).find("div[name='inputDisplay']").show();
        $(tr).find("input[name='expsYn']").attr("disabled", false);
    });

    //취소버튼 이벤트
    $(document).on("click","button[name='editCancelButton']", function(){
        var tr = $(this).closest("tr");

        $(tr).find("div[name='textDisplay']").show();
        $(tr).find("button[name='editButton']").show();
        $(tr).find("button[name='editCancelButton']").hide();
        $(tr).find("button[name='editUpdateButton']").hide();
        $(tr).find("input").hide();
        $(tr).find("div[name='inputDisplay']").hide();
        var checkValue = $(tr).find("input[name='hiddenExpsYn']").val();
        $(tr).find("input[name='expsYn']").prop("checked", checkValue == "Y");
        $(tr).find("input[name='expsYn']").attr("disabled", true);
    });

    //저장버튼 이벤트
    $(document).on("click","button[name='editUpdateButton']", function(){
        var tr = $(this).closest("tr");
        var option = new Object();

        option.optSeq = $(tr).find("input[name='optSeq']").val();
        option.thumImgOn = $(tr).find("input[name='thumImgOn']").val();
        option.thumImgOff = $(tr).find("input[name='thumImgOff']").val();
        option.expsYn = $(tr).find("input[name='expsYn']").prop("checked") ? "Y" : "N";


        $.ajax({
               url : "${pageContext.request.contextPath}/majoropt/update",
               type: "POST",
               data : option,
               success : function(result){
                   if(result == 1 ){
                       location.reload();
                   } else {
                       alert("수정에 실패했습니다.");
                   }
               }
           });
    });

    //노출버튼 이벤트
    $(document).on("click","#expsYn",function(){
        $.ajax({
           url : "${pageContext.request.contextPath}/majoropt/list",
           type: "POST",
           data : $("#expsForm").serialize(),
           dataType : "html",
           success : function(data){
              $("#searchTable").html($(data).find('#searchTable').html());
              $("#paging").html($(data).find('#paging').html());

              if($("#expsYn").prop("checked")){
                  $("#updateIndex").hide();
              } else {
                  $("#updateIndex").show();
              }

              $('.main-options .upload').each(function(i) {
                  dropzoneLoad($(this));
              });
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

    //맨아래, 맨위에 버튼들 비활성화
    function upDowButtonDisabled(){
        //모든 버튼 활성화 뒤 맨아래, 맨위 버튼 비활성화
        $("button[name='upButton']").attr("disabled", false);
        $("button[name='downButton']").attr("disabled", false);
        $("#optionBody tr:first").find("button[name='upButton']").attr("disabled", true);
        $("#optionBody tr:last").find("button[name='downButton']").attr("disabled", true);
    }

    function dropzoneLoad(obj){
        var tr = $(obj).closest("tr");
        var td = $(obj).closest("td");
        var upload = new Dropzone($(obj).get(0), {
            url: "${pageContext.request.contextPath}/file/upload/dropzone?_csrf=${_csrf.token}",
            dictDefaultMessage: "업로드 할 파일을 선택하거나 <br>드래그 앤 드롭 하세요.",
            acceptedFiles: "image/jpeg,image/png,image/jpg",
            method: 'post',
            params: {'type': 'OPTION'},
            uploadMultiple: false,
            maxFiles: 1,
            addRemoveLinks: true
        });
        upload.on('success', function(file, response){
            //업로드 성공 후
            if($(td).find("input[name='thumImgOn']").val() != undefined){
                $(td).find("input[name='thumImgOn']").val(response.fileSeq);
            } else if ($(td).find("input[name='thumImgOff']").val() != undefined){
                $(td).find("input[name='thumImgOff']").val(response.fileSeq);
            }
        });
        upload.on('error', function(file, response) {
            if (response == 'You can not upload any more files.') {
                alert('기존 파일을 삭제한뒤 등록해주세요.');
            } else {
                alert('Error while uploading file!');
            }
            upload.removeFile(file);
        });
        upload.on("removedfile", function(file){
            //업로드 파일 remove 버튼 클릭 시 이전파일로 원복
            var _potoCnt = $(td).find('.dz-preview').length;
            if (_potoCnt == 2) {
                if($(td).find("input[name='thumImgOn']").val() != undefined){
                    var thumImgOn = $(td).find("input[name='orgThumImgOn']").val();
                    $(td).find("input[name='thumImgOn']").val(thumImgOn);
                } else if ($(td).find("input[name='thumImgOff']").val() != undefined){
                    var thumImgOff = $("input[name='orgThumImgOff']").val();
                    $(td).find("input[name='thumImgOff']").val(thumImgOff);
                }
            }
        });
    }

</script>
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
                        <span class="page-title"> 주요옵션 관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <span>우선 노출은 8개 까지 가능합니다.</span>
                        <!-- 노출여부가 체크되있을 시 정렬불가 -->
                        <c:if test="${searchParam.expsYn != 'Y'}">
                            <button type="button" class="btn btn-default" id="updateIndex">정렬 저장</button>
                        </c:if>
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
                <div class="card">
                    <div class="tools">
                        <div class="row">
                            <form id="expsForm">
                                <div class="col-xs-4">
                                    <span class="checkbox">
                                        <label>
                                        <input type="checkbox" name="expsYn" id="expsYn" value="Y" <c:if test="${searchParam.expsYn == 'Y'}">checked="checked"</c:if>> 노출
                                        </label>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </div>
                    <form id="majorOptionForm">
                        <table id="searchTable" class="table table-hover table-bordered table-vertical main-options">
                            <colgroup>
                                <col style="width: 70px;">
                                <col style="width: 70px;">
                                <col>
                                <col style="width: 300px;">
                                <col style="width: 300px;">
                                <col style="width: 100px;">
                                <col style="width: 100px;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>정렬</th>
                                    <th>유형</th>
                                    <th>옵션명</th>
                                    <th>썸네일 ON<span class="asterisk">*</span><br><small>이미지 형식 : PNG, JPG, JPGE / 권장 사이즈 : 113*113</small></th>
                                    <th>썸네일 OFF<span class="asterisk">*</span><br><small>이미지 형식 : PNG, JPG, JPGE / 권장 사이즈 : 113*113</small></th>
                                    <th>노출 여부</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody id="optionBody">
                                <c:forEach var="majorOption" items="${majorOptionList}" varStatus="status">
                                    <tr>
                                        <td>
                                            <button type="button" name="upButton" class="btn btn-xs btn-default" <c:if test="${status.first || searchParam.expsYn eq 'Y'}">disabled="disabled"</c:if>>
                                                <i class="fa fa-arrow-up"></i>
                                            </button>
                                            <button type="button" name="downButton" class="btn btn-xs btn-default" <c:if test="${status.last || searchParam.expsYn eq 'Y'}">disabled="disabled"</c:if>>
                                                <i class="fa fa-arrow-down"></i>
                                            </button>
                                        </td>
                                        <td class="text-left">${majorOption.cateName}</td>
                                        <td class="text-left">
                                            <input name="index" type="hidden" value="${status.index}">
                                            <input type="hidden" name="optSeq" value="${majorOption.optSeq}">
                                            <div>${majorOption.optNm}</div>
                                        </td>
                                        <td class="text-left">
                                            <input type="hidden" name="orgThumImgOn" value="${majorOption.thumImgOnFile.fileSeq}">
                                            <input type="hidden" name="thumImgOn" value="${majorOption.thumImgOnFile.fileSeq}">
                                            <div name="textDisplay" class="dropzone upload upload-option" <c:if test="${majorOption.thumImgOnFile == null || majorOption.thumImgOffFile == null}">style="display: none;"</c:if>>
                                                <div class="dz-preview dz-file-preview">
                                                    <div class="dz-preview dz-complete dz-image-preview">
                                                        <div class="dz-image">
                                                            <c:if test="${majorOption.thumImgOnFile != null}">
                                                                <img data-dz-thumbnail data-dz-remove src="${pageContext.request.scheme}://${searchParam.fileUrlPath}${majorOption.thumImgOnFile.filePath}${majorOption.thumImgOnFile.fileNm}">
                                                            </c:if>
                                                            <c:if test="${majorOption.thumImgOnFile == null}">
                                                                <img data-dz-thumbnail data-dz-remove src="http://via.placeholder.com/350x150">
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="dz-default dz-message"></div>
                                            </div>
                                            <div name="inputDisplay" class="dropzone upload upload-option" <c:if test="${majorOption.thumImgOnFile != null && majorOption.thumImgOffFile != null}">style="display: none;"</c:if>>
                                            </div>
                                        </td>
                                        <td class="text-left">
                                            <input type="hidden" name="orgThumImgOff" value="${majorOption.thumImgOffFile.fileSeq}">
                                            <input type="hidden" name="thumImgOff" value="${majorOption.thumImgOffFile.fileSeq}">
                                            <div name="textDisplay" class="dropzone upload upload-option" <c:if test="${majorOption.thumImgOnFile == null || majorOption.thumImgOffFile == null}">style="display: none;"</c:if>>
                                                <div class="dz-preview dz-file-preview">
                                                    <div class="dz-preview dz-complete dz-image-preview">
                                                        <div class="dz-image">
                                                            <c:if test="${majorOption.thumImgOffFile != null}">
                                                                <img data-dz-thumbnail data-dz-remove src="${pageContext.request.scheme}://${searchParam.fileUrlPath}${majorOption.thumImgOffFile.filePath}${majorOption.thumImgOffFile.fileNm}">
                                                            </c:if>
                                                            <c:if test="${majorOption.thumImgOffFile == null}">
                                                                <img data-dz-thumbnail data-dz-remove src="http://via.placeholder.com/350x150">
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="dz-default dz-message"></div>
                                            </div>
                                            <div name="inputDisplay" class="dropzone upload upload-option" <c:if test="${majorOption.thumImgOnFile != null && majorOption.thumImgOffFile != null}">style="display: none;"</c:if>>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="onoffswitch" >
                                                <input type="hidden" name="hiddenExpsYn" value="${majorOption.expsYn}">
                                                <input type="checkbox" class="onoffswitch-checkbox" data-id="${status.index}" name="expsYn" id="isVisibled-${status.index}" <c:if test="${majorOption.expsYn == 'Y'}"> checked="checked" </c:if> <c:if test="${majorOption.thumImgOnFile != null && majorOption.thumImgOffFile != null}"> disabled="disabled"</c:if>>
                                                <label class="onoffswitch-label" for="isVisibled-${status.index}">
                                                    <i class="inner"></i><i class="switch"></i>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <button type="button" name="editButton" class="btn btn-xs btn-default" <c:if test="${majorOption.thumImgOnFile == null || majorOption.thumImgOffFile == null}">style="display: none;"</c:if>>편집</button>
                                            <button type="button" name="editUpdateButton" class="btn btn-xs btn-primary" <c:if test="${majorOption.thumImgOnFile != null && majorOption.thumImgOffFile != null}">style="display: none;"</c:if>>저장</button>
                                            <button type="button" name="editCancelButton" class="btn btn-xs btn-default" <c:if test="${majorOption.thumImgOnFile != null && majorOption.thumImgOffFile != null}">style="display: none;"</c:if>>취소</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </form>
                    <div id="paging" class="row">
                        <div class="col-xs-2">
                            Total : <span>${fn:length(majorOptionList)}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        (function() {
            Dropzone.autoDiscover = false;
            $('.main-options .upload').each(function(i) {
                dropzoneLoad($(this));
            });
        })();
    </script>
</div>