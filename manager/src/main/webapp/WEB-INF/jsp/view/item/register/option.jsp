<%--
  Created by IntelliJ IDEA.
  User: DaDa
  Date: 2018-01-22
  Time: 오전 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<security:authorize access="isAuthenticated()">
    <security:authentication var="authType" property="principal.authType" />
</security:authorize>


<div id="container" class="container">
    <div class="wrap-contents">
        <div class="page-control">
            <div class="row">
                <div class="col-xs-3">
                    <span class="page-title"> 매물등록 </span>
                </div>
                <c:if test="${result.carInfo.carStatCd eq null and auth ne 'ADMIN'}">
                    <div class="col-xs-9 text-right" id="requestApply">
                        <small>정보 입력 완료 후, 미리보기 및 승인 요청이 가능합니다.</small>
                        <button type="button" class="btn btn-default" <c:if test="${result.tempSaveYn ne 'Y'}">disabled="disabled"</c:if> onclick="beforehandView()">미리보기</button>
                        <button type="button" class="btn btn-primary" <c:if test="${result.tempSaveYn ne 'Y'}">disabled="disabled"</c:if> onclick="requestApply()">승인 요청</button>
                    </div>
                </c:if>
                <c:if test="${result.carInfo.carStatCd eq 'D1002' and (auth eq 'VW' or auth eq 'ADMIN')}">
                    <div class="col-xs-9 text-right">
                        <small>판매중인 차량이오니, 수정 반영 시 신중하시기 바랍니다.</small>
                        <button type="button" class="btn btn-primary" onclick="tempSave('modify')">수정저장</button>
                    </div>
                </c:if>
                <c:if test="${result.carInfo.carStatCd eq 'D1001' and (auth eq 'VW' or auth eq 'OPERATOR')}">
                    <div class="col-xs-9 text-right">
                        <small>매물 수정 사항이 발생하여, 매물 재승인요청 합니다.</small>
                        <button type="button" class="btn btn-primary" onclick="requestApply()">승인요청</button>
                    </div>
                </c:if>
                <c:if test="${result.carInfo.carStatCd eq 'D1003' and (auth eq 'VW' or auth eq 'OPERATOR')}">
                    <div class="col-xs-9 text-right">
                        <small>반려 사유를 참고하여, 매물 재승인요청 합니다.</small>
                        <button type="button" class="btn btn-primary" onclick="requestApply()">승인요청</button>
                    </div>
                </c:if>
            </div>
        </div>
        <div class="contents">

            <div class="row wrap-sale">

                <c:import url="/item/register/info/${sellCarSeq}" />

                <div class="col-xs-9 detail-info">
                    <div class="card">
                        <ul class="nav nav-tabs nav-justified " role="tablist">
                            <c:choose>
                                <c:when test="${result.carInfo.carStatCd eq null or result.carInfo.carStatCd eq 'D1003'}">
                                    <li role="presentation" <c:if test="${result.saveYn.price eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/price/${sellCarSeq}')">가격·사고이력</a></li>
                                    <li role="presentation" class="active <c:if test="${result.saveYn.option eq 'Y'}">complete</c:if>"><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/option/${sellCarSeq}')">옵션·전차주</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.perform eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}')">제시·성능점검</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.disc eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}')">설명</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.photo eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/photo/${sellCarSeq}')">사진</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li role="presentation" <c:if test="${result.saveYn.price eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/price/${sellCarSeq}">가격·사고이력</a></li>
                                    <li role="presentation" class="active <c:if test="${result.saveYn.option eq 'Y'}">complete</c:if>"><a href="${pageContext.request.contextPath}/item/register/option/${sellCarSeq}">옵션·전차주</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.perform eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}">제시·성능점검</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.disc eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}">설명</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.photo eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/photo/${sellCarSeq}">사진</a></li>
                                </c:otherwise>
                            </c:choose>


                            <%-- 판매중, 판매완료, 판매종료/삭제 and 최고관리자 --%>
                            <c:if test="${(result.carInfo.carStatCd ne null and result.carInfo.carStatCd ne 'D1001' and result.carInfo.carStatCd ne 'D1003') and (auth eq 'VW' or auth eq 'ADMIN')}">
                                <li role="presentation"><a href="${pageContext.request.contextPath}/item/register/sellMng/${sellCarSeq}">판매관리</a></li>
                            </c:if>
                        </ul>

                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="tab2">
                                <div class="box">

                                    <%-- 승인대기상태 and 최고관리자 --%>
                                    <c:if test="${result.carInfo.carStatCd eq 'D1001' and (auth eq 'VW' or auth eq 'ADMIN')}">
                                        <div class="bs-callout bs-callout-info">
                                            <p class="title">반려사유를 입력하세요.</p>
                                            <div class="form-group">
                                                <textarea name="reson" id="reson" cols="30" rows="5" class="form-control"></textarea>
                                            </div>
                                            <div class="text-right">
                                                <button type="button" class="btn btn-default" onclick="returnApply()">반려</button>
                                                <button type="button" class="btn btn-primary" onclick="approvalApply()">승인</button>
                                            </div>
                                        </div>
                                    </c:if>

                                    <%-- 반려일때 --%>
                                    <c:if test="${result.carInfo.carStatCd eq 'D1003'}">
                                        <div class="bs-callout bs-callout-danger">
                                            <p class="title"><i class="fa fa-warning fa-2x"></i> 반려사유를 확인하세요.</p>
                                            <p>${result.carInfo.reason}</p>
                                        </div>
                                    </c:if>


                                    <div class="box-header">
                                        <p>옵션을 선택하세요.</p>
                                    </div>
                                    <ul class="select-option option-table">
                                        <li>
                                            <strong class="head">외장</strong>
                                            <ul class="depth">
                                                <c:forEach items="${result.trim}" var="trim">
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="options" value="${trim.optSeq}" ${trim.checked}>
                                                            <c:choose>
                                                                <c:when test="${not empty trim.disc}">
                                                                    <span data-toggle="tooltip" data-placement="top" title="${trim.optNm} : ${trim.disc}">${trim.optNm}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span>${trim.optNm}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                        <li>
                                            <strong class="head">내장</strong>
                                            <ul class="depth">
                                                <c:forEach items="${result.viscus}" var="viscus">
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="options" value="${viscus.optSeq}" ${viscus.checked}>
                                                            <c:choose>
                                                                <c:when test="${not empty viscus.disc}">
                                                                    <span data-toggle="tooltip" data-placement="top" title="${viscus.optNm} : ${viscus.disc}">${viscus.optNm}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span>${viscus.optNm}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                        <li>
                                            <strong class="head">안전</strong>
                                            <ul class="depth">
                                                <c:forEach items="${result.safety}" var="safety">
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="options" value="${safety.optSeq}" ${safety.checked}>
                                                            <c:choose>
                                                                <c:when test="${not empty safety.disc}">
                                                                    <span data-toggle="tooltip" data-placement="top" title="${safety.optNm} : ${safety.disc}">${safety.optNm}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span>${safety.optNm}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                        <li>
                                            <strong class="head">편의</strong>
                                            <ul class="depth">
                                                <c:forEach items="${result.convenience}" var="convenience">
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="options" value="${convenience.optSeq}" ${convenience.checked}>
                                                            <c:choose>
                                                                <c:when test="${not empty convenience.disc}">
                                                                    <span data-toggle="tooltip" data-placement="top" title="${convenience.optNm} : ${convenience.disc}">${convenience.optNm}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span>${convenience.optNm}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                        <li>
                                            <strong class="head">멀티미디어</strong>
                                            <ul class="depth">
                                                <c:forEach items="${result.multimedia}" var="multimedia">
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="options" value="${multimedia.optSeq}" ${multimedia.checked}>
                                                            <c:choose>
                                                                <c:when test="${not empty multimedia.disc}">
                                                                    <span data-toggle="tooltip" data-placement="top" title="${multimedia.optNm} : ${multimedia.disc}">${multimedia.optNm}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span>${multimedia.optNm}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                                <div class="box">
                                    <div class="box-header">
                                        <p>전차주정보</p>
                                    </div>
                                    <table class="table table-horizontal table-bordered">
                                        <colgroup>
                                            <col style="width: 150px">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th><span class="asterisk">*</span>흡연 여부</th>
                                            <td>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="smokYn" value="N" <c:if test="${result.BfCarOwner.smokYn ne 'Y'}">checked</c:if>> 비흡연
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="smokYn" value="Y" <c:if test="${result.BfCarOwner.smokYn eq 'Y'}">checked</c:if>> 흡연
                                                    </label>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span class="asterisk">*</span>차량 용도</th>
                                            <td>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="carUse" value="C" <c:if test="${result.BfCarOwner.carUse ne 'L' and result.BfCarOwner.carUse ne 'B'}">checked</c:if>> 출퇴근
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="carUse" value="L" <c:if test="${result.BfCarOwner.carUse eq 'L'}">checked</c:if>> 레저
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="carUse" value="B" <c:if test="${result.BfCarOwner.carUse eq 'B'}">checked</c:if>> 영업
                                                    </label>
                                                </span>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="btns text-right">
                                    <c:if test="${result.carInfo.carStatCd eq null or result.carInfo.carStatCd eq 'D1003'}">
                                        <button type="button" class="btn btn-default" onclick="goLocPage('${pageContext.request.contextPath}/item/register/price/${sellCarSeq}')">이전</button>
                                        <button type="button" class="btn btn-default" onclick="goLocPage('${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}')">다음</button>
                                        <button type="button" class="btn btn-primary" onclick="tempSave()">임시저장</button>
                                    </c:if>
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


    (function() {
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
    })();

    /** 임시저장 */
    function tempSave(type, url) {

        if (type == 'modify') {
            if(!confirm('수정저장 시, 이전 상태로 복구 불가하며,\n홈페이지에 노출됩니다.\n수정 저장 하시겠습니까?')){
                return false;
            }
        }

        var options = new Array();

        $('input[name=options]:checked').each(function(){
            options.push($(this).val());
        });

        console.log(options);

        var _data = {};
        _data['sellCarSeq'] = '${result.carInfo.sellCarSeq}';
        _data['options'] = options;
        _data['smokYn'] = $('input[name=smokYn]:checked').val();
        _data['carUse'] = $('input[name=carUse]:checked').val();




        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/option/tempSave",
            type: "POST",
            data : _data,
            async: false,
            success: function(result) {
                if (result.rtnStr != 'SUCC') {
                    alert('임시저장에 실패하였습니다.');
                } else {
                    carDefaulSave(type, url);
                }
                /*
                if (result.reqApplyYn == 'Y') {
                    $('#requestApply').children('button').prop('disabled', false);
                } else {
                    $('#requestApply').children('button').prop('disabled', true);
                }
                */
            }
        });
    }

    function carDefaulSave(type, url) {
        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/update/defaultInfo",
            type: "POST",
            async: false,
            data : $('#itemForm').serialize(),
            success: function(result) {
                if("SUCC" == result) {
                    if (type == 'modify') {
                        alert('수정 저장 완료되었습니다.')
                    }

                    if (url != '' && url != null) {
                        location.href = url;
                    } else {
                        location.reload();
                    }
                } else {
                    alert('기본 정보 저장에 실패하였습니다.');
                }
            }
        });
    }

    /** 승인요청 */
    function requestApply() {
        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/carSellStat/requestApply",
            type: "POST",
            data : {sellCarSeq : '${result.carInfo.sellCarSeq}'},
            success: function(result) {
                if (result == 'SUCC') {
                    alert('승인신청되었습니다.');
                    location.reload();
                } else if (result == 'OVERLAP') {
                    alert('이미 승인신청된 매물입니다.');
                    location.reload();
                }
            }
        });
    }

    /** 반려 */
    function returnApply() {
        if ($.trim($('#reson').val()) == '') {
            alert('미입력 항목이 있습니다.');
            return false;
        }

        if (confirm('반려 하시겠습니까?')) {
            $.ajax({
                url: "${pageContext.request.contextPath}/item/register/carSellStat/returnApply",
                type: "POST",
                data : {sellCarSeq : '${result.carInfo.sellCarSeq}', reason : $('#reson').val()},
                success: function(result) {
                    if (result == 'SUCC') {
                        alert('반려 완료되었습니다.');
                        location.reload();
                    } else if (result == 'OVERLAP') {
                        alert('이미 반려된 매물입니다.');
                        location.reload();
                    }
                }
            });
        }
    }

    /** 승인 */
    function approvalApply() {
        if (confirm('승인 하시면, 홈페이지에 노출됩니다.\n승인하시겠습니까?')) {
            $.ajax({
                url: "${pageContext.request.contextPath}/item/register/carSellStat/approvalApply",
                type: "POST",
                data : {sellCarSeq : '${result.carInfo.sellCarSeq}'},
                success: function(result) {
                    if (result == 'SUCC') {
                        alert('승인 완료되었습니다.');
                        location.reload();
                    } else if (result == 'OVERLAP') {
                        alert('이미 승인완료된 매물입니다.');
                        location.reload();
                    }
                }
            });
        }
    }

    function goLocPage(url) {
        tempSave(null, url);
    }

    /** 미리보기 */
    function beforehandView() {
        window.open('${pageContext.request.contextPath}/item/register/preview/${sellCarSeq}');
    }


</script>