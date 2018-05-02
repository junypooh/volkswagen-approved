<%--
    자주하는질문관리/등록, 수정
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(function(){

    //취소버튼 이벤트
    $("#cancelButton").on("click", function(){
        location.href = "${pageContext.request.contextPath}/faq/list";
    });

    //저장버튼 이벤트
    $("#saveButton").on("click", function(){

        //미입력항목 체크
        if(!inputCheck($("input[name='title']"))) return;

        if(CKEDITOR.instances.editor1.getData()=="" || CKEDITOR.instances.editor1.getData()==null){
           alert("미입력 항목이 있습니다.");
           return;
        }

        //ckeditor 데이터 저장
        $("textarea[name='ctnt']").val(CKEDITOR.instances.editor1.getData());

        if($("input[name='fixYn']").is(":checked") && Number("${faqFixYCount}") > 9){
            alert("상단고정 게시물은 10개까지만 가능합니다.");
            return;
        }

        $.ajax({
            url : "${pageContext.request.contextPath}/faq/saveFaq",
            type: "POST",
            data : $("#faqForm").serialize(),
            success : function(result){
               if(result.faqSeq != null && result.faqSeq != 0 ){
                   if($("#faqForm").find("input[name='faqSeq']").val() == ""){
                        alert("등록되었습니다.");
                   } else {
                        alert("저장되었습니다.");
                   }
                   location.href = "${pageContext.request.contextPath}/faq/detail/" + result.faqSeq;
               } else {
                    if($("#faqForm").find("input[name='faqSeq']").val() == ""){
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

        var faq = new Object();
        faq.faqSeq = $("#faqForm").find("input[name='faqSeq']").val();

        $.ajax({
            url : "${pageContext.request.contextPath}/faq/deleteFaq",
            type: "POST",
            data : faq,
            success : function(result){
               if(result >  0 ){
                   alert("삭제되었습니다.");
                   location.href = "${pageContext.request.contextPath}/faq/list";
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
                        <span class="page-title"> 자주하는 질문 관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <c:if test="${faq.faqSeq != null && faq.faqSeq != 0}">
                            <button type="button" id="deleteButton" class="btn btn-default btn-delete">삭제</button>
                        </c:if>
                        <button type="button" id="cancelButton" class="btn btn-default">목록</button>
                        <button type="button" id="saveButton" class="btn btn-primary">저장</button>
                    </div>
                </div>
            </div>
            <form id="faqForm">
                <input type="hidden" name="faqSeq" value="${faq.faqSeq}">
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
                                        유형선택<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <span class="select">
                                            <select name="categoryCd" class="form-control">
                                                <option value="A1001" <c:if test="${faq.categoryCd eq 'A1001'}">selected="selected"</c:if>>문의관련</option>
                                                <option value="A1002" <c:if test="${faq.categoryCd eq 'A1002'}">selected="selected"</c:if>>사이트이용</option>
                                                <option value="A1003" <c:if test="${faq.categoryCd eq 'A1003'}">selected="selected"</c:if>>구매가이드</option>
                                            </select>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        제목<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <input type="text" name="title" onkeyup="limitByteStr(this)" value="${faq.title}" limitByte="50" class="form-control" placeholder="제목을 입력하세요" >
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        내용<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <textarea name="ctnt" id="editor1" cols="100" rows="20" class="form-control" placeholder="상세 내용을 입력하세요"  >${faq.ctnt}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        노출 여부<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <span class="onoffswitch">
                                            <input type="checkbox" name="expsYn" value="Y" class="onoffswitch-checkbox" data-id="01" name="isVisibled" id="isVisibled-01" <c:if test="${faq.expsYn == null || faq.expsYn eq 'Y'}"> checked="checked" </c:if>>
                                            <label class="onoffswitch-label" for="isVisibled-01">
                                                <i class="inner"></i><i class="switch"></i>
                                            </label>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        상단 고정<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <span class="onoffswitch">
                                            <input type="checkbox" name="fixYn" value="Y" class="onoffswitch-checkbox" data-id="02" name="isVisibled" id="isVisibled-02" <c:if test="${faq.fixYn == null || faq.fixYn eq 'Y'}"> checked="checked" </c:if>>
                                            <label class="onoffswitch-label" for="isVisibled-02">
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
        $('.datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: "kr"
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

    filebrowserUploadUrl: "${pageContext.request.contextPath}/file/upload/CKEditor?_csrf=${_csrf.token}&type=FAQ",

} );
</script>
