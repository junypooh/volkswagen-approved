<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2017-12-19
  Time: 오후 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("br", "\r\n"); %>
<main class="content-wrapper page-main">
    <section class="section section-visual">
        <div class="items">
            <c:forEach items="${banners}" var="item" varStatus="status">
                <div>
                    <div class="item">
                        <div class="content">
                            <h2>${item.title}</h2>
                            <p class="description">${fn:replace(item.ctnt, br, "<br/>")}</p>
                        </div>
                        <c:choose>
                            <c:when test="${not empty item.linkUrl}">
                                <a href="${item.linkUrl}" <c:if test="${item.newWinYn eq 'Y'}">target="_blank"</c:if><i class="image" style="background-image:url('${pageContext.request.scheme}://${fileUrlPath}${item.file.filePath}${item.file.fileNm}');"></i></a>
                            </c:when>
                            <c:otherwise>
                                <i class="image" style="background-image:url('${pageContext.request.scheme}://${fileUrlPath}${item.file.filePath}${item.file.fileNm}');"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div  class="slider-control">
            <div class="inner">
                <button type="button" class="btn-play">재생/정지</button>
            </div>
        </div>
    </section>
    <section class="section section-benefits">
        <div class="inner">
            <nav class="tab">
                <button type="button" class="item-1 active" onclick="refreshNewIncomming(this, 'Y')">인증 중고차<i class="icon icon-arrow-bottom"></i></button>
                <button type="button" class="item-2 " onclick="refreshNewIncomming(this, 'N')">비인증 중고차<i class="icon icon-arrow-bottom"></i></button>
            </nav>
            <div class="tab-conwrap">
                <div class="tabcon certification">
                    <h2>Volkswagen 공식 인증 중고차</h2>
                    <p class="description">88가지 점검항목을 통과한 엄선된 공식 인증 중고차를 믿을 수 있는 폭스바겐 인증중고차로 편리하게 만나보세요.</p>
                    <ul class="benefits">
                        <li>
                            <i class="icon icon-round-check-list"></i>
                            <strong>Quality Check</strong>
                            <span>88가지 품질점검</span>
                        </li>
                        <li>
                            <i class="icon icon-round-warranty"></i>
                            <strong>Warranty Plus</strong>
                            <span>연장보증</span>
                        </li>
                        <li>
                            <i class="icon icon-round-trade-in"></i>
                            <strong>Trade in</strong>
                            <span>보상판매</span>
                        </li>
                        <li>
                            <i class="icon icon-round-finance"></i>
                            <strong>Finance Options</strong>
                            <span>금융상품</span>
                        </li>
                    </ul>
                    <p class="buttons">
                        <a href="${pageContext.request.contextPath}/benefit/view" class="btn btn-primary btn-radius"><em>혜택 더보기</em></a>
                    </p>
                </div>
                <div class="tabcon unauthorized" style="display:none;">
                    <h2>엄선된 중고차</h2>
                    <p class="description">정직한 가격으로 온라인과 오프라인 매장 어디서든 편리하고 쉽게 만나보세요.</p>
                    <ul class="benefits">
                        <li>
                            <i class="icon icon-round-guarantee"></i>
                            <strong>엄선된 딜러사의 차량</strong>
                            <span>클린 차량</span>
                        </li>
                        <li>
                            <i class="icon icon-round-compare"></i>
                            <strong>다양한 차량 비교</strong>
                            <span>비교견적</span>
                        </li>
                        <li>
                            <i class="icon icon-round-calc"></i>
                            <strong>거품없고 합리적인</strong>
                            <span>정직한 가격</span>
                        </li>
                        <li>
                            <i class="icon icon-round-service"></i>
                            <strong>스마트한 차량문의</strong>
                            <span>1:1 문의</span>
                        </li>
                    </ul>
                    <!-- <p class="buttons">
                        <a href="#none" class="btn btn-primary btn-radius"><em>혜택 더보기</em></a>
                    </p> -->
                </div>
            </div>
        </div>
    </section>
    <c:if test="${not empty items}">
    <section class="section section-new">
        <div class="inner">
            <h2>최근 입고된 차량</h2>
            <div class="list list-grid">
                <div class="inner" id="newIncomming">
                    <c:forEach items="${items}" var="item" varStatus="status">
                        <article class="article">
                            <div class="box">
                                <c:if test="${item.carStatCd ne 'D1004'}">
                                <a href="${pageContext.request.contextPath}/item/${item.sellCarSeq}">
                                </c:if>
                                    <c:if test="${item.certYn eq 'Y'}">
                                    <span class="label label-auth"><i class="icon icon-label-auth"></i><em class="hidden">공식인증</em></span>
                                    </c:if>

                                    <figure class="img">
                                        <span><img src="${pageContext.request.scheme}://${item.fileUrl}" onerror=""></span>
                                        <c:if test="${item.carStatCd eq 'D1004'}">
											<span class="soldout">
												<em><i class="icon icon-logo-white"></i><br>판매가 완료된 차량입니다.</em>
											</span>
                                        </c:if>
                                    </figure>

                                    <div class="content">
                                        <div class="tags">
                                            <c:forEach items="${item.tagVos}" var="tag" varStatus="status">
                                                <c:if test="${not empty tag.tagNm}">
                                                    <span><em>${tag.tagNm}</em></span>
                                                </c:if>
                                            </c:forEach>
                                        </div>

                                        <div class="model">${item.mak} ${item.detailModel}<small>${item.rating} ${item.detailRating}</small></div>

                                        <div class="price">
                                            <em><fmt:formatNumber value="${item.sellPrice}" pattern="#,###"/></em><small>만원</small>
                                            <c:if test="${item.monPayment > 0}"><span class="monthly-pay">(월 <fmt:formatNumber value="${item.monPayment}" pattern="#,###"/>만원 부터~)</span></c:if>
                                        </div>

										<span class="btn btn-like" title="좋아요" <c:if test="${item.carStatCd ne 'D1004'}">data-click="like(this, ${item.sellCarSeq})" data="${item.sellCarSeq}"</c:if>><i class="icon icon-util-like"></i></span>

										<span class="meta">
                                            <span><em>연식</em><em>${item.fromYear}년</em></span>
                                            <span><em>주행거리</em><em><fmt:formatNumber value="${item.driveDist}" pattern="#,###"/>km</em></span>
                                            <span><em>연료</em><em>${item.fuel}</em></span>
                                            <span><em>구동타입</em><em>${item.gear}</em></span>
                                            <span class="local"><em>지역</em><em>${item.sigun}</em></span>
                                            <span class="branch"><em>전시장위치</em><em>${item.branch}</em></span>
                                        </span>
                                    </div>
                                <c:if test="${item.carStatCd ne 'D1004'}">
                                </a>
                                </c:if>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
    </c:if>
    <c:if test="${not empty events}">
    <section class="section section-event">
        <c:forEach items="${events}" var="item" varStatus="status">
            <div class="inner">
                <div class="content">
                    <h2>EVENT</h2>
                    <p class="description">
                        ${item.title}
                    </p>
                    <c:if test="${not empty item.strDate and not empty item.endDate}">
                    <p class="date">${item.strDate} ~ ${item.endDate}</p>
                    </c:if>

                    <p class="buttons">
                    <c:choose>
                        <c:when test="${item.type == 'Registe'}">
                            <a href="${pageContext.request.contextPath}/event/detail/${item.eventSeq}" class="btn btn-primary btn-radius">자세히보기</a>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${pcMobile == 'pc'}">
                                <a href="${item.ctntPc}" class="btn btn-primary btn-radius" <c:if test="${item.newWinYnPc=='Y'}">target="_blank"</c:if>>자세히보기</a>
                            </c:if>
                            <c:if test="${pcMobile == 'mobile'}">
                                <a href="${item.ctntPc}" class="btn btn-primary btn-radius" <c:if test="${item.newWinYnMo=='Y'}">target="_blank"</c:if>>자세히보기</a>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                    </p>
                </div>
                <p class="image"><img src="${pageContext.request.scheme}://${fileUrlPath}${item.mainImgFile.filePath}${item.mainImgFile.fileNm}" alt=""></p>
            </div>
        </c:forEach>
    </section>
    </c:if>
    <section class="section section-search">
        <div class="inner">
            <h2>내 차, 폭스바겐에서 <span>시작하세요</span></h2>
            <fieldset>
                <legend>차량 검색</legend>
                <div class="form">
                    <select class="design-select" data-title="" id="mak" onchange="getModel(this.value)">
                        <option value="폭스바겐">폭스바겐</option>
                        <c:forEach items="${maks}" var="maks">
                            <option value="${maks.mak}">${maks.mak}</option>
                        </c:forEach>
                    </select>
                    <select class="design-select" data-title="MODEL" id="model" onchange="getDetailModel(this.value)">
                        <option value="">모델</option>
                        <c:forEach items="${models}" var="models">
                            <option value="${models.model}">${models.model}</option>
                        </c:forEach>
                    </select>
                    <select class="design-select" data-title="DETAIL" id="detailModel" onchange="getNowSellingItemCount()">
                        <option value="">세부모델</option>
                    </select>
                    <button type="button" class="btn btn-primary btn-radius" id="searchBtn" onclick="goList()"><em>검색</em><i>(${sellCount}건)</i></button>
                </div>
            </fieldset>
        </div>
    </section>
