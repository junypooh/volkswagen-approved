<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-02-13
  Time: 오후 4:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("br", "\r\n"); %>
<script src="${pageContext.request.contextPath}/resources/scripts/jquery/plugins/jquery.rowspanizer.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/vue/vue.min.js"></script>

<main class="content-wrapper page-car-detail">
    <section class="section section-detail">
        <div class="inner">
            <div class="header">
                <h2><strong>${result.info.mak} ${result.info.detailModel} <span>${result.info.rating} ${result.info.detailRating}</span></strong><c:if test="${result.info.labelYn eq 'Y'}"> <i class="new">NEW</i></c:if></h2>
                <div class="utils">
                    <button type="button" class="icon icon-util-line-like" onclick="like(this, ${sellCarSeq})" data="${sellCarSeq}"></button>
                    <button type="button" class="icon icon-util-share" onclick="layerOpen('layer-share')"></button>
                    <button type="button" class="icon icon-util-download"></button>
                    <button type="button" class="icon icon-util-print"></button>
                </div>
                <div class="tags">
                    <c:forEach items="${result.info.tagVos}" var="item">
                        <c:if test="${not empty item.tagNm}">
                            <span><em>${item.tagNm}</em></span>
                        </c:if>
                    </c:forEach>
                </div>
                <button type="button" class="icon icon-sub-page-close" onclick="${backBtnScript}"></button>
            </div>
            <div class="calculator-wrap">
                <div class="image">
                    <c:if test="${result.info.certYn eq 'Y'}">
                        <span class="label label-auth"><i class="icon icon-label-auth"></i><em class="hidden">공식인증</em></span>
                    </c:if>
                    <img src="${pageContext.request.scheme}://${result.info.fileUrl}" alt="">
                    <span class="watermark">Volkswagen Approved</span>
                </div>
                <div class="calculator">
                    <div class="head">
                        <span class="label">가격</span>
                        <span class="value">
                            <strong><fmt:formatNumber value="${result.info.sellPrice}" pattern="#,###"/></strong>만원
                            <span><c:if test="${result.info.monPayment > 0}"> (월 <fmt:formatNumber value="${result.info.monPayment}" pattern="#,###"/>만원~)</c:if></span>
                        </span>
                    </div>
                    <jsp:useBean id="toDay" class="java.util.Date" />
                    <fmt:formatDate value="${toDay}" pattern="yyyy" var="year"/>
                    <c:set var="startYear" value="2008" />
                    <div class="body">
                        <div class="item">
                            <span class="label">연식</span>
                            <div class="graph" data-start="${year}년" data-end="${startYear}년 이하">
                                <div class="bar" data-animate-width="${ (year - result.info.fromYear) / (year - startYear) * 100 > 100 ? 100 : (year - result.info.fromYear) / (year - startYear) * 100 }">
                                    <span class="value">${result.info.fromYear}연식</span>
                                    <i class="icon icon-graph-car"></i>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <span class="label">주행거리</span>
                            <div class="graph" data-start="0km" data-end="15만km 이상">
                                <div class="bar" data-animate-width="${ result.info.driveDist/150000*100 > 100 ? 100 : result.info.driveDist/150000*100 }">
                                    <span class="value"><fmt:formatNumber value="${result.info.driveDist}" pattern="#,###"/>km</span>
                                    <i class="icon icon-graph-car"></i>
                                </div>
                            </div>
                        </div>
                        <p class="buttons">
                            <button type="button" class="btn btn-primary btn-radius" onclick="layerOpen('layer-qna')"><em>문의하기</em></button>
                        </p>
                    </div>
                </div>
            </div>
            <div class="info">
                <ul>
                    <li>
                        <span>연료</span>
                        <strong>${result.info.fuel}</strong>
                    </li>
                    <li>
                        <span>변속기</span>
                        <strong>${result.info.gear}</strong>
                    </li>
                    <li>
                        <span>차종</span>
                        <strong>${result.info.carType}</strong>
                    </li>
                    <li>
                        <span>배기량</span>
                        <strong>${result.carInfo.disp}cc</strong>
                    </li>
                    <li>
                        <span>사고유무</span>
                        <strong><c:choose><c:when test="${result.priceInfo.accidHisYn eq 'Y'}">유</c:when><c:when test="${result.priceInfo.accidHisYn eq 'N'}">무</c:when><c:otherwise>비공개</c:otherwise></c:choose></strong>
                    </li>
                    <li>
                        <span>흡연여부</span>
                        <strong><c:choose><c:when test="${result.BfCarOwner.smokYn eq 'Y'}">흡연</c:when><c:otherwise>비흡연</c:otherwise></c:choose></strong>
                    </li>
                    <li>
                        <span>차량용도</span>
                        <strong><c:choose><c:when test="${result.BfCarOwner.carUse eq 'C'}">출퇴근</c:when><c:when test="${result.BfCarOwner.carUse eq 'L'}">레저</c:when><c:otherwise>영업</c:otherwise></c:choose></strong>
                    </li>
                    <li>
                        <span>외장 색상</span>
                        <strong>${result.info.color}</strong>
                    </li>
                    <li>
                        <span>내장 색상</span>
                        <strong>${result.info.innerColor}</strong>
                    </li>
                    <li>
                        <span>압류/저당</span>
                        <strong>
                            <c:choose><c:when test="${result.priceInfo.seize eq 'Y'}">있음</c:when><c:when test="${result.priceInfo.seize eq 'N'}">없음</c:when><c:otherwise>정보없음</c:otherwise></c:choose>/
                            <c:choose><c:when test="${result.priceInfo.pled eq 'Y'}">있음</c:when><c:when test="${result.priceInfo.pled eq 'N'}">없음</c:when><c:otherwise>정보없음</c:otherwise></c:choose>
                        </strong>
                    </li>
                </ul>
                <small class="note point">※ 사고유무는 성능&middot;상태 점검기록부에 의해 작성된 내용입니다.</small>
            </div>
        </div>
    </section>
    <%--
    <c:if test="${result.info.certYn eq 'Y'}">
    <section class="section section-service">
        <div class="inner">
            <div class="guide">
                <div class="item">
                    <strong>Warranty</strong>
                    <span class="month"><em>${result.priceInfo.wrt}</em>개월</span>
                    <p>신차 기준 잔여 보증 기간을 인증 중고 차량 구매 고객님께 인계하여 신차와 동일한 서비스를 전달합니다.</p>
                </div>
                <div class="item">
                    <strong>Warranty Plus</strong>
                    <span class="month"><em>${result.priceInfo.wrtPlus}</em>개월</span>
                    <p>폭스바겐 인증 중고 차량은 고객님께서 수리비 부담없이 안심하고 구매하실 수 있도록 연장보증을 제공합니다.</p>
                </div>
            </div>
            <div class="service">
                <strong>Service Plus</strong>
                <p>폭스바겐 서비스 플러스 프로그램은 보증기간 동안 차량의 유지보수 비용을 최소화 할 수 있도록 소모품 교환을 지원하는 서비스 프로그램입니다. 폭스바겐의 모든 차량에 적용되며 공식 서비스센터에서 전문적이고 체계적인 서비스를 받으실 수 있습니다.</p>
                <ul class="list-service">
                    <li <c:if test="${result.servicePlus.E1101 eq 0}">class="disabled"</c:if>>
                        <div>
                            <i class="icon icon-service-check<c:if test="${result.servicePlus.E1101 eq 0}">-disabled</c:if>"></i>
                            <p>
                                <em>정기점검</em>
                                <span>${result.servicePlus.E1101}회</span>
                            </p>
                        </div>
                    </li>
                    <li <c:if test="${result.servicePlus.E1103 eq 0}">class="disabled"</c:if>>
                        <div>
                            <i class="icon icon-service-oil-filter<c:if test="${result.servicePlus.E1103 eq 0}">-disabled</c:if>"></i>
                            <p>
                                <em>오일 필터</em>
                                <span>${result.servicePlus.E1103}회</span>
                            </p>
                        </div>
                    </li>
                    <li <c:if test="${result.servicePlus.E1105 eq 0}">class="disabled"</c:if>>
                        <div>
                            <i class="icon icon-service-aircon-filter<c:if test="${result.servicePlus.E1105 eq 0}">-disabled</c:if>"></i>
                            <p>
                                <em>에어컨 필터</em>
                                <span>${result.servicePlus.E1105}회</span>
                            </p>
                        </div>
                    </li>
                    <li <c:if test="${result.servicePlus.E1102 eq 0}">class="disabled"</c:if>>
                        <div>
                            <i class="icon icon-service-engine-oil<c:if test="${result.servicePlus.E1102 eq 0}">-disabled</c:if>"></i>
                            <p>
                                <em>엔진 오일</em>
                                <span>${result.servicePlus.E1102}회</span>
                            </p>
                        </div>
                    </li>
                    <li <c:if test="${result.servicePlus.E1104 eq 0}">class="disabled"</c:if>>
                        <div>
                            <i class="icon icon-service-fuel-filter<c:if test="${result.servicePlus.E1104 eq 0}">-disabled</c:if>"></i>
                            <p>
                                <em>연료필터</em>
                                <span>${result.servicePlus.E1104}회</span>
                                <small>(폴로, 투아렉 한정)</small>
                            </p>
                        </div>
                    </li>
                    <li <c:if test="${result.servicePlus.E1106 eq 0}">class="disabled"</c:if>>
                        <div>
                            <i class="icon icon-service-transmission-oil<c:if test="${result.servicePlus.E1106 eq 0}">-disabled</c:if>"></i>
                            <p>
                                <em>트렌스미션 오일</em>
                                <span>${result.servicePlus.E1106}회</span>
                            </p>
                        </div>
                    </li>
                    <li <c:if test="${result.servicePlus.E1107 eq 0}">class="disabled"</c:if>>
                        <div>
                            <i class="icon icon-service-spark-plug<c:if test="${result.servicePlus.E1107 eq 0}">-disabled</c:if>"></i>
                            <p>
                                <em>스파크 플러그</em>
                                <span>${result.servicePlus.E1107}회</span>
                                <small>(가솔린 차량 한정) </small>
                            </p>
                        </div>
                    </li>
                    <li <c:if test="${result.servicePlus.E1201 eq 0}">class="disabled"</c:if>>
                        <div>
                            <i class="icon icon-service-front-brake<c:if test="${result.servicePlus.E1201 eq 0}">-disabled</c:if>"></i>
                            <p>
                                <em>앞 브레이크 패드</em>
                                <span>${result.servicePlus.E1201}회</span>
                            </p>
                        </div>
                    </li>
                    <li <c:if test="${result.servicePlus.E1202 eq 0}">class="disabled"</c:if>>
                        <div>
                            <i class="icon icon-service-back-brake<c:if test="${result.servicePlus.E1202 eq 0}">-disabled</c:if>"></i>
                            <p>
                                <em>뒷 브레이크 패드</em>
                                <span>${result.servicePlus.E1202}회</span>
                            </p>
                        </div>
                    </li>
                    <li <c:if test="${result.servicePlus.E1203 eq 0}">class="disabled"</c:if>>
                        <div>
                            <i class="icon icon-service-wiper-blade<c:if test="${result.servicePlus.E1203 eq 0}">-disabled</c:if>"></i>
                            <p>
                                <em>와이퍼 블레이드</em>
                                <span>${result.servicePlus.E1203}회</span>
                            </p>
                        </div>
                    </li>
                </ul>
                <small>※ 상기 서비스 품목은 차량에 따라 다르게 적용될 수 있습니다. </small>
            </div>
        </div>
    </section>
    </c:if>
    --%>
    <section class="section section-image-list">
        <div class="inner">
            <ul>
                <c:forEach items="${result.photos}" var="photo">
                    <c:if test="${not empty photo.fileUrl and photo.photoCd ne 'C1001'}">
                        <li><a href="${pageContext.request.scheme}://${photo.fileUrl}"><span class="watermark">Volkswagen Approved</span><img src="${pageContext.request.scheme}://${photo.fileUrl}" alt=""><i class="icon icon-image-more"></i></a></li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </section>
    <section class="section section-car-status">
        <div class="inner">
            <article id="detail-options" class="options" >
                <h2>
                    <span class="current">옵션정보</span>
                    <a href="#detail-table" aria-hidden="true">성능 점검표</a>
                    <a href="#detail-description" aria-hidden="true">차량 설명</a>
                </h2>
                <ul class="main">
                    <c:forEach items="${result.majorOptions}" var="majorOption">
                        <li>
                            <span class="img">
                                <c:choose>
                                    <c:when test="${not empty majorOption.sellCarSeq}">
                                        <img src="${pageContext.request.scheme}://${fileUrlPath}${majorOption.thumImgOnFile.filePath}${majorOption.thumImgOnFile.fileNm}" alt="">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.scheme}://${fileUrlPath}${majorOption.thumImgOffFile.filePath}${majorOption.thumImgOffFile.fileNm}" alt="">
                                    </c:otherwise>
                                </c:choose>
                            </span>
                            <span>${majorOption.optNm}</span>
                        </li>
                    </c:forEach>
                </ul>
                <div class="options-category">
                    <i class="bullet active"></i><em>포함 옵션</em>&nbsp;<i class="bullet"></i><em>불포함 옵션</em>
                </div>
                <p class="buttons">
                    <button type="button" class="btn btn-deepdark btn-radius btn-option"><em>상세 옵션 열기</em></button>
                </p>
                <div id="detail-options-div" class="detail-options" style="display: none">
                    <ul>
                        <c:forEach items="${result.options}" var="option" varStatus="status">
                            <li<c:if test="${status.index == 0}"> class="current"</c:if>><span class="head">${option.cateName}</span>
                                <ul>
                                    <c:forEach items="${option.optList}" var="list" varStatus="state">
                                        <li<c:if test="${not empty list.sellCarSeq}"> class="active"</c:if>><span>${list.optNm}</span></li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </article>
            <article id="detail-table" class="table">
                <h2>
                    <a href="#detail-options" aria-hidden="true">옵션정보</a>
                    <span class="current">성능 점검표</span>
                    <a href="#detail-description" aria-hidden="true">차량 설명</a>
                </h2>
                <div class="check-point">
                    <div class="item panel">

                        <c:forEach items="${result.panels}" var="panel" varStatus="status">
                            <span class="check ${panel.cd}">
                                <c:if test="${panel.exch eq 'Y'}"><span class="point exchange" >X</span></c:if>
                                <c:if test="${panel.weld eq 'Y'}"><span class="point weld" >W</span></c:if>
                                <c:if test="${panel.corr eq 'Y'}"><span class="point corrosion" >C</span></c:if>
                            </span>
                        </c:forEach>

                        <img src="${pageContext.request.contextPath}/resources/images/car-check-front.png" alt="외판 부위의 교환, 부식, 판금 및 용접수리">
                    </div>
                    <div class="item frame">

                        <c:forEach items="${result.frames}" var="panel" varStatus="status">
                            <span class="check ${panel.cd}">
                                <c:if test="${panel.exch eq 'Y'}"><span class="point exchange" >X</span></c:if>
                                <c:if test="${panel.weld eq 'Y'}"><span class="point weld" >W</span></c:if>
                                <c:if test="${panel.corr eq 'Y'}"><span class="point corrosion" >C</span></c:if>
                            </span>
                        </c:forEach>

                        <img src="${pageContext.request.contextPath}/resources/images/car-check-back.png" alt="주요골격 부위의 교환, 부식, 판금 및 용접수리">
                    </div>
                </div>
                <div class="guide">
                    <ul>
                        <li>
                            <span class="point exchange">X</span> 교환
                        </li>
                        <li>
                            <span class="point weld">W</span> 판금/용접
                        </li>
                        <li>
                            <span class="point corrosion">C</span> 부식
                        </li>
                    </ul>
                </div>
                <p class="detail-more">
                    <button type="button" class="btn sub-btn btn-dark" onclick="layerOpen('layer-checklist')"><em>성능점검표 상세보기</em></button>
                    <strong>성능/상태 점검일</strong>
                    <time>${result.performance.statConfYear}.${result.performance.statConfMonth}.${result.performance.statConfDay}</time>
                </p>
                <c:if test="${not empty result.priceInfo.qualityChkDay}">
                    <fmt:parseDate value="${result.priceInfo.qualityChkDay}" var="qualityChkDay" pattern="yyyyMMdd"/>
                    <p class="detail-more">
                        <c:choose>
                            <c:when test="${result.priceQualityYn eq 'Y'}">
                                <button type="button" class="btn sub-btn btn-dark" onclick="layerOpen('layer-multi-checklist')"><i class="icon icon-util-download-white"></i><em>88가지 품질점검표</em></button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn sub-btn btn-dark" onclick="openFile('${pageContext.request.scheme}://${fileUrlPath}${result.priceInfo.qualityFile.filePath}${result.priceInfo.qualityFile.fileNm}')"><i class="icon icon-util-download-white"></i><em>88가지 품질점검표</em></button>
                            </c:otherwise>
                        </c:choose>
                        <strong>품질 점검일</strong>
                        <time><fmt:formatDate value="${qualityChkDay}" pattern="yyyy.MM.dd"/></time>
                    </p>
                </c:if>
            </article>
            <article id="detail-description" class="description" >
                <h2>
                    <a href="#detail-options" aria-hidden="true">옵션정보</a>
                    <a href="#detail-table" aria-hidden="true">성능 점검표</a>
                    <span class="current">차량 설명</span>
                </h2>
                <div class="dealer">
                    <div class="comment">
                        <i class="icon icon-dealer"></i>
                        <div>
                            <strong>판매자 한마디</strong>
                            <p>${result.discVo.sellDisc}</p>
                        </div>
                    </div>
                    <p class="note">폭스바겐 공식 인증 중고차 딜러사에서 진단하고 검증한 차량입니다.</p>
                </div>
                <c:if test="${not empty result.discVo.discWrit}">
                    <p class="buttons">
                        <button type="button" class="btn btn-deepdark btn-radius btn-explanation"><em>상세 설명 열기</em></button>
                    </p>
                    <div class="explanation">
                        <p class="title">차량 상세 설명</p>
                        <div class="box">
                            <p>${fn:replace(result.discVo.discWrit, br, "<br/>")}</p>
                        </div>
                    </div>
                </c:if>
            </article>
        </div>
    </section>
    <c:if test="${result.info.certYn eq 'Y'}">
        <section class="section section-benefits">
            <div class="inner">
                <h2>인증 중고차 구매 혜택 안내</h2>
                <ul>
                    <li>
                        <i class="icon icon-round-approved"></i>
                        <strong>
                            폭스바겐 인증 중고차
                            <small>Volkswagen Approved</small>
                        </strong>
                        <p>
                            엄격한 검증을 거친 폭스바겐 공식 인증 중고차로 구매부터 판매까지 고객들의 안심거래를 도와드립니다.
                        </p>
                    </li>
                    <li>
                        <i class="icon icon-round-trade-in"></i>
                        <strong>
                            보상판매
                            <small>Trade in</small>
                        </strong>
                        <p>
                            기존의 차량을 반납하시고 폭스바겐 신차 또는 중고차를 구매하실 수 있습니다.
                        </p>
                    </li>
                    <li>
                        <i class="icon icon-round-check-list"></i>
                        <strong>
                            88가지 품질점검
                            <small>Technical quality check</small>
                        </strong>
                        <p>
                            폭스바겐 인증 중고차량의 품질을 유지하기 위해 88가지의 품질 및 기술점검을 실시하여 최상의 품질을 제공합니다.
                        </p>
                    </li>
                    <li>
                        <i class="icon icon-round-reconditioning"></i>
                        <strong>
                            상품화
                            <small>Reconditioning</small>
                        </strong>
                        <p>
                            Volkswagen Approved차량이 최상의 상태를 유지할 수 있도록 전문적인 솔루션을 사용하는 상품화 과정을 거치게 됩니다.
                        </p>
                    </li>
                    <li>
                        <i class="icon icon-round-warranty"></i>
                        <strong>
                            연장보증
                            <small>Warranty Plus</small>
                        </strong>
                        <p>
                            폭스바겐파이낸셜 서비스를 통해 구매시점부터 추가 1년의 연장보증 서비스를 제공합니다.
                        </p>
                    </li>
                    <li>
                        <i class="icon icon-round-finance"></i>
                        <strong>
                            금융상품
                            <small>Finance options</small>
                        </strong>
                        <p>
                            보다 쉽게 Volkswagen Approved차량을 구매 하실 수 있도록 다양한 리스, 할부 등의 금융상품을 폭스바겐파이낸셜서비스와 함께 제공합니다.
                        </p>
                    </li>
                </ul>
            </div>
        </section>
    </c:if>
    <section class="section section-showroom">
        <div class="inner">
            <h2>전시장 안내</h2>
            <div class="item">
                <div class="info">
                    <span><em>Volkswagen Approved</em> 폭스바겐 인증 중고차</span>
                    <strong>${result.branchVo.branch.type}<br/>${result.branchVo.branch.storeNm}</strong>
                    <ul>
                        <li class="icon icon-location">${result.branchVo.branch.detailAddr}</li>
                        <li class="icon icon-tel">${result.branchVo.branch.tel}</li>
                    </ul>
                </div>
                <a href="http://map.naver.com/index.nhn?enc=utf8&level=2&lng=${result.branchVo.branch.xcoordinate}&lat=${result.branchVo.branch.ycoordinate}&pinTitle=${result.branchVo.branch.addr}" target="_blank">
                    <div class="map" id="map"></div>
                </a>
            </div>
        </div>
    </section>
    <section class="section section-sale">
        <div class="inner">
            <h2>추천매물</h2>
            <div class="list list-grid">
                <div class="inner">
                    <c:forEach items="${result.recommends}" var="info">
                        <article class="article">
                            <div class="box">
                                <a href="${pageContext.request.contextPath}/item/${info.sellCarSeq}">
                                    <c:if test="${info.certYn eq 'Y'}"><span class="label label-auth"><i class="icon icon-label-auth"></i><em class="hidden">공식인증</em></span></c:if>

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
                                            <c:if test="${info.monPayment > 0}"><span class="monthly-pay">(월 <fmt:formatNumber value="${info.monPayment}" pattern="#,###"/>만원 부터~)</span></c:if>
                                        </div>

										<span class="btn btn-like" title="좋아요" data-click="like(this, ${info.sellCarSeq})" data="${info.sellCarSeq}"><i class="icon icon-util-like"></i></span>

                                        <span class="meta">
                                            <span><em>연식</em><em>${info.fromYear}년</em></span>
                                            <span><em>주행거리</em><em><fmt:formatNumber value="${info.driveDist}" pattern="#,###" />km</em></span>
                                            <span><em>연료</em><em>${info.fuel}</em></span>
                                            <span><em>변속기</em><em>${info.gear}</em></span>
                                            <span class="local"><em>지역</em><em>${info.sigun}</em></span>
                                            <span class="branch"><em>전시장위치</em><em>${info.type} ${info.storeNm}</em></span>
                                        </span>
                                    </div>
                                </a>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- layer : share 공유하기-->
