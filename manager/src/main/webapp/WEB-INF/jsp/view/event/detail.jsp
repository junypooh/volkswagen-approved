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
        <form id="eventForm">
          <div class="page-control">
              <div class="row">
                  <div class="col-xs-6">
                        <span class="page-title"> 이벤트 관리 </span>
                  </div>
                  <div class="col-xs-6 text-right">
				        <c:if test="${eventVo.formFlag == 1}">
					        <button type="button" id="deleteButton" class="btn btn-default btn-delete">삭제</button>
					    </c:if>
					    <button type="button" id="cancelButton" class="btn btn-default">목록</button>
					    <c:if test="${eventVo.formFlag == 0}">
					        <button type="button" id="saveButton" class="btn btn-primary">저장</button>
					    </c:if>
                        <c:if test="${eventVo.formFlag == 1}">
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
                                  <input name="title" type="text" class="form-control" placeholder="제목을 입력하세요" onkeyup="limitByteStr(this)" limitByte="50" value="${eventVo.title}">
                              </td>
                          </tr>
                          <tr>
                              <th>
                                  타입<span class="asterisk">*</span>
                              </th>
                              <td>
                                  <span class="radio-inline">
                                      <input type="radio" value="Registe" name="type" <c:if test="${eventVo.type == 'Registe' || eventVo.type == null}">checked="checked"</c:if>> 등록
                                  </span>
                                  <span class="radio-inline">
                                      <input type="radio" value="Link" name="type" <c:if test="${eventVo.type == 'Link'}">checked="checked"</c:if>> 링크
                                  </span>
                              </td>
                          </tr>
                          <tr>
                              <th>
                                  내용(PC)<span class="asterisk">*</span>
                              </th>
                              <td id="registePc" <c:if test="${eventVo.type == 'Link'}"> style="display : none;"</c:if>>
                                  <textarea name="ctntPc" id="editor1" cols="100" rows="10" class="form-control" placeholder="내용을 입력하세요"><c:if test="${eventVo.type == 'Registe'}">${eventVo.ctntPc}</c:if>

                                  </textarea>
                              </td>
                              <td id="linkPc" <c:if test="${eventVo.type == 'Registe' || eventVo.type == null}"> style="display : none;"</c:if>>
                                <span class="checkbox">
                                    <label>
                                        <input type="checkbox" name="newWinYnPc" <c:if test="${eventVo.newWinYnPc == 'Y'}">checked="checked"</c:if>> 새 창
                                    </label>
                                </span>
                                <input type="text" name="pcLinkUrl" class="form-control" placeholder="http://부터 전체 URL을 입력하세요." <c:if test="${eventVo.type == 'Link'}">value="${eventVo.ctntPc}"</c:if>>
                              </td>

                          </tr>
                          <tr>
                              <th>
                                  내용(Mobile)
                              </th>
                              <td id="registeMo" <c:if test="${eventVo.type == 'Link'}"> style="display : none;"</c:if>>
                                  <textarea name="ctntMo"id="editor2" cols="100" rows="10" class="form-control" placeholder="내용을 입력하세요"><c:if test="${eventVo.type == 'Registe'}">${eventVo.ctntMo}</c:if>
                                  </textarea>
                              </td>
                              <td id="linkMo" <c:if test="${eventVo.type == 'Registe' || eventVo.type == null}"> style="display : none;"</c:if>>
                                <span class="checkbox">
                                    <label>
                                            <input type="checkbox" name="newWinYnMo" <c:if test="${eventVo.newWinYnMo == 'Y'}">checked="checked"</c:if>> 새 창
                                    </label>
                                </span>
                                <input type="text" name="moLinkUrl" class="form-control" placeholder="http://부터 전체 URL을 입력하세요."<c:if test="${eventVo.type == 'Link'}">value="${eventVo.ctntMo}"</c:if>>
                              </td>

                          </tr>
                          <tr>
                              <th>
                                  섬네일<span class="asterisk">*</span>
                              </th>
                              <td>
                                    <div id="upload" class="dropzone">
                                        <c:if test="${eventVo.fileUrl !='' && eventVo.fileUrl != null}">
                                        <div name="preview" class="dz-preview dz-processing dz-image-preview dz-success dz-complete">
                                            <div class="dz-image">
                                                <img data-dz-thumbnail src="${pageContext.request.scheme}://${eventVo.fileUrl}" style="width: 100%; height: 100%;">
                                            </div>
                                            <div class="dz-details">
                                                <div class="dz-size">
                                                    <span>
                                                        <strong>${eventVo.file.fileSize}</strong> byte
                                                    </span>
                                                </div>
                                                <div class="dz-filename">
                                                    <span class="dz-upload" data-dz-uploadprogress style="width: 100%;">${eventVo.file.oriFileNm}</span>
                                                </div>
                                            </div>
                                        </div>
                                        </c:if>
                                    </div>
                                    <p class="help-block">이미지 형식 : PNG, JPG, JPGE / 권장 사이즈 : 1280*360</p>
                                    <input name="imgSeq" type="hidden" value="${eventVo.file.fileSeq}">
                                    <input name="imgSeq2" type="hidden" value="${eventVo.file.fileSeq}">
                              </td>
                          </tr>
                          <tr>
                              <th>
                                  섬네일 (메인)<span class="asterisk">*</span>
                              </th>
                              <td>
                                    <div class="dropzone">
                                        <c:if test="${eventVo.mainFileUrl !='' && eventVo.mainFileUrl != null}">
                                        <div name="preview" class="dz-preview dz-processing dz-image-preview dz-success dz-complete">
                                            <div class="dz-image">
                                                <img data-dz-thumbnail src="${pageContext.request.scheme}://${eventVo.mainFileUrl}" style="width: 100%; height: 100%;">
                                            </div>
                                            <div class="dz-details">
                                                <div class="dz-size">
                                                    <span>
                                                        <strong>${eventVo.mainImgFile.fileSize}</strong> byte
                                                    </span>
                                                </div>
                                                <div class="dz-filename">
                                                    <span class="dz-upload" data-dz-uploadprogress style="width: 100%;">${eventVo.mainImgFile.oriFileNm}</span>
                                                </div>
                                            </div>
                                        </div>
                                        </c:if>
                                    </div>
                                    <p class="help-block">이미지 형식 : PNG, JPG, JPGE / 권장 사이즈 : 620*425</p>
                                    <input name="mainImgSeq" type="hidden" value="${eventVo.mainImgFile.fileSeq}">
                                    <input name="mainImgSeq2" type="hidden" value="${eventVo.mainImgFile.fileSeq}">
                              </td>
                          </tr>
                          <tr>
                              <th>
                                  노출 여부<span class="asterisk">*</span>
                              </th>
                              <td>
								    <span class="onoffswitch">
                                        <input type="checkbox" class="onoffswitch-checkbox" data-id="4033" name="expsYn" id="expsYn-4033"<c:if test="${eventVo.expsYn == 'Y'}"> checked="checked"</c:if>>
									    <label class="onoffswitch-label" for="expsYn-4033">
									        <i class="inner"></i><i class="switch"></i>
									    </label>
								    </span>
                              </td>
                          </tr>
                          <tr>
                              <th>
                                  이벤트 기간<span class="asterisk">*</span>
                              </th>
                              <td>
                                  <div class="wrap-calendar reservation-calendar form-inline ">
                                  <div class="input-group">
                                      <div class="input-icon">
                                          <i class="fa fa-calendar"></i>
                                          <input type="text" class="form-control datetimepicker" name="strDate" id="strDate" value="${eventVo.strDate}" placeholder="from" >
                                      </div>
                                      <span class="input-group-addon">~</span>
                                          <div class="input-icon">
                                              <i class="fa fa-calendar"></i>
                                              <input type="text" class="form-control datetimepicker" name="endDate" id="endDate" value="${eventVo.endDate}" placeholder="to">
                                          </div>
                                      </div>
                                  </div>
                              </td>
                          </tr>
                          <tr>
                              <th>
                                  당첨자 발표
                              </th>
                              <td>
                                  <span class="checkbox">
                                      <label>
                                          <input type="checkbox" name="winnNewWinYn" <c:if test="${eventVo.winnNewWinYn == 'Y'}">checked="checked"</c:if>> 새 창
                                      </label>
                                  </span>
                                  <input name="winnLinkUrl" value="${eventVo.winnLinkUrl}" type="text" class="form-control" placeholder="http://부터 전체 URL을 입력하세요." >
                                  <input type="hidden" name="eventSeq" value="${eventVo.eventSeq}">
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
//구분 선택 이벤트
$("input[name='type']").on("change", function(){
    var value = $(this).val()
    if(value == "Link"){
        $("#linkMo").show();
        $("#linkPc").show();
        $("#registePc").hide();
        $("#registeMo").hide();

    } else {
        $("#registePc").show();
        $("#registeMo").show();
        $("#linkPc").hide();
        $("#linkMo").hide();
    }
});

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

    var eventSeq=$("input[name='eventSeq']").val();

    $.ajax({
        url : "${pageContext.request.contextPath }/event/eventDelete",
        type : "POST",
        data : {eventSeq:eventSeq},
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
    location.href = "${pageContext.request.contextPath}/event/list";
});