</main>

<c:forEach items="${popups}" var="popup">
    <div class="layer-wrap layer-main" id="mainLayer${popup.popupSeq}">
        <div class="layer">
            <div class="layer-content">
                <div>
                    <span class="img">
                        <a href="${popup.linkUrl}" <c:if test="${popup.newWinYn eq 'Y'}">target="_blank"</c:if>>
                            <img src="${pageContext.request.scheme}://${fileUrlPath}${popup.file.filePath}${popup.file.fileNm}" alt="">
                        </a>
                    </span>
                </div>
            </div>
            <div class="layer-footer">
                <button type="button" class="btn btn btn-deepdark btn-radius" data-trigger="layer-close" >닫기</button>
            </div>
        </div>
    </div>
</c:forEach>

<script type="text/javascript">

    $(document).ready(function () {
        // 좋아요 버튼 제어
        likeEvent();

		$('.layer-main').layer();
    });

    var $tabs = $('.tab button'),
        $conts = $('.tab-conwrap .tabcon');

    $tabs.on('click', function() {
        var $index = $(this).index();

        $(this).addClass('active')
            .siblings().removeClass('active');

        $conts.eq($index)
            .show()
            .siblings('.tabcon')
            .hide();
        return false;
    });

    var xpaused = false;
    function mainSlide() {
        var $mainSlide = $('.section-visual .items').slick({
            pauseOnHover: false,
            pauseOnFocus: false,
            autoplay:true,
            autoplaySpeed:3000,
            dots: true,
            appendDots: ".slider-control .inner",
            arrows: true,
            infinite: true,
            slidesToShow: 1,
            slidesToScroll: 1
        });
        $(".slider-control .btn-play").on("click", function() {
            if( xpaused ) {
                $mainSlide.slick("play");
            } else {
                $mainSlide.slick("pause");
            }
            xpaused = !xpaused;
            $(this).toggleClass( "btn-paused" );
        });
    }
    mainSlide();

    /** 좋아요 클릭 */
    function like(obj, sellCarSeq) {

        if ($(obj).children().hasClass('active')) {
            $(obj).children().removeClass('active');
            //window.localStorage.removeItem('like_'+sellCarSeq);
            localStorageRemove('like', sellCarSeq);
        } else {
            $(obj).children().addClass('active');
            //window.localStorage.setItem('like_'+sellCarSeq, sellCarSeq);
            localStorageSet('like', sellCarSeq);
        }

    }

    /** 좋아요 버튼 제어 */
    function likeEvent() {
        $.each(localStorageGet('like'), function(i, likeSeq){
            $('.btn-like').each(function(){
                if (likeSeq == $(this).attr('data')) {
                    $(this).children().addClass('active');
                }
            });
        });
    }

    // 제조사 선택 모델 가져오기
    function getModel(mak) {

        $.ajax({
            url: "${pageContext.request.contextPath}/index/model",
            type: "POST",
            data: {mak: mak},
            async: false,
            success: function(result) {
                var _html = '<option value="">모델</option>';
                if(result.length > 0) {
                    $.each(result, function (idx, item) {
                        _html += '<option value="' + item.model + '">' + item.model + '</option>';
                    })
                }
                $('#model').empty().append(_html);
                getNowSellingItemCount();
                $('#detailModel option:eq(0)').attr('selected', 'selected');
            }
        });
    }

    // 모델 선택 세부모델 가져오기
    function getDetailModel(model) {
        $.ajax({
            url: "${pageContext.request.contextPath}/index/model/detail",
            type: "POST",
            data: {mak: $('#mak').val(), model: model},
            async: false,
            success: function(result) {
                var _html = '<option value="">세부모델</option>';
                if(result.length > 0) {
                    $.each(result, function (idx, item) {
                        _html += '<option value="' + item.detailModel + '">' + item.detailModel + '</option>';
                    })
                }
                $('#detailModel').empty().append(_html);
                getNowSellingItemCount();
            }
        });
    }

    // 차량 선택 selectbox 초기화
    function carSelectReset() {
        $('.form .select-box.design-select').each(function() {
            var _defaultText = $('#'+$(this).children().eq(0).attr('id') + ' option:selected').text();
            $(this).children().eq(1).text(_defaultText);


            if($('#'+$(this).children().eq(0).attr('id') + ' option:selected').val() == '') {
                var _dataTitle = $(this).children().first().attr('data-title');
                $(this).children().eq(1).attr('data-title', _dataTitle);
            } else {
                $(this).children().eq(1).attr('data-title', '');
            }
        });
    }

    // 현재 판매진행 중이 차량수
    function getNowSellingItemCount() {

        $.ajax({
            url: "${pageContext.request.contextPath}/index/item/count",
            type: "POST",
            data: {mak: $('#mak').val(), model: $('#model').val(), detailModel: $('#detailModel').val()},
            success: function(result) {
                $('#searchBtn').find('i').empty().append("(" + result + ")건");
            }
        });
        carSelectReset();

    }

    // 차량 검색으로 이동
    function goList() {

        var listUrl = '${pageContext.request.contextPath}/item/list',
            params = {
                mak: $('#mak').val(),
                model: $('#model').val(),
                detailModel: $('#detailModel').val(),
                certYn: 'ALL'
            };

        location.href = listUrl + '?' + $.param(params);
    }

    // 최근 입고된 차량 갱신
    function refreshNewIncomming(obj, certYn) {
        $('html, body').animate({
            scrollTop: $(obj).offset().top - 10
        });

        if($(obj).hasClass('active')) {
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/recentList",
            type: "GET",
            data : {certYn : certYn},
            success: function(result) {
                $('#newIncomming').empty().append($(result).find('#newIncomming').html());
            }
        });
    }
</script>