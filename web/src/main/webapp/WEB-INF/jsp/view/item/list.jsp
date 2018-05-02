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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/10.0.0/bootstrap-slider.min.js"></script>

<main class="content-wrapper page-search">
    <section class="section section-search">
        <div class="inner">
            <div class="search-header">
                <h2>차량검색</h2>
                <button type="button" class="btn m-btn-extend" id="m-btn-extend"><i class="icon icon-car-search">상세 검색 열기</i></button>
                <button type="button" class="btn btn-layer-close"><i class="icon icon-layer-close">상세 검색 닫기</i></button>
            </div>
            <div class="search-bar">
                <fieldset>
                    <legend>모델명 검색</legend>
                    <div class="form">
                        <input type="search" id="search-bar" placeholder="모델을 검색하세요" onkeypress="limitByteStr(this)" limitByte="100"/>
                        <button type="button" class="btn btn-search" onclick="goSearch('Y')"><i class="icon icon-util-lens"></i><em class="hidden">검색</em></button>
                    </div>
                </fieldset>
            </div>
            <div class="search-wrap">
                <ul class="tab-auth">
                    <li<c:if test="${certYn eq 'ALL'}"> class="active"</c:if>><a href="javascript:void(0)" onclick="certSearch(this)">전체</a></li>
                    <li<c:if test="${certYn eq 'Y'}"> class="active"</c:if>><a href="javascript:void(0)" onclick="certSearch(this)">인증차</a></li>
                    <li<c:if test="${certYn eq 'N'}"> class="active"</c:if>><a href="javascript:void(0)" onclick="certSearch(this)">비인증차</a></li>
                </ul>
                <div class="select-wrap">
                    <fieldset>
                        <legend>차량 검색</legend>
                        <div class="form">
                            <select class="design-select reverse" data-title="CAR MAKE" id="making" onchange="selectModel(this.value)">
                                <option value="">제조사</option>
                                <option value="폭스바겐" <c:if test="${param.mak eq '폭스바겐'}">selected</c:if> >폭스바겐</option>
                                <c:forEach items="${maks}" var="maks">
                                    <option value="${maks.mak}" <c:if test="${param.mak eq maks.mak}">selected</c:if>>${maks.mak}</option>
                                </c:forEach>
                            </select>
                            <select class="design-select reverse" data-title="MODEL" id="model" onchange="selectDetailModel(this.value)">
                                <option value="">모델</option>
                                <c:forEach items="${models}" var="models">
                                    <option value="${models.model}" <c:if test="${param.model eq models.model}">selected</c:if>>${models.model}</option>
                                </c:forEach>
                            </select>
                            <select class="design-select reverse" data-title="DETAIL" id="detailModel" onchange="carSelectReset()">
                                <option value="">세부모델</option>
                                <c:forEach items="${detailModels}" var="detailModels">
                                    <option value="${detailModels.detailModel}" <c:if test="${param.detailModel eq detailModels.detailModel}">selected</c:if>>${detailModels.detailModel}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="btns">
                            <button type="button" class="btn btn-deepdark btn-radius btn-extend" id="btn-extend"><em>상세 검색 열기</em></button>
                        </div>
                    </fieldset>
                </div>
                <div class="search-category-wrap" style="">
                    <fieldset>
                        <legend>차량 상세 검색</legend>
                        <div class="form">
                            <form id="detailSearchForm">
                                <div>
                                    <div class="search-category onethird">
                                        <strong class="category-tit">가격</strong>
                                        <div class="finder-wrap">
                                            <div class="multi-form">
                                                <span class="input-text"><input type="text" min="0" value="" id="price-min" placeholder="0원" onkeyup="setSlider(this)" style="width: 100%"></span>
                                                <em class="split">~</em>
                                                <span class="input-text"><input type="text" min="0" value="" id="price-max" placeholder="1억원 이상" onkeyup="setSlider(this)" style="width: 100%"></span>
                                                <em class="unit">원</em>
                                            </div>
                                        </div>
                                        <div class="range-wrap">
                                            <input type="text" class="range-slider"
                                                   data-provide="slider"
                                                   data-slider-ticks="[0, 100000000]"
                                                   data-slider-ticks-labels='["0원", "1억원 이상"]'
                                                   data-slider-min="0"
                                                   data-slider-max="100000000"
                                                   data-slider-step="5000000"
                                                   data-slider-value="[1, 100000000]"
                                                   data-slider-tooltip="hide"
                                                   data-target-min="#price-min"
                                                   data-target-max="#price-max">
                                        </div>
                                    </div>
                                    <div class="search-category onethird">
                                        <strong class="category-tit">연식</strong>
                                        <div class="finder-wrap">
                                            <div class="multi-form">
                                                <span class="input-text"><input type="text" min="0" value="" id="year-min" placeholder="2008년 이하" onkeyup="setSlider(this)" style="width: 100%"></span>
                                                <em class="split">~</em>
                                                <span class="input-text"><input type="text" min="0" value="" id="year-max" placeholder="현재 연도" onkeyup="setSlider(this)" style="width: 100%"></span>
                                                <em class="unit">년</em>
                                            </div>
                                        </div>
                                        <div class="range-wrap">
                                            <input type="text" class="range-slider"
                                                   data-provide="slider"
                                                   data-slider-ticks="[2008, 2018]"
                                                   data-slider-ticks-labels='["2008년 이하", "현재 연도"]'
                                                   data-slider-min="2008"
                                                   data-slider-max="2018"
                                                   data-slider-value="[2008, 2018]"
                                                   data-slider-tooltip="hide"
                                                   data-target-min="#year-min"
                                                   data-target-max="#year-max">
                                        </div>
                                    </div>
                                    <div class="search-category onethird">
                                        <strong class="category-tit">주행거리</strong>
                                        <div class="finder-wrap margin">
                                            <div class="multi-form">
                                                <span class="input-text"><input type="text" min="0" value="" id="distance-min" placeholder="0km" onkeyup="setSlider(this)" style="width: 100%"></span>
                                                <em class="split">~</em>
                                                <span class="input-text"><input type="text" min="0" value="" id="distance-max" placeholder="15만km 이상" onkeyup="setSlider(this)" style="width: 100%"></span>
                                                <em class="unit">km</em>
                                            </div>
                                        </div>
                                        <div class="range-wrap">
                                            <input type="text" class="range-slider"
                                                   data-provide="slider"
                                                   data-slider-ticks="[0, 150000]"
                                                   data-slider-ticks-labels='["0km", "15만km 이상"]'
                                                   data-slider-min="0"
                                                   data-slider-max="150000"
                                                   data-slider-step="10000"
                                                   data-slider-value="[0, 150000]"
                                                   data-slider-tooltip="hide"
                                                   data-target-min="#distance-min"
                                                   data-target-max="#distance-max">
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="search-category">
                                        <strong class="category-tit">연료</strong>
                                        <div class="finder-wrap margin">
                                            <ul class="finder-list">
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="fuel-all" name="" />
                                                        <label for="fuel-all"><em>전체</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="fuel-1" name="fuelChk" class="select_chkbox" />
                                                        <label for="fuel-1"><em>가솔린</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="fuel-2" name="fuelChk" class="select_chkbox" />
                                                        <label for="fuel-2"><em>디젤</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="fuel-3" name="fuelChk" class="select_chkbox" />
                                                        <label for="fuel-3"><em>LPG</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="fuel-4" name="fuelChk" class="select_chkbox" />
                                                        <label for="fuel-4"><em>전기</em></label>
                                                    </span>
                                                </li>
                                                <!-- <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="fuel-5" name="" />
                                                        <label for="fuel-5"><em>LNG</em></label>
                                                    </span>
                                                </li> -->
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="fuel-6" name="fuelChk" class="select_chkbox" />
                                                        <label for="fuel-6"><em>기타</em></label>
                                                    </span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="search-category">
                                        <strong class="category-tit">차종</strong>
                                        <div class="finder-wrap margin">
                                            <ul class="finder-list">
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="cartype-all" name="" />
                                                        <label for="cartype-all"><em>전체</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="cartype-1" name="cartypeChk" class="select_chkbox" />
                                                        <label for="cartype-1"><em>경차</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="cartype-2" name="cartypeChk" class="select_chkbox" />
                                                        <label for="cartype-2"><em>소형차</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="cartype-3" name="cartypeChk" class="select_chkbox" />
                                                        <label for="cartype-3"><em>준중형차</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="cartype-4" name="cartypeChk" class="select_chkbox" />
                                                        <label for="cartype-4"><em>중형차</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="cartype-5" name="cartypeChk" class="select_chkbox" />
                                                        <label for="cartype-5"><em>대형차</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="cartype-6" name="cartypeChk" class="select_chkbox" />
                                                        <label for="cartype-6"><em>SUV/RV</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="cartype-7" name="cartypeChk" class="select_chkbox" />
                                                        <label for="cartype-7"><em>스포츠카</em></label>
                                                    </span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="search-category">
                                        <strong class="category-tit tit-color">색상계열</strong>
                                        <div class="finder-wrap margin">
                                            <ul class="finder-list finder-color">
                                                <li>
                                                    <button type="button" class="btn btn-all" id="color-all"><em>전체</em></button>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="color-1" name="colorChk" class="select_chkbox"/>
                                                        <label for="color-1" style="background-color:#000000;"><em class="hidden">검정색</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="color-2" name="colorChk" class="select_chkbox"/>
                                                        <label for="color-2" style="background-color:#5a5a5a;"><em class="hidden">진회색</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="color-3" name="colorChk" class="select_chkbox"/>
                                                        <label for="color-3" style="background-color:#cfd7d9;"><em class="hidden">은색</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="color-4" name="colorChk" class="select_chkbox"/>
                                                        <label for="color-4" class="reverse" style="background-color:#ffffff;"><em class="hidden">흰색</em></label><!-- 색이 밝을 시 class="reverse" -->
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="color-5" name="colorChk" class="select_chkbox"/>
                                                        <label for="color-5" style="background-color:#622500;"><em class="hidden">브라운</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="color-6" name="colorChk" class="select_chkbox"/>
                                                        <label for="color-6" style="background-color:#2374ac;"><em class="hidden">청색</em></label>
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="chkbox">
                                                        <input type="checkbox" id="color-7" name="colorChk" class="select_chkbox"/>
                                                        <label for="color-7" style="background-color:#c82e2e;"><em class="hidden">빨간색</em></label>
                                                    </span>
                                                </li>
                                                <!-- <li>
                                                    <button type="button" class="btn btn-more">
                                                        <i class="icon icon-util-more"></i>
                                                        <em class="hidden">더보기</em>
                                                    </button>
                                                </li> -->
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="btns">
                                        <button type="button" class="btn btn-dark btn-radius btn-refresh" onclick="goReset()"><i class="icon icon-util-refresh"></i><em>초기화</em></button>
                                        <button type="button" class="btn btn-primary btn-radius btn-search" id="searchButton" onclick="goSearch('Y')"><em>검색</em><i>(${result.infoTotCnt}건)</i></button>
                                    </div>
                                </div>
                                <div class="selected-list">
                                    <button type="button" class="btn sub-btn btn-bordered btn-rounded btn-selected-item" style="display: none;" ><em>LPG</em><i class="icon icon-util-x" onclick="removeSearchItem(this)"></i></button>
                                    <%--<button type="button" class="btn sub-btn btn-bordered btn-rounded btn-selected-item"><em>중형차</em><i class="icon icon-util-x"></i></button>--%>
                                </div>
                            </form>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
    </section>

    <section class="section section-list">
        <div class="inner">
            <div class="control">
                <span class="count">검색결과<strong>${result.infoTotCnt}</strong>대</span>
                <div class="sort">
                    <fieldset>
                        <legend>정렬</legend>
                        <div class="form">
                            <select class="design-select gray-select small-select" id="sigun" onchange="goSearch('Y')">
                                <option value="">지역전체</option>
                                <c:forEach items="${result.sigunList}" var="list">
                                    <option value="${list.sigun}">${list.sigun}</option>
                                </c:forEach>
                            </select>
                            <select class="design-select gray-select small-select" id="orderType" onchange="goSearch('Y')">
                                <option value="AA.CRE_DATE DESC">최근 등록일순</option>
                                <option value="CAST(AA.SELL_PRICE AS UNSIGNED) ASC">가격 낮은순</option>
                                <option value="AA.FROM_YEAR DESC">최근 연식순</option>
                                <option value="CAST(AA.DRIVE_DIST AS UNSIGNED) ASC">주행거리 낮은순</option>
                            </select>
                        </div>
                        <legend>보기</legend>
                        <div class="form switch">
                            <button type="button" id="grid" class="btn grid" title="그리드형 보기" onclick="viewType(this)"><i class="icon icon-view-grid active"></i><span class="hidden">그리드형 보기</span></button>
                            <button type="button" id="ahead" class="btn ahead" title="미리보기형 보기" onclick="viewType(this)"><i class="icon icon-view-ahead"></i><span class="hidden">미리보기형 보기</span></button>
                        </div>
                    </fieldset>
                </div>
            </div>
            <div id="contentHtml">
                <c:if test="${not empty result.info}">
                    <div class="list list-grid">
                        <div class="inner">
                            <c:forEach items="${result.info}" var="info">
                                <article class="article">
                                    <div class="box">
                                        <c:if test="${info.carStatCd ne 'D1004'}">
                                        <a href="${pageContext.request.contextPath}/item/${info.sellCarSeq}">
                                        </c:if>
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

												<span class="btn btn-like" title="좋아요" <c:if test="${info.carStatCd ne 'D1004'}">onclick="like(this, ${info.sellCarSeq}, event)" data="${info.sellCarSeq}"</c:if>><i class="icon icon-util-like"></i></span>

												<span class="meta">
                                                    <span><em>연식</em><em>${info.fromYear}년</em></span>
                                                    <span><em>주행거리</em><em><fmt:formatNumber value="${info.driveDist}" pattern="#,###" />km</em></span>
                                                    <span><em>연료</em><em>${info.fuel}</em></span>
                                                    <span><em>변속기</em><em>${info.gear}</em></span>
                                                    <span class="local"><em>지역</em><em>${info.sigun}</em></span>
                                                    <span class="branch"><em>전시장위치</em><em>${info.type} ${info.storeNm}</em></span>
                                                </span>
                                            </div>
                                         <c:if test="${info.carStatCd ne 'D1004'}">
                                        </a>
                                        </c:if>
                                    </div>
                                </article>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="btns" id="paging">
                        ${pageHtml}
                    </div>
                </c:if>
                <c:if test="${empty result.info}">
                    <!-- 검색 결과 없을 시 -->
                    <div class="no-result">
                        <div class="">
                            <i class="icon icon-list-empty"></i>
                            <p>검색 결과가 없습니다.</p>
                        </div>
                    </div>
                    <!-- //검색 결과 없을 시 -->
                </c:if>
            </div>
        </div>
    </section>
