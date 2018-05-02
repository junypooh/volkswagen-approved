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
    <section class="section section-list">
        <form id="detailForm">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="hidden" name="eventSeq">
        </form>
        <div class="list">
            <div class="inner">
                <!-- item -->
                <c:forEach items="${list}" var="item" varStatus="status">
                    <c:if test="${item.flag != 2}">
                        <div class="item type-black" style="background-image: url(${pageContext.request.scheme}://${searchParam.fileUrlPath}${item.file.filePath}${item.file.fileNm})" > <!-- type : type-black, type-white -->
                    </c:if>
                    <c:if test="${item.flag == 2}">
                        <div class="item type-white" style="background-image: url(${pageContext.request.scheme}://${searchParam.fileUrlPath}${item.file.filePath}${item.file.fileNm})" > <!-- type : type-black, type-white -->
                    </c:if>
                        <div class="cont">
                            <span class="sticky">
                                <c:if test="${item.flag == 0}">
                                    예약중
                                </c:if>
                                <c:if test="${item.flag == 1}">
                                    진행중
                                </c:if>
                                <c:if test="${item.flag == 2}">
                                    종료
                                </c:if>
                            </span>
                            <h3 class="tit">${item.title}</h3>
                                <time>${item.strDate} ~ ${item.endDate}</time>
                            <c:if test="${item.flag == 2}">
                                <c:if test="${item.winnLinkUrl != '' && item.winnLinkUrl != null}">
                                    <a href="${item.winnLinkUrl}" class="btn btn-primary btn-radius" <c:if test="${item.winnNewWinYn=='Y'}">target="_blank"</c:if>>당첨확인하기</a>
                                </c:if>
                            </c:if>

                            <c:if test="${item.flag == 1}">
                                <c:if test="${searchParam.check == 'pc'}">
                                    <c:if test="${item.type == 'Link'}">
                                        <a href="${item.ctntPc}" class="btn btn-primary btn-radius" <c:if test="${item.newWinYnPc=='Y'}">target="_blank"</c:if>>참여하기</a>
                                    </c:if>
                                </c:if>
                                <c:if test="${searchParam.check == 'mobile'}">
                                    <c:if test="${item.type == 'Link'}">
                                        <a href="${item.ctntPc}" class="btn btn-primary btn-radius" <c:if test="${item.newWinYnMo=='Y'}">target="_blank"</c:if>>참여하기</a>
                                    </c:if>
                                </c:if>
                                <c:if test="${item.type == 'Registe'}">
                                    <a href="${pageContext.request.contextPath}/event/detail/${item.eventSeq}" class="btn btn-primary btn-radius">참여하기</a>
                                </c:if>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
                <!-- // item -->

            </div>
        </div>
    </section>
</main>
<!-- //e:content-wrapper -->
