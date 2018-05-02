<%--
  Created by IntelliJ IDEA.
  User: DaDa
  Date: 2018-01-18
  Time: 오후 4:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>--%>
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
                                    <li role="presentation" class="active <c:if test="${result.saveYn.perform eq 'Y'}">complete</c:if>"><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}')">제시·성능점검</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.disc eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}')">설명</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.photo eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/photo/${sellCarSeq}')">사진</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li role="presentation" <c:if test="${result.saveYn.price eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/price/${sellCarSeq}">가격·사고이력</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.option eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/option/${sellCarSeq}">옵션·전차주</a></li>
                                    <li role="presentation" class="active <c:if test="${result.saveYn.perform eq 'Y'}">complete</c:if>"><a href="${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}">제시·성능점검</a></li>
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
                            <div role="tabpanel" class="tab-pane active" id="tab3">
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


                                    <div class="box-header"><p>제시번호·성능점검 기록부를 입력하세요.</p></div>
                                    <table class="table table-horizontal table-bordered">
                                        <colgroup>
                                            <col style="width: 150px">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th><span class="asterisk">*</span>제시번호</th>
                                            <td>
                                                <div class="form-inline">
                                                    <input type="text" name="suggNo" id="suggNo" class="form-control" placeholder="예) 2017549010 " value="${result.info.suggNo}">
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <small class="help-block">
                                        매매회원이 중요 정보(제시번호, 성능점검기록부, 조합/상사명) 미기재, 허위 기재시 표시광고의 공정화에 관한 법률 (20조 제1항 제1호)에 의해 1억원 이하의 과태료가 부과될 수 있습니다.
                                    </small>
                                </div>
                                <div class="box">
                                    <form:form id="frm">
                                        <input type="hidden" name="sellCarSeq" value="${result.carInfo.sellCarSeq}">
                                        <div class="box-header"><p>성능점검 기록부를 입력하세요.</p></div>
                                        <table class="table table-horizontal table-bordered">
                                            <colgroup>
                                                <col style="width: 150px">
                                                <col>
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th><span class="asterisk">*</span>중고자동차 성능 · 상태 검검기록부</th>
                                                <td>
                                                    <div class="form-inline">
                                                        제 <input type="text" name="statRecNo" id="statRecNo" class="form-control" placeholder="" value="${result.info.statRecNo}"> 호
                                                    </div>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                        <table class="table table-horizontal table-bordered">
                                            <colgroup>
                                                <col style="width: 150px">
                                                <col style="width: 200px">
                                                <col style="width: 150px">
                                                <col>
                                            </colgroup>
                                            <tbody>
                                            <tr>
                                                <th>차명</th>
                                                <td>${result.carInfo.model} ${result.carInfo.detailModel} ${result.carInfo.rating}</td>
                                                <th><%--자동차 등록번호--%></th>
                                                <td><%--${result.carInfo.carSellNo}--%></td>
                                            </tr>
                                            <tr>

                                                <th><span class="asterisk">*</span>주행거리/계기상태</th>
                                                <td><fmt:formatNumber value="${result.carInfo.driveDist}" pattern="#,###" /> km</td>
                                                <th>연식</th>
                                                <td>${result.carInfo.fromYear}년</td>
                                            </tr>
                                            <tr>
                                                <th><span class="asterisk">*</span>검사 유효기간</th>
                                                <td>
                                                    <div class="wrap-calendar form-inline ">
                                                        <div class="input-group">
                                                            <div class="input-icon">
                                                                <i class="fa fa-calendar"></i>
                                                                <input type="text" class="form-control datetimepicker" name="strDate" id="strDate" value="${result.info.strDate}" placeholder="from" >
                                                            </div>
                                                            <span class="input-group-addon">~</span>
                                                            <div class="input-icon">
                                                                <i class="fa fa-calendar"></i>
                                                                <input type="text" class="form-control datetimepicker" name="endDate" id="endDate" value="${result.info.endDate}" placeholder="to">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <th><span class="asterisk">*</span>최초 등록일</th>
                                                <td>
                                                    <div class="form-inline">
                                                        <fmt:parseDate value="${result.carInfo.prodYear}" var="prodDate" pattern="yyyyMM"/>
                                                        <fmt:formatDate value="${prodDate}" pattern="yyyy" var="pordYear"/><fmt:formatDate value="${prodDate}" pattern="MM" var="prodMonth"/>
                                                        ${pordYear}년 ${prodMonth}월
                                                        <span class="select">
                                                            <select name="day" id="day" class="form-control">
                                                                <option value="">일 선택</option>
                                                            </select>
                                                        </span>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>원동기 형식</th>
                                                <td>
                                                    <input type="text" name="moterFrom" id="moterFrom" class="form-control" value="${result.info.moterFrom}">
                                                </td>
                                                <th>변속기 종류</th>
                                                <td>
                                                    ${result.carInfo.gear}
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>차대번호</th>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${result.info.chasNo ne '' and result.info.chasNo ne null}"><c:set var="chasNo" value="${result.info.chasNo}"/></c:when>
                                                        <c:otherwise><c:set var="chasNo" value="비공개"/></c:otherwise>
                                                    </c:choose>
                                                    <input type="text" name="chasNo" id="chasNo" class="form-control" value="${chasNo}">
                                                </td>
                                                <th><span class="asterisk">*</span>보증 유형</th>
                                                <td>
                                                    <span class="radio-inline">
                                                        <label>

                                                            <input type="radio" name="warrCategory" value="S" <c:if test="${result.info.warrCategory ne 'I'}">checked</c:if>> 자가보증
                                                        </label>
                                                    </span>
                                                    <span class="radio-inline">
                                                        <label>
                                                            <input type="radio" name="warrCategory" value="I" <c:if test="${result.info.warrCategory eq 'I'}">checked</c:if>> 보험사보증
                                                        </label>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th><span class="asterisk">*</span>동일성확인<br>(차대번호 표기)</th>
                                                <td>
                                                    <span class="select">
                                                        <select name="sameConf" id="sameConf" class="form-control">
                                                            <option value="양호" <c:if test="${result.info.sameConf ne '불량'}">selected</c:if>>양호</option>
                                                            <option value="상이" <c:if test="${result.info.sameConf eq '상이'}">selected</c:if>>상이</option>
                                                            <option value="부식" <c:if test="${result.info.sameConf eq '부식'}">selected</c:if>>부식</option>
                                                            <option value="훼손(오손)" <c:if test="${result.info.sameConf eq '훼손(오손)'}">selected</c:if>>훼손(오손)</option>
                                                            <option value="변조(변타)" <c:if test="${result.info.sameConf eq '변조(변타)'}">selected</c:if>>변조(변타)</option>
                                                            <option value="도말" <c:if test="${result.info.sameConf eq '도말'}">selected</c:if>>도말</option>
                                                        </select>
                                                    </span>
                                                </td>
                                                <th><span class="asterisk">*</span>불법구조 변경</th>
                                                <td>
                                                    <span class="radio-inline">
                                                        <label>
                                                            <input type="radio" name="illeStruUpdYn" value="Y" <c:if test="${result.info.illeStruUpdYn eq 'Y'}">checked</c:if>> 유
                                                        </label>
                                                    </span>
                                                    <span class="radio-inline">
                                                        <label>
                                                            <input type="radio" name="illeStruUpdYn" value="N" <c:if test="${result.info.illeStruUpdYn ne 'Y'}">checked</c:if>> 무
                                                        </label>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th><span class="asterisk">*</span>사고 유무<br>(단순수리 제외)</th>
                                                <td>
                                                    <span class="radio-inline">
                                                        <label>
                                                            <input type="radio" name="accidYn" value="N" <c:if test="${result.info.accidYn ne 'Y'}">checked</c:if>> 없음
                                                        </label>
                                                    </span>
                                                    <span class="radio-inline">
                                                        <label>

                                                            <input type="radio" name="accidYn" value="Y" <c:if test="${result.info.accidYn eq 'Y'}">checked</c:if>> 있음
                                                        </label>
                                                    </span>
                                                </td>
                                                <th><span class="asterisk">*</span>침수 유무</th>
                                                <td>
                                                    <span class="radio-inline">
                                                        <label>
                                                            <input type="radio" name="flodYn" value="N" <c:if test="${result.info.flodYn ne 'Y'}">checked</c:if>> 없음
                                                        </label>
                                                    </span>
                                                    <span class="radio-inline">
                                                        <label>
                                                            <input type="radio" name="flodYn" value="Y" <c:if test="${result.info.flodYn eq 'Y'}">checked</c:if>> 있음
                                                        </label>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>자가진단사항</th>
                                                <td>
                                                    <div class="form-inline row">
                                                        <div class="form-group col-xs-3">
                                                            <p>원동기</p>
                                                        </div>
                                                        <div class="form-group">
                                                            <span class="radio-inline">
                                                                <label>
                                                                    <input type="radio" name="moterDiagYn" value="Y" <c:if test="${result.info.moterDiagYn ne 'N'}">checked</c:if>> 양호
                                                                </label>
                                                            </span>
                                                            <span class="radio-inline">
                                                                <label>
                                                                    <input type="radio" name="moterDiagYn" value="N" <c:if test="${result.info.moterDiagYn eq 'N'}">checked</c:if>> 정비요
                                                                </label>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="form-inline row">
                                                        <div class="form-group col-xs-3">
                                                            <p>변속기</p>
                                                        </div>
                                                        <div class="form-group">
                                                            <span class="radio-inline">
                                                                <label>

                                                                    <input type="radio" name="gearDiagYn" value="Y" <c:if test="${result.info.gearDiagYn ne 'N'}">checked</c:if>> 양호
                                                                </label>
                                                            </span>
                                                            <span class="radio-inline">
                                                                <label>
                                                                    <input type="radio" name="gearDiagYn" value="N" <c:if test="${result.info.gearDiagYn eq 'N'}">checked</c:if>> 정비요
                                                                </label>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </td>
                                                <th><span class="asterisk">*</span>배출가스</th>
                                                <td>
                                                    <div class="form-inline row">
                                                        <div class="form-group col-xs-4 ">
                                                            <p class="form-control-static">일산화탄소(CO)</p>
                                                        </div>
                                                        <div class="form-group">
                                                            <c:choose>
                                                                <c:when test="${result.info.co ne '' and result.info.co ne null}"><c:set var="co" value="${result.info.co}"/></c:when>
                                                                <c:otherwise><c:set var="co" value="0"/></c:otherwise>
                                                            </c:choose>
                                                            <input type="text" name="co" class="form-control" value="${co}">
                                                        </div>
                                                        %
                                                    </div>
                                                    <div class="form-inline row">
                                                        <div class="form-group col-xs-4">
                                                            <p class="form-control-static">탄화수소(HC)</p>
                                                        </div>
                                                        <div class="form-group">
                                                            <c:choose>
                                                                <c:when test="${result.info.hc ne '' and result.info.hc ne null}"><c:set var="hc" value="${result.info.hc}"/></c:when>
                                                                <c:otherwise><c:set var="hc" value="0"/></c:otherwise>
                                                            </c:choose>
                                                            <input type="text" name="hc" class="form-control" value="${hc}">
                                                        </div>
                                                        ppm
                                                    </div>
                                                    <div class="form-inline row">
                                                        <div class="form-group col-xs-4">
                                                            <p class="form-control-static">매연</p>
                                                        </div>
                                                        <div class="form-group">
                                                            <c:choose>
                                                                <c:when test="${result.info.exh ne '' and result.info.exh ne null}"><c:set var="exh" value="${result.info.exh}"/></c:when>
                                                                <c:otherwise><c:set var="exh" value="0"/></c:otherwise>
                                                            </c:choose>
                                                            <input type="text" name="exh" class="form-control" value="${exh}">
                                                        </div>
                                                        %
                                                    </div>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </form:form>
                                </div>
                                <div class="box" id="carStatus">
                                    <div class="box-header"><p>자동차의 상태표시</p></div>
                                    <table class="table table-vertical table-bordered ">
                                        <colgroup>
                                            <col style="width:450px">
                                            <col>
                                            <col>
                                            <col style="width: 100px">
                                            <col style="width: 100px">
                                            <col style="width: 100px">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>외판 부위의 교환, 부식, 판금 및 용접수리</th>
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
                                                <input type="hidden" name="partCd" value="${list.cd}" />
                                                <c:if test="${status.index == 0}">
                                                    <td rowspan="14">
                                                        <img src="${pageContext.request.contextPath}/resources/images/car-outside.png" alt="">
                                                    </td>
                                                </c:if>
                                                <td>${list.no}</td>
                                                <td>${list.cdNm}</td>
                                                <td>
                                                    <label>
                                                        <input type="checkbox" name="exch" value="Y" <c:if test="${list.exch eq 'Y'}">checked</c:if>>
                                                        <span></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label>
                                                        <input type="checkbox" name="weld" value="Y" <c:if test="${list.weld eq 'Y'}">checked</c:if>>
                                                        <span></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label>
                                                        <input type="checkbox" name="corr" value="Y" <c:if test="${list.corr eq 'Y'}">checked</c:if>>
                                                        <span></span>
                                                    </label>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <table class="table table-vertical table-bordered ">
                                        <colgroup>
                                            <col style="width:450px">
                                            <col>
                                            <col>
                                            <col style="width: 100px">
                                            <col style="width: 100px">
                                            <col style="width: 100px">
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
                                                <input type="hidden" name="partCd" value="${list.cd}" />
                                                <c:if test="${status.index == 0}">
                                                    <td rowspan="23">
                                                        <img src="${pageContext.request.contextPath}/resources/images/car-inside.png" alt="">
                                                    </td>
                                                </c:if>
                                                <td>${list.no}</td>
                                                <td>${list.cdNm}</td>
                                                <td>
                                                    <label>
                                                        <input type="checkbox" name="exch" value="Y" <c:if test="${list.exch eq 'Y'}">checked</c:if>>
                                                        <span></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label>
                                                        <input type="checkbox" name="weld" value="Y" <c:if test="${list.weld eq 'Y'}">checked</c:if>>
                                                        <span></span>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label>
                                                        <input type="checkbox" name="corr" value="Y" <c:if test="${list.corr eq 'Y'}">checked</c:if>>
                                                        <span></span>
                                                    </label>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="box">
                                    <div class="box-header"><p>주요장치</p></div>
                                    <table class="table table-bordered table-vertical" id="device-list">
                                        <colgroup>
                                            <col style="width: 100px;">
                                            <col style="width: 150px;">
                                            <col style="width: 200px;">
                                            <col>
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
                                        <%--
                                        <tr v-for="item in item">
                                            <th v-if="item.device" v-html="item.device" :colspan="item.cd == 'G1811' ? '3' : ''"></th>
                                            <th v-if="item.device" v-html="item.item" :colspan="item.cd != 'G1811' && item.part ? '' : '2'"></th>
                                            <th v-if="item.part" v-html="item.part"></th>
                                            &lt;%&ndash;<th v-if="item.other == 'G1811'" v-html="item.device" colspan="3"></th>&ndash;%&gt;
                                            <td class="text-left">
                                                <span class="radio-inline" v-if="item.state && item.cd != 'G1811'" v-for="radio in item.state"><label><input type="radio" :name="item.cd" :value="radio.value" :checked="radio.checked"> {{radio.text}}</label></span>

                                                <span v-else v-for="a in item.state">

                                                    <textarea class="form-control"></textarea>
                                                </span>
                                                &lt;%&ndash;<span v-if="item.other" v-html="'<textarea name=\''+ item.cd +'\' class=\'form-control\'></textarea>'">{{item.opinion}}</span>&ndash;%&gt;
                                            </td>
                                        </tr>
