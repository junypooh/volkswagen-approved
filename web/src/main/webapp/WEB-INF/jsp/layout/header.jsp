<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="global-nav">

    <c:set var="currentUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
    <div class="wrap">
        <h1 class="logo"><a href="${pageContext.request.contextPath}/" class="icon icon-global-logo">폭스바겐</a></h1>
        <ul class="lnb">
            <li><a href="javascript:;" class="icon icon-menu-all " onclick="allMenuToggle(this)"><em data-title="Menu">전체메뉴</em></a></li>
            <li<c:if test="${fn:contains(currentUrl, '/item/')}"> data-current="active"</c:if>><a href="javascript:;" class="icon icon-menu-search<c:if test="${fn:contains(currentUrl, '/item/')}"> active</c:if>" onclick="sellCarSearch()"><em data-title="Find a match">차량 검색</em></a></li>
            <li><a href="javascript:;" onclick="qnaQuickToggle(this)" class="icon icon-menu-contact"><em data-title="Buy Cars">빠른 문의</em></a></li>
            <li<c:if test="${fn:contains(currentUrl, '/sellcars/')}"> data-current="active"</c:if>><a href="${pageContext.request.contextPath}/sellcars/view" class="icon icon-menu-sell<c:if test="${fn:contains(currentUrl, '/sellcars/')}"> active</c:if>"><em data-title="Sell Cars">내차 팔기</em></a></li>
        </ul>
        <ul class="etc-lnb">
            <li><a href="javascript:;" onclick="latestToggle(this)" title="최근 본 차량" class="icon icon-menu-history"><em>최근 본 차량</em></a></li>
            <li><a href="javascript:;" onclick="interestToggle(this)" title="관심 차량" class="icon icon-util-like"><em>관심 차량</em></a></li>
            <li><a href="https://www.volkswagen.co.kr" title="폭스바겐 코리아" class="icon icon-menu-parent" target="_blank"><em>폭스바겐 코리아</em></a></li>
        </ul>
    </div>

    <nav class="snb">
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/">처음으로<em>Home</em></a>
                <a href="${pageContext.request.contextPath}/benefit/view">폭스바겐 인증중고차 혜택<em>Benefit</em></a>
                <a href="javascript:void(0)" onclick="sellCarSearch()">차량 검색<em>Find a match</em></a>
                <a href="javascript:void(0)" onclick="qnaQuickToggle('.icon-menu-contact')">빠른 문의<em>Buy Cars</em></a>
                <a href="${pageContext.request.contextPath}/sellcars/view">내차 팔기<em>Sell Cars</em></a>
                <a href="${pageContext.request.contextPath}/community/list">커뮤니티<em>Community</em></a>
                <a href="${pageContext.request.contextPath}/faq/list">자주 묻는 질문<em>FAQ</em></a>
                <a href="${pageContext.request.contextPath}/event/list">이벤트<em>Event</em></a>
                <a href="${pageContext.request.contextPath}/branch/list">전시장 안내<em>Branch</em></a>
            </li>
        </ul>
        <button type="button" class="btn btn-snb-close" data-trigger="layer-close"><i class="icon icon-menu-snb-close">메뉴 닫기</i></button>
    </nav>

</div>
<script type="text/javascript">

    $(document).ready(function () {
        $('[data-trigger="layer"]').layer();
    });

    function toggleLnbLayer($layer, callback) {
        var $target = $(this);

        $('[data-active]').each(function() {
			if($layer[0] != $(this)[0]) {
				$(this).data('layer').close();
			}
		});

        if($layer.data('layer') === undefined) {
            $layer.one('layer.open', function() {
				$(this).attr('data-active', true);
				if(callback) callback();
			}).one('layer.close', function() {
                $(this).removeData('layer').removeAttr('data-active');
                $target.removeClass('active').find('.icon').removeClass('active');
                $('.lnb [data-current="active"]').find('.icon').addClass('active').find('.icon').addClass('active');
            }).layer();
			$('.lnb').find('.icon').removeClass('active');
			$target.addClass('active').find('.icon').addClass('active');
        } else {
            $layer.data('layer').close();
        }
    }

	function allMenuToggle(target) {
		var $layer = $('.global-nav .snb');

        toggleLnbLayer.call(target, $layer);
	}

    //LNB빠른문의 토글
    function qnaQuickToggle(target){
        var $layer = $('#qnaQuick');

        toggleLnbLayer.call(target, $layer);
        $("#fastInquiryForm")[0].reset();
    }

    //LNB관심차량 토글
    function interestToggle(target){
        var $layer = $('#interest');

        toggleLnbLayer.call(target, $layer, interest);
    }

    //LNB최근본차량 토글
    function latestToggle(target){
        var $layer = $('#latest');

        toggleLnbLayer.call(target, $layer, latest);
    }

    // LNB OFF 처리
    function clearLnbOn() {

        $('.lnb > li').each(function() {
            $(this).removeClass('active')
            $(this).find('a').each(function() {
                $(this).removeClass('active')
            })
        })

        $('.etc-lnb > li').each(function() {
            $(this).removeClass('active')
            $(this).find('a').each(function() {
                $(this).removeClass('active')
            })
        })
    }

    // LNB ON 처리
    function setLnbOn() {

        clearLnbOn();

        var currentUrl = '${currentUrl}';
        if(currentUrl.indexOf('item') > -1) {
            $('.lnb > li').eq(1).addClass('active');
            $('.lnb > li').eq(1).children('a').addClass('active');
        } else {
            if(currentUrl.indexOf('sellcars') > -1) {
                $('.lnb > li').eq(3).addClass('active');
                $('.lnb > li').eq(3).children('a').addClass('active');
            }
        }
    }

    // 차량 검색 검색조건초기화 후 이동
    function sellCarSearch() {
        history.pushState(null, 'VWA', '${pageContext.request.contextPath}/item/list');
        location.href = '${pageContext.request.contextPath}/item/list';
    }

</script>

