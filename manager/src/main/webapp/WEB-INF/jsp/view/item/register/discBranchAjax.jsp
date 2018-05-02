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

<div>
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