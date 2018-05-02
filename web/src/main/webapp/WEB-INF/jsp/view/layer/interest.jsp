<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-02-20
  Time: 오후 2:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- layer : interest 관심 차량-->
<div class="layer-wrap layer-vehicle layer-interest" id="interest">
    <div class="layer">
        <div id="likeContent" class="layer-content">
            <div class="layer-header">
                <p class="layer-title">관심 차량<small>총 <span class="point">${interest.infoTotCnt}</span>대</small></p>
            </div>
            <div class="layer-body">
                <div class="list list-simple">
                    <div class="inner">
                        <ul class="latest-list">
                            <c:forEach var="info" items="${interest.info}" end="2">
                                <li>
                                    <span class="checkbox">
                                        <input type="checkbox" name="likeCheck" class="checkbox" value="${info.sellCarSeq}"><i></i>
                                    </span>
                                    <article class="article">
                                        <div class="box">
                                            <c:if test="${info.carStatCd ne 'D1004'}">
                                            <a href="${pageContext.request.contextPath}/item/${info.sellCarSeq}">
                                            </c:if>
                                                <c:if test="${info.certYn eq 'Y'}"><span class="label label-auth"><i class="icon icon-label-auth-small"></i><em class="hidden">공식인증</em></span></c:if>

                                                <figure class="img">
                                                    <span><img src="${pageContext.request.scheme}://${info.fileUrl}" onerror=""></span>
                                                    <c:if test="${info.carStatCd eq 'D1004'}">
                                                        <span class="soldout">
                                                            <em><i class="icon icon-logo-white"></i><br>판매가 완료된 차량입니다.</em>
                                                        </span>
                                                    </c:if>
                                                </figure>

                                                <div class="content">
                                                    <div class="tags">
                                                        <c:forEach items="${info.tagVos}" var="tagVo" end="2">
                                                            <c:if test="${not empty tagVo.tagNm}">
                                                                <span><em>${tagVo.tagNm}</em></span>
                                                            </c:if>
                                                        </c:forEach>
                                                    </div>

                                                    <div class="model">${info.mak} ${info.detailModel}<small>${info.rating} ${info.detailRating}</small></div>

                                                    <div class="price">
                                                        <em><fmt:formatNumber value="${info.sellPrice}" pattern="#,###" /></em><small>만원</small>
                                                        <c:if test="${info.monPayment > 0}">
                                                            <span class="monthly-pay">(월 <fmt:formatNumber value="${info.monPayment}" pattern="#,###"/>만원 부터~)</span>
                                                        </c:if>
                                                    </div>

                                                    <span class="meta">
                                                    <span><em>연식</em><em>${info.fromYear}년</em></span>
                                                    <span><em>주행거리</em><em><fmt:formatNumber value="${info.driveDist}" pattern="#,###" />km</em></span>
                                                    <span><em>연료</em><em>${info.fuel}</em></span>
                                                    <span><em>구동타입</em><em>${info.gear}</em></span>
                                                    <span class="local"><em>지역</em><em>${info.sigun}</em></span>
                                                    <span class="branch"><em>전시장위치</em><em>${info.type} ${info.storeNm}</em></span>
                                                </span>
                                                </div>
                                            <c:if test="${info.carStatCd ne 'D1004'}">
                                            </a>
                                            </c:if>
                                        </div>
                                    </article>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <c:if test="${fn:length(interest.info) != 0}">
                    <div class="btns">
                        <button type="button" id="likeRemoveButton" class="btn btn-deepdark btn-radius" <c:if test="${fn:length(interest.info) == 0}">disabled="disabled"</c:if>><em>삭제하기</em></button>
                        <button type="button" id="likeCompareButton" class="btn btn-primary btn-radius" <c:if test="${fn:length(interest.info) == 0}">disabled="disabled"</c:if>><em>비교하기</em><em id="likeCompareEm">0/2</em></button>
                    </div>
                </c:if>
                <c:if test="${fn:length(interest.info) == 0}">
                    <!-- 검색 결과 없을 시 -->
                    <div class="no-result">
                        <div class="">
                            <i class="icon icon-interest-empty"></i>
                            <p>관심차량을 등록해주세요.</p>
                        </div>
                    </div>
                    <!-- //검색 결과 없을 시 -->
                </c:if>
            </div>
        </div>
        <button type="button" class="btn btn-layer-close" data-trigger="layer-close" onclick="closeInterest()"><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
    </div>
</div>

<script type="text/javascript">
$(function(){

    //삭제하기버튼 이벤트
    $(document).on("click","#likeRemoveButton",function(){

        if($("input[name='likeCheck']:checked").length == 0){
            toast("최소 1대 이상의 차량을 선택해주세요");
            return;
        }
        if(!confirm("정말 삭제하시겠습니까?")) return;

        $("input[name='likeCheck']:checked").each(function (index) {
            var sellCarSeq = Number($(this).val());
            localStorageRemove("like", sellCarSeq);
        });
        interest();
    });

    //비교하기버튼 이벤트
    $(document).on("click", "#likeCompareButton", function(){
        if($("input[name='likeCheck']:checked").length != 2){
            toast("2대의 차량을 선택해주세요");
            return;
        }
        var firstSellCarSeq = "";
        var lastSellCarSeq = "";
        $("input[name='likeCheck']:checked").each(function (index) {
            if(index == 0){
                firstSellCarSeq = $(this).val();
            } else {
                lastSellCarSeq = $(this).val();
            }
        });
        var url = "${pageContext.request.contextPath}/comparison/view/" + firstSellCarSeq + "/" + lastSellCarSeq;

        window.open(url, "_blank");
    });

    //체크박스 클릭 이벤트
    $(document).on("change", "input[name='likeCheck']", function(){
        var _html = $("input[name='likeCheck']:checked").length + "/2";
        $("#likeCompareEm").html(_html);
    });

});
//localStorage에서 관심차량 가져오기
function interest(){
    var likeSeq = localStorageGet("like");

    $.ajax({
        url : "${pageContext.request.contextPath}/layer/getInterest",
        type: "POST",
        data : {sellCarSeq : likeSeq},
        dataType : "html",
        async: false,
        success : function(data){
            $("#likeContent").html($(data).find('#likeContent').html());
        }
    });
}

function closeInterest() {
    //$('#interest').toggle();
    //setLnbOn();
}
</script>
<!-- //layer : interest 관심 차량 -->