</main>


<script type="text/javascript">
    $('.range-slider').on('slide', function(e) {
        var _minId = $($(e.target).data('target-min')).attr('id').split('-')[0];
        var _maxId = $($(e.target).data('target-max')).attr('id').split('-')[0];

        if (_minId == 'price' || _maxId == 'price') {
            $($(e.target).data('target-min')).val(toCurrency(e.value[0]));
            $($(e.target).data('target-max')).val(toCurrency(e.value[1]));
        }
        if (_minId == 'year' || _maxId == 'year') {
            $($(e.target).data('target-min')).val(e.value[0]);
            $($(e.target).data('target-max')).val(e.value[1]);
        }
        if (_minId == 'distance' || _maxId == 'distance') {
            $($(e.target).data('target-min')).val(toCurrency(e.value[0]));
            $($(e.target).data('target-max')).val(toCurrency(e.value[1]));
        }
    });

    // 스크롤 멈췄을시
    $('.range-slider').on('slideStop', function(){
        goSearch();
    });

    $('#btn-extend, #m-btn-extend').on('click', function() {
        if($(window).width() > 846) {
            $('.search-category-wrap').slideToggle('3000', function() {
                $(this).toggleClass('active');
            });
            if($('.search-category-wrap').hasClass('active')){
                $('.btn-extend em').text('상세 검색 열기');
            }else{
                $('.btn-extend em').text('상세 검색 닫기');
            }
        }else{
            $('html').addClass('show-layer');
            $('.section-search').addClass('active');
            $('.search-category-wrap').addClass('active');
            $('.range-wrap').css({
                width: $('.range-wrap').parent().width()
            });
            $('.range-slider').parent().find('input').slider('relayout');
        }
    });

    $('.search-header .btn-layer-close').on('click', function() {
        $('html').removeClass('show-layer');
        $('.section-search').removeClass('active');
    });

    // F5눌렀을때 검색조건 초기화.
    $(document).on("keydown", function (event) {
        if (event.keyCode == 116) {
            history.pushState(null, 'VWA', '${pageContext.request.contextPath}/item/list');
        }
    });

    $(document).ready(function(e) {
        // 메인에서 접근시 상단검색 영역 Setting
        if ('${param.detailModel}' != '') {
            $('#detailModel').siblings('.selected').attr('data-title', '');
        }
        if ('${param.model}' != '') {
            $('#model').siblings('.selected').attr('data-title', '');
        }
        if ('${param.mak}' != '') {
            $('#making').siblings('.selected').attr('data-title', '');
            goSearch();
        }


       // 연료 전체 체크
       $('#fuel-all').click(function(){
           if ($('#fuel-all').prop('checked')) {
               $('input[name=fuelChk]').each(function() {
                   if (!$(this).prop('checked')) {
                       $(this).prop('checked', true).trigger('change');
                   }
               });
           } else {
               $('input[name=fuelChk]').prop('checked', false).trigger('change');
           }
           goSearch();
       });

        $('input[name=fuelChk]').change(function() {
            if ($('input[name=fuelChk]:checked').length == $('input[name=fuelChk]').length) {
                $('#fuel-all').prop('checked', true);
            } else {
                $('#fuel-all').prop('checked', false);
            }
        });


        // 차종 전체 체크
        $('#cartype-all').click(function(){
            if ($('#cartype-all').prop('checked')) {

                $('input[name=cartypeChk]').each(function() {
                   if (!$(this).prop('checked')) {
                       $(this).prop('checked', true).trigger('change');
                   }
                });
            } else {
                $('input[name=cartypeChk]').prop('checked', false).trigger('change');
            }
            goSearch();
        });

        $('input[name=cartypeChk]').change(function() {
            if ($('input[name=cartypeChk]:checked').length == $('input[name=cartypeChk]').length) {
                $('#cartype-all').prop('checked', true);
            } else {
                $('#cartype-all').prop('checked', false);
            }
        });


        // 색상계열 전체체크
        $('#color-all').click(function(){
            var boxChkCnt = $('input[name=colorChk]:checked').length;
            var boxCnt = $('input[name=colorChk]').length;

            if (boxCnt == boxChkCnt) {
                $('input[name=colorChk]').prop('checked', false).trigger('change');
            } else {
                $('input[name=colorChk]').each(function() {
                    if (!$(this).prop('checked')) {
                        $(this).prop('checked', true).trigger('change');
                    }
                });
            }
            goSearch();
        });

        // 연료, 차종, 색상계열 선택시
        $('.select_chkbox').change(function(){
            var _chkText = $(this).siblings().children().first().text();

            if ($(this).prop('checked')) {
                var _item = $('.selected-list').children().first().clone().css('display', '');
                _item.children().first().html(_chkText);
                $('.selected-list').append(_item);
            } else {
                $('.selected-list').children('button').each(function(i){
                    if (i > 0) {
                        if (_chkText == $(this).children().first().text()) {
                            $(this).remove();
                        }
                    }
                });
            }
        });

        // 연료, 차종, 색상계열 선택시 change에서 goSearch() 여러번 호출 방지위해..
        $('.select_chkbox').click(function(){
            goSearch();
        });

        // 기존 검색 유지
        if (history.state != null) {
            var _state = history.state;

            // 인증차, 비인증차 SET
            if (_state.certYn != '' && _state.certYn != null) {
                $('.tab-auth li').removeClass('active');
                if (_state.certYn == 'ALL') $('.tab-auth li').eq(0).addClass('active');
                if (_state.certYn == 'Y') $('.tab-auth li').eq(1).addClass('active');
                if (_state.certYn == 'N') $('.tab-auth li').eq(2).addClass('active');
            }

            // 가격 스크롤 SET
            var _priceSlider = $('.range-slider').eq(0);
            var _priceMin = _priceSlider.attr('data-slider-min');
            var _priceMax = _priceSlider.attr('data-slider-max');
            if ($.trim(_state.strSellPrice) != '') {
                _priceMin = _state.strSellPrice;
                $('#price-min').val(toCurrency(_state.strSellPrice));
            }
            if ($.trim(_state.endSellPrice) != '') {
                _priceMax = _state.endSellPrice;
                $('#price-max').val(toCurrency(_state.endSellPrice));
            }
            _priceSlider.slider({
                value: [parseInt(_priceMin), parseInt(_priceMax)]
            });
            _priceSlider.slider('refresh');

            // 연식 스크롤 SET
            var _yeareSlider = $('.range-slider').eq(1);
            var _yeareMin = _yeareSlider.attr('data-slider-min');
            var _yeareMax = _yeareSlider.attr('data-slider-max');

            if ($.trim(_state.strFromYear) != '') {
                _yeareMin = _state.strFromYear;
                $('#year-min').val(_state.strFromYear);
            }
            if ($.trim(_state.endFromYear) != '') {
                _yeareMax = _state.endFromYear;
                $('#year-max').val(_state.endFromYear);
            }
            _yeareSlider.slider({
                value: [parseInt(_yeareMin), parseInt(_yeareMax)]
            });
            _yeareSlider.slider('refresh');

            // 주행거리 스크롤 SET
            var _distanceeSlider = $('.range-slider').eq(2);
            var _distanceeMin = _distanceeSlider.attr('data-slider-min');
            var _distanceeMax = _distanceeSlider.attr('data-slider-max');

            if ($.trim(_state.strDriveDist) != '') {
                _distanceeMin = _state.strDriveDist;
                $('#distance-min').val(toCurrency(_state.strDriveDist));
            }
            if ($.trim(_state.endDriveDist) != '') {
                _distanceeMax = _state.endDriveDist;
                $('#distance-max').val(toCurrency(_state.endDriveDist));
            }
            _distanceeSlider.slider({
                value: [parseInt(_distanceeMin), parseInt(_distanceeMax)]
            });
            _distanceeSlider.slider('refresh');


            // 연료 SET
            $.each(_state.fuel, function(i, val){
                $('input[name=fuelChk]').each(function(){
                    var _fual = $(this).siblings().children().first().text();
                    if (val == _fual) {
                        $(this).prop('checked', true).trigger('change');
                    }
                });
            });

            // 차종 SET
            $.each(_state.carType, function(i, val){
                $('input[name=cartypeChk]').each(function(){
                    var _carType = $(this).siblings().children().first().text();
                    if (val == _carType) {
                        $(this).prop('checked', true).trigger('change');
                    }
                });
            });

            // 색상 SET
            $.each(_state.color, function(i, val){
                $('input[name=colorChk]').each(function(){
                    var _color = $(this).siblings().children().first().text();
                    if (val == _color) {
                        $(this).prop('checked', true).trigger('change');
                    }
                });
            });

            // 지역 SET
            if (_state.sigun != '' && _state.orderType != null) {
                $('#sigun').val(_state.sigun);
                $('#sigun').siblings('.selected').text(_state.sigun);
            }

            // Sorting SET
            if (_state.orderType != '' && _state.orderType != null) {
                $('#orderType').val(_state.orderType);
                $('#orderType').siblings('.selected').text($('#orderType option:selected').text());
            }

            // 그리드 SET
            if (_state.listType != '') {
                $('.switch').children('button').each(function() {
                    if ($(this).attr('id') == _state.listType) {
                        $(this).children().first().addClass('active');
                    } else {
                        $(this).children().first().removeClass('active');
                    }

                });
                $('.list').attr('class', 'list');
                $('.list').addClass('list-'+_state.listType);
            }

            // 제조사 SET
            if (_state.mak != '' && _state.mak != null) {
                $('#making').val(_state.mak);
                $('#making').siblings('.selected').text(_state.mak);
                selectModel(_state.mak);
            }
            // 모델 SET
            if (_state.model != '' && _state.model != null) {
                $('#model').val(_state.model);
                $('#model').siblings('.selected').text(_state.model);
                selectDetailModel(_state.model);
            }
            // 세부모델 SET
            if (_state.detailModel != '' && _state.detailModel != null) {
                $('#detailModel').val(_state.detailModel);
                $('#detailModel').siblings('.selected').text(_state.detailModel);
            }


            goSearch('Y', 'Y', _state.currPage);

        }


        // 좋아요 버튼 제어
        likeEvent();


    });

    /** 선택된 검색 조건 삭제 */
    function removeSearchItem(obj) {
        var _removeChkText = $(obj).siblings().text();

        $('.select_chkbox').each(function(){
            if ($(this).siblings().children().first().text() == _removeChkText) {
                $(this).prop('checked', false).trigger('change');
            }
        });

        $(obj).parent().remove()

    }



    /** 화면 타입 */
    function viewType(obj) {
        $('.switch').children('button').each(function() {
            $(this).children().first().removeClass('active');
        });

        $(obj).children().first().addClass('active');

        $('.list').attr('class', 'list');
        $('.list').addClass('list-'+$(obj).attr('id'));

        _searchParam.listType = $(obj).attr('id');
        history.pushState(_searchParam, 'VWA', '${pageContext.request.contextPath}/item/list');
    }

    /** 인증/비인증 조회 */
    function certSearch(obj) {
        $('.tab-auth li').removeClass('active');
        $(obj).parent().addClass('active');

        if ($(obj).text() == '인증차') {
            $('#making').val('폭스바겐');
            $('#making').siblings('.selected').text('폭스바겐');
            $('#making').siblings('.selected').attr('data-title', '');
            selectModel($('#making').val());
            goSearch();
        } else {

            $('#making option:eq(0)').attr('selected', 'selected');
            $('#making').siblings('.selected').attr('data-title', 'CAR MAKE');
            $('.form .select-box.design-select.reverse').each(function() {
                var _defaultText = $('#'+$(this).children().eq(0).attr('id') + ' option:eq(0)').text();
                $(this).children().eq(1).text(_defaultText);
            });
            $('#model').empty().append('<option value="">모델</option>');
            $('#detailModel').empty().append('<option value="">세부모델</option>');
            goSearch();
            //carSelectReset();
        }
    }

    /** 검색 */
    var _searchParam = {};
    function goSearch(mSearchYn, retainYn, currPage) {

        var _data = {};
        if (currPage == '' || currPage == null) {
            currPage = 1;
        }
        _data.currPage = currPage;
        _data.retainYn = retainYn;
        _data.searchWord = $('#search-bar').val();

        _data.sigun = $('#sigun').val();
        _data.orderType = $('#orderType').val();


        var fuelList = [];
        $('input[name=fuelChk]:checked').each(function(){
            fuelList.push($(this).siblings().children().first().text());
        });
        _data.fuel = fuelList;

        var carTypeList = [];
        $('input[name=cartypeChk]:checked').each(function(){
            carTypeList.push($(this).siblings().children().first().text());
        });
        _data.carType = carTypeList;

        var colorList = [];
        $('input[name=colorChk]:checked').each(function(){
            colorList.push($(this).siblings().children().first().text());
        });
        _data.color = colorList;


        _data.strSellPrice = $('#price-min').val().replace(/[^0-9]/g,"");
        _data.endSellPrice = $('#price-max').val().replace(/[^0-9]/g,"");
        _data.strFromYear = $('#year-min').val().replace(/[^0-9]/g,"");
        _data.endFromYear = $('#year-max').val().replace(/[^0-9]/g,"");
        _data.strDriveDist = $('#distance-min').val().replace(/[^0-9]/g,"");
        _data.endDriveDist = $('#distance-max').val().replace(/[^0-9]/g,"");

        _data.mak = $('#making').val();
        _data.model = $('#model').val();
        _data.detailModel = $('#detailModel').val();

        $('.tab-auth li').each(function () {
            if ($(this).hasClass('active')) {
                if ($(this).children().text() == '인증차') {
                    _data.certYn = 'Y';
                } else if($(this).children().text() == '비인증차') {
                    _data.certYn = 'N';
                } else {
                    _data.certYn = 'ALL';
                }
            }
        });


        $('.switch').children('button').each(function() {
            if ($(this).children().first().hasClass('active')) {
                _data.listType = $(this).attr('id');
            }
        });

        // PC Search일경우.. 로딩바표시 여부위해 분리
        if (!vwa.isMobile) {
            $.ajax({
                url: "${pageContext.request.contextPath}/item/list",
                type: "POST",
                data : _data,
                success: function(result) {



                    $('.count').empty().append($(result).find('.count').html());

                    var _oriViewClass = $('.list').attr('class');
                    $('#contentHtml').empty().append($(result).find('#contentHtml').html());
                    $('.list').attr('class', _oriViewClass);

                    _searchParam = _data;

                    $('#searchButton').empty().append($(result).find('#searchButton').html());

                    history.pushState(_searchParam, 'VWA', '${pageContext.request.contextPath}/item/list');



                    // 좋아요 버튼
                    likeEvent();
                }
            });

        } else {
            $.ajax({
                url: "${pageContext.request.contextPath}/item/list",
                type: "POST",
                data : _data,
                beforeSend: function () {

                },
                success: function(result) {
                    // PC거나 Mobile 검색버튼을 눌렀을때
                    if ( !vwa.isMobile ||(vwa.isMobile && mSearchYn == 'Y')) {

                        $('.count').empty().append($(result).find('.count').html());

                        var _oriViewClass = $('.list').attr('class');
                        $('#contentHtml').empty().append($(result).find('#contentHtml').html());
                        $('.list').attr('class', _oriViewClass);

                        _searchParam = _data;

                        $('.btn.btn-layer-close').trigger('click');

                    }
                    $('#searchButton').empty().append($(result).find('#searchButton').html());


                    history.pushState(_searchParam, 'VWA', '${pageContext.request.contextPath}/item/list');


                    // 좋아요 버튼
                    likeEvent();
                }
            });

        }


    }


    /** 더보기 */
    function goPage(currPage) {
        _searchParam.currPage = currPage;
        _searchParam.retainYn = 'N';

        $('.switch').children('button').each(function() {
            if ($(this).children().first().hasClass('active')) {
                _searchParam.listType = $(this).attr('id');
            }
        });

        $.ajax({
            url: "${pageContext.request.contextPath}/item/list",
            type: "POST",
            data : _searchParam,
            success: function(result) {

                $('.list > .inner').append($(result).find('.list > .inner').html());
                $('#paging').empty().append($(result).find('#paging').html());

                history.pushState(_searchParam, 'VWA', '${pageContext.request.contextPath}/item/list');

                // 좋아요 버튼
                likeEvent();


            }
        });
    }



    /** 스크롤 TEXT 변경시 */
    var _keyupArr = [];
    function setSlider(obj) {


        var _slider = $(obj).parent().parent().parent().siblings('.range-wrap').children('.range-slider');
        var _id = $(obj).attr('id').split('-')[0];

        setTimeout(function(){
            if ($(obj).val().replace(/[^0-9]/g,"") != '') {
                if (_id == 'price') {
                    $(obj).val(toCurrency($(obj).val().replace(/[^0-9]/g,"")));
                } else if (_id == 'year') {
                    $(obj).val($(obj).val().replace(/[^0-9]/g,""));
                } else if (_id == 'distance') {
                    $(obj).val(toCurrency($(obj).val().replace(/[^0-9]/g,"")));
                }
            } else {
                $(obj).val('');
            }
        }, 1000);



        var _minVal = $('#'+_id+'-min').val().replace(/[^0-9]/g,"");
        var _maxVal = $('#'+_id+'-max').val().replace(/[^0-9]/g,"");
        var _min = _slider.attr('data-slider-min');
        var _max = _slider.attr('data-slider-max');


        if ($.trim(_minVal) == '') {
            _minVal = _slider.attr('data-slider-min');
            //$('#'+_id+'-min').val(0);
        }

        if ($.trim(_maxVal) == '') {
            _maxVal = _slider.attr('data-slider-max');
            //$('#'+_id+'-max').val(0);
        }

        // 숫자만 입력
        // $(obj).val($(obj).val().replace(/[^0-9]/g,""));


        /*
        if (parseInt(_max) < parseInt($(obj).val())) {
            $(obj).val(_max);
        }
        if (parseInt(_min) > parseInt($(obj).val())) {
            $(obj).val(_min);
        }


        if (_minVal > _maxVal) {
            alert('올바른 값을 입력해주세요.');
            return false;
        }
        */

        _slider.slider({
            value: [parseInt(_minVal), parseInt(_maxVal)]
        });
        _slider.slider('refresh');


        _keyupArr.push(_keyupArr.length);
        setTimeout('keyUpSlider()', 500);

    }

    /**
     *  Slider Text 여러번 입력시
     *  마지막 한번만 Search 호출
     */
    var _playFnArr = [];
    function keyUpSlider(){
        _playFnArr.push(_playFnArr.length);
        if (_keyupArr.length == _playFnArr.length) {
            goSearch();
            _keyupArr = [];
            _playFnArr = [];
        }
    }


    /** 제조사 선택 모델 가져오기 */
    function selectModel(mak) {

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

                $('#detailModel option:eq(0)').attr('selected', 'selected');
                carSelectReset();
            }
        });

    }

    /** 모델 선택 세부모델 가져오기 */
    function selectDetailModel(model) {

        $.ajax({
            url: "${pageContext.request.contextPath}/index/model/detail",
            type: "POST",
            data: {mak: $('#making').val(), model: model},
            async: false,
            success: function(result) {
                var _html = '<option value="">세부모델</option>';
                if(result.length > 0) {
                    $.each(result, function (idx, item) {
                        _html += '<option value="' + item.detailModel + '">' + item.detailModel + '</option>';
                    })
                }
                $('#detailModel').empty().append(_html);
                carSelectReset();
            }
        });

    }

    /** 차량 선택 selectbox 초기화 */
    function carSelectReset() {
        $('.select-wrap .form .select-box.design-select.reverse').each(function() {
            var _defaultText = $('#'+$(this).children().eq(0).attr('id') + ' option:selected').text();
            console.log(_defaultText)
            $(this).children().eq(1).text(_defaultText);

            if ($('#'+$(this).children().eq(0).attr('id') + ' option:selected').val() == '') {
                var _dataTitle = $(this).children().first().attr('data-title');
                $(this).children().eq(1).attr('data-title', _dataTitle);
            } else {
                $(this).children().eq(1).attr('data-title', '');
            }
        });

        goSearch();
    }



    /** 좋아요 클릭 */
    function like(obj, sellCarSeq, e) {
        e.preventDefault();

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

    /** 초기화 */
    function goReset() {

        $('.tab-auth li').removeClass('active');
        $('.tab-auth').children().first().addClass('active');

        $('#making option:eq(0)').attr('selected', 'selected');
        $('.form .select-box.design-select.reverse').each(function() {
            var _defaultText = $('#'+$(this).children().eq(0).attr('id') + ' option:eq(0)').text();
            $(this).children().eq(1).text(_defaultText);
        });
        $('#model').empty().append('<option value="">모델</option>');
        $('#detailModel').empty().append('<option value="">세부모델</option>');


        $('#detailSearchForm').each(function() {
           this.reset();
        });

        $('.selected-list button').each(function(i){
            if (i > 0) {
                $(this).remove();
            }
        });

        $('.range-slider').each(function(){
            $(this).slider({
                value: [parseInt($(this).attr('data-slider-min')), parseInt($(this).attr('data-slider-max'))]
            });
            $(this).slider('refresh');
        });

        goSearch();

    }


</script>