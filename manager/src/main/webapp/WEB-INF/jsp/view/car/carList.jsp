<%--
  차량관리/목록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    $(function(){

        //등록버튼 이벤트
        $(document).on("click","#carRegiste",function(){
            location.href = "${pageContext.request.contextPath}/car/registe";
        });

        //편집버튼 이벤트
        $(document).on("click","button[name='editButton']",function(){
            var tr = $(this).closest("tr");
            $(tr).find("div[name='textDisplay']").hide();
            $(tr).find("input").show();
            $(tr).find("span").show();
            $(tr).find("div[name='checkboxDisplay']").show();
            $(tr).find("button[name='editButton']").hide();
            $(tr).find("button[name='editCancelButton']").show();
            $(tr).find("button[name='editUpdateButton']").show();
        });

        //편집취소버튼 이벤트
        $(document).on("click","button[name='editCancelButton']",function(){
            var tr = $(this).closest("tr");
            $(tr).find("div[name='textDisplay']").show();
            $(tr).find("input").hide();
            $(tr).find("span").hide();
            $(tr).find("div[name='checkboxDisplay']").hide();
            $(tr).find("button[name='editButton']").show();
            $(tr).find("button[name='editCancelButton']").hide();
            $(tr).find("button[name='editUpdateButton']").hide();
        });

        //편집적용버튼 이벤트
        $(document).on("click","button[name='editUpdateButton']",function(){
            var tr = $(this).closest("tr");
            var carMng = new Object();
            carMng.carSeq = $(tr).find("input[name='carSeq']").val();
            carMng.model = $(tr).find("input[name='model']").val();
            carMng.detailModel = $(tr).find("input[name='detailModel']").val();
            carMng.sellStrYear = $(tr).find("select[name='sellStrYear']").val();
            carMng.sellEndYear = $(tr).find("select[name='sellEndYear']").val();
            carMng.fuel = $(tr).find("select[name='fuel']").val();
            carMng.disp = $(tr).find("select[name='disp']").val();
            carMng.rating = $(tr).find("input[name='rating']").val();
            carMng.detailRating = $(tr).find("input[name='detailRating']").val();
            carMng.ratingStrYear = $(tr).find("select[name='ratingStrYear']").val();
            carMng.ratingEndYear = $(tr).find("select[name='ratingEndYear']").val();
            carMng.useYn = $(tr).find("input[name='useYn']").prop("checked") ? "Y" : "N";

            $.ajax({
                    url : "${pageContext.request.contextPath}/car/update",
                    type: "POST",
                    data : carMng,
                    success : function(result){
                        if(result == 1 ){
                            location.reload();
                        } else {
                            alert("수정에 실패했습니다.");
                        }
                    }
                });
        });

    });

    //검색 이벤트
    function carSearch(){
        $.ajax({
           url : "${pageContext.request.contextPath}/car/list",
           type: "POST",
           data : $("#searchForm").serialize(),
           dataType : "html",
           success : function(data){
              $("#searchTable").html($(data).find('#searchTable').html());
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
                        <span class="page-title"> 차량 관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <button type="button" class="btn btn-primary" id="carRegiste">등록</button>
                    </div>
                </div>
            </div>
            <div class="contents">
                <div class="card">
                    <div class="tools">
                        <div class="row">
                            <form id="searchForm" action="${pageContext.request.contextPath}/car/list" method="POST">
                                <div class="col-xs-4">
                                    <div class="form-inline">
                                        <span class="select">
                                            <select name="searchMak" disabled="disabled" class="form-control">
                                                <option value="폭스바겐">폭스바겐</option>
                                            </select>
                                        </span>
                                        <span class="select">
                                            <select name="searchModel" onchange="carSearch()" class="form-control">
                                                <option value="">모델 전체</option>
                                                <c:forEach var="carModel" items="${carModelList}">
                                                    <option value="${carModel.model}"
                                                        <c:if test="${searchParam.searchModel == carModel.model}">
                                                            selected="selected"
                                                        </c:if>
                                                    >${carModel.model}</option>
                                                </c:forEach>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-xs-8 text-right">
                                    <div class="form-inline">
                                        <div class="input-group ">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                            <input type="text" name="searchText" class="form-control" placeholder="검색어 입력" value="${searchParam.searchText}" onkeypress="if(event.keyCode==13) {carSearch(); return false;}">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default btn-search" type="button" id="search" onclick="carSearch()"><i class="fa fa-search" aria-hidden="true"></i></button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <table id="searchTable" class="table table-hover table-bordered table-vertical ">
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
                            <col style="width: 100px">
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
                                <th>사용 여부</th>
                                <th>기능</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="carMng" items="${carMngList}">
                                <tr>
                                    <td>
                                        ${carMng.mak}
                                        <input type="hidden" name="carSeq" value="${carMng.carSeq}">
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.model}</div>
                                        <input type="text" name="model" value="${carMng.model}" class="form-control" style="display : none;">
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.detailModel}</div>
                                        <input type="text" name="detailModel" value="${carMng.detailModel}" class="form-control" style="display : none;">
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.sellStrYear}</div>
                                        <span class="select" style="display : none;">
                                            <select name="sellStrYear" class="form-control">
                                                <c:forEach var="i" begin="0" end="${2018-1990}">
                                                    <c:set var="yearOption" value="${2018-i}"/>
                                                    <%-- 값이 '-'일때 yearOption과의 비교는 숫자-문자 비교로 오류, 때문에 if로 한번 더 감싸줌 --%>
                                                    <option value="${yearOption}" <c:if test="${carMng.sellStrYear ne '현재년도'}"><c:if test="${carMng.sellStrYear eq yearOption}">selected="selected"</c:if></c:if>>${yearOption}</option>
                                                </c:forEach>
                                            </select>
                                        </span>
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.sellEndYear}</div>
                                        <span class="select" style="display : none;">
                                            <select name="sellEndYear" class="form-control">
                                                <c:forEach var="i" begin="0" end="${2018-1990}">
                                                    <c:set var="yearOption" value="${2018-i}"/>
                                                    <option value="${yearOption}" <c:if test="${carMng.sellEndYear ne '현재년도'}"><c:if test="${carMng.sellEndYear eq yearOption}">selected="selected"</c:if></c:if>>${yearOption}</option>
                                                </c:forEach>
                                            </select>
                                        </span>
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.fuel}</div>
                                        <span class="select" style="display : none;">
                                            <select name="fuel" class="form-control">
                                                <option value="가솔린" <c:if test="${carMng.fuel == '가솔린'}">selected="selected"</c:if>>가솔린</option>
                                                <option value="디젤"  <c:if test="${carMng.fuel == '디젤'}">selected="selected"</c:if>>디젤</option>
                                                <option value="LPG"  <c:if test="${carMng.fuel == 'LPG'}">selected="selected"</c:if>>LPG</option>
                                                <option value="전기"  <c:if test="${carMng.fuel == '전기'}">selected="selected"</c:if>>전기</option>
                                            </select>
                                        </span>
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.disp}</div>
                                        <span class="select" style="display : none;">
                                            <select name="disp" class="form-control">
                                                <option value="2000cc 이상" <c:if test="${carMng.disp == '2000cc 이상'}">selected="selected"</c:if>>2000cc이상</option>
                                                <option value="2000cc" <c:if test="${carMng.disp == '2000cc'}">selected="selected"</c:if>>2000cc</option>
                                                <option value="2000cc 이하" <c:if test="${carMng.disp == '2000cc 이하'}">selected="selected"</c:if>>2000cc이하</option>
                                            </select>
                                        </span>
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.rating}</div>
                                        <input type="text" name="rating" class="form-control" value="${carMng.rating}" style="display : none;">
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.detailRating}</div>
                                        <input type="text" name="detailRating" class="form-control" value="${carMng.detailRating}" style="display : none;">
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.ratingStrYear}</div>
                                        <span class="select" style="display : none;">
                                            <select name="ratingStrYear" class="form-control">
                                                <c:forEach var="i" begin="0" end="${2018-1990}">
                                                    <c:set var="yearOption" value="${2018-i}"/>
                                                    <option value="${yearOption}" <c:if test="${carMng.ratingStrYear ne '현재년도'}"><c:if test="${carMng.ratingStrYear eq yearOption}">selected="selected"</c:if></c:if>>${yearOption}</option>
                                                </c:forEach>
                                            </select>
                                        </span>
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.ratingEndYear}</div>
                                        <span class="select" style="display : none;">
                                            <select name="ratingEndYear" class="form-control">
                                                <c:forEach var="i" begin="0" end="${2018-1990}">
                                                    <c:set var="yearOption" value="${2018-i}"/>
                                                    <option value="${yearOption}" <c:if test="${carMng.ratingEndYear ne '현재년도'}"><c:if test="${carMng.ratingEndYear eq yearOption}">selected="selected"</c:if></c:if>>${yearOption}</option>
                                                </c:forEach>
                                            </select>
                                        </span>
                                    </td>
                                    <td>
                                        <div name="textDisplay">${carMng.useYn == 'Y' ? 'ON' : 'OFF'}</div>
                                        <div name="checkboxDisplay" class="onoffswitch"  style="display : none;">
                                            <input type="checkbox" class="onoffswitch-checkbox" data-id="${carMng.carSeq}" name="useYn" id="isVisibled-${carMng.carSeq}" <c:if test="${carMng.useYn == 'Y'}"> checked="checked" </c:if>>
                                            <label class="onoffswitch-label" for="isVisibled-${carMng.carSeq}">
                                                <i class="inner"></i><i class="switch"></i>
                                            </label>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="btns">
                                            <button type="button" name="editButton" class="btn btn-xs btn-default ">편집</button>
                                            <button type="button" name="editCancelButton" class="btn btn-xs btn-default " style="display: none;">취소</button>
                                            <button type="button" name="editUpdateButton" class="btn btn-xs btn-primary " style="display: none;">저장</button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>