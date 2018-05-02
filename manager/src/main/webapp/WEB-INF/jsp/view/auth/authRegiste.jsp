<%--
  권한관리/관리자 등록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    $(function(){
        //최소버튼 이벤트
        $("#cancelButton").on("click", function(){
            location.href = "${pageContext.request.contextPath}/auth/list";
        });

        //구분 선택 이벤트
        $("input[name='authType']").on("change", function(){
            var value = $(this).val()
            if(value == "VW"){
                $("#exhibTable").hide();
                $("select[name='exhHallSeq']").attr("disabled", true);
            } else {
                $("#exhibTable").show();
                $("select[name='exhHallSeq']").attr("disabled", false);
            }
        });

        //구분의 전시장 선택시 이벤트
        $("select[name='exhHallSeq']").on("change", function(){
            var value = $(this).val();
            $("#isVisibled-" + value).prop("checked", true);
        });

        //저장버튼 이벤트
        $("#registeButton").on("click", function(){

            var authority = new Object();
            authority.authType = $("input[name='authType']:checked").val();
            authority.useYn = $("input[name='useYn']").prop("checked") ? "Y" : "N";
            authority.memo = $("input[name='memo']").val();

            var exhibUseYn = new Array;
            var exhHallSeq = new Array;
            var auth = new Array;
            $("input[name='exhibUseYn']:checked").each(function() {
                var tr = $(this).closest("tr");
                exhibUseYn.push($(this).val());
                exhHallSeq.push($(tr).find("input[name='exhHallSeq']").val());
                auth.push($(tr).find("input[type='radio']:checked").val());
            });
            authority.exhibUseYn = exhibUseYn;
            authority.exhHallSeq = exhHallSeq;
            authority.auth = auth;

            authority.defaultExhHallSeq = $("select[name='exhHallSeq']").val();

            if(authority.defaultExhHallSeq == '') {
                alert('디폴트 전시장을 선택해주세요.');
                return;
            }

            $.ajax({
               url : "${pageContext.request.contextPath}/auth/registe",
               type: "POST",
               data : authority,
               success : function(result){
                   if(result.admSeq != null && result.admSeq != 0 ){
                        alert("등록에 성공했습니다.");
                        location.href = "${pageContext.request.contextPath}/auth/detail/" + result.admSeq;
                   } else {
                        alert("등록에 실패했습니다.");
                   }
               }
            });
        });
    });
</script>

<div id="body">

    <div id="container" class="container">
        <div class="wrap-contents">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> 관리자 관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <button type="button" id="cancelButton" class="btn btn-default">목록</button>
                        <button type="button" id="registeButton" class="btn btn-primary">저장</button>
                    </div>
                </div>
            </div>
            <form id="registeForm">
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
                                        <div class="form-inline">
                                            <span class="radio-inline">
                                                <label>
                                                    <input type="radio" name="authType" value="VW" <c:if test="${authType ne 'VW'}">disabled="disabled"</c:if>> VW
                                                </label>
                                            </span>
                                            <span class="radio-inline">
                                                <label>
                                                    <input type="radio" name="authType" value="Branch" checked="checked"> Branch
                                                </label>
                                            </span>
                                            <span class="select">
                                                <select name="exhHallSeq" class="form-control">
                                                    <option value="">전시장 선택</option>
                                                    <c:forEach var="branch" items="${branchList}">
                                                        <option value="${branch.exhHallSeq}">${branch.storeNm}</option>
                                                    </c:forEach>
                                                </select>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>ID</th>
                                    <td>ID는 등록 후, 자동 발급됩니다.</td>
                                </tr>
                                <tr>
                                    <th>
                                        사용 여부<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <span class="onoffswitch">
                                            <input type="checkbox" class="onoffswitch-checkbox" data-id="4033" name="useYn" id="isVisibled-4033" value="Y">
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
                                        <input type="text" name="memo" onkeyup="limitByteStr(this)" limitByte="50" class="form-control">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table id="exhibTable" class="table table-vertical table-bordered">
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
                                <c:forEach var="branch" items="${branchList}">
                                    <tr>
                                        <input type="hidden" name="exhHallSeq" value="${branch.exhHallSeq}">
                                        <td>${branch.type}</td>
                                        <td>${branch.storeNm}</td>
                                        <td>
                                            <span class="radio-inline">
                                                <label>
                                                    <input type="radio" name="auth${branch.exhHallSeq}" value="ADMIN"> ADMIN
                                                </label>
                                            </span>
                                            <span class="radio-inline">
                                                <label>
                                                    <input type="radio" name="auth${branch.exhHallSeq}"  value="OPERATOR" checked="checked"> OPERATOR
                                                </label>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="onoffswitch">
                                                <input type="checkbox" class="onoffswitch-checkbox" data-id="${branch.exhHallSeq}" name="exhibUseYn" id="isVisibled-${branch.exhHallSeq}" value="Y">
                                                <label class="onoffswitch-label" for="isVisibled-${branch.exhHallSeq}">
                                                    <i class="inner"></i><i class="switch"></i>
                                                </label>
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>