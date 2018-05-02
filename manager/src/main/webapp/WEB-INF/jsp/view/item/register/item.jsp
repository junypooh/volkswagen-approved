<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-02-05
  Time: 오후 5:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="container" class="container">
    <div class="wrap-contents">
        <div class="page-control">
            <div class="row">
                <div class="col-xs-12">
                    <span class="page-title"> 매물등록 </span>
                </div>
            </div>
        </div>
        <div class="contents">

            <div class="row wrap-sale">

                <div class="col-xs-3 default-info">
                    <div class="card">
                        <form:form id="itemForm" method="post">
                        <div class="panel panel-default">
                            <div class="panel-heading text-center">
                                <i class="fa fa-car fa-3x"></i>
                                <p>차량 기본 정보</p>
                            </div>
                            <ul class="list-group" id="accordion" >
                                <c:choose>
                                    <c:when test="${vwa eq 'Y'}">
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading">제조사</p>
                                            <p class="list-group-item-text">폭스바겐</p>
                                            <input type="hidden" name="mak" value="폭스바겐" />
                                        </li>
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading"><span class="asterisk">*</span>모델</p>
                                            <div class="collapse-header">
                                                <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option0" aria-expanded="true" aria-controls="option0"> 모델을 선택하세요</a>
                                            </div>
                                            <div id="option0" class="collapse-body collapse" aria-labelledby="option1">
                                                <ul class="list-group select-option">
                                                    <c:forEach items="${models}" var="models">
                                                        <li class="list-group-item">
                                                            <label>
                                                                <input type="radio" name="model" value="${models.model}" mandatory> <span>${models.model}</span>
                                                            </label>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </li>
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading"><span class="asterisk">*</span>세부모델</p>
                                            <div class="collapse-header">
                                                <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option1" aria-expanded="true" aria-controls="option1"> 세부모델을 선택하세요</a>
                                            </div>
                                            <div id="option1" class="collapse-body collapse" aria-labelledby="option1">
                                                <ul class="list-group select-option" id="detail-model">
                                                </ul>
                                            </div>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading"><span class="asterisk">*</span>제조사</p>
                                            <div class="form-inline">
                                                <input type="text" name="mak" id="mak" mandatory class="form-control" placeholder="제조사를 입력하세요">
                                            </div>
                                        </li>
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading"><span class="asterisk">*</span>모델</p>
                                            <div class="form-inline">
                                                <input type="text" name="model" id="model" mandatory class="form-control" placeholder="모델을 입력하세요">
                                            </div>
                                        </li>
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading"><span class="asterisk">*</span>세부모델</p>
                                            <div class="form-inline">
                                                <input type="text" name="detailModel" id="detailModel" mandatory class="form-control" placeholder="세부모델을 입력하세요">
                                            </div>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                                <li class="panel list-group-item">
                                    <p class="list-group-item-heading"><span class="asterisk">*</span>차종</p>
                                    <div class="collapse-header">
                                        <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option2" aria-expanded="false" aria-controls="option2"> 차종을 선택하세요</a>
                                    </div>
                                    <div id="option2" class="collapse-body collapse" aria-labelledby="option2">
                                        <ul class="list-group select-option">
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="carType" value="경차" mandatory> <span>경차</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="carType" value="소형차" mandatory> <span>소형차</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="carType" value="준중형차" mandatory> <span>준중형차</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="carType" value="중형차" mandatory> <span>중형차</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="carType" value="SUV/RV" mandatory> <span>SUV/RV</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="carType" value="스포츠카" mandatory> <span>스포츠카</span>
                                                </label>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li class="panel list-group-item">
                                    <p class="list-group-item-heading"><span class="asterisk">*</span>연료</p>
                                    <div class="collapse-header">
                                        <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option3" aria-expanded="false"> 연료를 선택하세요</a>
                                    </div>
                                    <div id="option3" class="collapse-body collapse">
                                        <small class="text-right">2개 선택 가능</small>
                                        <ul class="list-group select-option">
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="checkbox" data-max-check="2" name="fuel" value="가솔린" mandatory> <span>가솔린</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="checkbox" data-max-check="2" name="fuel" value="디젤" mandatory> <span>디젤</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="checkbox" data-max-check="2" name="fuel" value="LPG" mandatory> <span>LPG</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="checkbox" data-max-check="2" name="fuel" value="전기" mandatory> <span>전기</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="checkbox" data-max-check="2" name="fuel" value="기타" mandatory> <span>기타</span>
                                                </label>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <c:choose>
                                    <c:when test="${vwa eq 'Y'}">
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading"><span class="asterisk">*</span>등급</p>
                                            <div class="collapse-header">
                                                <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option4" aria-expanded="false"> 등급을 선택하세요</a>
                                            </div>
                                            <div id="option4" class="collapse-body collapse">
                                                <ul class="list-group select-option" id="rating">
                                                </ul>
                                            </div>
                                        </li>
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading">세부등급</p>
                                            <div class="collapse-header">
                                                <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option5" aria-expanded="false"> 세부등급을 선택하세요</a>
                                            </div>
                                            <div id="option5" class="collapse-body collapse">
                                                <ul class="list-group select-option" id="detailRating">
                                                </ul>
                                            </div>
                                        </li>

                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading">수입구분</p>
                                            <div class="collapse-header">
                                                <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option6" aria-expanded="false"> 수입구분을 선택하세요</a>
                                            </div>
                                            <div id="option6" class="collapse-body collapse">
                                                <ul class="list-group select-option">
                                                    <li class="list-group-item">
                                                        <label>
                                                            <input type="radio" name="impoType" value="정식수입"> <span>정식 수입</span>
                                                        </label>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <label>
                                                            <input type="radio" name="impoType" value="병행수입"> <span>병행 수입</span>
                                                        </label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading">폭스바겐 인증</p>
                                            <div class="collapse-header">
                                                <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option7" aria-expanded="false"> 인증여부를 선택하세요</a>
                                            </div>
                                            <div id="option7" class="collapse-body collapse">
                                                <div class="guide">
                                                    <p class="text-center"><strong>폭스바겐 중고인증차량 조건</strong></p>
                                                    <ol>
                                                        <li>정식수입</li>
                                                        <li>연식 5년이하</li>
                                                        <li>주행거리 100,000 km이내</li>
                                                        <li>공식 정비센터 정비 완료 </li>
                                                        <li>전손 없는 차량</li>
                                                    </ol>
                                                </div>
                                                <ul class="list-group select-option">
                                                    <li class="list-group-item">
                                                        <label>
                                                            <input type="radio" name="certYn" value="Y"> <span>인증 차량</span>
                                                        </label>
                                                    </li>
                                                    <li class="list-group-item">
                                                        <label>
                                                            <input type="radio" name="certYn" value="N"> <span>비인증 차량</span>
                                                        </label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 폭스바겐 차량이 아닐 경우 등급, 세부등급 -->
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading"><span class="asterisk">*</span>등급</p>
                                            <div class="form-inline">
                                                <input type="text" name="rating" id="rating" mandatory class="form-control" placeholder="등급을 입력하세요">
                                            </div>
                                        </li>
                                        <li class="panel list-group-item">
                                            <p class="list-group-item-heading">세부등급</p>
                                            <div class="form-inline">
                                                <input type="text" name="detailRating" id="detailRating" class="form-control" placeholder="세부등급을 입력하세요">
                                            </div>
                                        </li>
                                        <!-- //폭스바겐 차량이 아닐 경우 등급, 세부등급 -->
                                    </c:otherwise>
                                </c:choose>
                                <li class="panel list-group-item">
                                    <p class="list-group-item-heading"><span class="asterisk">*</span>연식(최초등록일)</p>
                                    <div class="form-inline ">
                                        <input type="text" class="form-control datetimepicker" name="prodYear" mandatory value="" placeholder="" maxlength="6">
                                    </div>
                                </li>
                                <li class="panel list-group-item">
                                    <p class="list-group-item-heading"><span class="asterisk">*</span>형식년도</p>
                                    <div class="form-inline">
                                        <input type="text" class="form-control datetimepicker" name="fromYear" mandatory value="" placeholder="" maxlength="6">
                                    </div>
                                </li>
                                <li class="panel list-group-item">
                                    <p class="list-group-item-heading"><span class="asterisk">*</span>배기량</p>
                                    <div class="form-inline">
                                        <div class="input-group">
                                            <input type="text" name="disp" id="disp" mandatory class="form-control" placeholder="배기량을 입력하세요" maxlength="4">
                                            <i class="input-group-addon">CC</i>
                                        </div>
                                    </div>
                                </li>
                                <li class="panel list-group-item">
                                    <p class="list-group-item-heading"><span class="asterisk">*</span>변속기</p>
                                    <div class="collapse-header">
                                        <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option8" aria-expanded="false"> 변속기를 선택하세요</a>
                                    </div>
                                    <div id="option8" class="collapse-body collapse">
                                        <ul class="list-group select-option">
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="gear" value="오토" mandatory> <span>오토</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="gear" value="수동" mandatory> <span>수동</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="gear" value="세미오토" mandatory> <span>세미오토</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="gear" value="CVT" mandatory> <span>CVT</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="gear" value="기타" mandatory> <span>기타</span>
                                                </label>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li class="panel list-group-item">
                                    <p class="list-group-item-heading"><span class="asterisk">*</span>외장 색상 계열</p>
                                    <div class="collapse-header">
                                        <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option9" aria-expanded="false"> 색상을 선택하세요</a>
                                    </div>
                                    <div id="option9" class="collapse-body collapse">
                                        <ul class="list-group select-option select-color">
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="color" value="검정색" mandatory> <span class="colorchip color1">검정색</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="color" value="진회색" mandatory> <span class="colorchip color2">진회색</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="color" value="은색" mandatory> <span class="colorchip color3">은색</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="color" value="흰색" mandatory> <span class="colorchip color4">흰색</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="color" value="브라운" mandatory> <span class="colorchip color5">브라운</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="color" value="청색" mandatory> <span class="colorchip color6">청색</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="color" value="빨강색" mandatory> <span class="colorchip color7">빨강색</span>
                                                </label>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li class="panel list-group-item">
                                    <p class="list-group-item-heading"><span class="asterisk">*</span>내장 색상 계열</p>
                                    <div class="collapse-header">
                                        <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option10" aria-expanded="false"> 색상을 선택하세요</a>
                                    </div>
                                    <div id="option10" class="collapse-body collapse">
                                        <ul class="list-group select-option select-color">
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="innerColor" value="검정색" mandatory> <span class="colorchip color1">검정색</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="innerColor" value="진회색" mandatory> <span class="colorchip color2">진회색</span>
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="innerColor" value="브라운" mandatory> <span class="colorchip color3">브라운</span>
                                                </label>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li class="panel list-group-item">
                                    <p class="list-group-item-heading"><span class="asterisk">*</span>주행거리</p>
                                    <div class="form-inline">
                                        <div class="input-group">
                                            <input type="text" name="driveDist" id="driveDist" mandatory class="form-control" placeholder="주행거리를 입력하세요" maxlength="7">
                                            <i class="input-group-addon">Km</i>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <div class="panel-footer text-center">
                                <button type="button" class="btn btn-primary" id="saveBtn" onclick="saveData()" disabled="disabled">기본 정보 저장</button>
                            </div>
                        </div>
                        </form:form>
                    </div>
                </div>

                <div class="col-xs-9">
                    <div class="card">
                        <div class="wrap-guide ">
                            <div class="guide-header">
                                차량 기본 정보 가이드
                            </div>
                            <div class="guide-body">
                                <div class="row item-1">
                                    <div class="col-xs-6">
                                        <p class="title">연식과 형식년도</p>
                                        <span>자동차 등록증에서 확인하실 수 있습니다.</span>
                                        <div class="thumbnail">
                                            <img src="${pageContext.request.contextPath}/resources/images/guide-1.png" alt="">
                                        </div>
                                        <small class="text-right">A : 연식=최초등록일  B : 형식연도</small>
                                    </div>
                                    <div class="col-xs-6">
                                        <p class="title">주행거리</p>
                                        <span>계기판의 주행거리를 확인하세요.</span>
                                        <div class="thumbnail">
                                            <img src="${pageContext.request.contextPath}/resources/images/guide-2.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${vwa eq 'Y'}">
                                <div class="row item-2">
                                    <div class="col-xs-12">
                                        <p class="title"><i class="fa fa-info-circle"></i> 폭스바겐 인증차량 조건</p>
                                        <ol>
                                            <li>정식수입</li>
                                            <li>연식 5년이하</li>
                                            <li>주행거리 100,000 km이내</li>
                                            <li>공식 정비센터 정비 완료 </li>
                                            <li>전손 없는 차량</li>
                                        </ol>
                                    </div>
                                </div>
                                </c:if>
                                <div class="row item-2">
                                    <div class="col-xs-12">
                                        <p class="title"><i class="fa fa-info-circle"></i> 안내 및 주의사항</p>
                                        <ul>
                                            <li>차량번호, 제조사, 모델, 연식, 형식 연도는 수정이 불가합니다.</li>
                                            <li>수입 구분과 폭스바겐 보증은 해당 차량에만 해당합니다.</li>
                                            <li>등록 차량이 없다면, 모델/등급 추가 요청하세요. (문의 : <a href="mailto:helpdeask@vwa.co.kr">helpdeask@vwa.co.kr</a>)</li>
                                            <li>실제 차량정보와 다르게 입력하는 경우 차량등록에 제한할 수 있으며, 관련법에 따라 처벌받을 수 있습니다.<br>자동차관리법 58조, 80조 / 자동차관리법 시행규칙 120조</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>
