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

<div id="body">
<div id="container" class="container">
    <form id="subForm">
        <input type="hidden" name="admSeq">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    </form>
        <div class="wrap-contents">
		    <div class="page-control">
			    <div class="row">
				    <div class="col-xs-6">
					    <span class="page-title"> 관리자 관리 </span>
				    </div>
				    <div class="col-xs-6 text-right">
				        <c:if test="${authorityCd eq 'VW' || authorityCd eq 'ADMIN'}">
					        <button type="button" id="registe" class="btn btn-primary">등록</button>
				        </c:if>
				    </div>
			    </div>
		    </div>
		    <div class="contents">
			    <div class="card">
				    <div class="tools">
					    <div class="row">
						    <div class="col-xs-12">
							    <div class="form-inline">
								    <span class="select">
									    <form id="home" action="list" method="post" >
										    <input type="hidden" name="currPage" id="currPage" value="${searchParam.currPage}">
										    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
											<select name="value" id="select" class="form-control">
                                                <option value="all">소속전체</option>
                                                <option value="Branch" <c:if test="${searchParam.value eq 'Branch'}">selected="selected"</c:if>>Branch</option>
                                                <option value="VW" <c:if test="${searchParam.value eq 'VW'}">selected="selected"</c:if>>VW</option>
											</select>
                                        </form>
								    </span>
							    </div>
						    </div>
					    </div>
				    </div>
				    <table id="tt" class="table table-hover table-bordered table-vertical">
					    <colgroup>
						    <col>
						    <col style="width: 100px">
						    <col>
						    <col style="width: 150px">
						    <col style="width: 150px">
						    <col style="width: 200px">
					    </colgroup>
					    <thead>
						    <tr>
							    <th>아이디</th>
							    <th>소속</th>
							    <th>권한</th>
							    <th>최근방문일</th>
							    <th>최종승인일</th>
							    <th>메모</th>
						    </tr>
					    </thead>
					    <tbody>
                            <c:forEach items="${cList}" var="list" varStatus="status">
								<tr>
									<td>
									    <a href="${pageContext.request.contextPath}/auth/detail/${list.admSeq}">${list.id}</a>
									</td>
									<td>${list.authType}</td>
									<td>
										<ul class="list-group list-admin">
                                            <c:if test="${list.authType ne 'VW'}">
                                                <c:forEach items="${list.list}" var="item" varStatus="status">
                                                    <li class="list-group-item">
                                                        <div>
                                                            <span>${item.type}</span>
                                                            <span>${item.storeNm}</span>
                                                            <span>${item.auth}</span>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${list.authType eq 'VW'}">
                                                <li class="list-group-item">
                                                    <div>
                                                        <span>SUPRER_ADMIN</span>
                                                    </div>
                                                </li>
                                            </c:if>
										</ul>
									</td>
									<td>
										${list.visitDay}
									</td>
									<td>
										${list.updDate}
									</td>
									<td>${list.memo}</td>
								</tr>
                            </c:forEach>
					    </tbody>
				    </table>
				    <div class="row" id="paging">
					    <div class="col-xs-2">
                            Total : <span>${totalCount}</span>
					    </div>
					    <div class="col-xs-10 text-right">
						    <ul class="pagination pagination-sm">
                                    ${pageHtml}
						    </ul>
					    </div>
				    </div>
			    </div>
		    </div>
	    </div>
    </div>
</div>
<script type="text/javascript">
//VW,Branch 구분 버튼
$(document).on("change","#select",function(){
   $("#currPage").val("1");
   $.ajax({
       url : "${pageContext.request.contextPath}/auth/list",
       type: "POST",
       data : $("#home").serialize(),
       dataType : "html",
       success : function(data){
           var t = $(data).find('#tt').html();
           var c = $(data).find('#paging').html();
           $("#tt").html(t);
           $("#paging").html(c);
       }
   });
});

//등록이동버튼
$(document).on("click","#registe",function(){
     location.href = "${pageContext.request.contextPath}/auth/registe";
});
</script>