<div class="layer-wrap layer-share" id="share">
    <div class="layer layer-md layer-bg">
        <div class="layer-content">
            <div class="layer-header">
                <p class="layer-title">${result.info.mak} ${result.info.detailModel}</p>
                <span>${result.info.rating} ${result.info.detailRating}</span>
            </div>
            <div class="layer-body">
                <p>차량정보를 공유할 SNS를 선택해 주세요.</p>
                <ul class="list-sns">
                    <li class="facebook">
                        <a href="javascript:share('facebook')">
                            <span><i class="icon icon-sns-facebook"></i></span>
                            <strong>페이스북</strong>
                        </a>
                    </li>
                    <li class="twitter">
                        <a href="javascript:share('twitter')">
                            <span><i class="icon icon-sns-twitter"></i></span>
                            <strong>트위터</strong>
                        </a>
                    </li>
                    <li class="kakao">
                        <a href="javascript:share('kakao')">
                            <span><i class="icon icon-sns-kakaotalk"></i></span>
                            <strong>카카오톡</strong>
                        </a>
                    </li>
                    <li class="mail">
                        <a href="javascript:;" data-trigger="layer" data-target=".layer-mail" onclick="share('mail');">
                            <span><i class="icon icon-sns-mail"></i></span>
                            <strong>메일</strong>
                        </a>
                    </li>
                </ul>
                <div class="copy">
                    <p>※ 주소를 마우스 클릭하시면 클립보드로 복사하실 수 있습니다.</p>
                    <div class="url">
                        <a href="javascript:void(0)" onclick="$('#shareLayerCloseBtn').click();$('#btnCopy').click()">${shareUrl}</a>
                        <input type="hidden" name="shareUrl" id="shareUrl" class="btn-copy" value="${shareUrl}">
                        <button type="button" class="btn btn-deepdark btn-radius btn-copy" id="btnCopy" data-clipboard-action="copy" data-clipboard-target="#shareUrl"><em>URL 복사하기</em></button>
                        <%--<button type="button" class="btn btn-deepdark btn-radius btn-copy" id="btnCopy" onclick="urlCopy()"><em>URL 복사하기</em></button>--%>
                    </div>
                </div>
            </div>
        </div>
        <button type="button" class="btn btn-layer-close" data-trigger="layer-close" id="shareLayerCloseBtn"><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
    </div>