<script type="text/javascript">

    $(document).ready(function () {

        initPageAction();

        $('input[type=text][name=prodYear]').datetimepicker({
            format: 'YYYYMM',
            viewMode: 'years',
            widgetPositioning : {
                horizontal : 'right',
                vertical : 'bottom'
            },
            locale: "kr"
        }).on('dp.change',function(event){
            checkMandatoryFiled();
        });

        $('input[type=text][name=fromYear]').datetimepicker({
            format: 'YYYY',
            viewMode: 'years',
            widgetPositioning : {
                horizontal : 'right',
                vertical : 'bottom'
            },
            locale: "kr"
        }).on('dp.change',function(event){
            checkMandatoryFiled();
        });
    });

    // 페이지 object action init
    function initPageAction() {
        var $info = $('.default-info');
        $info.find('input[type="radio"], input[type="checkbox"], input[type="text"]').unbind('change');

        // 모델 선택
        $('input[type=radio][name=model]').change(function() {
            getDetailModel($(this).val());
        });

        // 세부모델 선택 등급 가져오기
        $('input[type=radio][name=detailModel]').change(function() {
            getRating($('input[type=radio][name=model]:checked').val(), $(this).val());
        });

        // 등급 선택 세부 등급 가져오기
        $('input[type=radio][name=rating]').change(function() {
            getDetailRating($('input[type=radio][name=model]:checked').val(), $('input[type=radio][name=detailModel]:checked').val(), $(this).val());
        });

        // 선택된 값 화면에 표시
        $info.find('input[type="radio"], input[type="checkbox"], input[type="text"]').on('change', function() {
            var $input = $(this),
                _value;

            if($input.attr('type') == 'checkbox') {
                _value = [];
                $input.closest('.select-option').find('input[type="checkbox"]:checked').each(function() {
                    _value.push($(this).next('span').html());
                });

                var maxCheck = $input.attr('data-max-check');
                if(_value.length > maxCheck) {
                    alert(maxCheck + '개까지 선택 가능합니다.');
                    $input.prop('checked', false);
                    return false;
                }

                _value = _value.join(', ');
            } else if($input.attr('type') == 'radio') {
                _value = $input.filter(':checked').next('span').html();
            }

            $(this).closest('.collapse-body').parent().find('.collapse-header a').html(_value);

            checkMandatoryFiled();
        });

        // text 값 변경
        $info.find('input[type="text"]').keyup(function() {
            checkMandatoryFiled();
        });
    }

    // 필수체크 항목 체크
    function checkMandatoryFiled() {
        var uniqueElements = [];
        var $info = $('.default-info');
        $info.find('input[type="text"], input[type="radio"], input[type="checkbox"]').each(function() {
            var $input = $(this);
            var mandatory = $input.attr('mandatory');

            // element name 중복 제거
            if(typeof mandatory !== 'undefined') {
                if($.inArray($input.attr('name'), uniqueElements) === -1) uniqueElements.push($input.attr('name'));
            }
        });

        // element 별 값 있는지 확인
        var check = false;
        $.each(uniqueElements, function(idx, element) {
            var type = $('input[name="' + element + '"]').attr('type'),
                _value = [],
                elementValue;
            if (type == 'text') {
                //console.log(idx, type, element, $('input[name="' + element + '"]').val());
                elementValue = $('input[name="' + element + '"]').val();
            } else if (type == 'checkbox') {
                $('input[name="' + element + '"]:checked').each(function() {
                    _value.push($(this).val());
                });
                //console.log(idx, type, element, _value.join(', '));
                elementValue = _value.join(', ');
            } else {
                //console.log(idx, type, element, $('input[name="' + element + '"]:checked').val());
                elementValue = $('input[name="' + element + '"]:checked').val();
            }

            if(typeof elementValue !== 'undefined' && elementValue != '') {
                check = false;
            } else {
                check = true;
                return false;
            }
        });

        //console.log(check);
        $('#saveBtn').attr('disabled', check);
    }

    // 모델 선택 세부모델 가져오기
    function getDetailModel(model) {

        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/model/detail",
            type: "POST",
            data : {model: model},
            success: function(result) {
                var _html = '';
                if(result.length > 0) {
                    $.each(result, function (idx, item) {
                        _html += '<li class="list-group-item">';
                        _html += '  <label>';
                        _html += '      <input type="radio" name="detailModel" value="' + item.detailModel + '" mandatory> <span>' + item.detailModel + '</span>';
                        _html += '  </label>';
                        _html += '</li>';
                    })
                }
                $('#detail-model').empty().append(_html);
                initPageAction();

                // 세부모델 선택 값 초기화
                $('#detail-model').closest('.collapse-body').parent().find('.collapse-header a').html('세부모델을 선택하세요');

                // 등급 선택 값 초기화
                $('#rating').closest('.collapse-body').parent().find('.collapse-header a').html('등급을 선택하세요');

                // 등급 선택 값 초기화
                $('#detailRating').closest('.collapse-body').parent().find('.collapse-header a').html('세부등급을 선택하세요');
            }
        });
    }

    //  세부모델 선택 등급 가져오기
    function getRating(model, detailModel) {

        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/rating",
            type: "POST",
            data : {model: model, detailModel: detailModel},
            success: function(result) {
                var _html = '';
                if(result.length > 0) {
                    $.each(result, function (idx, item) {
                        _html += '<li class="list-group-item">';
                        _html += '  <label>';
                        _html += '      <input type="radio" name="rating" value="' + item.rating + '" mandatory> <span>' + item.rating + '</span>';
                        _html += '  </label>';
                        _html += '</li>';
                    })
                }
                $('#rating').empty().append(_html);
                initPageAction();

                // 등급 선택 값 초기화
                $('#rating').closest('.collapse-body').parent().find('.collapse-header a').html('등급을 선택하세요');

                // 등급 선택 값 초기화
                $('#detailRating').closest('.collapse-body').parent().find('.collapse-header a').html('세부등급을 선택하세요');
            }
        });
    }

    // 등급 선택 세부 등급 가져오기
    function getDetailRating(model, detailModel, rating) {

        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/rating/detail",
            type: "POST",
            data : {model: model, detailModel: detailModel, rating: rating},
            success: function(result) {
                var _html = '';
                if(result.length > 0) {
                    $.each(result, function (idx, item) {
                        _html += '<li class="list-group-item">';
                        _html += '  <label>';
                        _html += '      <input type="radio" name="detailRating" value="' + item.detailRating + '"> <span>' + item.detailRating + '</span>';
                        _html += '  </label>';
                        _html += '</li>';
                    })
                }
                $('#detailRating').empty().append(_html);
                initPageAction();
            }
        });
    }

    // 데이터 저장
    function saveData() {
        // console.log($('#itemForm').serialize());
        $('#itemForm').attr('action','${pageContext.request.contextPath}/item/register/defaultInfo').submit();

        /*$.ajax({
            url: "${pageContext.request.contextPath}/item/register/defaultInfo",
            type: "POST",
            data : $('#itemForm').serialize(),
            success: function(result) {

                console.log(result);
            }
        });*/

    }

</script>