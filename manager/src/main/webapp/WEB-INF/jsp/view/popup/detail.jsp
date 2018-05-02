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
    <div class="wrap-contents">
        <form id="popupForm">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> 팝업관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
				        <c:if test="${popupVo.formFlag == 1}">
					        <button type="button" id="deleteButton" class="btn btn-default btn-delete">삭제</button>
					    </c:if>
					    <button type="button" id="cancelButton" class="btn btn-default">목록</button>
					    <c:if test="${popupVo.formFlag == 0}">
					        <button type="button" id="saveButton" class="btn btn-primary">저장</button>
					    </c:if>
                        <c:if test="${popupVo.formFlag == 1}">
					        <button type="button" id="updateButton" class="btn btn-primary">저장</button>
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
                                    제목<span class="asterisk">*</span>
                                </th>
                                <td>
                                    <input name="title" type="text" class="form-control" placeholder="제목을 입력하세요" value="${popupVo.title}" onkeyup="limitByteStr(this)" limitByte="50">
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    링크 URL
                                </th>
                                <td>
                                    <span class="checkbox">
                                        <label>
                                            <input type="checkbox" name="newWinYn" <c:if test="${popupVo.newWinYn == 'Y'}">checked="checked" </c:if>> 새 창
                                        </label>
                                    </span>
                                    <input type="hidden" name="popupSeq" value="${popupVo.popupSeq}">
                                    <input name="imgSeq" type="hidden" value="${popupVo.file.fileSeq}">
                                    <input name="imgSeq2" type="hidden" value="${popupVo.file.fileSeq}">
                                    <input type="text" name="linkUrl" value="${popupVo.linkUrl}" class="form-control" placeholder="http://부터 전체 URL을 입력하세요." >
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    이미지<span class="asterisk">*</span>
                                </th>
                                <td>
                                    <div id="upload" class="dropzone">
                                        <c:if test="${popupVo.fileUrl !='' && popupVo.fileUrl != null}">
                                        <div name="preview" class="dz-preview dz-processing dz-image-preview dz-success dz-complete">
                                            <div class="dz-image">
                                                <img data-dz-thumbnail src="${pageContext.request.scheme}://${popupVo.fileUrl}" style="width: 100%; height: 100%;">
                                            </div>
                                            <div class="dz-details">
                                                <div class="dz-size">
                                                    <span>
                                                        <strong>${popupVo.file.fileSize}</strong> byte
                                                    </span>
                                                </div>
                                                <div class="dz-filename">
                                                    <span class="dz-upload" data-dz-uploadprogress style="width: 100%;">${popupVo.file.oriFileNm}</span>
                                                </div>
                                            </div>
                                        </div>
                                        </c:if>
                                    </div>
                                    <p class="help-block">이미지 형식 : PNG, JPG, JPGE / 권장 사이즈 : 500*700</p>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    노출 여부<span class="asterisk">*</span>
                                </th>
                                <td>
								    <span class="onoffswitch">
                                        <input type="checkbox" class="onoffswitch-checkbox" data-id="4033" name="expsYn" id="expsYn-4033"<c:if test="${popupVo.expsYn == 'Y'}"> checked="checked"</c:if>>
									    <label class="onoffswitch-label" for="expsYn-4033">
									        <i class="inner"></i><i class="switch"></i>
									    </label>
								    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    예약 설정
                                </th>
                                <td>
                                    <span class="checkbox">
                                        <label>
                                            <input name="Yn" type="checkbox" onchange="valueChanged(this)" <c:if test="${popupVo.endDate != '' && popupVo.endDate != null}">checked="checked"</c:if>> 사용
                                        </label>
                                    </span>
                                    <div class="wrap-calendar reservation-calendar form-inline ">
                                        <div class="input-group">
                                            <div class="input-icon">
                                                <i class="fa fa-calendar"></i>
                                                <input type="text" class="form-control datetimepicker" name="strDate" id="strDate" value="${popupVo.strDate}" placeholder="from" <c:if test="${popupVo.endDate == '' || popupVo.endDate == null}">disabled="disabled"</c:if>>
                                            </div>
                                            <span class="input-group-addon">~</span>
                                            <div class="input-icon">
                                                <i class="fa fa-calendar"></i>
                                                <input type="text" class="form-control datetimepicker" name="endDate" id="endDate" value="${popupVo.endDate}" placeholder="to" <c:if test="${popupVo.endDate == '' || popupVo.endDate == null}">disabled="disabled"</c:if>>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
//사용체크시 달력이용
function valueChanged(obj) {
    if($(obj).is(":checked"))
        $(".reservation-calendar input").prop("disabled",false);
    else
        $(".reservation-calendar input").prop("disabled",true);
}