</div>
<!-- //layer : share 공유하기 -->

<!-- layer : sendMail 메일 보내기-->
<div class="layer-wrap layer-mail" id="sendMail">
    <div class="layer layer-md layer-bg">
        <div class="layer-content">
            <div class="layer-header">
                <p class="layer-title">메일 보내기</p>
            </div>
            <div class="layer-body">
                <form:form id="mailForm" onsubmit="return false;">
                    <fieldset>
                        <div class="tb-form tb-write">
                            <table summary="">
                                <colgroup>
                                    <col >
                                    <col width="80%">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th scope="row">이름<small class="require">*</small></th>
                                    <td>
                                        <span class="input-text"><input type="text" placeholder="받는분의 이름을 입력해주세요." id="mailUserNm" required /></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">이메일<small class="require">*</small></th>
                                    <td>
                                        <div class="multi-form email-form">
                                            <span class="input-text"><input type="text" id="mailId" required onkeyup="limitEmail(this)" /></span>
                                            <span class="split">@</span>
                                            <span class="input-text"><input type="text" id="mailDomain" required onkeyup="limitEmail(this)" /></span>
                                            <span class="default-select">
                                                <select name="" id="mailDomainCombo" onchange="$('#mailDomain').val(this.value)">
                                                    <option value="">직접입력</option>
                                                    <option value="naver.com">naver.com</option>
                                                    <option value="daum.net">daum.net</option>
                                                    <option value="gmail.com">gmail.com</option>
                                                    <option value="hotmail.com">hotmail.com</option>
                                                    <option value="nate.com">nate.com</option>
                                                </select>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="submit">
                            <p>※ 입력하신 정보는 이메일 전송 외의 목적으로 사용되지 않습니다.</p>
                            <button type="submit" class="btn btn-deepdark btn-radius" id="sendMailBtn" ><em>보내기</em></button>
                        </div>
                    </fieldset>
                </form:form>
            </div>
        </div>
        <button type="button" class="btn btn-layer-close" data-trigger="layer-close"><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
    </div>
</div>
<!-- //layer : sendMail 메일 보내기 -->


