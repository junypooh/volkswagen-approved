<%--
    기간/주기 설정
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="container" class="container">
    <div class="wrap-contents">
        <div class="page-control">
            <div class="row">
                <div class="col-xs-6">
                    <span class="page-title"> 기간/주기 설정 </span>
                </div>
            </div>
        </div>
        <div class="contents">
            <div class="card">
                <table id="tt" class="table table-hover table-bordered table-vertical main-options">
                    <colgroup>
                        <col style="width: 250px;">
                        <col>
                        <col style="width: 160px;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>구분</th>
                            <th>기간/주기 설정</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>  매물 New 아이콘 노출 주기</td>
                            <td class="text-left form-inline" name="dataTd">
                                ${list[1].opt} 시간
                            </td>
                            <td class="text-left form-inline" name="inputTd" style="display : none;">
                                <input type="hidden" name="cd" value="F1002">
                                <input type="text" name="optTime" class="form-control" value="${list[1].opt}" onkeyup="limitByteStr(this)" limitByte="5"> 시간
                            </td>
                            <td>
                                <button name="editButton"  type="button" class="btn btn-xs btn-default">편집</button>
                                <button name="editUpdateButton" type="button" style="display : none;" class="btn btn-xs btn-primary">저장</button>
                                <button name="editCancelButton" type="button" style="display : none;" class="btn btn-xs btn-default">취소</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                판매 완료/종료 매물 노출 기간
                            </td>
                            <td class="text-left form-inline" name="dataTd">
                                ${list[0].opt} 시간
                            </td>
                            <td class="text-left form-inline" name="inputTd" style="display : none;">
                                <input type="hidden" name="cd" value="F1001">
                                <input type="text" name="optTime" class="form-control" value="${list[0].opt}" onkeyup="limitByteStr(this)" limitByte="5"> 시간
                            </td>
                            <td>
                                <button name="editButton" type="button" class="btn btn-xs btn-default">편집</button>
                                <button name="editUpdateButton" type="button" style="display : none;" class="btn btn-xs btn-primary">저장</button>
                                <button name="editCancelButton" type="button" style="display : none;" class="btn btn-xs btn-default" >취소</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

//편집버튼 이벤트
$(document).on("click","button[name='editButton']",function(){
    var tr = $(this).closest("tr");
    $(tr).find("td[name='inputTd']").show();
    $(tr).find("td[name='dataTd']").hide();
    $(tr).find("button[name='editButton']").hide();
    $(tr).find("button[name='editCancelButton']").show();
    $(tr).find("button[name='editUpdateButton']").show();
});

//편집취소버튼 이벤트
$(document).on("click","button[name='editCancelButton']",function(){
    var tr = $(this).closest("tr");
    $(tr).find("td[name='inputTd']").hide();
    $(tr).find("td[name='dataTd']").show();
    $(tr).find("button[name='editButton']").show();
    $(tr).find("button[name='editCancelButton']").hide();
    $(tr).find("button[name='editUpdateButton']").hide();

});

//숫자입력 정규식 표현
$("input[name='optTime']").on("keyup", function(){
    $(this).val($(this).val().replace(/[^0-9]/g,""));
});

//편집적용버튼 이벤트
$(document).on("click","button[name='editUpdateButton']",function(){
    var tr = $(this).closest("tr");
    var exposeMng = new Object();
    exposeMng.opt = $(tr).find("input[name='optTime']").val();
    exposeMng.cd = $(tr).find("input[name='cd']").val();

    if(exposeMng.opt == "" || exposeMng.opt == null){
        alert("미입력 항목이 있습니다.");
        return;
    }

    $.ajax({
         url : "${pageContext.request.contextPath }/expose/updateExposeMng",
        type: "POST",
        data : exposeMng,
        success : function(result){
            if(result == 1 ){
                alert("저장되었습니다.");
                location.reload();
            } else {
                alert("수정에 실패했습니다.");
                return;
            }
        }
    });

/*
    $(tr).find("button[name='editCancelButton']").hide();
    $(tr).find("button[name='editUpdateButton']").hide();
    $(tr).find("button[name='editButton']").show();
    $(tr).find("td[name='optTime']").hide();
    $(tr).find("td[name='testDiv']").show();
*/
});

</script>

