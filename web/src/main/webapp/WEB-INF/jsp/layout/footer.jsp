<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="footer" id="mainFooter">
    <div class="inner">
        <nav class="menu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/community/list">커뮤니티</a></li>
                <li><a href="${pageContext.request.contextPath}/faq/list">자주 묻는 질문</a></li>
                <li><a href="${pageContext.request.contextPath}/event/list">이벤트</a></li>
                <li><a href="${pageContext.request.contextPath}/branch/list">전시장 안내</a></li>
            </ul>
        </nav>
        <p class="contact">
            <a href="tel:080-767-0089">
                <em>고객지원실</em>
                <strong>080-767-0089</strong>
                <small>(상담시간 : 24시)</small>
            </a>
        </p>
        <nav class="link">
            <ul>
                <li><a href="https://www.volkswagen.co.kr" target="_blank">Volkswagen Korea</a></li>
                <li><a href="https://www.vwfs.co.kr/vwfs/" target="_blank">Volkswagen Financial Services Korea</a></li>
            </ul>
        </nav>
        <p class="copy">
            &copy; Volkswagen 2018
        </p>
    </div>
</footer>

<!-- layer : toast message -->
<div class="layer-wrap layer-toast" id="toast">
    <div class="layer layer-sm">
        <div class="layer-content">
            <div class="layer-body">
                <i class="icon icon-success"></i>
                <p>Text를 설정해주세요.</p>
                <!--<button type="button" class="btn btn-primary btn-radius" data-trigger="layer-close">확인</button>-->
            </div>
        </div>
        <!--<button type="button" class="btn btn-layer-close" data-trigger="layer-close"><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>-->
    </div>
    <i class="layer-dim fade"></i>
</div>
<!-- //layer : toast message -->

<c:import url="/layer/quick" />
<c:import url="/layer/interest" />
<c:import url="/layer/latest" />