<!-- layer : 성능 점검표 상세보기 -->
<div class="layer-wrap layer-checklist" id="checklist">
    <div class="layer">
        <div class="layer-content">
            <div class="layer-header">
                <p class="layer-title">성능점검표 상세보기</p>
            </div>
            <div class="layer-body">
                <p>본 페이지는 중고자동차 성능ㆍ상태 점검 기록부의 모든 항목을 동일하게 적용하고 있으며, 항목 위치는 일부 변경되었습니다.</p>
                <p>해당 내용은 판매자가 직접 입력한 내용으로 모든 책임은 판매자에게 있습니다.</p>
                <div class="guide">
                    <p>중고차 성능 상태점검 기록부는?</p>
                    <ul>
                        <li>자동차 관리법 제 58조 1항, 같은법 시행규칙 제 120조 제 1항에 따라 개인이 아닌 판매자에게 중고차 구매 전 확인 및 요구할 수 있는 내용으로 차량 상태 뿐만 아니라 구매 후 보증까지 약속 받는 중요한 문서입니다.</li>
                        <li>성능상태점검기록부의 유효기간은 점검일로부터 120일 이내이어야 유효하므로, 날짜를 확인 하신뒤 유효기간이 지난 문서라면 반드시 재점검 후 교부를 요청하셔야 합니다.</li>
                        <li>최종 계약 시 점검자와 고지자의 서명날인(직인)이 있는 성능상태점검기록부의 교부를 확인하십시오.</li>
                        <li>점검내용 사항이 30일, 2,000킬로미터 이내인 경우 보증수리를 요구할 수 있습니다.</li>
                        <li>계약 시 보중수리 주체가 점검자와 고지자(판매자)인지 확실하지 않다면, 계약서 약관에 표기한 뒤 유효한 날인을 받으셔야 합니다.</li>
                    </ul>
                </div>
                <div class="info">
                    <span>제시번호</span>
                    <strong>${result.performance.suggNo} </strong>
                    <small>매매회원이 중요 정보(제시번호, 성능점검기록부, 조합/상사명) 미기재, 허위 기재시 <br>표시광고의 공정화에 관한 법률 (20조 제1항 제1호)에 의해 1억원 이하의 과태료가 부과될 수 있습니다.</small>
                </div>
                <div class="table table-responsive ">
                    <p class="table-title">중고자동차 성능 · 상태 검검기록부 제 ${result.performance.statRecNo}호 </p>
                    <table>
                        <colgroup>
                            <col style="width: 16%">
                            <col>
                            <col style="width: 16%">
                            <col>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>차명</th>
                            <td colspan="3" data-title="차명">${result.carInfo.model} ${result.carInfo.detailModel} ${result.carInfo.rating}</td>
                        </tr>
                        <tr>
                            <th>주행거리/계기상태</th>
                            <td data-title="주행거리/계기상태"><fmt:formatNumber value="${result.carInfo.driveDist}" pattern="#,###" />km</td>
                            <th>연식</th>
                            <td data-title="연식">${result.carInfo.fromYear}년</td>
                        </tr>
                        <tr>
                            <th>검사 유효기간</th>
                            <fmt:parseDate value="${result.performance.strDate}" var="strDate" pattern="yyyyMMdd"/><fmt:parseDate value="${result.performance.endDate}" var="endDate" pattern="yyyyMMdd"/>
                            <td data-title="검사 유효기간"><fmt:formatDate value="${strDate}" pattern="yyyy년 MM월 dd일"/> ~ <fmt:formatDate value="${endDate}" pattern="yyyy년 MM월 dd일"/></td>
                            <th>최초 등록일</th>
                            <fmt:parseDate value="${result.carInfo.prodYear}" var="prodDate" pattern="yyyyMM"/>
                            <fmt:formatDate value="${prodDate}" pattern="yyyy" var="pordYear"/><fmt:formatDate value="${prodDate}" pattern="MM" var="prodMonth"/>
                            <td data-title="최초 등록일">${pordYear}년 ${prodMonth}월 ${result.performance.day}일</td>
                        </tr>
                        <tr>
                            <th>원동기 형식</th>
                            <td data-title="원동기 형식">${result.performance.moterFrom}</td>
                            <th>변속기 종류</th>
                            <td data-title="변속기 종류">${result.carInfo.gear}</td>
                        </tr>
                        <tr>
                            <th>차대번호</th>
                            <td data-title="차대번호">${result.performance.chasNo}</td>
                            <th>보증유형</th>
                            <td data-title="보증유형">
                                <label for="radio1">
                                    <span class="radio">
                                        <input id="radio1" name="radio-group-1" type="radio" class="radio" <c:if test="${result.performance.warrCategory eq 'S'}">checked</c:if> disabled><i></i>
                                    </span>
                                    자가보증
                                </label>
                                <label for="radio2">
                                    <span class="radio">
                                        <input id="radio2" name="radio-group-1" type="radio" class="radio" <c:if test="${result.performance.warrCategory eq 'I'}">checked</c:if> disabled><i></i>
                                    </span>
                                    보험사보증
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>동일성확인<br>(차대번호 표기)</th>
                            <td data-title="동일성확인 (차대번호 표기)">${result.performance.sameConf}</td>
                            <th>불법구조 변경</th>
                            <td data-title="불법구조 변경">
                                <label for="radio3">
                                    <span class="radio">
                                        <input id="radio3" name="radio-group-2" type="radio" class="radio" <c:if test="${result.performance.illeStruUpdYn eq 'Y'}">checked</c:if> disabled><i></i>
                                    </span>
                                    유
                                </label>
                                <label for="radio4">
                                    <span class="radio">
                                        <input id="radio4" name="radio-group-2" type="radio" class="radio" <c:if test="${result.performance.illeStruUpdYn eq 'N'}">checked</c:if> disabled><i></i>
                                    </span>
                                    무
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>사고 유무<br>(단순수리 제외)</th>
                            <td data-title="사고 유무 (단순수리 제외)">
                                <label for="radio5">
                                    <span class="radio">
                                        <input id="radio5" name="radio-group-3" type="radio" class="radio" <c:if test="${result.performance.accidYn eq 'N'}">checked</c:if> disabled><i></i>
                                    </span>
                                    없음
                                </label>
                                <label for="radio6">
                                    <span class="radio">
                                        <input id="radio6" name="radio-group-3" type="radio" class="radio" <c:if test="${result.performance.accidYn eq 'Y'}">checked</c:if> disabled><i></i>
                                    </span>
                                    있음
                                </label>
                            </td>
                            <th>침수 유무</th>
                            <td data-title="침수 유무">
                                <label for="radio7">
                                    <span class="radio">
                                        <input id="radio7" name="radio-group-4" type="radio" class="radio" <c:if test="${result.performance.flodYn eq 'N'}">checked</c:if> disabled><i></i>
                                    </span>
                                    없음
                                </label>
                                <label for="radio8">
                                    <span class="radio">
                                        <input id="radio8" name="radio-group-4" type="radio" class="radio" <c:if test="${result.performance.flodYn eq 'Y'}">checked</c:if> disabled><i></i>
                                    </span>
                                    있음
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>자가진단사항</th>
                            <td data-title="자가진단사항">
                                <ul class="list-separate">
                                    <li>
                                        <strong>원동기</strong>
                                        <label for="radio9">
                                            <span class="radio">
                                                <input id="radio9" name="radio-group-5" type="radio" class="radio" <c:if test="${result.performance.moterDiagYn eq 'Y'}">checked</c:if> disabled><i></i>
                                            </span>
                                            양호
                                        </label>
                                        <label for="radio10">
                                            <span class="radio">
                                                <input id="radio10" name="radio-group-5" type="radio" class="radio" <c:if test="${result.performance.moterDiagYn eq 'N'}">checked</c:if> disabled><i></i>
                                            </span>
                                            정비요
                                        </label>
                                    </li>
                                    <li>
                                        <strong>변속기</strong>
                                        <label for="radio11">
                                            <span class="radio">
                                                <input id="radio11" name="radio-group-6" type="radio" class="radio" <c:if test="${result.performance.gearDiagYn eq 'Y'}">checked</c:if> disabled><i></i>
                                            </span>
                                            양호
                                        </label>
                                        <label for="radio12">
                                            <span class="radio">
                                                <input id="radio12" name="radio-group-6" type="radio" class="radio" <c:if test="${result.performance.gearDiagYn eq 'N'}">checked</c:if> disabled><i></i>
                                            </span>
                                            정비요
                                        </label>
                                    </li>
                                </ul>
                            </td>
                            <th>배출가스</th>
                            <td data-title="배출가스">
                                <ul class="list-separate">
                                    <li>
                                        <strong>일산화탄소(CO)</strong>
                                        <span>${result.performance.co}%</span>
                                    </li>
                                    <li>
                                        <strong>탄화수소(HC)</strong>
                                        <span>${result.performance.hc}ppm</span>
                                    </li>
                                    <li>
                                        <strong>매연</strong>
                                        <span>${result.performance.exh}%</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="table table-center table-responsive-status">
                    <p class="table-title">자동차의 상태표시</p>

                    <span class="mobile-car" data-title="외판 부위의 교환,부식,판금 및 용접수리">
                        <i><img src="${pageContext.request.contextPath}/resources/images/car_expansion_plan_front.gif" alt=""></i>
                    </span>
                    <table>
                        <colgroup>
                            <col style="width: 50%;">
                            <col>
                            <col style="width: 20%">
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>외판 부위의 교환,부식,판금 및 용접수리</th>
                            <th>번호</th>
                            <th>부위 명칭</th>
                            <th>교환(교체)</th>
                            <th>판금/용접</th>
                            <th>부식</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${result.coverPanel}" var="list" varStatus="status">
                            <tr>
                                <c:if test="${status.index == 0}">
                                    <td class="car" rowspan="14">
                                        <span data-title="외판 부위의 교환,부식,판금 및 용접수리">
                                            <i><img src="${pageContext.request.contextPath}/resources/images/car_expansion_plan_front.gif" alt=""></i>
                                        </span>
                                    </td>
                                </c:if>
                                <td>${list.no}</td>
                                <td class="text-left">${list.cdNm}</td>
                                <td>
                                    <span class="checkbox">
                                        <input type="checkbox" class="checkbox" <c:if test="${list.exch eq 'Y'}">checked</c:if> disabled><i></i>
                                    </span>
                                </td>
                                <td>
                                    <span class="checkbox">
                                        <input type="checkbox" class="checkbox" <c:if test="${list.weld eq 'Y'}">checked</c:if> disabled><i></i>
                                    </span>
                                </td>
                                <td>
                                    <span class="checkbox">
                                        <input type="checkbox" class="checkbox" <c:if test="${list.corr eq 'Y'}">checked</c:if> disabled><i></i>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="table table-center table-responsive-status">
                    <span class="mobile-car" data-title="주요골격 부위의 교환, 부식, 판금 및 용접수리">
                        <i><img src="${pageContext.request.contextPath}/resources/images/car_expansion_plan_back.gif" alt=""></i>
                    </span>
                    <table>
                        <colgroup>
                            <col style="width: 50%">
                            <col>
                            <col style="width: 20%">
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>주요골격 부위의 교환, 부식, 판금 및 용접수리</th>
                            <th>번호</th>
                            <th>부위 명칭</th>
                            <th>교환(교체)</th>
                            <th>판금/용접</th>
                            <th>부식</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${result.majorFrame}" var="list" varStatus="status">
                            <tr>
                                <c:if test="${status.index == 0}">
                                    <td class="car" rowspan="23">
                                        <span data-title="주요골격 부위의 교환, 부식, 판금 및 용접수리">
                                            <i><img src="${pageContext.request.contextPath}/resources/images/car_expansion_plan_back.gif" alt=""></i>
                                        </span>
                                    </td>
                                </c:if>
                                <td>${list.no}</td>
                                <td class="text-left">${list.cdNm}</td>
                                <td>
                                    <span class="checkbox">
                                        <input type="checkbox" class="checkbox" <c:if test="${list.exch eq 'Y'}">checked</c:if> disabled><i></i>
                                    </span>
                                </td>
                                <td>
                                    <span class="checkbox">
                                        <input type="checkbox" class="checkbox" <c:if test="${list.weld eq 'Y'}">checked</c:if> disabled><i></i>
                                    </span>
                                </td>
                                <td>
                                    <span class="checkbox">
                                        <input type="checkbox" class="checkbox" <c:if test="${list.corr eq 'Y'}">checked</c:if> disabled><i></i>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="table table-responsive-device">
                    <p class="table-title">주요장치</p>

                    <table id="device-list">
                        <colgroup>
                            <col>
                            <col>
                            <col>
                            <col style="width: 50%;">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>주요장치</th>
                            <th>항목</th>
                            <th>해당부품</th>
                            <th>상태</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="item in item" :data-title="item.device">
                            <th class="device"><span>{{item.device}}</span></th>
                            <th :colspan="item.part ? '' : '2'">{{item.item}}</th>
                            <th v-if="item.part">{{item.part}}</th>
                            <td>
                                <label v-for="radio in item.state" for="">
                                    <span class="radio">
                                        <input id=""  type="radio" class="radio" :name="item.cd" :value="radio.value" :checked="radio.checked" disabled><i></i>
                                    </span>
                                    {{radio.text}}
                                </label>
                            </td>
                        </tr>
                        </tbody>
                        <tfoot>
                        <tr v-for="item in item">
                            <th colspan="3">{{item.device}}</th>
                            <td>
                                {{item.opinion}}
                            </td>
                        </tr>
                        </tfoot>
                    </table>

                </div>

                <div class="authentication">
                    <div class="notice">
                        <p>자동차관리법」 제58조 제1항 및 같은법 시행규칙 제120조 제1항에 따라 <br>중고자동차의 성능 · 상태를 점검하였음을 확인합니다.</p>
                    </div>
                    <span class="date">${result.performance.statConfYear}년 ${result.performance.statConfMonth}월 ${result.performance.statConfDay}일</span>
                    <div class="table">
                        <table>
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <tbody>
                            <tr>
                                <td>중고자동차 성능 · 상태 점검자</td>
                                <td>
                                    <strong>${result.performance.statConfUser}</strong>
                                    <span>(인)</span>
                                </td>
                            </tr>
                            <tr>
                                <td>중고자동차 성능 · 상태 고지자</td>
                                <td>
                                    <strong>${result.performance.statNotfUser}</strong>
                                    <span>(인)</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <button type="button" class="btn btn-layer-close" data-trigger="layer-close" onclick="layerClose('layer-checklist')"><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
    </div>
    <i class="dim" data-trigger="layer-close"></i>