--%>

                                        <%--
                                        <tr v-for="item in item">
                                            <th v-if="item.device" v-html="item.device"></th>
                                            <th v-if="item.device" v-html="item.item" :colspan="item.part ? '' : '2'"></th>
                                            <th v-if="item.part" v-html="item.part"></th>
                                            <th v-if="item.other" v-html="item.other" colspan="3"></th>
                                            <td class="text-left">
                                                <span class="radio-inline" v-if="item.state" v-for="radio in item.state"><label><input type="radio" :name="item.radioName"> {{radio.text}}</label></span>
                                                <span v-if="item.other" v-html="'<' + item.input + ' name=\''+ item.radioName +'\' class=\'form-control\'></' + item.input + '>'"></span>
                                            </td>
                                        </tr>
                                        --%>

                                        <tr v-for="item in item">
                                            <th v-html="item.device" :colspan="item.cd == 'G1811' ? '3' : ''"></th>
                                            <th v-if="item.cd != 'G1811'"  v-html="item.item" :colspan="item.part ? '' : '2'"></th>
                                            <th v-if="item.part" v-html="item.part"></th>
                                            <td class="text-left">
                                                <span v-if="item.cd != 'G1811'" class="radio-inline" v-for="radio in item.state"><label><input type="radio" :name="item.cd" :value="radio.value" :checked="radio.checked"> {{radio.text}}</label></span>
                                                <span v-else><textarea class="form-control" :id="item.cd" :name="item.cd">{{item.opinion}}</textarea></span>
                                            </td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </div>

                                <div class="box">
                                    <div class="confirm">
                                        <p class="text-center">「자동차관리법」 제58조 제1항 및 같은법 시행규칙 제120조 제1항에 따라 중고자동차의 성능 · 상태를 점검하였음을 확인합니다.</p>
                                        <div class="form-inline text-center">
                                            <jsp:useBean id="toDay" class="java.util.Date" />
                                            <span class="select">
                                                <select name="statConfYear" id="statConfYear" class="form-control">
                                                    <fmt:formatDate value="${toDay}" pattern="yyyy" var="year"/>
                                                    <c:choose>
                                                        <c:when test="${not empty result.info.statConfYear}">
                                                            <c:forEach begin="${result.info.statConfYear}" end="${year}" varStatus="status">
                                                                <option value="${status.current}" <c:if test="${status.current eq result.info.statConfYear}">selected</c:if>>${status.current}</option>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${year - 1}">${year - 1}</option>
                                                            <option value="${year}">${year}</option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </select>
                                            </span>
                                            <span class="select">
                                                <select name="statConfMonth" id="statConfMonth" class="form-control" onchange="setStatConfDay()">
                                                    <fmt:formatDate value="${toDay}" pattern="MM" var="month"/>
                                                    <c:forEach begin="1" end="12" varStatus="status">
                                                        <fmt:formatNumber value="${status.index}" pattern="00" var="month_idx"/>
                                                        <c:choose>
                                                            <c:when test="${not empty result.info.statConfMonth}">
                                                                <option value="${month_idx}" <c:if test="${month_idx eq result.info.statConfMonth}">selected</c:if>>${month_idx} </option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option value="${month_idx}" <c:if test="${month_idx eq month}">selected</c:if>>${month_idx} </option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </select>
                                            </span>
                                            <span class="select">
                                                <select name="statConfDay" id="statConfDay" class="form-control">
                                                    <fmt:formatDate value="${toDay}" pattern="dd" var="day"/>
                                                    <option value="">일 선택</option>
                                                </select>
                                            </span>
                                        </div>
                                    </div>
                                    <table class="table table-horizontal table-bordered">
                                        <colgroup>
                                            <col style="width: 450px">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th><span class="asterisk">*</span>중고자동차 성능 · 상태 점검자</th>
                                            <td>
                                                <div class="form-inline">
                                                    <input type="text" name="statConfUser" id="statConfUser" class="form-control" value="${result.info.statConfUser}"> (인)
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span class="asterisk">*</span>중고자동차 성능 · 상태 고지자</th>
                                            <td>
                                                <div class="form-inline">
                                                    <input type="text" name="statNotfUser" id="statNotfUser" class="form-control" value="${result.info.statNotfUser}">  (인)
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="btns text-right">
                                    <c:if test="${result.carInfo.carStatCd eq null or result.carInfo.carStatCd eq 'D1003'}">
                                        <button type="button" class="btn btn-default" onclick="goLocPage('${pageContext.request.contextPath}/item/register/option/${sellCarSeq}')">이전</button>
                                        <button type="button" class="btn btn-default" onclick="goLocPage('${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}')">다음</button>
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
    $(document).ready(function(){
        var deviceTable = new Vue({
            el: '#device-list tbody',
            data: {
                item: ${result.jsonData}
            },
            created: function() {
                setTimeout(function() {
                    $("#device-list").rowspanizer();
                });
            }
        });

        // 점검일자 setting
        setStatConfDay();
        // 최초 등록일 일자 setting
        firstRegisterDay();


        $('.datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: "kr"
        });



    });

    /** 임시저장 */
    function tempSave(type, url) {

        if (type == 'modify') {
            if(!confirm('수정저장 시, 이전 상태로 복구 불가하며,\n홈페이지에 노출됩니다.\n수정 저장 하시겠습니까?')){
                return false;
            }
        }

        var _data = {};
        $.each($('#frm').serializeArray(), function(key, value){
            _data[value.name] = value.value;
        });
        _data['suggNo']         = $('#suggNo').val();
        _data['statConfYear']   = $('#statConfYear').val();
        _data['statConfMonth']  = $('#statConfMonth').val();
        _data['statConfDay']    = $('#statConfDay').val();
        _data['statConfUser']   = $('#statConfUser').val();
        _data['statNotfUser']   = $('#statNotfUser').val();

        var i = 0;
        $('#carStatus tr').each(function(){
            var partCd = $(this).find('input[name=partCd]').val();

            if (typeof(partCd) != 'undefined') {
                _data['carStatusVos['+i+'].partCd']   = $(this).find('input[name=partCd]').val();
                _data['carStatusVos['+i+'].exch']     = $(this).find('input[name=exch]:checked').val();
                _data['carStatusVos['+i+'].weld']     = $(this).find('input[name=weld]:checked').val();
                _data['carStatusVos['+i+'].corr']     = $(this).find('input[name=corr]:checked').val();
                i++;
            }

        });

        // 주요장치 Data Set
        var detailCds = new Array();
        $('input[name^=G]:checked').each(function(){
            detailCds.push($(this).val());
        });
        detailCds.push('G18111');
        _data['detailCds'] = detailCds;
        _data['opinion'] = $('#G1811').val();

        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/performance/tempSave",
            type: "POST",
            data : _data,
            traditional: true,
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


    /** 점검 일자 setting */
    function setStatConfDay(){
        if ('${result.info.statConfDay}' != null && '${result.info.statConfDay}' != '') {
            $('#statConfDay').empty().append(monthDay($('#statConfYear').val(), $('#statConfMonth').val(), '${result.info.statConfDay}'));
        } else {
            $('#statConfDay').empty().append(monthDay($('#statConfYear').val(), $('#statConfMonth').val(), '${day}'));
        }
    }

    /** 최초 등록일 일자 setting */
    function firstRegisterDay() {
        $('#day').empty().append(monthDay('${prodYear}', '${prodMonth}', '${result.info.day}'));
    }

    /** 해당년, 월의 일자 */
    function monthDay(year, month, selectVal) {
        var lastDay = 32 - new Date(year, month-1, 32).getDate();

        var html = '<option value="">일 선택</option>';
        for(var i = 0; i < lastDay; i++) {
            if (selectVal == numberPad(i+1)) {
                html += '<option value="'+numberPad(i+1)+'" selected>'+numberPad(i+1)+'</option>';
            } else {
                html += '<option value="'+numberPad(i+1)+'">'+numberPad(i+1)+'</option>';
            }
        }
        return html;
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