//데이터 피커 형식지정
$('.datetimepicker').datetimepicker({
    format: 'YYYY-MM-DD',
    locale: "kr"
});

//드랍존 제거시 이벤트
$(document).on('click', ".dz-remove", function(){
    $("input[name='imgSeq']").val("");
});

//삭제버튼
$("#deleteButton").on("click", function(){
    if (confirm("정말 삭제하시겠습니까??") == true){    //확인

    }else{   //취소
            return;
    }

    var popupSeq=$("input[name='popupSeq']").val();

    $.ajax({
        url : "${pageContext.request.contextPath }/popup/popupDelete",
        type : "POST",
        data : {popupSeq:popupSeq},
        success : function(result){
            if(result == 1 ){
                alert("삭제되었습니다.");
                $("#cancelButton").trigger("click");
            } else {
                alert("삭제에 실패했습니다.");
            }
        }
    });
});

//취소버튼 이동
$("#cancelButton").on("click", function(){
    location.href = "${pageContext.request.contextPath}/popup/list";
});

//저장버튼 이동
$("#saveButton").on("click", function(){
    if($("input[name='title']").val() == "" || $("input[name='title']").val() == null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if($("input[name='Yn']").prop("checked") ){

        if($("input[name='strDate']").val()=="" || $("input[name='strDate']").val()==null){
            alert("미입력 항목이 있습니다.");
            return;
        }

        if($("input[name='endDate']").val()=="" || $("input[name='endDate']").val()==null){
            alert("미입력 항목이 있습니다.");
            return;
        }
    }

    if($("input[name='imgSeq']").val()=="" || $("input[name='imgSeq']").val()==null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if($("input[name='expsYn']").is(":checked") && Number("${popupExpsYCount}") >= 1){
        alert("팝업은 1개까지만 노출이 가능합니다.");
        return;
    }

    $.ajax({
        url : "${pageContext.request.contextPath }/popup/popupRegiste",
        type : "POST",
        data : $("#popupForm").serialize(),
        success : function(result){
            location.href = "${pageContext.request.contextPath}/popup/detail/"+result;
            alert("저장되었습니다.");
        }
    });
});

//업데이트버튼 이동
$("#updateButton").on("click", function(){
    if($("input[name='title']").val() == "" || $("input[name='title']").val() == null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if($("input[name='Yn']").prop("checked") ){

        if($("input[name='strDate']").val()=="" || $("input[name='strDate']").val()==null){
            alert("미입력 항목이 있습니다.");
            return;
        }

        if($("input[name='endDate']").val()=="" || $("input[name='endDate']").val()==null){
            alert("미입력 항목이 있습니다.");
            return;
        }
    }

    if($("input[name='imgSeq']").val()=="" || $("input[name='imgSeq']").val()==null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if($("input[name='expsYn']").is(":checked") && Number("${popupExpsYCount}") >= 1){
        alert("팝업은 1개까지만 노출이 가능합니다.");
        return;
    }

    $.ajax({
        url : "${pageContext.request.contextPath }/popup/updatePopup",
        type : "POST",
        data : $("#popupForm").serialize(),
        success : function(result){
            location.href = "${pageContext.request.contextPath}/popup/detail/"+result;
            alert("저장되었습니다.");
        }
    });
});
</script>

<script type="text/javascript">
//드랍존 표시
(function() {
        /** file Upload */
        Dropzone.autoDiscover = false;
        $('#upload').each(function(i){
            var upload = new Dropzone($(this).get(0), {
                url: "${pageContext.request.contextPath}/file/upload/dropzone?_csrf=${_csrf.token}",
                acceptedFiles: "image/jpeg,image/png,image/jpg",
                method: 'post',
                params: {'type': 'POPUP'},
                uploadMultiple: false,
                addRemoveLinks: true,
                maxFiles: 1,
                autoProcessQueue: true
            });
            upload.on('success', function(file, response){
                $("div[name='preview']").hide();
                $("input[name='imgSeq']").val(response.fileSeq);
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
                /*
                if(file.status=="success"){
                    var seq=$("input[name='imgSeq2']").val();
                    $("input[name='imgSeq']").val(seq);
                    $("div[name='preview']").show();
                }
                */
                var _potoCnt = $('#upload').find('.dz-preview').length;
                if (_potoCnt == 1) {
                    var _oriImgSeq = $("input[name='imgSeq2']").val();
                    $("input[name='imgSeq']").val(_oriImgSeq);
                    $("div[name='preview']").show();
                }
            });

        });
    })();


</script>