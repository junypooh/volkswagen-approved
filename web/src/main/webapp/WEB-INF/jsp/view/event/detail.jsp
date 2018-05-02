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

		<main class="content-wrapper page-event">
			<section class="section section-visual">
				<div class="inner">
                    <div class="item">
                        <h2 class="page-header">EVENT</h2>
                        <i class="image" style="background-image:url('${pageContext.request.contextPath}/resources/images/event-top-visual.jpg');"></i>
                    </div>
				</div>
			</section>
			<section class="section section-detail">
				<div class="inner">
					<div class="detail-head">
						<span class="label label-news">
						    <c:if test="${eventVo.flag == 0}">
                                예약중
                            </c:if>
                            <c:if test="${eventVo.flag == 1}">
                                진행중
                            </c:if>
                            <c:if test="${eventVo.flag == 2}">
                                종료
                            </c:if>
                            <c:if test="${eventVo.flag == 3}">
                                상시
                            </c:if>
						</span>
						<h3 class="tit">${eventVo.title}</h3>
						<span class="date"><em>이벤트 기간</em>
						    <c:if test="${eventVo.flag != 3}">
						        <time>${eventVo.strDate} ~ ${eventVo.endDate}</time>
						    </c:if>
                            <c:if test="${eventVo.flag == 3}">
                                <time>상시</time>
                            </c:if>
						</span>
					</div>
					<div class="detail-body">
						<div class="pc">
							${eventVo.ctntPc}
						</div>
						<div class="mobile">
                            <c:if test="${eventVo.ctntMo == '' || eventVo.ctntMo == null}">
                                ${eventVo.ctntPc}
                            </c:if>
                            <c:if test="${eventVo.ctntMo != '' && eventVo.ctntMo != null}">
                                ${eventVo.ctntMo}
                            </c:if>
						</div>

					</div>
					<div class="btns">
						<button type="button" id="list" class="btn btn-deepdark btn-radius ff-noto"><em>목록</em></button>
					</div>
				</div>
			</section>
		</main>
<script type="text/javascript">
//취소버튼 이동
$("#list").on("click", function(){
    location.href = "${pageContext.request.contextPath}/event/list";
});
</script>
