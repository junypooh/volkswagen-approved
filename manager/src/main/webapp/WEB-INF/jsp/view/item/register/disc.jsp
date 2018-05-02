<%--
  Created by IntelliJ IDEA.
  User: DaDa
  Date: 2018-01-26
  Time: 오전 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                                    <li role="presentation" <c:if test="${result.saveYn.option eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/option/${sellCarSeq}')">옵션·전차주</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.perform eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}')">제시·성능점검</a></li>
                                    <li role="presentation" class="active <c:if test="${result.saveYn.disc eq 'Y'}">complete</c:if>"><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}')">설명</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.photo eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/photo/${sellCarSeq}')">사진</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li role="presentation" <c:if test="${result.saveYn.price eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/price/${sellCarSeq}">가격·사고이력</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.option eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/option/${sellCarSeq}">옵션·전차주</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.perform eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}">제시·성능점검</a></li>
                                    <li role="presentation" class="active <c:if test="${result.saveYn.disc eq 'Y'}">complete</c:if>"><a href="${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}">설명</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.photo eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/photo/${sellCarSeq}">사진</a></li>
                                </c:otherwise>
                            </c:choose>
                            <%-- 판매중, 판매완료, 판매종료/삭제 and 최고관리자 --%>
                            <c:if test="${(result.carInfo.carStatCd ne null and result.carInfo.carStatCd ne 'D1001' and result.carInfo.carStatCd ne 'D1003') and (auth eq 'VW' or auth eq 'ADMIN')}">
                                <li role="presentation"><a href="${pageContext.request.contextPath}/item/register/sellMng/${sellCarSeq}">판매관리</a></li>
                            </c:if>
                        </ul>

                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="tab4">
                                <form:form id="frm">
                                    <input type="hidden" name="sellCarSeq" value="${result.carInfo.sellCarSeq}">
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
                                            <p>판매자 정보를 확인하세요.</p>
                                        </div>
                                        <div class="row seller-info">
                                            <div class="col-xs-12">
                                                <table class="table table-horizontal table-bordered" id="hallContent">
                                                    <tr>
                                                        <th>전시장 선택</th>
                                                        <td>
                                                            <div class="form-inline">
                                                                <span class="select">
                                                                    <select name="exhHallSeq" id="exhHallSeq" class="form-control" onchange="hallChange()">
                                                                        <c:forEach items="${result.hallList}" var="hallList">
                                                                            <option value="${hallList.exhHallSeq}" <c:if test="${hallList.exhHallSeq == result.hallVo.exhHallSeq}">selected</c:if>>${hallList.type} ${hallList.storeNm}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>전시장명</th>
                                                        <td>폭스바겐 공식 인증 중고차  <strong>${result.hallVo.type} ${result.hallVo.storeNm}</strong></td>
                                                    </tr>
                                                    <tr>
                                                        <th>주소</th>
                                                        <td>${result.hallVo.sigun} ${result.hallVo.addr} ${result.hallVo.detailAddr}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>대표번호</th>
                                                        <td>${result.hallVo.tel}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>대표 이메일</th>
                                                        <td>${result.hallVo.email}</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box">
                                        <div class="box-header">
                                            <p>설명글을 입력하세요.</p>
                                        </div>
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <strong>매물 판매자 한마디</strong> <small>(매물에 대한 요약 정보를 입력하세요)</small>
                                            </div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        <input type="text" name="sellDisc" id="sellDisc" class="form-control" value="${result.discVo.sellDisc}">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="panel-heading">
                                                <strong>매물 태그</strong> <small>(최대 3개까지 선택 가능합니다.)</small>
                                            </div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        <div class="select-tags">
                                                            <c:forEach items="${result.tagList}" var="tagList">
                                                                <label>
                                                                    <input type="checkbox" name="tagSeqs" value="${tagList.tagSeq}" ${tagList.checked}>
                                                                    <span>${tagList.tagNm}</span>
                                                                </label>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="panel-heading">
                                                <div class="row">
                                                    <div class="col-xs-10">
                                                        <div class="form-inline">
                                                            <strong>설명글</strong>
                                                            <label>
                                                                <input type="radio" name="discType" value="D" <c:if test="${result.discVo.discType ne 'M'}">checked</c:if>>
                                                                <span>직접 입력</span>
                                                            </label>
                                                            <label>
                                                                <input type="radio" name="discType" value="M" <c:if test="${result.discVo.discType eq 'M'}">checked</c:if>>
                                                                <span>내 설명글</span>
                                                            </label>
                                                            <span class="select">
                                                                <select name="myDiscList" id="myDiscList" class="form-control" onchange="myDiscMngChange()" <c:if test="${result.discVo.discType ne 'M'}">disabled</c:if>>
                                                                    <option value="">내 설명글 선택 (${fn:length(result.myDiscList)})</option>
                                                                    <c:forEach items="${result.myDiscList}" var="myDiscList">
                                                                        <option value="${myDiscList.discSeq}">${myDiscList.discNm}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-2 text-right">
                                                        <button type="button" class="btn btn-primary btn-sm" onclick="resetDisc()"><i class="fa fa-refresh"></i> 내용 초기화</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        <textarea name="discWrit" id="discWrit" cols="30" rows="10" class="form-control">${result.discVo.discWrit}</textarea>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="btns text-right">
                                        <c:if test="${result.carInfo.carStatCd eq null or result.carInfo.carStatCd eq 'D1003'}">
                                            <button type="button" class="btn btn-default" onclick="goLocPage('${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}')">이전</button>
                                            <button type="button" class="btn btn-default" onclick="goLocPage('${pageContext.request.contextPath}/item/register/photo/${sellCarSeq}')">다음</button>
                                            <button type="button" class="btn btn-primary" onclick="tempSave()">임시저장</button>
                                        </c:if>
                                    </div>
                                </form:form>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">


    var inputDisc = null;
    $(document).ready(function() {
        // 설명글 라디오 버튼 이벤트
        $('input[name=discType]').change(function(){
            // console.log($(this).val());
            if ( $(this).val() == 'M') {
                $('#myDiscList').prop('disabled', false);
                inputDisc = $('#discWrit').val();
                //$('#myDiscList').val($('#myDiscList').find('option:eq(0)').val()).change();
            } else {
                $('#myDiscList').prop('disabled', true);
                $('#myDiscList').val('');
                $('#discWrit').val(inputDisc);
            }
        });

        // 매물태그 선택시
        $('input[name=tagSeqs]').click(function(){
            if ($('input[name=tagSeqs]:checked').length > 3) {
                alert('매물태그는 3개까지 선택 가능합니다.');
                $(this).prop('checked', false);
            }

        });
    });

    /** 전시장 선택 Change */
    function hallChange() {
        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/disc/exhHall",
            type: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType : 'HTML',
            traditional: true,
            data : {'exhHallSeq': $('#exhHallSeq').val(), 'sellCarSeq':'${sellCarSeq}'},
            success: function(result) {
                $('#hallContent').empty().append($(result).find('#hallContent').html());
            }
        });
    }

    /** 내설명글 Change */
    function myDiscMngChange() {
        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/disc/myDiscMng",
            type: "POST",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data : {'discSeq': $('#myDiscList').val()},
            dataType : 'TEXT',
            success: function(result) {
                $('#discWrit').val(result);
            }
        });

    }

    /** 내용 초기화 */
    function resetDisc() {
        // 매장 초기화
        //$('#exhHallSeq').val($('#exhHallSeq').find('option:eq(0)').val()).change();

        // 매물판매자 한마디 초기화
        //$('#sellDisc').val('');

        // 매물태그 초기화
        //$('input[name=tagSeqs]').prop('checked', false);

        // 설명글 Radio 초기화
        $('input[name=discType][value=D]').prop('checked', true);
        $('input[name=discType][value=D]').change();

        // 설명글 초기화
        $('#discWrit').val('');
    }

    /** 임시저장 */
    function tempSave(type, url) {

        if (type == 'modify') {
            if(!confirm('수정저장 시, 이전 상태로 복구 불가하며,\n홈페이지에 노출됩니다.\n수정 저장 하시겠습니까?')){
                return false;
            }
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/disc/tempSave",
            type: "POST",
            data : $('#frm').serialize(),
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
