<%--
    커뮤니티/상세
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
</script>

<main class="content-wrapper page-community">
    <section class="section section-visual">
        <div class="inner">
            <div class="item">
                <h2 class="page-header">community</h2>
                <i class="image" style="background-image:url('${pageContext.request.contextPath}/resources/images/community-top-visual.jpg');"></i>
            </div>
        </div>
    </section>
    <section class="section section-detail">
        <div class="inner">
            <div class="detail-head">
                <span class="label label-news">${result.community.type}</span>
                <h3 class="tit">${result.community.title}</h3>
                <time><fmt:formatDate value="${result.community.creDate}" pattern="yyyy.MM.dd"/></time>
            </div>
            <div class="detail-body">
                ${result.community.ctnt}
            </div>
            <div class="detail-foot">
                <c:if test="${result.prevCommunity != null}">
                    <a href="${pageContext.request.contextPath}/community/detail/${result.prevCommunity.commSeq}">
                        <span class="txt prev">이전글<i class="icon icon-arrow-dark-top"></i></span>
                        <span class="tit">${result.prevCommunity.title}</span>
                        <time><fmt:formatDate value="${result.prevCommunity.creDate}" pattern="yyyy.MM.dd"/></time>
                    </a>
                </c:if>
                <c:if test="${result.prevCommunity == null}">
                    <a>
                        <span class="txt prev">이전글<i class="icon icon-arrow-dark-top"></i></span>
                        <span class="tit">이전글이 없습니다.</span>
                    </a>
                </c:if>
                <c:if test="${result.nextCommunity != null}">
                    <a href="${pageContext.request.contextPath}/community/detail/${result.nextCommunity.commSeq}">
                        <span class="txt label-next">다음글<i class="icon icon-arrow-dark-bottom"></i></span>
                        <span class="tit">${result.nextCommunity.title}</span>
                        <time><fmt:formatDate value="${result.nextCommunity.creDate}" pattern="yyyy.MM.dd"/></time>
                    </a>
                </c:if>
                <c:if test="${result.nextCommunity == null}">
                    <a>
                        <span class="txt label-next">다음글<i class="icon icon-arrow-dark-bottom"></i></span>
                        <span class="tit">다음글이 없습니다.</span>
                    </a>
                </c:if>
            </div>
            <div class="btns">
                <a href="${pageContext.request.contextPath}/community/list"><button type="button" class="btn btn-deepdark btn-radius ff-noto"><em>목록</em></button></a>
            </div>
        </div>
    </section>
</main>

