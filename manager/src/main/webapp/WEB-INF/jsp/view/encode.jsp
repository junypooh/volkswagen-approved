<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2017-12-19
  Time: 오후 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<div id="body">
    Manager Body 영역 <br/>
    <form:form action="${pageContext.request.contextPath}/encode">
        평문 : <input type="text" name="targetStr" value="${param.targetStr}" placeholder="targetStr" style="width: 600px;" /><br/>
        암호화 : <input type="text" name="result" value="${result}" placeholder="result" style="width: 600px;" /><br/>
        매칭대상 : <input type="text" name="encStr" value="${param.encStr}" placeholder="encStr" style="width: 600px;" /><br/>
        결과 : <input type="text" name="test" value="${test}" placeholder="test" style="width: 600px;" /><br/>
        <input type="submit" value="전송" />
    </form:form>
</div>
