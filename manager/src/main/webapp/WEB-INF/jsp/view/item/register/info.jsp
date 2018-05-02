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

    <div class="col-xs-3 default-info">
        <div class="card">
            <form:form id="itemForm" method="post">
            <input type="hidden" name="sellCarSeq" value="${sellCarModelVo.sellCarSeq}" />
            <div class="panel panel-default">
                <div class="panel-heading text-center complete">
                    <i class="fa fa-car fa-3x"></i>
                    <p>차량 기본 정보</p>
                </div>
                <ul class="list-group" id="accordion" >
                    <c:choose>
                        <c:when test="${vwa eq 'Y'}">
                            <li class="panel list-group-item">
                                <p class="list-group-item-heading">제조사</p>
                                <p class="list-group-item-text">${sellCarModelVo.mak}</p>
                                <input type="hidden" name="mak" value="${sellCarModelVo.mak}" />
                            </li>
                            <li class="panel list-group-item">
                                <p class="list-group-item-heading"><span class="asterisk">*</span>모델</p>
                                <div class="collapse-header">
                                    <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option0" aria-expanded="true" aria-controls="option0"> ${sellCarModelVo.model}</a>
                                </div>
                                <div id="option0" class="collapse-body collapse" aria-labelledby="option1">
                                    <ul class="list-group select-option">
                                        <c:forEach items="${models}" var="models">
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="model" value="${models.model}" <c:if test="${sellCarModelVo.model eq models.model}">checked="checked"</c:if> mandatory> <span>${models.model}</span>
                                                </label>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </li>
                            <li class="panel list-group-item">
                                <p class="list-group-item-heading"><span class="asterisk">*</span>세부모델</p>
                                <div class="collapse-header">
                                    <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option1" aria-expanded="true" aria-controls="option1"> ${sellCarModelVo.detailModel}</a>
                                </div>
                                <div id="option1" class="collapse-body collapse" aria-labelledby="option1">
                                    <ul class="list-group select-option" id="detail-model">
                                        <c:forEach items="${detailModels}" var="detailModels">
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="detailModel" value="${detailModels.detailModel}" <c:if test="${sellCarModelVo.detailModel eq detailModels.detailModel}">checked="checked"</c:if> mandatory> <span>${detailModels.detailModel}</span>
                                                </label>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="panel list-group-item">
                                <p class="list-group-item-heading"><span class="asterisk">*</span>제조사</p>
                                <div class="form-inline">
                                    <input type="text" name="mak" id="mak" value="${sellCarModelVo.mak}" mandatory class="form-control" placeholder="제조사를 입력하세요">
                                </div>
                            </li>
                            <li class="panel list-group-item">
                                <p class="list-group-item-heading"><span class="asterisk">*</span>모델</p>
                                <div class="form-inline">
                                    <input type="text" name="model" id="model" value="${sellCarModelVo.model}" mandatory class="form-control" placeholder="모델을 입력하세요">
                                </div>
                            </li>
                            <li class="panel list-group-item">
                                <p class="list-group-item-heading"><span class="asterisk">*</span>세부모델</p>
                                <div class="form-inline">
                                    <input type="text" name="detailModel" id="detailModel" value="${sellCarModelVo.detailModel}" mandatory class="form-control" placeholder="세부모델을 입력하세요">
                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
                    <li class="panel list-group-item">
                        <p class="list-group-item-heading"><span class="asterisk">*</span>차종</p>
                        <div class="collapse-header">
                            <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option2" aria-expanded="false" aria-controls="option2"> ${sellCarModelVo.carType}</a>
                        </div>
                        <div id="option2" class="collapse-body collapse" aria-labelledby="option2">
                            <ul class="list-group select-option">
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="carType" value="경차" <c:if test="${sellCarModelVo.carType eq '경차'}">checked="checked"</c:if> mandatory> <span>경차</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="carType" value="소형차" <c:if test="${sellCarModelVo.carType eq '소형차'}">checked="checked"</c:if> mandatory> <span>소형차</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="carType" value="준중형차" <c:if test="${sellCarModelVo.carType eq '준중형차'}">checked="checked"</c:if> mandatory> <span>준중형차</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="carType" value="중형차" <c:if test="${sellCarModelVo.carType eq '중형차'}">checked="checked"</c:if> mandatory> <span>중형차</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="carType" value="SUV/RV" <c:if test="${sellCarModelVo.carType eq 'SUV/RV'}">checked="checked"</c:if> mandatory> <span>SUV/RV</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="carType" value="스포츠카" <c:if test="${sellCarModelVo.carType eq '스포츠카'}">checked="checked"</c:if> mandatory> <span>스포츠카</span>
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="panel list-group-item">
                        <p class="list-group-item-heading"><span class="asterisk">*</span>연료</p>
                        <div class="collapse-header">
                            <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option3" aria-expanded="false"> ${sellCarModelVo.fuel}</a>
                        </div>
                        <div id="option3" class="collapse-body collapse">
                            <small class="text-right">2개 선택 가능</small>
                            <ul class="list-group select-option">
                                <li class="list-group-item">
                                    <label>
                                        <input type="checkbox" data-max-check="2" name="fuel" value="가솔린" <c:if test="${fn:contains(sellCarModelVo.fuel, '가솔린')}">checked="checked"</c:if> mandatory> <span>가솔린</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="checkbox" data-max-check="2" name="fuel" value="디젤" <c:if test="${fn:contains(sellCarModelVo.fuel, '디젤')}">checked="checked"</c:if> mandatory> <span>디젤</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="checkbox" data-max-check="2" name="fuel" value="LPG" <c:if test="${fn:contains(sellCarModelVo.fuel, 'LPG')}">checked="checked"</c:if> mandatory> <span>LPG</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="checkbox" data-max-check="2" name="fuel" value="전기" <c:if test="${fn:contains(sellCarModelVo.fuel, '전기')}">checked="checked"</c:if> mandatory> <span>전기</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="checkbox" data-max-check="2" name="fuel" value="기타" <c:if test="${sellCarModelVo.fuel eq '기타'}">checked="checked"</c:if> mandatory> <span>기타</span>
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
                                    <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option4" aria-expanded="false"> ${sellCarModelVo.rating}</a>
                                </div>
                                <div id="option4" class="collapse-body collapse">
                                    <ul class="list-group select-option" id="rating">
                                        <c:forEach items="${ratings}" var="ratings">
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="rating" value="${ratings.rating}" <c:if test="${sellCarModelVo.rating eq ratings.rating}">checked="checked"</c:if> mandatory> <span>${ratings.rating}</span>
                                                </label>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </li>
                            <li class="panel list-group-item">
                                <p class="list-group-item-heading">세부등급</p>
                                <div class="collapse-header">
                                    <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option5" aria-expanded="false"> ${sellCarModelVo.detailRating}</a>
                                </div>
                                <div id="option5" class="collapse-body collapse">
                                    <ul class="list-group select-option" id="detailRating">
                                        <c:forEach items="${detailRatings}" var="detailRatings">
                                            <li class="list-group-item">
                                                <label>
                                                    <input type="radio" name="detailRating" value="${detailRatings.detailRating}" <c:if test="${sellCarModelVo.detailRating eq detailRatings.detailRating}">checked="checked"</c:if>> <span>${detailRatings.detailRating}</span>
                                                </label>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </li>

                            <li class="panel list-group-item">
                                <p class="list-group-item-heading">수입구분</p>
                                <div class="collapse-header">
                                    <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option6" aria-expanded="false"> ${sellCarModelVo.impoType}</a>
                                </div>
                                <div id="option6" class="collapse-body collapse">
                                    <ul class="list-group select-option">
                                        <li class="list-group-item">
                                            <label>
                                                <input type="radio" name="impoType" <c:if test="${sellCarModelVo.impoType eq '정식수입'}">checked="checked"</c:if> value="정식수입"> <span>정식 수입</span>
                                            </label>
                                        </li>
                                        <li class="list-group-item">
                                            <label>
                                                <input type="radio" name="impoType" <c:if test="${sellCarModelVo.impoType eq '병행수입'}">checked="checked"</c:if> value="병행수입"> <span>병행 수입</span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="panel list-group-item">
                                <p class="list-group-item-heading">폭스바겐 인증</p>
                                <div class="collapse-header">
                                    <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option7" aria-expanded="false"> <c:choose><c:when test="${sellCarModelVo.certYn eq 'Y'}">인증 차량</c:when><c:otherwise>비인증 차량</c:otherwise></c:choose></a>
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
                                                <input type="radio" name="certYn" <c:if test="${sellCarModelVo.certYn eq 'Y'}">checked="checked"</c:if> value="Y"> <span>인증 차량</span>
                                            </label>
                                        </li>
                                        <li class="list-group-item">
                                            <label>
                                                <input type="radio" name="certYn" <c:if test="${sellCarModelVo.certYn eq 'N'}">checked="checked"</c:if> value="N"> <span>비인증 차량</span>
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
                                    <input type="text" name="rating" id="rating" value="${sellCarModelVo.rating}" mandatory class="form-control" placeholder="등급을 입력하세요">
                                </div>
                            </li>
                            <li class="panel list-group-item">
                                <p class="list-group-item-heading">세부등급</p>
                                <div class="form-inline">
                                    <input type="text" name="detailRating" id="detailRating" value="${sellCarModelVo.detailRating}" class="form-control" placeholder="세부등급을 입력하세요">
                                </div>
                            </li>
                            <!-- //폭스바겐 차량이 아닐 경우 등급, 세부등급 -->
                        </c:otherwise>
                    </c:choose>
                    <li class="panel list-group-item">
                        <p class="list-group-item-heading"><span class="asterisk">*</span>연식(최초등록일)</p>
                        <div class="form-inline ">
                            <input type="text" class="form-control datetimepicker" name="prodYear" value="${sellCarModelVo.prodYear}" mandatory placeholder="" maxlength="6">
                        </div>
                    </li>
                    <li class="panel list-group-item">
                        <p class="list-group-item-heading"><span class="asterisk">*</span>형식년도</p>
                        <div class="form-inline">
                            <input type="text" class="form-control datetimepicker" name="fromYear" value="${sellCarModelVo.fromYear}" mandatory placeholder="" maxlength="4">
                        </div>
                    </li>
                    <li class="panel list-group-item">
                        <p class="list-group-item-heading"><span class="asterisk">*</span>배기량</p>
                        <div class="form-inline">
                            <div class="input-group">
                                <input type="text" name="disp" id="disp" value="${sellCarModelVo.disp}" mandatory class="form-control" placeholder="배기량을 입력하세요" maxlength="4">
                                <i class="input-group-addon">CC</i>
                            </div>
                        </div>
                    </li>
                    <li class="panel list-group-item">
                        <p class="list-group-item-heading"><span class="asterisk">*</span>변속기</p>
                        <div class="collapse-header">
                            <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option8" aria-expanded="false"> ${sellCarModelVo.gear}</a>
                        </div>
                        <div id="option8" class="collapse-body collapse">
                            <ul class="list-group select-option">
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="gear" value="오토" <c:if test="${sellCarModelVo.gear eq '오토'}">checked="checked"</c:if> mandatory> <span>오토</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="gear" value="수동" <c:if test="${sellCarModelVo.gear eq '수동'}">checked="checked"</c:if> mandatory> <span>수동</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="gear" value="세미오토" <c:if test="${sellCarModelVo.gear eq '세미오토'}">checked="checked"</c:if> mandatory> <span>세미오토</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="gear" value="CVT" <c:if test="${sellCarModelVo.gear eq 'CVT'}">checked="checked"</c:if> mandatory> <span>CVT</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="gear" value="기타" <c:if test="${sellCarModelVo.gear eq '기타'}">checked="checked"</c:if> mandatory> <span>기타</span>
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="panel list-group-item">
                        <p class="list-group-item-heading"><span class="asterisk">*</span>외장 색상 계열</p>
                        <div class="collapse-header">
                            <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option9" aria-expanded="false"> ${sellCarModelVo.color}</a>
                        </div>
                        <div id="option9" class="collapse-body collapse">
                            <ul class="list-group select-option select-color">
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="color" value="검정색" <c:if test="${sellCarModelVo.color eq '검정색'}">checked="checked"</c:if> mandatory> <span class="colorchip color1">검정색</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="color" value="진회색" <c:if test="${sellCarModelVo.color eq '진회색'}">checked="checked"</c:if> mandatory> <span class="colorchip color2">진회색</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="color" value="은색" <c:if test="${sellCarModelVo.color eq '은색'}">checked="checked"</c:if> mandatory> <span class="colorchip color3">은색</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="color" value="흰색" <c:if test="${sellCarModelVo.color eq '흰색'}">checked="checked"</c:if> mandatory> <span class="colorchip color4">흰색</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="color" value="브라운" <c:if test="${sellCarModelVo.color eq '브라운'}">checked="checked"</c:if> mandatory> <span class="colorchip color5">브라운</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="color" value="청색" <c:if test="${sellCarModelVo.color eq '청색'}">checked="checked"</c:if> mandatory> <span class="colorchip color6">청색</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="color" value="빨강색" <c:if test="${sellCarModelVo.color eq '빨강색'}">checked="checked"</c:if> mandatory> <span class="colorchip color7">빨강색</span>
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="panel list-group-item">
                        <p class="list-group-item-heading"><span class="asterisk">*</span>내장 색상 계열</p>
                        <div class="collapse-header">
                            <a data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#option10" aria-expanded="false"> ${sellCarModelVo.innerColor}</a>
                        </div>
                        <div id="option10" class="collapse-body collapse">
                            <ul class="list-group select-option select-color">
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="innerColor" value="검정색" <c:if test="${sellCarModelVo.innerColor eq '검정색'}">checked="checked"</c:if> mandatory> <span class="colorchip color1">검정색</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="innerColor" value="진회색" <c:if test="${sellCarModelVo.innerColor eq '진회색'}">checked="checked"</c:if> mandatory> <span class="colorchip color2">진회색</span>
                                    </label>
                                </li>
                                <li class="list-group-item">
                                    <label>
                                        <input type="radio" name="innerColor" value="브라운" <c:if test="${sellCarModelVo.innerColor eq '브라운'}">checked="checked"</c:if> mandatory> <span class="colorchip color3">브라운</span>
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="panel list-group-item">
                        <p class="list-group-item-heading"><span class="asterisk">*</span>주행거리</p>
                        <div class="form-inline">
                            <div class="input-group">
                                <input type="text" name="driveDist" id="driveDist" value="${sellCarModelVo.driveDist}" mandatory class="form-control" placeholder="주행거리를 입력하세요" maxlength="7">
                                <i class="input-group-addon">Km</i>
                            </div>
                        </div>
                    </li>
                </ul>
                <div class="panel-footer text-center">
                    <c:if test="${result.carInfo.carStatCd ne 'D1004' and result.carInfo.carStatCd ne 'D1005'}"> <!-- 판매완료 / 판매취소가 아닐때 -->
                    <button type="button" class="btn btn-primary" id="saveBtn" onclick="saveData()">기본 정보 저장</button>
                    </c:if>
                </div>
            </div>
            </form:form>
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

    // 세부모델 선택 등급 가져오기
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

    <c:if test="${result.carInfo.carStatCd ne 'D1004' and result.carInfo.carStatCd ne 'D1005'}"> <!-- 판매완료 / 판매취소가 아닐때 -->
    // 기본 정보 데이터 저장
    function saveData() {

        // 임시저장
        <c:if test="${result.carInfo.carStatCd eq 'D1002' and (auth eq 'VW' or auth eq 'ADMIN')}">
        tempSave('modify');
        </c:if>
        <c:if test="${result.carInfo.carStatCd eq null or result.carInfo.carStatCd eq 'D1003'}">
        tempSave();
        </c:if>

        /*$.ajax({
            url: "${pageContext.request.contextPath}/item/register/update/defaultInfo",
            type: "POST",
            async: false,
            data : $('#itemForm').serialize(),
            success: function(result) {
                //console.log(result);

                if("SUCC" == result) {
                    // 임시저장
                    <c:if test="${result.carInfo.carStatCd eq 'D1002' and (auth eq 'VW' or auth eq 'ADMIN')}">
                    tempSave('modify');
                    </c:if>
                    <c:if test="${result.carInfo.carStatCd eq null or result.carInfo.carStatCd eq 'D1003'}">
                    tempSave();
                    </c:if>
                } else {
                    alert('저장에 실패되었습니다.');
                }
            }
        });*/

    }
    </c:if>

</script>