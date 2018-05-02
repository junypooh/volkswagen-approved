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
                                    <li role="presentation" class="active <c:if test="${result.saveYn.price eq 'Y'}">complete</c:if>"><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/price/${sellCarSeq}')">가격·사고이력</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.option eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/option/${sellCarSeq}')">옵션·전차주</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.perform eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}')">제시·성능점검</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.disc eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}')">설명</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.photo eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/photo/${sellCarSeq}')">사진</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li role="presentation" class="active <c:if test="${result.saveYn.price eq 'Y'}">complete</c:if>"><a href="${pageContext.request.contextPath}/item/register/price/${sellCarSeq}">가격·사고이력</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.option eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/option/${sellCarSeq}">옵션·전차주</a></li>
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
                            <div role="tabpanel" class="tab-pane active" id="tab1">
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



                                    <div class="box-header"><p>가격을 입력하세요.</p></div>
                                    <table class="table table-horizontal table-bordered">
                                        <colgroup>
                                            <col style="width: 150px">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th><span class="asterisk">*</span>판매구분</th>
                                            <td>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="sellType" value="G" <c:if test="${result.info.sellType ne 'L'}">checked="checked"</c:if>> 일반차량
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="sellType" value="L" <c:if test="${result.info.sellType eq 'L'}">checked="checked"</c:if>> 리스승계차량
                                                    </label>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span class="asterisk">*</span>판매가격</th>
                                            <td>
                                                <div class="form-inline">
                                                    <input type="text" name="sellPrice" id="sellPrice" value="<fmt:formatNumber value="${result.info.sellPrice}" pattern="#,###"/>" class="form-control" onkeyup="limitByteNumberPrice(this)" limitByte="5"> 만원
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>월 납입금</th>
                                            <td>
                                                <div class="form-inline">
                                                    <input type="text" name="monPayment" id="monPayment" value="<fmt:formatNumber value="${result.info.monPayment}" pattern="#,###"/>" class="form-control" onkeyup="limitByteNumberPrice(this)" limitByte="5"> 만원
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <small class="help-block">
                                        중고차 시세, 팔린/동급 매물 가격을 참고하여 적절한 판매 가격을 제시해 보세요.<br>할부/리스 차량은 선납금, 잔여 개월 수 등을 고려하여 실 판매가로 입력해 주세요.
                                    </small>
                                </div>


                                <c:if test="${result.carInfo.certYn eq 'Y'}">
                                    <div class="box">
                                        <div class="box-header">
                                            <p>인증차량 공식 정비내역서 정보를 입력하세요.</p>
                                        </div>
                                        <table class="table table-horizontal table-bordered">
                                            <colgroup>
                                                <col style="width: 15%">
                                                <col>
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th>
                                                    <span class="asterisk">*</span> 88가지 품질 점검일</th>
                                                <td>
                                                    <div class="form-inline ">
                                                        <div class="">
                                                            <div class="input-group">
                                                                <input type="text" class="form-control datetimepicker" name="qualityChkDay" id="qualityChkDay" value="${result.info.qualityChkDay}" placeholder="">
                                                                <span class="input-group-addon">
                                                                    <i class="fa fa-calendar"></i>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>

                                        <table class="table table-horizontal table-bordered">
                                            <colgroup>
                                                <col style="width: 15%">
                                                <col style="width: 35%">
                                                <col style="width: 15%">
                                                <col style="width: 35%">
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th colspan="4">차량 정보</th>
                                            </tr>
                                            <tr>
                                                <th>차량 모델</th>
                                                <td>${result.carInfo.model} ${result.carInfo.detailModel} ${result.carInfo.rating}</td>
                                                <th>사고 유무</th>
                                                <td>${result.info.accidHisNm}</td>
                                            </tr>
                                            <tr>
                                                <th>차량 색상</th>
                                                <td>${result.carInfo.color}</td>
                                                <th>주행거리</th>
                                                <td><fmt:formatNumber value="${result.carInfo.driveDist}" pattern="#,###"/></td>
                                            </tr>
                                            <tr>
                                                <th>차대 번호</th>
                                                <td>
                                                    <input type="text" name="" class="form-control" value="${result.info.chasNo}" readonly>
                                                </td>
                                                <th>등록일</th>
                                                <fmt:parseDate value="${result.carInfo.prodYear}" var="prodDate" pattern="yyyyMM"/>
                                                <td><fmt:formatDate value="${prodDate}" pattern="yyyy년 MM 월"/></td>
                                            </tr>
                                            </tbody>
                                        </table>

                                        <table class="table table-vertical table-bordered">
                                            <colgroup>
                                                <col style="width: 5%">
                                                <col style="width: 45%">
                                                <col style="width: 15%">
                                                <col style="width: 35%">
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th colspan="2">
                                                    <div class="text-left">
                                                        <span class="asterisk">*</span> 기본 점검
                                                    </div>
                                                </th>
                                                <th>
                                                    <span class="one-third">정상</span>
                                                    <span class="one-third">이상</span>
                                                    <span class="one-third">수리</span>
                                                </th>
                                                <th>수리/교환 내역</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${result.quality1}" var="quality1">
                                                <tr>
                                                    <input type="hidden" name="cd" value="${quality1.cd}">
                                                    <td>${quality1.no}</td>
                                                    <td class="text-left">${quality1.cdNm}</td>
                                                    <td>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality1.cd}" value="Y" title="정상" <c:if test="${quality1.confYn ne 'N' and quality1.confYn ne 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality1.cd}" value="N" title="이상" <c:if test="${quality1.confYn eq 'N'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality1.cd}" value="T" title="수리" <c:if test="${quality1.confYn eq 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="repairCtnt" class="form-control" value="${quality1.repairCtnt}">
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>

                                        <table class="table table-vertical table-bordered">
                                            <colgroup>
                                                <col style="width: 5%">
                                                <col style="width: 45%">
                                                <col style="width: 15%">
                                                <col style="width: 35%">
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th colspan="2">
                                                    <div class="text-left"><span class="asterisk">*</span> 실내 운전석에서 점검</div>
                                                </th>
                                                <th>
                                                    <span class="one-third">정상</span>
                                                    <span class="one-third">이상</span>
                                                    <span class="one-third">수리</span>
                                                </th>
                                                <th>수리/교환 내역</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${result.quality2}" var="quality2">
                                                <tr>
                                                    <input type="hidden" name="cd" value="${quality2.cd}">
                                                    <td>${quality2.no}</td>
                                                    <td class="text-left">${quality2.cdNm}</td>
                                                    <td>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality2.cd}" value="Y" title="정상" <c:if test="${quality2.confYn ne 'N' and quality2.confYn ne 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality2.cd}" value="N" title="이상" <c:if test="${quality2.confYn eq 'N'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality2.cd}" value="T" title="수리" <c:if test="${quality2.confYn eq 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="repairCtnt" class="form-control" value="${quality2.repairCtnt}">
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <table class="table table-vertical table-bordered">
                                            <colgroup>
                                                <col style="width: 5%">
                                                <col style="width: 45%">
                                                <col style="width: 15%">
                                                <col style="width: 35%">
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th colspan="2">
                                                    <div class="text-left"><span class="asterisk">*</span> 진단기 점검</div>
                                                </th>
                                                <th>
                                                    <span class="one-third">정상</span>
                                                    <span class="one-third">이상</span>
                                                    <span class="one-third">수리</span>
                                                </th>
                                                <th>수리/교환 내역</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${result.quality3}" var="quality3">
                                                <tr>
                                                    <input type="hidden" name="cd" value="${quality3.cd}">
                                                    <td>${quality3.no}</td>
                                                    <td class="text-left">${quality3.cdNm}</td>
                                                    <td>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality3.cd}" value="Y" title="정상" <c:if test="${quality3.confYn ne 'N' and quality3.confYn ne 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality3.cd}" value="N" title="이상" <c:if test="${quality3.confYn eq 'N'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality3.cd}" value="T" title="수리" <c:if test="${quality3.confYn eq 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="repairCtnt" class="form-control" value="${quality3.repairCtnt}">
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <table class="table table-vertical table-bordered">
                                            <colgroup>
                                                <col style="width: 5%">
                                                <col style="width: 45%">
                                                <col style="width: 15%">
                                                <col style="width: 35%">
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th colspan="2">
                                                    <div class="text-left"><span class="asterisk">*</span> 등화류 점검</div>
                                                </th>
                                                <th>
                                                    <span class="one-third">정상</span>
                                                    <span class="one-third">이상</span>
                                                    <span class="one-third">수리</span>
                                                </th>
                                                <th>수리/교환 내역</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${result.quality4}" var="quality4">
                                                <tr>
                                                    <input type="hidden" name="cd" value="${quality4.cd}">
                                                    <td>${quality4.no}</td>
                                                    <td class="text-left">${quality4.cdNm}</td>
                                                    <td>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality4.cd}" value="Y" title="정상" <c:if test="${quality4.confYn ne 'N' and quality4.confYn ne 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality4.cd}" value="N" title="이상" <c:if test="${quality4.confYn eq 'N'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality4.cd}" value="T" title="수리" <c:if test="${quality4.confYn eq 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="repairCtnt" class="form-control" value="${quality4.repairCtnt}">
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <table class="table table-vertical table-bordered">
                                            <colgroup>
                                                <col style="width: 5%">
                                                <col style="width: 45%">
                                                <col style="width: 15%">
                                                <col style="width: 35%">
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th colspan="2">
                                                    <div class="text-left"><span class="asterisk">*</span> 차량 전방 및 엔진룸 점검</div>
                                                </th>
                                                <th>
                                                    <span class="one-third">정상</span>
                                                    <span class="one-third">이상</span>
                                                    <span class="one-third">수리</span>
                                                </th>
                                                <th>수리/교환 내역</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${result.quality5}" var="quality5">
                                                <tr>
                                                    <input type="hidden" name="cd" value="${quality5.cd}">
                                                    <td>${quality5.no}</td>
                                                    <td class="text-left">${quality5.cdNm}</td>
                                                    <td>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality5.cd}" value="Y" title="정상" <c:if test="${quality5.confYn ne 'N' and quality5.confYn ne 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality5.cd}" value="N" title="이상" <c:if test="${quality5.confYn eq 'N'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality5.cd}" value="T" title="수리" <c:if test="${quality5.confYn eq 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="repairCtnt" class="form-control" value="${quality5.repairCtnt}">
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <table class="table table-vertical table-bordered">
                                            <colgroup>
                                                <col style="width: 5%">
                                                <col style="width: 45%">
                                                <col style="width: 15%">
                                                <col style="width: 35%">
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th colspan="2">
                                                    <div class="text-left"><span class="asterisk">*</span> 소모품 점검</div>
                                                </th>
                                                <th>
                                                    <span class="one-third">정상</span>
                                                    <span class="one-third">이상</span>
                                                    <span class="one-third">수리</span>
                                                </th>
                                                <th>수리/교환 내역</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${result.quality6}" var="quality6">
                                                <tr>
                                                    <input type="hidden" name="cd" value="${quality6.cd}">
                                                    <td>${quality6.no}</td>
                                                    <td class="text-left">${quality6.cdNm}</td>
                                                    <td>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality6.cd}" value="Y" title="정상" <c:if test="${quality6.confYn ne 'N' and quality6.confYn ne 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality6.cd}" value="N" title="이상" <c:if test="${quality6.confYn eq 'N'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality6.cd}" value="T" title="수리" <c:if test="${quality6.confYn eq 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="repairCtnt" class="form-control" value="${quality6.repairCtnt}">
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <table class="table table-vertical table-bordered">
                                            <colgroup>
                                                <col style="width: 5%">
                                                <col style="width: 45%">
                                                <col style="width: 15%">
                                                <col style="width: 35%">
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th colspan="2">
                                                    <div class="text-left"><span class="asterisk">*</span> 시운전 점검</div>
                                                </th>
                                                <th>
                                                    <span class="one-third">정상</span>
                                                    <span class="one-third">이상</span>
                                                    <span class="one-third">수리</span>
                                                </th>
                                                <th>수리/교환 내역</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${result.quality7}" var="quality7">
                                                <tr>
                                                    <input type="hidden" name="cd" value="${quality7.cd}">
                                                    <td>${quality7.no}</td>
                                                    <td class="text-left">${quality7.cdNm}</td>
                                                    <td>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality7.cd}" value="Y" title="정상" <c:if test="${quality7.confYn ne 'N' and quality7.confYn ne 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality7.cd}" value="N" title="이상" <c:if test="${quality7.confYn eq 'N'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality7.cd}" value="T" title="수리" <c:if test="${quality7.confYn eq 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="repairCtnt" class="form-control" value="${quality7.repairCtnt}">
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <table class="table table-vertical table-bordered">
                                            <colgroup>
                                                <col style="width: 5%">
                                                <col style="width: 45%">
                                                <col style="width: 15%">
                                                <col style="width: 35%">
                                            </colgroup>
                                            <thead>
                                            <tr>
                                                <th colspan="2">
                                                    <div class="text-left"><span class="asterisk">*</span> 베이/리프팅 점검</div>
                                                </th>
                                                <th>
                                                    <span class="one-third">정상</span>
                                                    <span class="one-third">이상</span>
                                                    <span class="one-third">수리</span>
                                                </th>
                                                <th>수리/교환 내역</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${result.quality8}" var="quality8">
                                                <tr>
                                                    <input type="hidden" name="cd" value="${quality8.cd}">
                                                    <td>${quality8.no}</td>
                                                    <td class="text-left">${quality8.cdNm}</td>
                                                    <td>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality8.cd}" value="Y" title="정상" <c:if test="${quality8.confYn ne 'N' and quality8.confYn ne 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality8.cd}" value="N" title="이상" <c:if test="${quality8.confYn eq 'N'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                        <span class="one-third">
                                                            <label>
                                                                <input type="radio" name="${quality8.cd}" value="T" title="수리" <c:if test="${quality8.confYn eq 'T'}">checked</c:if>>
                                                            </label>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="repairCtnt" class="form-control" value="${quality8.repairCtnt}">
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>

                                        <table class="table table-vertical table-bordered">
                                            <colgroup>
                                                <col style="width: 33%">
                                                <col style="width: 33%">
                                                <col>
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th colspan="3">점검자 서명</th>
                                            </tr>
                                            <tr>
                                                <th class="text-center"><span class="asterisk">*</span> 테크니션</th>
                                                <td>
                                                    <div class="form-inline ">
                                                        <div class="">
                                                            <div class="input-group">
                                                                <input type="text" class="form-control datetimepicker" id="techDate" name="" value="${result.info.techDate}" placeholder="">
                                                                <span class="input-group-addon">
                                                                    <i class="fa fa-calendar"></i>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control text-center" id="techNm" name="" value="${result.info.techNm}" placeholder="성명을 입력하세요">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="text-center">서비스 어드바이저</th>
                                                <td>
                                                    <div class="form-inline ">
                                                        <div class="">
                                                            <div class="input-group">
                                                                <input type="text" class="form-control datetimepicker" id="svcAdvDate" name="" value="${result.info.svcAdvDate}" placeholder="">
                                                                <span class="input-group-addon">
                                                                    <i class="fa fa-calendar"></i>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control text-center" id="svcAdvNm" name="" value="${result.info.svcAdvNm}" placeholder="성명을 입력하세요">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="text-center"><span class="asterisk">*</span> 서비스 매니저</th>
                                                <td>
                                                    <div class="form-inline ">
                                                        <div class="">
                                                            <div class="input-group">
                                                                <input type="text" class="form-control datetimepicker" id="svcMngDate" name="" value="${result.info.svcMngDate}" placeholder="">
                                                                <span class="input-group-addon">
                                                                    <i class="fa fa-calendar"></i>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control text-center" id="svcMngNm" name="" value="${result.info.svcMngNm}" placeholder="성명을 입력하세요">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="text-center"><span class="asterisk">*</span> 인증 중고차 매니저</th>
                                                <td>
                                                    <div class="form-inline ">
                                                        <div class="">
                                                            <div class="input-group">
                                                                <input type="text" class="form-control datetimepicker" id="authCarDate" name="" value="${result.info.authCarDate}" placeholder="">
                                                                <span class="input-group-addon">
                                                                    <i class="fa fa-calendar"></i>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <input type="text" class="form-control text-center" id="authCarNm" name="" value="${result.info.authCarNm}" placeholder="성명을 입력하세요">
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>





















<%--
                                <c:if test="${result.carInfo.certYn eq 'Y'}">
                                    <div class="box">
                                        <div class="box-header"><p>인증차량 공식 정비내역서 정보를 입력하세요.</p></div>
                                        <table class="table table-horizontal table-bordered">
                                            <colgroup>
                                                <col style="width: 150px">
                                                <col>
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th><span class="asterisk">*</span>88가지 품질 점검일</th>
                                                <td>
                                                    <div class="form-inline ">
                                                        <input type="text" class="form-control datetimepicker" name="qualityChkDay" id="qualityChkDay" value="${result.info.qualityChkDay}" placeholder="">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th><span class="asterisk">*</span>88가지 품질 정비내역서</th>
                                                <td>
                                                    <form:form id="fileForm"  method="post" enctype="multipart/form-data">
                                                        <input type="file" name="uploadFile" id="uploadFile">
                                                        <input type="hidden" name="type" value="PRICE" />
                                                        <input type="hidden" name="fileSeq" id="fileSeq" value="${result.info.qualityFile.fileSeq}" />
                                                    </form:form>
                                                    <c:if test="${result.info.qualityFile.fileSeq ne '' and result.info.qualityFile.fileSeq ne null}">
                                                        <p class="file-name">
                                                            <a href="#none">${result.info.qualityFile.oriFileNm}</a>
                                                            <button type="button" onclick="removeFile()"><em>x</em></button>
                                                        </p>
                                                    </c:if>
                                                    <small class="help-block">
                                                        파일 형식 : PNG, JPG, JPGE, PDF / 파일 크기 : 10MB
                                                    </small>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                                --%>
<%--

                                <c:if test="${result.carInfo.certYn eq 'Y'}">
                                    <div class="box">
                                        <div class="box-header"><p>인증차량 공식 정비내역서 및 잔여 혜택 정보를 입력하세요.</p></div>
                                        <table class="table table-horizontal table-bordered" id="device-list">
                                            <colgroup>
                                                <col style="width: 150px">
                                                <col style="width: 150px">
                                                <col>
                                            </colgroup>
                                            <tbody>

                                            <tr>
                                                <th colspan="2">정비내역서</th>
                                                <td>
                                                    <form:form id="fileForm"  method="post" enctype="multipart/form-data">
                                                        <input type="file" name="uploadFile" id="uploadFile">
                                                        <input type="hidden" name="type" value="PRICE" />
                                                        <input type="hidden" name="fileSeq" id="fileSeq" value="${result.info.fileSeq}" />
                                                    </form:form>
                                                    <c:if test="${result.info.fileSeq ne '' and result.info.fileSeq ne null}">
                                                        <p class="file-name">
                                                            <a href="#none">${result.fileInfo.oriFileNm}</a>
                                                            <button type="button" onclick="removeFile()"><em>x</em></button>
                                                        </p>
                                                    </c:if>
                                                    <small class="help-block">
                                                        파일 형식 : PNG, JPG, JPGE, PDF / 파일 크기 : 10MB
                                                    </small>
                                                </td>
                                            </tr>

                                            <tr>
                                                <th colspan="2">Warranty (잔여)</th>
                                                <td>
                                                    <div class="form-inline">
                                                        <select name="wrt" id="wrt" class="form-control">
                                                            <option value="0" <c:if test="${result.info.wrt eq '0'}">selected</c:if>>없음</option>
                                                            <c:forEach var="i" begin="1" end="24" step="1">
                                                                <option value="${i}" <c:if test="${result.info.wrt eq i}">selected</c:if>>${i}</option>
                                                            </c:forEach>
                                                        </select>
                                                        개월
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th colspan="2">Warranty Plus (잔여)</th>
                                                <td>
                                                    <div class="form-inline">
                                                        <select name="wrtPlus" id="wrtPlus" class="form-control">
                                                            <option value="0" <c:if test="${result.info.wrtPlus eq '0'}">selected</c:if>>없음</option>
                                                            <c:forEach var="i" begin="1" end="24" step="1">
                                                                <option value="${i}" <c:if test="${result.info.wrtPlus eq i}">selected</c:if>>${i}</option>
                                                            </c:forEach>
                                                        </select>
                                                        개월
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr v-for="item in item">
                                                <th v-html="item.device"></th>
                                                <th v-html="item.item"></th>
                                                <td>
                                                    <span class="radio-inline" v-for="radio in item.state"><label><input type="radio" :name="item.cd" :value="radio.value" :checked="radio.checked"> {{radio.text}}</label></span>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
--%>



                                <div class="box">
                                    <div class="box-header"><p>압류/저당을 선택하세요.</p></div>
                                    <table class="table table-horizontal table-bordered">
                                        <colgroup>
                                            <col style="width:150px">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th>압류</th>
                                            <td>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="seize" value="N" <c:if test="${result.info.seize ne 'Y' and result.info.seize ne 'T'}">checked="checked"</c:if>> 없음
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="seize" value="Y" <c:if test="${result.info.seize eq 'Y'}">checked="checked"</c:if>> 있음
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="seize" value="T" <c:if test="${result.info.seize eq 'T'}">checked="checked"</c:if>> 정보없음
                                                    </label>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>저당</th>
                                            <td>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="pled" value="N" <c:if test="${result.info.pled ne 'Y' and result.info.pled ne 'T'}">checked="checked"</c:if>> 없음
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="pled" value="Y" <c:if test="${result.info.pled eq 'Y'}">checked="checked"</c:if>> 있음
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="pled" value="T" <c:if test="${result.info.pled eq 'T'}">checked="checked"</c:if>> 정보없음
                                                    </label>
                                                </span>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <small class="help-block">
                                        판매차량의 자동차등록원부에 기재되어 있는 압류/저당 정보를 입력해 주세요.
                                    </small>
                                </div>

                                <div class="box">
                                    <div class="box-header">
                                        <p>사고이력을 선택하세요.</p>
                                        <!-- <button class="btn btn-default btn-sm pull-right" data-toggle="modal" data-target="#accidentHistory">자세히 보기</button> -->
                                    </div>

                                    <table class="table table-horizontal table-bordered">
                                        <colgroup>
                                            <col style="width:150px">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th>사고이력</th>
                                            <td>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="accidHisYn" value="N" <c:if test="${result.info.accidHisYn ne 'Y' and result.info.accidHisYn ne 'T'}">checked="checked"</c:if>> 없음
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
													<label>
														<input type="radio" name="accidHisYn" value="Y" <c:if test="${result.info.accidHisYn eq 'Y'}">checked="checked"</c:if>> 있음
													</label>
												</span>
                                                <span class="radio-inline">
													<label>
												    	<input type="radio" name="accidHisYn" value="T" <c:if test="${result.info.accidHisYn eq 'T'}">checked="checked"</c:if>> 비공개
													</label>
												</span>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <small class="help-block">
                                        성능점검표 기준으로 사고유무를 체크해 주세요.
                                    </small>
                                </div>
                                <div class="btns text-right">
                                    <c:if test="${result.carInfo.carStatCd eq null or result.carInfo.carStatCd eq 'D1003'}">
                                        <button type="button" class="btn btn-default" disabled="disabled">이전</button>
                                        <button type="button" class="btn btn-default" onclick="goLocPage('${pageContext.request.contextPath}/item/register/option/${sellCarSeq}')">다음</button>
                                        <button type="button" class="btn btn-primary" onclick="tempSave()">임시저장</button>
                                        <%--<button type="button" class="btn btn-primary" onclick="test()">임시저장</button>--%>
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
    $(document).ready(function(){
        /* 인증차량 계층 구조 스크립트 */
        var deviceTable = new Vue({
            el: '#device-list tbody',
            data: {
                item: ${result.jsonData}
            },
            created: function() {
                setTimeout(function() {
                    $("#device-list").rowspanizer(
                        defaults = {vertical_align: ""}
                    );
                });
            }
        });

        /* 첨부파일 추가 */
        $('#uploadFile').change(function(){

            if ($('#fileSeq').val() != '') {
                alert('한개의 파일만 첨부 가능합니다.');
                resetFile();
                return false;
            }

            var ext = $('#uploadFile').val().split('.').pop().toLowerCase();
            if ($.inArray(ext, ['png', 'jpg', 'jpge', 'pdf']) == -1) {
                alert('png, jpg, jpge, pdf 파일만 등록 가능합니다.');
                resetFile();
                return false;
            }

            $("#fileForm").ajaxForm({
                url : "${pageContext.request.contextPath}/file/upload",
                dataType: 'text',
                success:function(data, status){
                    var response = JSON.parse(data);
                    console.log(response);
                    console.log(response.fileSeq);

                    if (response.fileSize > 10 * 1024 * 1024) {
                        alert('10MB 이하로 업로드 해주세요.');
                        resetFile();
                        return false;
                    }

                    $('#fileSeq').val(response.fileSeq);
                    $('.file-name').show();
                    $('.file-name a').text(response.oriFileName);
                }
            }).submit();
        });



        $('.datetimepicker').datetimepicker({
            format: 'YYYY.MM.DD',
            locale: "kr"
        });

    });


    /** 첨부파일 초기화 */
    function resetFile() {
        var agent = navigator.userAgent.toLowerCase();
        if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
            $("#uploadFile").replaceWith( $("#uploadFile").clone(true) );
        } else{
            $('#uploadFile').val('');
        }
    }

    /** 임시저장 */
    function tempSave(type, url) {

        if (type == 'modify') {
            if(!confirm('수정저장 시, 이전 상태로 복구 불가하며,\n홈페이지에 노출됩니다.\n수정 저장 하시겠습니까?')){
                return false;
            }
        }

        var detailCds = new Array();
        $('input[name^=E]:checked').each(function(){
            detailCds.push($(this).val());
        });

        var _data = {};
        _data['sellCarSeq']     = '${result.carInfo.sellCarSeq}';
        _data['sellType']       = $('input[name=sellType]').val();
        _data['sellPrice']      = $('#sellPrice').val().split(',').join('');
        _data['monPayment']     = $('#monPayment').val().split(',').join('');
        _data['qualityChkDay']  = $('#qualityChkDay').val();
        _data['fileSeq']        = $('#fileSeq').val();
        _data['wrt']            = $('#wrt').val();
        _data['wrtPlus']        = $('#wrtPlus').val();
        _data['seize']          = $('input[name=seize]:checked').val();
        _data['pled']           = $('input[name=pled]:checked').val();
        _data['accidHisYn']     = $('input[name=accidHisYn]:checked').val();
        _data['detailCds']      = detailCds;


        // 88가지 품질 점검 정비내역 리스트
        $('input[name=cd]').each(function(i) {
            _data['qualityList['+i+'].cd']         = $(this).val();
            _data['qualityList['+i+'].confYn']     = $('input[name='+$(this).val()+']:checked').val();
            _data['qualityList['+i+'].repairCtnt'] = $(this).parent().children(':last').find('input[name=repairCtnt]').val();

        });

        _data['techDate']       = $('#techDate').val();
        _data['techNm']         = $('#techNm').val();
        _data['svcAdvDate']     = $('#svcAdvDate').val();
        _data['svcAdvNm']       = $('#svcAdvNm').val();
        _data['svcMngDate']     = $('#svcMngDate').val();
        _data['svcMngNm']       = $('#svcMngNm').val();
        _data['authCarDate']    = $('#authCarDate').val();
        _data['authCarNm']      = $('#authCarNm').val();

        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/price/tempSave",
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

    /** 첨부파일 삭제 */
    function removeFile() {
        $('#fileSeq').val('');
        $('.file-name').hide();
    }

    function goLocPage(url) {
        tempSave(null, url);
    }

    /** 미리보기 */
    function beforehandView() {
        window.open('${pageContext.request.contextPath}/item/register/preview/${sellCarSeq}');
    }

    function test() {
        console.log('a');

        var _data = {};

        $('input[name=cd]').each(function(i) {

            _data['qualityList['+i+'].cd']         = $(this).val();
            _data['qualityList['+i+'].confYn']     = $('input[name='+$(this).val()+']:checked').val();
            _data['qualityList['+i+'].repairCtnt'] = $(this).parent().children(':last').find('input[name=repairCtnt]').val();

        });

        _data['techDate']       = $('#techDate').val();
        _data['techNm']         = $('#techNm').val();
        _data['svcAdvDate']     = $('#svcAdvDate').val();
        _data['svcAdvNm']       = $('#svcAdvNm').val();
        _data['svcMngDate']     = $('#svcMngDate').val();
        _data['svcMngNm']       = $('#svcMngNm').val();
        _data['authCarDate']    = $('#authCarDate').val();
        _data['authCarNm']      = $('#authCarNm').val();

        console.log(_data);


    }

</script>