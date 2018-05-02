<%--
    커뮤니티/목록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(function(){

    //유형 select박스 선택 이벤트
    $(document).on("change","select[name='categoryCd']",function(){
        $.ajax({
            url : "${pageContext.request.contextPath}/faq/list",
            type: "POST",
            data : $("#categoryForm").serialize(),
            dataType : "html",
            success : function(data){
                $("#count").html($(data).find('#count').html());
                $("#faqBody").html($(data).find('#faqBody').html());
            }
       });
    });
});
</script>
<main class="content-wrapper page-faq">
    <section class="section section-visual">
        <div class="inner">
            <div class="item">
                <h2 class="page-header">FAQ</h2>
                <i class="image" style="background-image:url('${pageContext.request.contextPath}/resources/images/faq-top-visual.jpg');"></i>
            </div>
        </div>
    </section>
    <section class="section section-list">
        <div class="inner">
            <div class="control">
                <span id="count" class="count">전체<strong>${fn:length(faqFixYList) + fn:length(faqFixNList)}</strong>개</span>
                <div class="sort">
                    <fieldset>
                        <legend>정렬</legend>
                        <form id="categoryForm">
                            <div class="form">
                                <select name="categoryCd" class="design-select gray-select small-select">
                                    <option value="">전체</option>
                                    <c:forEach var="faqType" items="${faqTypeList}">
                                        <option value="${faqType.categoryCd}">${faqType.categoryNm}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </form>
                    </fieldset>
                </div>
            </div>
            <div id="faqBody" class="list">
                <c:forEach var="faq" items="${faqFixYList}">
                    <!-- item -->
                    <div class="item">
                        <a href="#" class="question">
                            <span class="type">[${faq.categoryNm}]</span>
                            <strong class="tit">
                                <em class="sticky">BEST</em>
                                <span>${faq.title}</span>
                            </strong>
                        </a>
                        <div class="answer">
                           ${faq.ctnt}
                        </div>
                    </div>
                    <!-- // item -->
                </c:forEach>
                <c:forEach var="faq" items="${faqFixNList}">
                    <!-- item -->
                    <div class="item">
                        <a href="#" class="question">
                            <span class="type">[${faq.categoryNm}]</span>
                            <strong class="tit">
                                <span>${faq.title}</span>
                            </strong>
                        </a>
                        <div class="answer">
                            ${faq.ctnt}
                            <!-- <c:out value="${faq.ctnt}" escapeXml="false" /> -->
                        </div>
                    </div>
                    <!-- // item -->
                </c:forEach>
            </div>
        </div>
    </section>
</main>

<script>
	//faq
	//var $trigger = $('');
	$(document).on("click",".page-faq .question",function(event){
		var $this = $(this),
			$item = $this.closest('.item');

		event.preventDefault();

		$item.toggleClass('active');

	});
</script>