<%--
  차량관리/등록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    $(function(){
        //파일 선택 시 이벤트
        $("input[name='registeFile']").on("change", function(){
            var registeFile = $("input[name='registeFile']").val();
            $("input[name='hiddenFile']").val(registeFile);
            if(registeFile == ""){
                $("#registeButton").attr("disabled", true);
            } else {
                $("#registeButton").attr("disabled", false);
            }
        });

        //전송버튼 클릭 시 이벤트
        $("#registeButton").on("click", function(){

            var form = new FormData($("#registeForm")[0]);
            //전송버튼 비활성화
            $("#registeButton").attr("disabled", true);
            $.ajax({
                url: "${pageContext.request.contextPath}/car/readExcel",
                type: 'POST',
                data: form,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: function (response) {
                    if(response == null && response.length == 0){
                        alert("업로드에 실패했습니다.");
                        $("#registeButton").attr("disabled", false);
                    }
                    $("#registeBody").empty();
                    for(var i=0 ; i < response.length ; i++){
                        var html = "";
                        var carMng = response[i];
                        html += "<tr>";
                        html += "<td>" + carMng.mak + "</td>";
                        html += "<td>" + carMng.model + "</td>";
                        html += "<td>" + carMng.detailModel + "</td>";
                        html += "<td>" + carMng.sellStrYear + "</td>";
                        html += "<td>" + carMng.sellEndYear + "</td>";
                        html += "<td>" + carMng.fuel + "</td>";
                        html += "<td>" + carMng.disp + "</td>";
                        html += "<td>" + carMng.rating + "</td>";
                        html += "<td>" + carMng.detailRating + "</td>";
                        html += "<td>" + carMng.ratingStrYear + "</td>";
                        html += "<td>" + carMng.ratingEndYear + "</td>";
                        html += "</tr>";
                        $("#registeBody").append(html);
                    }
                    $("#registe").attr("disabled", false);
                }
            });

        });

        //등록버튼 클릭 시 이벤트
        $("#registe").on("click", function(){
            var form = new FormData($("#registeForm")[0]);
            $.ajax({
                url: "${pageContext.request.contextPath}/car/registe",
                type: 'POST',
                data: form,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: function (response) {
                    if(response == null && response.length == 0){
                        alert("업로드에 실패했습니다.");
                    }
                    location.href="${pageContext.request.contextPath}/car/list";

                }
            });
        });

        //취소버튼 클릭 시 이벤트
        $("#cancel").on("click", function(){
            location.href = "${pageContext.request.contextPath}/car/list";
        });
    });
</script>
<div id="body">
    <div id="container" class="container">
        <div class="wrap-contents">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> 차량 관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <button type="button" id="cancel" class="btn btn-default">취소</button>
                        <button type="button" id="registe" disabled="disabled" class="btn btn-primary">등록</button>
                    </div>
                </div>
            </div>
            <div class="contents">
                <div class="card">
                    <form id="registeForm" method="POST" action="/manager/carMngRegiste" enctype="multipart/form-data">
                        <table class="table table-bordered table-horizontal">
                            <colgroup>
                                <col style="width: 150px;">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>
                                        차량 등록<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <input type="file" name="registeFile" accept="*" class="form-control">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                    <div class="btns text-right">
                        <button type="button" id="registeButton" disabled="disabled" class="btn btn-primary">전송</button> <!-- disabled -->
                    </div>
                    <table class="table table-hover table-bordered table-vertical ">
                        <colgroup>
                            <col style="width: 70px;">
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <thead>
                            <tr>
                                <th>제조사</th>
                                <th>모델</th>
                                <th>세부 모델</th>
                                <th>모델 판매 <br>시작 연도</th>
                                <th>모델 판매 <br>종료 연도</th>
                                <th>연료</th>
                                <th>배기량</th>
                                <th>등급</th>
                                <th>세부 등급</th>
                                <th>등급 <br>시작 연도</th>
                                <th>등급 <br>종료 연도</th>
                            </tr>
                        </thead>
                        <tbody id="registeBody">
                            <tr>
                                <td colspan="12">차량이 없습니다.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>