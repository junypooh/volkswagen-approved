<%--
    커뮤니티관리/등록, 수정
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(function(){

    $(document).on('click', ".dz-remove", function(){
        $("input[name='imgSeq']").val("");
    });

    //취소버튼 이벤트
    $("#cancelButton").on("click", function(){
        location.href = "${pageContext.request.contextPath}/community/list";
    });

    //저장버튼 이벤트
    $("#saveButton").on("click", function(){

        //미입력항목 체크
        if(!inputCheck($("input[name='title']"))) return;
        //if(!inputCheck($("textarea[name='ctnt']"))) return;
        if(!inputCheck($("input[name='imgSeq']"))) return;

        //내용체크
        if(CKEDITOR.instances.editor1.getData()=="" || CKEDITOR.instances.editor1.getData()==null){
           alert("미입력 항목이 있습니다.");
           return;
         }

        if($("input[name='useDate']").prop("checked")){
            if(!inputCheck($("input[name='strDate']"))) return;
            if(!inputCheck($("input[name='endDate']"))) return;

            //날짜비교
            var strDate = new Date($("input[name='strDate']").val());
            var endDate = new Date($("input[name='endDate']").val());
            if(strDate.getTime() > endDate.getTime()){
                alert("노출기간을 잘못 선택했습니다.");
                return;
            }
        }

        //ckeditor 데이터 저장
        $("textarea[name='ctnt']").val(CKEDITOR.instances.editor1.getData());

        if($("input[name='fixYn']").is(":checked") && Number("${fixYCount}") > 2){
            alert("상단고정 게시물은 3개까지만 가능합니다.");
            return;
        }

        $.ajax({
            url : "${pageContext.request.contextPath}/community/saveCommunity",
            type: "POST",
            data : $("#communityForm").serialize(),
            success : function(result){
               if(result.commSeq != null && result.commSeq != 0 ){
                   if($("#communityForm").find("input[name='commSeq']").val() == ""){
                        alert("등록되었습니다.");
                   } else {
                        alert("저장되었습니다.");
                   }
                   location.href = "${pageContext.request.contextPath}/community/detail/" + result.commSeq;
               } else {
                    if($("#communityForm").find("input[name='commSeq']").val() == ""){
                        alert("등록에 실패했습니다.");
                    } else {
                        alert("저장에 실패했습니다.");
                    }
               }
            }
        });
    });

    //삭제버튼 이벤트
    $("#deleteButton").on("click", function(){

        if(!confirm("삭제 하시겠습니까?")) return;

        var community = new Object();
        community.commSeq = $("#communityForm").find("input[name='commSeq']").val();

        $.ajax({
            url : "${pageContext.request.contextPath}/community/deleteCommunity",
            type: "POST",
            data : community,
            success : function(result){
               if(result >  0 ){
                   alert("삭제되었습니다.");
                   location.href = "${pageContext.request.contextPath}/community/list";
               } else {
                   alert("삭제에 실패했습니다.");
               }
            }
        });
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
                        <c:if test="${community.commSeq != null && community.commSeq != 0}">
                            <button type="button" id="deleteButton" class="btn btn-default btn-delete">삭제</button>
                        </c:if>
                        <button type="button" id="cancelButton" class="btn btn-default">목록</button>
                        <button type="button" id="saveButton" class="btn btn-primary">저장</button>
                    </div>
                </div>
            </div>
            <form id="communityForm">
                <input type="hidden" name="commSeq" value="${community.commSeq}">
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
                                    </th>
                                    <td>
                                        <span class="radio-inline">
                                            <label>
                                                <input type="radio" name="type" value="공지" <c:if test="${community.type eq '공지' || community.type == null}">checked="checked"</c:if>> 공지
                                            </label>
                                        </span>
                                        <span class="radio-inline">
                                            <label>
                                                <input type="radio" name="type" value="뉴스" <c:if test="${community.type eq '뉴스'}">checked="checked"</c:if>> 뉴스
                                            </label>
                                        </span>
                                        <span class="radio-inline">
                                            <label>
                                                <input type="radio" name="type" value="후기" <c:if test="${community.type eq '후기'}">checked="checked"</c:if>> 후기
                                            </label>
                                        </span>
                                        <span class="radio-inline">
                                            <label>
                                                <input type="radio" name="type" value="정보" <c:if test="${community.type eq '정보'}">checked="checked"</c:if>> 정보
                                            </label>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        제목<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <input type="text" name="title" class="form-control" onkeyup="limitByteStr(this)" limitByte="90" placeholder="제목을 입력하세요" value="${community.title}">
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        상세<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <textarea cols="100" rows="20" name="ctnt" id="editor1" class="form-control" placeholder="상세 내용을 입력하세요" >${community.ctnt}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        이미지<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <input type="hidden" name="orgImgSeq" <c:if test="${community.file != null}">value="${community.file.fileSeq}"</c:if>>
                                        <input type="hidden" name="imgSeq" <c:if test="${community.file != null}">value="${community.file.fileSeq}"</c:if>>
                                        <div id="upload" class="dropzone">
                                            <c:if test="${community.file != null}">
                                                <div name="preview" class="dz-preview dz-processing dz-image-preview dz-success dz-complete">
                                                    <div class="dz-image">
                                                        <img data-dz-thumbnail src="${pageContext.request.scheme}://${community.fileUrlPath}${community.file.filePath}${community.file.fileNm}" style="width: 100%; height: 100%;">
                                                    </div>
                                                    <div class="dz-details">
                                                        <div class="dz-size">
                                                            <span>
                                                                <strong>${community.file.fileSize}</strong> byte
                                                            </span>
                                                        </div>
                                                        <div class="dz-filename">
                                                            <span class="dz-upload" data-dz-uploadprogress style="width: 100%;">${community.file.oriFileNm}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                        <p class="help-block">이미지 형식 : PNG, JPG, JPGE / 권장 사이즈 : 480*270</p>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        노출 여부<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <span class="onoffswitch">
                                            <input type="checkbox" class="onoffswitch-checkbox" data-id="4033" name="expsYn" id="isVisibled-4033" value="Y" <c:if test="${community.expsYn == null || community.expsYn eq 'Y'}"> checked="checked" </c:if>>
                                            <label class="onoffswitch-label" for="isVisibled-4033">
                                                <i class="inner"></i><i class="switch"></i>
                                            </label>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        노출 기간
                                    </th>
                                    <td>
                                        <span class="checkbox">
                                            <label>
                                                <input type="checkbox" name="useDate" onchange="valueChanged(this)" <c:if test="${community.endDate != '' && community.endDate != null}">checked="checked"</c:if>> 사용
                                            </label>
                                        </span>
                                        <div class="wrap-calendar reservation-calendar form-inline ">
                                            <div class="input-group">
                                                <div class="input-icon">
                                                    <i class="fa fa-calendar"></i>
                                                    <input type="text" class="form-control datetimepicker" name="strDate" placeholder="from" value="${community.strDate}" <c:if test="${community.endDate == '' || community.endDate == null}">disabled="disabled"</c:if> >
                                                </div>
                                                <span class="input-group-addon">~</span>
                                                <div class="input-icon">
                                                    <i class="fa fa-calendar"></i>
                                                    <input type="text" class="form-control datetimepicker" name="endDate" placeholder="to" value="${community.endDate}" <c:if test="${community.endDate == '' || community.endDate == null}">disabled="disabled"</c:if> >
                                                </div>
                                            </div>
                                        </div>
                                        <p class="help-block">노출기간 미설정 시, 상시 노출됩니다.</p>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        상단 고정<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <span class="onoffswitch">
                                            <input type="checkbox" class="onoffswitch-checkbox" data-id="4033" name="fixYn" id="isVisibled-4034" value="Y" <c:if test="${community.fixYn eq 'Y'}"> checked="checked" </c:if>>
                                            <label class="onoffswitch-label" for="isVisibled-4034">
                                                <i class="inner"></i><i class="switch"></i>
                                            </label>
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
    Dropzone.autoDiscover = false;

    function valueChanged(obj) {
        if($(obj).is(":checked"))
            $(".reservation-calendar input").prop("disabled",false);
        else
            $(".reservation-calendar input").prop("disabled",true);
    }

    (function() {
        var fileUpload = new Dropzone("#upload", {
            paramName: "file",
            url: "${pageContext.request.contextPath}/file/upload/dropzone?_csrf=${_csrf.token}",
            params: {'type': 'COMMUNITY'},
            dictDefaultMessage: "업로드 할 파일을 선택하거나 드래그 앤 드롭 하세요.",
            acceptedFiles: "image/jpeg,image/png,image/jpg",
            uploadMultiple: false,
            addRemoveLinks: true,
            maxFiles: 1,
            autoProcessQueue: true
        });
        fileUpload.on('success', function(file, response){
            $("div[name='preview']").hide();
            $("input[name='imgSeq']").val(response.fileSeq);
        });
        fileUpload.on('error', function(file, response) {
            if (response == 'You can not upload any more files.') {
                alert('기존 파일을 삭제한뒤 등록해주세요.');
            } else {
                alert('Error while uploading file!');
            }
            fileUpload.removeFile(file);
        });
        fileUpload.on("removedfile", function(file){
            /*
            if(file.status=="success"){
                var seq=$("input[name='orgImgSeq']").val();
                $("input[name='imgSeq']").val(seq);
                $("div[name='preview']").show();
            }
            */
            var _potoCnt = $('#upload').find('.dz-preview').length;
            if (_potoCnt == 1) {
                var _oriImgSeq = $("input[name='orgImgSeq']").val();
                $("input[name='imgSeq']").val(_oriImgSeq);
                $("div[name='preview']").show();
            }
        });

        $('.datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD'
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

    filebrowserUploadUrl: "${pageContext.request.contextPath}/file/upload/CKEditor?_csrf=${_csrf.token}&type=COMMUNITY",

    extraAllowedContent: ['div(*)']

} );
</script>