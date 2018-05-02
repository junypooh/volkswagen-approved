<%--
    전시장관리/등록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=${result.clientId}&submodules=geocoder"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){

    //취소버튼 이벤트
    $("#cancelButton").on("click", function(){
        location.href = "${pageContext.request.contextPath}/branch/list";
    });

    //전화번호 입력 이벤트트
   $("input[name='tel1'], input[name='tel2'], input[name='tel3']").on("keyup", function(){
        $(this).val($(this).val().replace(/[^0-9]/g,""));
        if($(this).val().length > 4) {
            $(this).val($(this).val().substring(0, 4));
        }
        //4자리 채우고 난뒤 포커스 이동
        if($(this).val().length == 4){
            if($(this).attr("name") == "tel1"){
                $("input[name='tel2']").focus();
            } else if($(this).attr("name") == "tel2"){
               $("input[name='tel3']").focus();
           }
        }
    });

    $(document).on("keyup","input[name='email'], input[name='etcEmail']",function(){
        $(this).val($(this).val().replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g,""));
    });

    //이메일 추가 버튼
    $("#emailAddButton").on("click", function(){
        var html = "<div class='input-group'>";
        html += "<input type='text' name='etcEmail' class='form-control' placeholder='이메일 주소를 입력하세요.'>";
        html += "<span class='input-group-btn'>";
        html += "<button type='button' name='emailDelButton' class='btn btn-delete'>삭제</button>";
        html += "</span>";
        html += "</div>";
        $("#emailTd").append(html);
    });

    //이메일 삭제버튼 이벤트
    $(document).on("click","button[name='emailDelButton']",function(){
        $(this).parent().parent().remove();
    });

    //IP 추가 버튼
    $("#ipAddButton").on("click", function(){
        var html = "<div class='input-group'>";
        html += "   <input type='text' name='ipAddresses' class='form-control' placeholder='접근 IP를 입력하세요.'>";
        html += "   <span class='input-group-btn'>";
        html += "       <button type='button' class='btn btn-delete' id='ipDelButton' >삭제</button>";
        html += "   </span>";
        html += "</div>";
        $("#ipDiv").append(html);
    });

    //IP 삭제버튼 이벤트
    $(document).on("click","button[id='ipDelButton']",function(){
        $(this).parent().parent().remove();
    });

    //저장버튼 이벤트
    $("#saveButton").on("click", function(){

        //미입력항목 체크
        if(!inputCheck($("input[name='storeNm']"))) return;
        if(!inputCheck($("input[name='tel1']"))) return;
        if(!inputCheck($("input[name='tel2']"))) return;
        if(!inputCheck($("input[name='tel3']"))) return;

        //번호는 최소 8자리 이상
        var tel = $("input[name='tel1']").val() + $("input[name='tel2']").val() + $("input[name='tel3']").val();
        if(tel.length < 8){
            alert("미입력 항목이 있습니다");
            $("input[name='tel1']").focus();
            return;
        }
        if(!inputCheck($("input[name='email']"))) return;

        //이메일 형식 체크
        var email = $("input[name='email']").val();
        var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
        if (!email.match(regExp)){
            alert("올바른 이메일을 입력하세요");
            $("input[name='email']").focus();
            return;
        }

        var balid = true;
        $("input[name='etcEmail']").each(function(){
            //기타이메일 미입력 체크
            if(!inputCheck($(this))){
                balid = false;
                return false;
            }
            //기타이메일 형식 체크
            email = $(this).val();
            if (!email.match(regExp)){
                alert("올바른 이메일을 입력하세요");
                $(this).focus();
                balid = false;
                return false;
            }
        });
        if(!balid) return;

        if(!inputCheck($("input[name='detailAddr']"))) return;

        //주소 좌표 구해오기
        var myaddress = $("input[name='addr']").val();
        naver.maps.Service.geocode({address: myaddress}, function(status, response) {
            if (status !== naver.maps.Service.Status.OK) {
                $("input[name='xcoordinate']").val("");
                $("input[name='ycoordinate']").val("");
            }
          var result = response.result;
          $("input[name='xcoordinate']").val(result.items[0].point.x);
          $("input[name='ycoordinate']").val(result.items[0].point.y);

            $.ajax({
                url : "${pageContext.request.contextPath}/branch/saveBranch",
                type: "POST",
                data : $("#branchForm").serialize(),
                success : function(result){
                   if(result.exhHallSeq != null && result.exhHallSeq != 0 ){
                       alert("등록되었습니다.");
                       location.href = "${pageContext.request.contextPath}/branch/detail/" + result.exhHallSeq;
                   } else {
                       alert("등록에 실패했습니다.");
                   }
                }
            });
        });

    });

    //삭제버튼 이벤트
    $("#deleteButton").on("click", function(){

        if(!confirm("삭제 하시겠습니까?")) return;

        var branch = new Object();
        branch.exhHallSeq = $("input[name='exhHallSeq']").val();

        $.ajax({
            url : "${pageContext.request.contextPath}/branch/deleteBranch",
            type: "POST",
            data : branch,
            success : function(result){
               if(result >  0 ){
                   alert("삭제되었습니다.");
                   location.href = "${pageContext.request.contextPath}/branch/list";
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

//주소검색 api 팝업 호출
function findAddr(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 주소 정보를 해당 필드에 넣는다.
            $("input[name='addr']").val(data.roadAddress);
            $("input[name='detailAddr']").val(data.roadAddress);
            $("input[name='sigun']").val(data.sido);
        }
    }).open();
}

</script>

<div id="body">
    <div id="container" class="container">
        <div class="wrap-contents">
            <div class="page-control">
                <div class="row">
                    <div class="col-xs-6">
                        <span class="page-title"> 전시장 관리 </span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <c:if test="${result.branch.exhHallSeq != null && result.branch.exhHallSeq != 0}">
                            <button type="button" id="deleteButton" class="btn btn-default btn-delete">삭제</button>
                        </c:if>
                        <button type="button" id="cancelButton" class="btn btn-default">목록</button>
                        <button type="button" id="saveButton" class="btn btn-primary">저장</button>
                    </div>
                </div>
            </div>
            <div class="contents">
                <div class="card">
                    <form id="branchForm">
                        <input type="hidden" name="exhHallSeq" value="${result.branch.exhHallSeq}">
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
                                            <label><input type="radio" name="type" value="Meister Motors" <c:if test="${result.branch.type == null || result.branch.type eq 'Meister Motors'}"> checked="checked" </c:if>> Meister Motors</label>
                                        </span>
                                        <span class="radio-inline">
                                            <label><input type="radio" name="type" value="Klasse Auto" <c:if test="${result.branch.type != null && result.branch.type eq 'Klasse Auto'}"> checked="checked" </c:if>> Klasse Auto</label>
                                        </span>
                                        <span class="radio-inline">
                                            <label><input type="radio" name="type" value="Ucaro Automobile" <c:if test="${result.branch.type != null || result.branch.type eq 'Ucaro Automobile'}"> checked="checked" </c:if>> Ucaro Automobile</label>
                                        </span>
                                        <span class="radio-inline">
                                            <label><input type="radio" name="type" value="GioHaus" <c:if test="${result.branch.type != null && result.branch.type eq 'GioHaus'}"> checked="checked" </c:if>> GioHaus</label>
                                        </span>
                                        <span class="radio-inline">
                                            <label><input type="radio" name="type" value="G&B Automobilee" <c:if test="${result.branch.type != null && result.branch.type eq 'G&B Automobilee'}"> checked="checked" </c:if>> G&B Automobilee</label>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        상호<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <input type="text" name="storeNm" onkeyup="limitByteStr(this)" limitByte="50" value="${result.branch.storeNm}" class="form-control" placeholder="상호를 입력하세요" >
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        번호<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <div class="form-inline">
                                            <input type="text" name="tel1" value="${result.branch.tel1}" class="form-control" placeholder="숫자만입력하세요">
                                            ~
                                            <input type="text" name="tel2" value="${result.branch.tel2}" class="form-control" placeholder="숫자만입력하세요">
                                            ~
                                            <input type="text" name="tel3" value="${result.branch.tel3}" class="form-control" placeholder="숫자만입력하세요">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        이메일<span class="asterisk">*</span>
                                    </th>
                                    <td id="emailTd">
                                        <c:if test="${result.branch.emailList == null || fn:length(result.branch.emailList) == 0}">
                                            <div class="input-group">
                                                <input type="text" name="email" value="${email.email}" class="form-control" placeholder="대표 이메일 주소를 입력하세요.">
                                                <span class="input-group-btn">
                                                    <button type="button" id="emailAddButton" class="btn btn-primary">추가</button>
                                                </span>
                                            </div>
                                        </c:if>
                                        <c:forEach var="email" items="${result.branch.emailList}">
                                            <c:if test="${email.reprEmailYn eq 'Y'}">
                                                <div class="input-group">
                                                    <input type="text" name="email" value="${email.email}" class="form-control" placeholder="대표 이메일 주소를 입력하세요.">
                                                    <span class="input-group-btn">
                                                        <button type="button" id="emailAddButton" class="btn btn-primary">추가</button>
                                                    </span>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <c:forEach var="email" items="${result.branch.emailList}">
                                            <c:if test="${email.reprEmailYn ne 'Y'}">
                                                <div class="input-group">
                                                    <input type="text" name="etcEmail" value="${email.email}" class="form-control" placeholder="이메일 주소를 입력하세요.">
                                                    <span class="input-group-btn">
                                                        <button type="button" name="emailDelButton" class="btn btn-delete">삭제</button>
                                                    </span>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        주소<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <div class="input-group">
                                            <input type="text" name="sigun" value="${result.branch.sigun}" class="form-control" placeholder="주소를 검색하세요" readonly="readonly">
                                        </div>
                                        <div class="input-group">
                                            <input type="hidden" name="xcoordinate" value="${result.branch.xcoordinate}">
                                            <input type="hidden" name="ycoordinate" value="${result.branch.ycoordinate}">
                                            <input type="hidden" name="addr" value="${result.branch.addr}">
                                            <input type="text" name="detailAddr" value="${result.branch.detailAddr}" class="form-control" placeholder="주소를 검색하세요">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-primary" onclick="findAddr()">주소 검색</button>
                                            </span>
                                        </div>
                                        <c:if test="${result.branch.addr != null && result.branch.addr ne ''}">
                                            <br>
                                            <div id="map" style="width:400px;height:300px;">
                                            </div>
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        접근 IP<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <div id="ipDiv">
                                        <c:choose>
                                            <c:when test="${empty result.branch.ipAddresses}">
                                                <div class="input-group">
                                                    <input type="text" name="ipAddresses" class="form-control" placeholder="접근 IP를 입력하세요.">
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-primary" id="ipAddButton">추가</button>
                                                    </span>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="ip" items="${result.branch.ipAddresses}" varStatus="status">
                                                    <div class="input-group">
                                                        <input type="text" name="ipAddresses" value="${ip}" class="form-control" placeholder="접근 IP를 입력하세요.">
                                                        <span class="input-group-btn">
                                                            <c:if test="${status.first}">
                                                                <button type="button" class="btn btn-primary" id="ipAddButton">추가</button>
                                                            </c:if>
                                                            <c:if test="${!status.first}">
                                                                <button type="button" class="btn btn-delete" id="ipDelButton">삭제</button>
                                                            </c:if>
                                                        </span>
                                                    </div>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                        </div>
                                        <p class="help-block">공인 IP를 등록해 주세요. 등록되지 않은 IP에서는 관리자페이지 접근이 제한됩니다. </p>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        노출 여부<span class="asterisk">*</span>
                                    </th>
                                    <td>
                                        <span class="onoffswitch">
                                            <input type="checkbox" class="onoffswitch-checkbox" data-id="expsYn" name="expsYn" id="expsYn" value="Y" <c:if test="${result.branch.expsYn == null || result.branch.expsYn eq 'Y'}"> checked="checked" </c:if>>
                                            <label class="onoffswitch-label" for="expsYn">
                                                <i class="inner"></i><i class="switch"></i>
                                            </label>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th rowspan="${result.branch.authExhibMapList == null || fn:length(result.branch.authExhibMapList) == 0 ? 1 : fn:length(result.branch.authExhibMapList)}">
                                        직원
                                    </th>
                                    <c:if test="${result.branch.authExhibMapList == null || fn:length(result.branch.authExhibMapList) == 0}">
                                        <td>
                                            등록된 직원이 없습니다.
                                        </td>
                                    </c:if>
                                    <c:if test="${result.branch.authExhibMapList != null && fn:length(result.branch.authExhibMapList) > 0}">
                                        <td>${result.branch.authExhibMapList[0].auth} : ${result.branch.authExhibMapList[0].id}</td>
                                    </c:if>
                                </tr>
                                <c:if test="${result.branch.authExhibMapList != null && fn:length(result.branch.authExhibMapList) > 1}">
                                    <c:forEach var="authExhibMap" items="${result.branch.authExhibMapList}" begin="1">
                                    <tr>
                                        <td>${authExhibMap.auth} : ${authExhibMap.id}</td>
                                    </tr>
                                    </c:forEach>
                                </c:if>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<c:if test="${result.branch.addr != null && result.branch.addr ne ''}">
    <script type="text/javascript">
      var map = new naver.maps.Map('map');
      var myaddress = $("input[name='addr']").val();// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
      naver.maps.Service.geocode({address: myaddress}, function(status, response) {
          if (status !== naver.maps.Service.Status.OK) {
              return alert(myaddress + '의 검색 결과가 없습니다.');
          }
          var result = response.result;
          // 검색 결과 갯수: result.total
          // 첫번째 결과 결과 주소: result.items[0].address
          // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
          var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
          map.setCenter(myaddr); // 검색된 좌표로 지도 이동
          // 마커 표시
          var marker = new naver.maps.Marker({
            position: myaddr,
            map: map
          });

      });
    </script>
</c:if>