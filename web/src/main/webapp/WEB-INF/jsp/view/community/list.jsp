<%--
    커뮤니티/목록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

$(function(){
    // F5눌렀을때 검색조건 초기화.
    $(document).on("keydown", function (event) {
        if (event.keyCode == 116) {
            history.pushState(null, 'VWA', '${pageContext.request.contextPath}/community/list');
        }
    });

    //유형 select박스 선택 이벤트
    $(document).on("change","select[name='type']",function(){
        var type = $(this).val();
        $("input[name='currPage']").val("1");
        var searchParam = new Object();
        searchParam.type = type;
        searchParam.currPage = $("input[name='currPage']").val();

        $.ajax({
            url : "${pageContext.request.contextPath}/community/list",
            type: "POST",
            data : $("#typeForm").serialize(),
            dataType : "html",
            success : function(data){
                //전체개수
                $("#count").html($(data).find('#count').html());
                //커뮤니티목록
                $("#contents").html($(data).find('#contents').html());
                //더보기버튼
                $("#addView").html($(data).find('#addView').html());

                history.pushState(searchParam, 'VWA', '${pageContext.request.contextPath}/community/list');
            }
       });
    });

    //더보기버튼 이벤트
    $(document).on("click","#addCommunity",function(){
        var currPage = Number($("input[name='currPage']").val()) + 1;
        $("input[name='currPage']").val(currPage);
        var searchParam = new Object();
        searchParam.type = $("select[name='type']").val();
        searchParam.currPage = $("input[name='currPage']").val();

        $.ajax({
            url : "${pageContext.request.contextPath}/community/list",
            type: "POST",
            data : $("#typeForm").serialize(),
            dataType : "html",
            success : function(data){
                $("#contents").append($(data).find('#contents').html());
                $("#addView").html($(data).find('#addView').html());

                history.pushState(searchParam, 'VWA', '${pageContext.request.contextPath}/community/list');
            }
       });
    });

    $(document).ready(function(e) {
        if (history.state != null) {
            var _state = history.state;
            $("select[name='type']").val(_state.type);
            $("input[name='currPage']").val(_state.currPage);
            $("input[name='retainYn']").val("Y");

            $.ajax({
                url : "${pageContext.request.contextPath}/community/list",
                type: "POST",
                data : $("#typeForm").serialize(),
                dataType : "html",
                success : function(data){
                    //전체개수
                    $("#count").html($(data).find('#count').html());
                    //커뮤니티목록
                    $("#contents").html($(data).find('#contents').html());
                    //더보기버튼
                    $("#addView").html($(data).find('#addView').html());

                    $("input[name='retainYn']").val("N");

                    history.pushState(_state, 'VWA', '${pageContext.request.contextPath}/community/list');
                }
           });

        }
    });

});

function detail(commSeq){
    $("#detailForm").attr("action", "${pageContext.request.contextPath}/community/detail");
    $("#detailForm").attr("method", "POST");
    $("#detailForm").find("input[name='commSeq']").val(commSeq);
    $("#detailForm").submit();
}
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
    <section class="section section-best">
        <div class="list list-grid">
            <div class="inner">
                <c:forEach var="community" items="${result.communityFixYList}" begin="0" end="2">
                    <article class="article">
                        <div class="item">
                            <a href="${pageContext.request.contextPath}/community/detail/${community.commSeq}">
                                <span class="label label-notice">${community.type}</span>
                                <figure class="img">
                                    <span><img src="${pageContext.request.scheme}://${result.fileUrlPath}${community.file.filePath}${community.file.fileNm}" onerror=""></span>
                                </figure>
                                <div class="content">
                                    <p class="subject ff-noto">${community.title}</p>
                                    <time class="ff-roboto" datetime=""><fmt:formatDate value="${community.creDate}" pattern="yyyy.MM.dd"/></time>
                                </div>
                            </a>
                        </div>
                    </article>
                </c:forEach>
            </div>
        </div>
    </section>
    <section class="section section-list">
        <div class="inner">
            <div class="control">
                <span id="count" class="count">전체<strong>${result.totalCount}</strong>개</span>
                <div class="sort">
                    <fieldset>
                        <legend>정렬</legend>
                        <div class="form">
                            <form id="typeForm">
                                <input type="hidden" name="currPage" value="${searchParam.currPage}">
                                <input type="hidden" name="retainYn" value="N">
                                <select name="type" class="design-select gray-select small-select">
                                    <option value="">전체</option>
                                    <c:forEach var="communityType" items="${communityTypeList}">
                                        <option value="${communityType.type}">${communityType.type}</option>
                                    </c:forEach>
                                </select>
                            </form>
                        </div>
                    </fieldset>
                </div>
            </div>
            <div id="contents" class="list list-grid">
                <div class="inner">
                    <c:forEach var="community" items="${result.communityFixNList}">
                        <article class="article">
                            <div class="item">
                                <a href="${pageContext.request.contextPath}/community/detail/${community.commSeq}">
                                    <span class="label label-notice">${community.type}</span>
                                    <figure class="img">
                                        <span><img src="${pageContext.request.scheme}://${result.fileUrlPath}${community.file.filePath}${community.file.fileNm}" onerror=""></span>
                                    </figure>
                                    <div class="content">
                                        <p class="subject ff-noto">${community.title}</p>
                                        <time class="ff-roboto" datetime=""><fmt:formatDate value="${community.creDate}" pattern="yyyy.MM.dd"/></time>
                                    </div>
                                </a>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </div>
            <div id="addView" class="btns">
                <c:if test="${result.lastPage > searchParam.currPage}">
                    <button type="button" id="addCommunity" class="btn btn-dark btn-radius ff-noto"><em>더보기</em></button>
                </c:if>
            </div>
        </div>
    </section>
</main>
<script>
    function bestSlide() {
        var $bestSlide = $('.section-best .inner'),
            _winWidth = $(window).width();

        if(_winWidth <= 846) {
            $bestSlide.not('.slick-initialized').slick();
        } else {
            if($bestSlide.hasClass('slick-slider')) {
                $bestSlide.slick('unslick');
            }
        }
    }

    bestSlide();

    $(window).on('resize', bestSlide);

</script>