</div>
<!-- //layer : 성능 점검표 상세보기 -->

<!-- layer : qnaBuycar 문의하기 -->
<div class="layer-wrap layer-qna" id="qnaBuycar">
    <div class="layer">
        <div class="layer-content">
            <div class="layer-header">
                <p class="layer-title">문의하기</p>
            </div>
            <div class="layer-body">
                <section class="section section-process">
                    <div class="inner">
                        <p class="txt">현재 보고있는 차량의 상세한 정보를 원하시면 <br>지금 바로 문의해보세요.</p>
                        <ul>
                            <li class="active">
                                <em class="step">STEP 1</em>
                                <div><i class="icon icon-round-mail"></i></div>
                                <strong>메일전송</strong>
                            </li>
                            <li>
                                <em class="step">STEP 2</em>
                                <div><i class="icon icon-round-counseling"></i></div>
                                <strong>판매자 상담</strong>
                            </li>
                        </ul>
                    </div>
                </section>
                <section class="section section-form">
                    <form:form id="qnaForm" onsubmit="return false;">
                    <div class="inner">
                        <fieldset>
                            <legend>신청서 작성</legend>
                            <strong class="warning-msg"><small class="require">*</small>필수항목을 모두 입력해주세요.</strong>
                            <div class="tb-form tb-write">
                                <table summary="">
                                    <colgroup>
                                        <col >
                                        <col width="80%">
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th scope="row">이름<small class="require">*</small></th>
                                        <td>
                                            <div class="name-form">
                                                <span class="input-text"><input type="text" id="qnamailUserNm" required placeholder="상담하실 고객님 이름을 입력하세요." /></span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">이메일<small class="require">*</small></th>
                                        <td>
                                            <div class="multi-form email-form">
                                                <span class="input-text"><input type="text" id="qnamailId" required onkeyup="limitEmail(this)"/></span>
                                                <span class="split">@</span>
                                                <span class="input-text"><input type="text" id="qnamailDomain" required onkeyup="limitEmail(this)"/></span>
                                                <span class="default-select">
                                                    <select name="" id="qnamailDomainCombo" onchange="$('#qnamailDomain').val(this.value)">
                                                        <option value="">직접입력</option>
                                                        <option value="naver.com">naver.com</option>
                                                        <option value="daum.net">daum.net</option>
                                                        <option value="gmail.com">gmail.com</option>
                                                        <option value="hotmail.com">hotmail.com</option>
                                                        <option value="nate.com">nate.com</option>
                                                    </select>
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="vertical-top">추가내용</th>
                                        <td>
                                            <span class="input-text size-full">
                                                <textarea name="" id="qnamailContents" cols="5" rows="5" placeholder="추가 내용을 입력하세요.&#13;&#10;추가 정보를 입력하시면 빠른 상담을 받으실 수 있습니다."></textarea>
                                            </span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="terms">
                                    <p class="tit">
                                        <span class="checkbox">
                                            <input type="checkbox" class="checkbox" id="allCheck"><i></i>
                                        </span>
                                        <label for="allCheck"><em>약관 전체 동의</em></label>
                                    </p>
                                    <div class="contents">
                                        <div class="item">
                                            <p class="tit">
                                                <span class="checkbox">
                                                    <input type="checkbox" class="checkbox" name="agree1" value="Y" id="agree1"><i></i>
                                                </span>
                                                <label for="agree1"><em>(필수) 개인정보 수집 및 이용 동의</em></label>
                                                <button type="button" class="btn btn-accordion">열기</button>
                                            </p>
                                            <div class="con">
                                                <div>
                                                    <ol>
                                                        <li>
                                                            <strong>1.  개인정보 수집·이용 목적</strong>
                                                            <p> - 고객의 중고차 문의에 대한 상담 및 기타 판매 및 구매 관련 정보 제공 등 </p>
                                                        </li>
                                                        <li>
                                                            <strong>2. 항목</strong>
                                                            <p> - 성명/ 휴대전화번호/ 이메일/ 관심모델</p>
                                                        </li>
                                                        <li>
                                                            <strong>3. 보유·이용기간</strong>
                                                            <p> - 수집 · 이용 목적 달성시까지</p>
                                                        </li>
                                                    </ol>
                                                    <small>※ 귀하는 위 사항에 대하여 동의를 하지 않을 수 있으나, 위 정보는 기재된 서비스 제공을 위해서 필요한 최소한의 개인정보이므로 동의를 해 주셔야 위 수집 및 이용목적에 기재된 서비스를 이용하실 수 있습니다.</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="item">
                                            <p class="tit">
                                                <span class="checkbox">
                                                    <input type="checkbox" class="checkbox" name="agree2" value="Y" id="agree2"><i></i>
                                                </span>
                                                <label for="agree2"><em>(필수) 개인정보 처리 위탁</em></label>
                                                <button type="button" class="btn btn-accordion">열기</button>
                                            </p>
                                            <div class="con">
                                                <div>
                                                    <ol>
                                                        <li>
                                                            <strong>1.  수탁 업체</strong>
                                                            <p> - 아우디 폭스바겐 코리아 주식회사 </p>
                                                        </li>
                                                        <li>
                                                            <strong>2. 항목</strong>
                                                            <p> - Volkswagen Approved 를 통하여 개인정보 수집 업무 및 인증 딜러사 전송</p>
                                                        </li>
                                                    </ol>
                                                    <small>※ 귀하는 위 사항에 대하여 동의를 하지 않을 수 있으나, 동의를 거부하시는 경우 위탁 업무 내용에 나열된 각종 서비스의 제공이 제한될 수 있습니다.</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="item">
                                            <p class="tit">
                                                <span class="checkbox">
                                                    <input type="checkbox" class="checkbox" name="agree3" value="Y" id="agree3"><i></i>
                                                </span>
                                                <label for="agree3"><em>(선택) 개인정보 수집 및 이용 동의</em></label>
                                                <button type="button" class="btn btn-accordion">열기</button>
                                            </p>
                                            <div class="con">
                                                <div>
                                                    <ol>
                                                        <li>
                                                            <strong>1.  개인정보 수집·이용 목적</strong>
                                                            <p> - 광고 등 홍보 및 마케팅 활용 </p>
                                                        </li>
                                                        <li>
                                                            <strong>2. 항목</strong>
                                                            <p> - 성명 / 휴대전화 번호 / 이메일 / 관심모델 / 선택 딜러사</p>
                                                        </li>
                                                        <li>
                                                            <strong>3. 보유·이용기간</strong>
                                                            <p> - 상담 신청 후 3년 </p>
                                                        </li>
                                                    </ol>
                                                    <small>※ 귀하는 위 사항에 대하여 동의를 하지 않을 수 있으나, 동의를 거부하시는 경우 제공 목적에 나열된 각종 서비스의 제공이 제한될 수 있습니다.</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="btns">
                                <button type="button" class="btn large-btn btn-dark btn-radius btn-refresh" onclick="$('#qnaForm')[0].reset();"><i class="icon icon-util-refresh"></i><em>초기화</em></button>
                                <button type="submit" class="btn large-btn btn-primary btn-radius"><em>문의하기</em></button>
                            </div>
                        </fieldset>
                    </div>
                    </form:form>
                </section>
            </div>
        </div>
        <button type="button" class="btn btn-layer-close" data-trigger="layer-close"><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
    </div>