//저장버튼 이동
$("#saveButton").on("click", function(){
    $("textarea[name='ctntPc']").val(CKEDITOR.instances.editor1.getData());
    $("textarea[name='ctntMo']").val(CKEDITOR.instances.editor2.getData());

    if($("input[name='title']").val() == "" || $("input[name='title']").val() == null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if($("input:radio[name='type']:checked").val()=='Link'){
        if($("input[name='pcLinkUrl']").val()=="" || $("input[name='pcLinkUrl']").val()==null){
            alert("미입력 항목이 있습니다.");
            return;
        } else {

        }
    } else {
        if(CKEDITOR.instances.editor1.getData()=="" || CKEDITOR.instances.editor1.getData()==null){
            alert("미입력 항목이 있습니다.");
            return;
        } else {

        }
    }



    if($("input[name='strDate']").val()=="" || $("input[name='strDate']").val()==null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if($("input[name='endDate']").val()=="" || $("input[name='endDate']").val()==null){
        alert("미입력 항목이 있습니다.");
        return;
    }


    if($("input[name='imgSeq']").val()=="" || $("input[name='imgSeq']").val()==null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if($("input[name='mainImgSeq']").val()=="" || $("input[name='mainImgSeq']").val()==null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    $.ajax({
        url : "${pageContext.request.contextPath }/event/eventRegiste",
        type : "POST",
        data : $("#eventForm").serialize(),
        success : function(result){
            location.href = "${pageContext.request.contextPath}/event/detail/"+result;
            alert("저장되었습니다.");
        }
    });
});

//업데이트버튼 이동
$("#updateButton").on("click", function(){
    $("textarea[name='ctntPc']").val(CKEDITOR.instances.editor1.getData());
    $("textarea[name='ctntMo']").val(CKEDITOR.instances.editor2.getData());
    if($("input[name='title']").val() == "" || $("input[name='title']").val() == null){
        alert("미입력 항목이 있습니다.");
        return;
    }


    if($("input:radio[name='type']:checked").val()=='Link'){
        if($("input[name='pcLinkUrl']").val()=="" || $("input[name='pcLinkUrl']").val()==null){
            alert("미입력 항목이 있습니다.");
            return;
        } else {

        }
    } else {
        if(CKEDITOR.instances.editor1.getData()=="" || CKEDITOR.instances.editor1.getData()==null){
            alert("미입력 항목이 있습니다.");
            return;
        } else {

        }
    }


    if($("input[name='strDate']").val()=="" || $("input[name='strDate']").val()==null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if($("input[name='endDate']").val()=="" || $("input[name='endDate']").val()==null){
        alert("미입력 항목이 있습니다.");
        return;
    }


    if($("input[name='imgSeq']").val()=="" || $("input[name='imgSeq']").val()==null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    if($("input[name='mainImgSeq']").val()=="" || $("input[name='mainImgSeq']").val()==null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    $.ajax({
        url : "${pageContext.request.contextPath }/event/updateEvent",
        type : "POST",
        data : $("#eventForm").serialize(),
        success : function(result){
            location.href = "${pageContext.request.contextPath}/event/detail/"+result;
            alert("저장되었습니다.");
        }
    });
});

//구분 선택 이벤트
$("input[name='type']").on("change", function(){
    var type = $(this).val()
    if(type == "Link"){
        $("#exhibTable").hide();
        $("select[name='exhHallSeq']").attr("disabled", true);
    } else {
        $("#exhibTable").show();
        $("select[name='exhHallSeq']").attr("disabled", false);
    }
});
</script>

<script type="text/javascript">
//드랍존 표시
(function() {
        /** file Upload */
        Dropzone.autoDiscover = false;
        $('.dropzone').each(function(i){
            var td = $(this).closest("td");
            var upload = new Dropzone($(this).get(0), {
                url: "${pageContext.request.contextPath}/file/upload/dropzone?_csrf=${_csrf.token}",
                acceptedFiles: "image/jpeg,image/png,image/jpg",
                method: 'post',
                params: {'type': 'EVENT'},
                uploadMultiple: false,
                addRemoveLinks: true,
                maxFiles: 1,
                autoProcessQueue: true
            });
            upload.on('success', function(file, response){
                $(td).find("div[name='preview']").hide();

                if($(td).find("input[name='imgSeq']").val() != undefined){
                    $(td).find("input[name='imgSeq']").val(response.fileSeq);
                } else if ($(td).find("input[name='mainImgSeq']").val() != undefined){
                    $(td).find("input[name='mainImgSeq']").val(response.fileSeq);
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
                var _potoCnt = $(td).find('.dz-preview').length;
                if (_potoCnt == 1) {
                    if($(td).find("input[name='imgSeq']").val() != undefined){
                        var imgSeq2 = $(td).find("input[name='imgSeq2']").val();
                        $(td).find("input[name='imgSeq']").val(imgSeq2);
                    } else if ($(td).find("input[name='mainImgSeq']").val() != undefined){
                        var mainImgSeq2 = $("input[name='mainImgSeq2']").val();
                        $(td).find("input[name='mainImgSeq']").val(mainImgSeq2);
                    }
                    $(td).find("div[name='preview']").show();
                }

            });

        });
    })();


</script>
<script>
//CKEditor 표시
CKEDITOR.replace( 'editor1', {
    language: 'ko',
    toolbar: [
        ['Source'],
         ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
         ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
         ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
         '/',
         ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
         ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
         ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
         ['Link','Unlink','Anchor'],
         ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
         '/',
         ['Styles','Format','Font','FontSize'],
         ['TextColor','BGColor'],
         ['Maximize', 'ShowBlocks','-','About']
    ],

    filebrowserUploadUrl: "${pageContext.request.contextPath}/file/upload/CKEditor?_csrf=${_csrf.token}&type=EVENT",

} );

    CKEDITOR.replace( 'editor2', {
        language: 'ko',
        toolbar: [
            ['Source'],
             ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
             ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
             ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
             '/',
             ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
             ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
             ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
             ['Link','Unlink','Anchor'],
             ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
             '/',
             ['Styles','Format','Font','FontSize'],
             ['TextColor','BGColor'],
             ['Maximize', 'ShowBlocks','-','About']
        ],

        filebrowserUploadUrl: "${pageContext.request.contextPath}/file/upload/CKEditor?_csrf=${_csrf.token}&type=EVENT",

    } );
</script>