</div>
<!-- //layer : qnaBuycar 문의하기 -->

<!-- layer : 88가지 품질점검표 -->
<div class="layer-wrap layer-multi-checklist" id="multi-checklist">
    <div class="layer">
        <div class="layer-content">
            <div class="layer-header">
                <p class="layer-title">88가지 품질점검표</p>
            </div>
            <div class="layer-body">
                <!-- 차량정보 -->
                <div class="item">
                    <p class="item-title">차량정보</p>
                    <div class="check-basic-info">
                        <ul>
                            <li>
                                <span>차량 모델</span>
                                <strong>${result.carInfo.model} ${result.carInfo.detailModel} ${result.carInfo.rating}</strong>
                            </li>
                            <li>
                                <span>차량 색상</span>
                                <strong>${result.carInfo.color}</strong>
                            </li>
                            <li>
                                <span>차대 번호</span>
                                <strong>${result.priceInfo.chasNo}</strong>
                            </li>
                        </ul>
                        <ul>
                            <li>
                                <span>사고 유무</span>
                                <strong>${result.priceInfo.accidHisNm}</strong>
                            </li>
                            <li>
                                <span>주행 거리</span>
                                <strong><fmt:formatNumber value="${result.carInfo.driveDist}" pattern="#,###"/></strong>
                            </li>
                            <li>
                                <span>등록일</span>
                                <fmt:parseDate value="${result.carInfo.prodYear}" var="prodDate" pattern="yyyyMM"/>
                                <strong><fmt:formatDate value="${prodDate}" pattern="yyyy년 MM 월"/></strong>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- 기본점검 -->
                <div class="table table-checklist">
                    <table>
                        <colgroup>
                            <col style="width:5%">
                            <col style="width:45%">
                            <col style="width:20%">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th class="question" colspan="2">기본 점검</th>
                            <th class="answer">
                                <span class="one-third">정상</span>
                                <span class="one-third">이상</span>
                                <span class="one-third">수리</span>
                            </th>
                            <th class="note">수리/교환 내역</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${result.quality1}" var="quality1">
                            <tr>
                                <td class="number">${quality1.no}</td>
                                <td class="question">${quality1.cdNm}</td>
                                <td class="answer">
                                    <div class="inner">
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality1.cd}" type="radio" class="radio" title="정상" <c:if test="${quality1.confYn eq 'Y'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality1.cd}" type="radio" class="radio" title="이상" <c:if test="${quality1.confYn eq 'N'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality1.cd}" type="radio" class="radio" title="수리" <c:if test="${quality1.confYn eq 'T'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                    </div>
                                </td>
                                <td class="note">${quality1.repairCtnt}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <table>
                        <colgroup>
                            <col style="width:5%">
                            <col style="width:45%">
                            <col style="width:20%">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th class="question" colspan="2">실내 운전석에서 점검</th>
                            <th class="answer">
                                <span class="one-third">정상</span>
                                <span class="one-third">이상</span>
                                <span class="one-third">수리</span>
                            </th>
                            <th class="note">수리/교환 내역</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${result.quality2}" var="quality2">
                            <tr>
                                <td class="number">${quality2.no}</td>
                                <td class="question">${quality2.cdNm}</td>
                                <td class="answer">
                                    <div class="inner">
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality2.cd}" type="radio" class="radio" title="정상" <c:if test="${quality2.confYn eq 'Y'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality2.cd}" type="radio" class="radio" title="이상" <c:if test="${quality2.confYn eq 'N'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality2.cd}" type="radio" class="radio" title="수리" <c:if test="${quality2.confYn eq 'T'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                    </div>
                                </td>
                                <td class="note">${quality2.repairCtnt}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <table>
                        <colgroup>
                            <col style="width:5%">
                            <col style="width:45%">
                            <col style="width:20%">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th class="question" colspan="2">진단기 점검</th>
                            <th class="answer">
                                <span class="one-third">정상</span>
                                <span class="one-third">이상</span>
                                <span class="one-third">수리</span>
                            </th>
                            <th class="note">수리/교환 내역</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${result.quality3}" var="quality3">
                            <tr>
                                <td class="number">${quality3.no}</td>
                                <td class="question">${quality3.cdNm}</td>
                                <td class="answer">
                                    <div class="inner">
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality3.cd}" type="radio" class="radio" title="정상" <c:if test="${quality3.confYn eq 'Y'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality3.cd}" type="radio" class="radio" title="이상" <c:if test="${quality3.confYn eq 'N'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality3.cd}" type="radio" class="radio" title="수리" <c:if test="${quality3.confYn eq 'T'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                    </div>
                                </td>
                                <td class="note">${quality3.repairCtnt}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <table>
                        <colgroup>
                            <col style="width:5%">
                            <col style="width:45%">
                            <col style="width:20%">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th class="question" colspan="2">등화류 점검</th>
                            <th class="answer">
                                <span class="one-third">정상</span>
                                <span class="one-third">이상</span>
                                <span class="one-third">수리</span>
                            </th>
                            <th class="note">수리/교환 내역</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${result.quality4}" var="quality4">
                            <tr>
                                <td class="number">${quality4.no}</td>
                                <td class="question">${quality4.cdNm}</td>
                                <td class="answer">
                                    <div class="inner">
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality4.cd}" type="radio" class="radio" title="정상" <c:if test="${quality4.confYn eq 'Y'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality4.cd}" type="radio" class="radio" title="이상" <c:if test="${quality4.confYn eq 'N'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality4.cd}" type="radio" class="radio" title="수리" <c:if test="${quality4.confYn eq 'T'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                    </div>
                                </td>
                                <td class="note">${quality4.repairCtnt}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <table>
                        <colgroup>
                            <col style="width:5%">
                            <col style="width:45%">
                            <col style="width:20%">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th class="question" colspan="2">차량 전방 및 엔진룸 점검</th>
                            <th class="answer">
                                <span class="one-third">정상</span>
                                <span class="one-third">이상</span>
                                <span class="one-third">수리</span>
                            </th>
                            <th class="note">수리/교환 내역</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${result.quality5}" var="quality5">
                            <tr>
                                <td class="number">${quality5.no}</td>
                                <td class="question">${quality5.cdNm}</td>
                                <td class="answer">
                                    <div class="inner">
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality5.cd}" type="radio" class="radio" title="정상" <c:if test="${quality5.confYn eq 'Y'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality5.cd}" type="radio" class="radio" title="이상" <c:if test="${quality5.confYn eq 'N'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality5.cd}" type="radio" class="radio" title="수리" <c:if test="${quality5.confYn eq 'T'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                    </div>
                                </td>
                                <td class="note">${quality5.repairCtnt}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <table>
                        <colgroup>
                            <col style="width:5%">
                            <col style="width:45%">
                            <col style="width:20%">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th class="question" colspan="2">소모품 점검</th>
                            <th class="answer">
                                <span class="one-third">정상</span>
                                <span class="one-third">이상</span>
                                <span class="one-third">수리</span>
                            </th>
                            <th class="note">수리/교환 내역</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${result.quality6}" var="quality6">
                            <tr>
                                <td class="number">${quality6.no}</td>
                                <td class="question">${quality6.cdNm}</td>
                                <td class="answer">
                                    <div class="inner">
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality6.cd}" type="radio" class="radio" title="정상" <c:if test="${quality6.confYn eq 'Y'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality6.cd}" type="radio" class="radio" title="이상" <c:if test="${quality6.confYn eq 'N'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality6.cd}" type="radio" class="radio" title="수리" <c:if test="${quality6.confYn eq 'T'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                    </div>
                                </td>
                                <td class="note">${quality6.repairCtnt}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <table>
                        <colgroup>
                            <col style="width:5%">
                            <col style="width:45%">
                            <col style="width:20%">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th class="question" colspan="2">시운전 점검</th>
                            <th class="answer">
                                <span class="one-third">정상</span>
                                <span class="one-third">이상</span>
                                <span class="one-third">수리</span>
                            </th>
                            <th class="note">수리/교환 내역</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${result.quality7}" var="quality7">
                            <tr>
                                <td class="number">${quality7.no}</td>
                                <td class="question">${quality7.cdNm}</td>
                                <td class="answer">
                                    <div class="inner">
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality7.cd}" type="radio" class="radio" title="정상" <c:if test="${quality7.confYn eq 'Y'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality7.cd}" type="radio" class="radio" title="이상" <c:if test="${quality7.confYn eq 'N'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality7.cd}" type="radio" class="radio" title="수리" <c:if test="${quality7.confYn eq 'T'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                    </div>
                                </td>
                                <td class="note">${quality7.repairCtnt}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <table>
                        <colgroup>
                            <col style="width:5%">
                            <col style="width:45%">
                            <col style="width:20%">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th class="question" colspan="2">베이/리프팅 점검</th>
                            <th class="answer">
                                <span class="one-third">정상</span>
                                <span class="one-third">이상</span>
                                <span class="one-third">수리</span>
                            </th>
                            <th class="note">수리/교환 내역</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${result.quality8}" var="quality8">
                            <tr>
                                <td class="number">${quality8.no}</td>
                                <td class="question">${quality8.cdNm}</td>
                                <td class="answer">
                                    <div class="inner">
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality8.cd}" type="radio" class="radio" title="정상" <c:if test="${quality8.confYn eq 'Y'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality8.cd}" type="radio" class="radio" title="이상" <c:if test="${quality8.confYn eq 'N'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                        <span class="one-third">
                                            <label for="">
                                                <span class="radio">
                                                    <input name="${quality8.cd}" type="radio" class="radio" title="수리" <c:if test="${quality8.confYn eq 'T'}">checked</c:if> disabled><i></i>
                                                </span>
                                            </label>
                                        </span>
                                    </div>
                                </td>
                                <td class="note">${quality8.repairCtnt}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="table">
                    <table>
                        <colgroup>
                            <col style="width:33.33%">
                            <col style="width:33.33%">
                            <col>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>테크니션</th>
                            <fmt:parseDate value="${result.priceInfo.techDate}" var="techDate" pattern="yyyyMMdd"/>
                            <td><fmt:formatDate value="${techDate}" pattern="yyyy-MM-dd"/></td>
                            <td class="sign"><em>${result.priceInfo.techNm}</em>(인)</td>
                        </tr>
                        <tr>
                            <th>서비스 어드바이저</th>
                            <fmt:parseDate value="${result.priceInfo.svcAdvDate}" var="svcAdvDate" pattern="yyyyMMdd"/>
                            <td><fmt:formatDate value="${svcAdvDate}" pattern="yyyy-MM-dd"/></td>
                            <td class="sign"><em>${result.priceInfo.svcAdvNm}</em>(인)</td>
                        </tr>
                        <tr>
                            <th>서비스 매니저</th>
                            <fmt:parseDate value="${result.priceInfo.svcMngDate}" var="svcMngDate" pattern="yyyyMMdd"/>
                            <td><fmt:formatDate value="${svcMngDate}" pattern="yyyy-MM-dd"/></td>
                            <td class="sign"><em>${result.priceInfo.svcMngNm}</em>(인)</td>
                        </tr>
                        <tr>
                            <th>인증 중고차 매니저</th>
                            <fmt:parseDate value="${result.priceInfo.authCarDate}" var="authCarDate" pattern="yyyyMMdd"/>
                            <td><fmt:formatDate value="${authCarDate}" pattern="yyyy-MM-dd"/></td>
                            <td class="sign"><em>${result.priceInfo.authCarNm}</em>(인)</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
        <button type="button" class="btn btn-layer-close" data-trigger="layer-close" ><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
    </div>

</div>
<!-- //layer : 88가지 품질점검표 -->



<script src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=_CIb0q_tmMChA4LbjUNp"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">

    $(document).ready(function() {

        // 최근 본 차량 정보 저장
        localStorageSet('recent', ${sellCarSeq});

        // 좋아요 버튼 제어
        likeEvent();

        // 약관 동의 체크박스 전체 선택/해제 (빠른 문의 layer 에서 이벤트 처리)
        $('#allCheck').click(function () {
            if ( $('#allCheck').is(':checked')) {
                $(':checkbox[id="agree1"]').prop('checked', true);
                $(':checkbox[id="agree2"]').prop('checked', true);
                $(':checkbox[id="agree3"]').prop('checked', true);
            } else {
                $(':checkbox[id="agree1"]').prop('checked', false);
                $(':checkbox[id="agree2"]').prop('checked', false);
                $(':checkbox[id="agree3"]').prop('checked', false);
            }
        })
        //약관동의 체크박스 모두 체크됐을 시 전체동의 체크박스 체크처리
        $('#agree1, #agree2, #agree3').click(function () {
            if($('#agree1').is(':checked') && $('#agree2').is(':checked') && $('#agree3').is(':checked')) {
                $('#allCheck').prop('checked', true);
            } else {
                $('#allCheck').prop('checked', false);
            }
        });

        var clipboard = new ClipboardJS('#btnCopy', {
            text: function(trigger) {
                var clipText = $("#shareUrl").val();
                if ( clipText == null || clipText == "" ) clipText = " ";
                return clipText;
            }
        });
        clipboard.on('success', function(e) {
            vwa.shareHistorySend('url');
            $('#shareLayerCloseBtn').click();
            toast('URL 복사가 완료되었습니다.');
        });
        clipboard.on('error', function(e) {
            toast('URL 복사가 실패되었습니다.');
        });

        Kakao.init('${kakaoClientId}');
    });

    (function() {

        // 전시장 지도 이미지 표시
        var mapApiUrl = 'https://openapi.naver.com/v1/map/staticmap.bin',
            imageMap = {
                clientId:'${result.branchVo.clientId}',
                url:'${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}',
                crs:'EPSG:4326',
                center:'${result.branchVo.branch.xcoordinate},${result.branchVo.branch.ycoordinate}',
                markers:'${result.branchVo.branch.xcoordinate},${result.branchVo.branch.ycoordinate}',
                level:11,
                w:750,
                h:310,
                baselayer:'default',
                format:'png'
            };

        $('#map').append('<img src="${pageContext.request.contextPath}/proxy/image?url='+ encodeURIComponent(mapApiUrl + '?' + jQuery.param(imageMap)) +'" alt="">');
        //$('#map').append('<img src="'+ mapApiUrl + '?' + $.param(imageMap) +'" alt="">');

        var $html = $('html');

        function createPrintContent(options) {
            var $printArea = $('.page-car-detail'),
                $printHtml = $printArea.html(),
                $printLayer = $($.utils.layerTemplate()).appendTo($printArea).addClass('layer-print');

            $html.addClass('create-print-image');

            $printLayer.find('.layer-body').html($printHtml);
            $printLayer.layer();

            if(options && options.init) {
                options.init($printLayer);
            }

            if(options && options.before) {
                options.before();
            }

            setTimeout(function() {
                html2canvas(document.querySelector('.layer-print .layer'), {
                    useCORS: true,
                    logging: false,
                    //foreignObjectRendering: true,
                    //async: false,
                    //allowTaint: true,
                }).then(function(canvas) {
                    canvas.setAttribute('id', 'print-image');
                    document.body.appendChild(canvas);
                    $html.addClass('has-print').removeClass('create-print-image');
                    //console.log(canvas.toDataURL('image/jpeg', 1.0));
                    if(options && options.after) {
                        options.after(canvas);
                    }
                });
            }, 10);

            $printLayer.on('layer.close', function() {
                $printLayer.remove();
                $('#print-image').remove();
                $html.removeClass('create-print-image').removeClass('has-print');
            });
        }

        // 프린트
        $('.icon-util-print').on('click', function() {
            createPrintContent({
                init: function(layer) {
                    layer.on('layer.close', function() {
                        $html.removeClass('layer-type-print');
                    }).find('.icon-util-print').on('click', function() {
                        window.print();
                    });
                },
                before: function() {
                    $html.addClass('layer-type-print');
                }
            });
        });

        // 다운로드
        $('.icon-util-download').on('click', function() {
            if(confirm('파일을 다운로드 하시겠습니까?')) {
                createPrintContent({
                    before: function() {
                        //vwa.showLoading();
                        $html.addClass('layer-type-download');
                    },
                    after: function(image) {
                        //vwa.hideLoading();
                        $html.removeClass('layer-type-download');
                        // file name
                        download(image.toDataURL('image/png', 1.0), 'Volkswagen Approved_${result.info.carSellNo}.png', 'image/png');
                    }
                });
            }
        });

        // 이미지 확대 보기
        var $imageLists = $('.section-image-list a');
        function sliderPaging(e, slick) {
            $('.layer-images .paging').html('<em>'+ (slick.currentSlide + 1) +'</em> / <span>'+ slick.slideCount +'</span>');
        }
        function imageViewer(e) {
            e.preventDefault();

            var $imageArea = $('.page-car-detail'),
                $imageLayer = $($.utils.layerTemplate()).appendTo($imageArea).addClass('layer-images'),
                $layerBody = $imageLayer.find('.layer-content'),
                $slierHtml = '<div class="image-viewer">',
                _index = $(this).parent().index();

            $imageLists.each(function() {
                $slierHtml += '<div><img src="'+ this.href +'" alt=""></div>';
            });

            $slierHtml += '</div>';
            $slierHtml += '<div class="paging"></div>';

            $layerBody.html($slierHtml);

            $imageLayer.on('layer.open', function() {
            });

            setTimeout(function() {
                $layerBody.find('.image-viewer')
                    .on('init', sliderPaging)
                    .on('afterChange', sliderPaging)
                    .slick().slick('slickGoTo', _index, true);
            }, 0);

            $imageLayer.layer();
        }
        $imageLists.on('click', imageViewer);

        // 상세 설명 열기/닫기
        $('.btn-explanation').on('click', function() {
            $('.explanation').slideToggle('3000', function() {
                $(this).toggleClass('active');
            });
            if($('.explanation').hasClass('active')){
                $('.btn-explanation em').text('상세 설명 열기');
            }else{
                $('.btn-explanation em').text('상세 설명 닫기');
            }
        });

        // 상세 옵션 열기/닫기
        $('.btn-option').on('click', function() {
            $('#detail-options-div').slideToggle('3000', function() {
                $(this).toggleClass('active');
            });
            if($('#detail-options-div').hasClass('active')){
                $('.btn-option em').text('상세 옵션 열기');
            }else{
                $('.btn-option em').text('상세 옵션 닫기');
            }
        });

        // 성능점검표 상세보기
        var device = [];
        var etcDevice = [];
        $.each(${result.jsonData}, function(key, val){
            if (val.cd == 'G1811') {
                etcDevice.push(val);
            } else {
                device.push(val);
            }
        });

        var deviceTable = new Vue({
            el: '#device-list tbody',
            data: {
                item: device
            },
            created: function() {
                setTimeout(function() {
                    $("#device-list").rowspanizer();
                });
            }
        });

        var deviceEtcTable = new Vue({
            el: '#device-list tfoot',
            data: {
                item: etcDevice
            },
            created: function() {
                setTimeout(function() {
                    $("#device-list").rowspanizer();
                });
            }
        });

        $('.detail-options .head').on('click', function() {
            $(this).closest('li').addClass('current').siblings().removeClass('current');
        });

        $(window).on('load', function() {
            $('[data-animate-width]').each(function() {
                $(this).css({
                   width: $(this).data('animate-width') + '%'
                });
            });
        });

        window.requestAniFrame = (function(callback) {
            return window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.oRequestAnimationFrame ||
            window.msRequestAnimationFrame ||
            function(callback) { window.setTimeout(callback, 1000 / 60); };
        })();

        var $checklist = $('.layer-checklist'),
            $stickys = $('.mobile-car i'),
            _stickyMap = null;

        function setSticky() {
            var sTop = $checklist.scrollTop();

            $.each(_stickyMap, function(index, position) {
                if(position.start <= sTop && position.end > sTop) {
                    $stickys.eq(index).addClass('sticky');
                } else {
                    $stickys.eq(index).removeClass('sticky');
                }
            });
            window.requestAniFrame(setSticky);
        }

        $checklist.on('layer.open', function() {
            _stickyMap = $stickys.map(function() {
                return {
                    start: $(this).offset().top - $(window).scrollTop(),
                    end: $(this).closest('.table').offset().top + $(this).closest('.table').outerHeight(true) - $(window).scrollTop()
                };
            });

            setSticky();
        });
    })();


    /** 좋아요 클릭 */
    function like(obj, sellCarSeq) {

        // 추천매물 부분
        if ($(obj).hasClass('btn-like')) {
            if ($(obj).children().hasClass('active')) {
                $(obj).children().removeClass('active');
                //window.localStorage.removeItem('like_'+sellCarSeq);
                localStorageRemove('like', sellCarSeq);
            } else {
                $(obj).children().addClass('active');
                //window.localStorage.setItem('like_'+sellCarSeq, sellCarSeq);
                localStorageSet('like', sellCarSeq);
            }
        } else {
            // 상단 부분
            if ($(obj).hasClass('active')) {
                $(obj).removeClass('active');
                //window.localStorage.removeItem('like_'+sellCarSeq);
                localStorageRemove('like', sellCarSeq);
            } else {
                $(obj).addClass('active');
                //window.localStorage.setItem('like_'+sellCarSeq, sellCarSeq);
                localStorageSet('like', sellCarSeq);
            }
        }

    }

    /** 좋아요 버튼 제어 */
    function likeEvent() {
        $.each(localStorageGet('like'), function(i, likeSeq){
            // 상단 좋아요
            $('.icon-util-line-like').each(function() {
                if (likeSeq == $(this).attr('data')) {
                    $(this).addClass('active');
                }
            });
            // 추천매물
            $('.btn-like').each(function() {
                if (likeSeq == $(this).attr('data')) {
                    $(this).children().addClass('active');
                }
            });
        });
    }

    // 공유하기
    function share(type) {
        if(type == 'facebook') {
            window.open(
                <%-- 'http://www.facebook.com/sharer/sharer.php?t=${result.info.mak} ${result.info.detailModel} ${result.info.rating} ${result.info.detailRating}&u=${shareUrl}', --%>
                'http://www.facebook.com/sharer/sharer.php?u=${shareUrl}',
                'sns-facebook',
                'width=600, height=260'
            );
            vwa.shareHistorySend(type);
        } else if(type == 'twitter') {
            window.open(
                'https://twitter.com/intent/tweet?text=${result.info.mak} ${result.info.detailModel} ${result.info.rating} ${result.info.detailRating}&url=${shareUrl}&image=${pageContext.request.scheme}://${result.info.fileUrl}',
                'sns-twitter',
                'width=600, height=260'
            );
            vwa.shareHistorySend(type);
        } else if(type == 'kakao') {
            Kakao.Link.sendScrap({
                requestUrl: '${shareUrl}'
            });
            vwa.shareHistorySend(type);
        } else if(type == 'mail') {
            $('.layer-share').data('layer').close();
        }
    }

    // 메일 보내기 (공유하기)
    $("#mailForm").validate({
        submitHandler: function(form){
            //error표시 삭제
            $("#mailForm").find("input").removeClass("form-error");

            $.ajax({
                url: "${pageContext.request.contextPath}/item/share/mail",
                type: "POST",
                data: {sellCarSeq: ${sellCarSeq}, mailUserNm: $('#mailUserNm').val(), mailAddr: $('#mailId').val() + '@' + $('#mailDomain').val()},
                success: function(result) {
                    $("#mailForm")[0].reset();
                    vwa.shareHistorySend('mail');
                    toast('메일을 성공적으로 전송했습니다.');
                    //layerClose('layer-mail');
                    $('.layer-mail').data('layer').close();
                }
            });
        }
    });

    // 레이어 Open
    function layerOpen(classNm) {
        $('.' + classNm).one('layer.close', function() {
            $(this).removeData('layer');
        }).layer();
    }

    // 레이어 Close
    function layerClose(classNm) {
        var $html = $('html');
        $html.removeClass('show-layer');
        $('.' + classNm).removeClass('active')
    }

    // 문의 메일 보내기
    $("#qnaForm").validate({
        submitHandler: function(form){
            //error표시 삭제
            $("#qnaForm").find("input").removeClass("form-error");

            if(!$("#agree1").prop("checked")){
                toast("개인정보 수집 및 이용 동의에 동의하세요.");
                return;
            }

            if(!$("#agree2").prop("checked")){
                toast("개인정보 처리 위탁에 동의하세요.");
                return;
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/item/qna/mail",
                type: "POST",
                data: {sellCarSeq: ${sellCarSeq}, mailUserNm: $('#qnamailUserNm').val(), mailAddr: $('#qnamailId').val() + '@' + $('#qnamailDomain').val(), mailContents: $('#qnamailContents').val(), agree1: $('#agree1').val(), agree2: $('#agree2').val(), agree3:$('#agree3').val() },
                success: function(result) {
                    $("#qnaForm")[0].reset();
                    toast('고객님의 문의사항이 접수되었습니다.<br/>답변은 입력하신 이메일로 전송됩니다.');
                    $('.layer-qna').data('layer').close();
                }
            });
        }
    });

    // url copy
    function urlCopy() {
        try {
            var copyText = document.getElementById("shareUrl");
            copyText.select();
            document.execCommand("Copy");
            vwa.shareHistorySend('url');
            $('#shareLayerCloseBtn').click();
            toast('URL 복사가 완료되었습니다.');
        } catch (e) {
            toast('URL 복사가 실패되었습니다.');
        }
    }

    function openFile(path) {
        window.open(path);
    }
</script>