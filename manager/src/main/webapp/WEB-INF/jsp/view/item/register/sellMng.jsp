<%--
  Created by IntelliJ IDEA.
  User: DaDa
  Date: 2018-01-31
  Time: 오후 5:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="container" class="container">
    <div class="wrap-contents">
        <div class="page-control">
            <div class="row">
                <div class="col-xs-3">
                    <span class="page-title"> 매물등록 </span>
                </div>
                <c:if test="${result.carInfo.carStatCd eq 'D1002'}">
                    <div class="col-xs-9 text-right">
                        <small>판매완료/종료/삭제 시, 더 이상 차량이 노출되지 않습니다.</small>
                        <button type="button" class="btn btn-primary sellComplete" onclick="sellSave()">판매 완료</button>
                        <button type="button" class="btn btn-primary sellEnd" style="display: none;" onclick="sellSave()">판매 종료/삭제</button>
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
                            <li role="presentation" <c:if test="${result.saveYn.price eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/price/${sellCarSeq}">가격·사고이력</a></li>
                            <li role="presentation" <c:if test="${result.saveYn.option eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/option/${sellCarSeq}">옵션·전차주</a></li>
                            <li role="presentation" <c:if test="${result.saveYn.perform eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}">제시·성능점검</a></li>
                            <li role="presentation" <c:if test="${result.saveYn.disc eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}">설명</a></li>
                            <li role="presentation" <c:if test="${result.saveYn.photo eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/photo/${sellCarSeq}">사진</a></li>
                            <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/item/register/sellMng/${sellCarSeq}">판매관리</a></li>
                        </ul>
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="tab6">

                                <div class="box">
<%--

                                    <div class="bs-callout bs-callout-info">
                                        <p class="title">반려사유를 입력하세요.</p>
                                        <div class="form-group">
                                            <textarea name="" id="" cols="30" rows="5" class="form-control"></textarea>
                                        </div>
                                        <div class="text-right">
                                            <button type="button" class="btn btn-default">반려</button>
                                            <button type="button" class="btn btn-primary">승인</button>
                                        </div>
                                    </div>

                                    <div class="bs-callout bs-callout-danger">
                                        <p class="title"><i class="fa fa-warning fa-2x"></i> 반려사유를 확인하세요.</p>
                                        <p>가격이 너무 높게 측정되었습니다. 1200만원으로 수정 요청하세요.</p>
                                    </div>
--%>




                                    <div class="box-header">
                                        <p>매물 노출 여부를 관리합니다.</p>
                                    </div>
                                    <table class="table table-horizontal table-bordered">
                                        <colgroup>
                                            <col style="width: 150px">
                                            <col>
                                        </colgroup>
                                        <tr>
                                            <th>노출 상태</th>
                                            <td>${result.info.cdNm}</td>
                                        </tr>
                                        <tr>
                                            <th>노출 여부</th>
                                            <td>
                                                <div class="onoffswitch">
                                                    <input type="checkbox" class="onoffswitch-checkbox" data-id="4033" name="isVisibled" id="isVisibled-4033" <c:if test="${result.info.viewYn eq 'Y'}">checked="checked"</c:if>>
                                                    <label class="onoffswitch-label" for="isVisibled-4033">
                                                        <i class="inner"></i><i class="switch"></i>
                                                    </label>
                                                </div>
                                                <div class="btns" id="switchBtn" style="display: none;">
                                                    <button type="button" class="btn btn-xs btn-default" onclick="dispCancel()">취소</button>
                                                    <button type="button" class="btn btn-xs btn-primary" onclick="dispButton();">적용</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>


                                    <div class="box-header">
                                        <p>판매 정보를 입력하세요.</p>
                                    </div>
                                    <table class="table table-horizontal table-bordered">
                                        <colgroup>
                                            <col style="width: 150px">
                                            <col>
                                        </colgroup>
                                        <tr>
                                            <th>판매기간</th>
                                            <td>
                                                <c:forEach items="${result.dateInfo}" var="list">
                                                    ${list.sellTime}<br>
                                                </c:forEach>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>재고기간</th>
                                            <td>
                                                <c:forEach items="${result.dateInfo}" var="list">
                                                    ${list.stockTime} (일)<br>
                                                </c:forEach>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>조회수</th>
                                            <td><fmt:formatNumber value="${result.info.hits}" pattern="#,###" /> (회)</td>
                                        </tr>
                                        <!-- 판매 완료일때 -->
                                        <tr>
                                            <th><span class="asterisk">*</span>판매상태</th>
                                            <td>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="sellStat" value="D1004" <c:if test="${result.info.sellStat ne 'D1005'}">checked</c:if>> 판매완료
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="sellStat" value="D1005" <c:if test="${result.info.sellStat eq 'D1005'}">checked</c:if>> 판매종료/삭제
                                                    </label>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr class="sellComplete">
                                            <th><span class="asterisk">*</span>실제 판매일</th>
                                            <td>
                                                <div class="wrap-calendar form-inline ">
                                                    <div class="input-group">
                                                        <div class="input-icon">
                                                            <i class="fa fa-calendar"></i>
                                                            <input type="text" class="form-control datetimepicker" name="statDate" id="completeDate" placeholder="YYYY.MM.DD" value="${result.info.statDate}">
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <!-- //판매 완료일때 -->

                                        <!-- 판매종료/삭제일때 -->
<%--

                                        <tr>
                                            <th><span class="asterisk">*</span>판매상태</th>
                                            <td>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="" id=""> 판매완료
                                                    </label>
                                                </span>
                                                <span class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="" id="" checked> 판매종료/삭제
                                                    </label>
                                                </span>
                                            </td>
                                        </tr>
--%>

                                        <tr class="sellEnd" style="display: none;">
                                            <th><span class="asterisk">*</span>종료/삭제일</th>
                                            <td>
                                                <div class="wrap-calendar form-inline ">
                                                    <div class="input-group">
                                                        <div class="input-icon">
                                                            <i class="fa fa-calendar"></i>
                                                            <input type="text" class="form-control datetimepicker" name="statDate" id="sellEndDate" placeholder="YYYY.MM.DD" value="${result.info.statDate}">
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="sellEnd" style="display: none;">
                                            <th><span class="asterisk">*</span>종료/삭제 사유</th>
                                            <td>
                                                <textarea name="reason" id="reason" cols="30" rows="10" class="form-control">${result.info.reason}</textarea>
                                            </td>
                                        </tr>
                                        <!-- //판매종료/삭제일때 -->
                                    </table>
                                </div>

                                <div class="btns text-right">
                                    <%--<button type="button" class="btn btn-default">이전</button>--%>
                                    <%--<button type="button" class="btn btn-default">다음</button>--%>
                                    <button type="button" class="btn btn-primary" onclick="beforehandView()">미리보기</button>
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

    $(document).ready(function() {

        $('.datetimepicker').datetimepicker({
            format: 'YYYY.MM.DD',
            locale: "kr"
        });

        if ($('input[name=sellStat]:checked').val() == 'D1005') {
            $('.sellEnd').show();
            $('.sellComplete').hide();
        } else {
            $('.sellEnd').hide();
            $('.sellComplete').show();
        }


        $('input[name=sellStat]').change(function(){
           if ($(this).val() == 'D1005') {
               $('.sellEnd').show();
               $('.sellComplete').hide();
           } else {
               $('.sellEnd').hide();
               $('.sellComplete').show();
           }
           $('.datetimepicker').val('');
           $('#reason').val('');
        });

        // 노출여부 적용버튼 제어
        $('.onoffswitch-checkbox').click(function(){
           $('#switchBtn').show();
        });


    });

    function sellSave() {
        var msg;
        var _data = {};
        _data['sellCarSeq'] = '${result.carInfo.sellCarSeq}';
        _data['statHisSeq'] = '${result.discInfo.statHisSeq}';

        _data['sellStat']   = $('input[name=sellStat]:checked').val();


        if ($('input[name=sellStat]:checked').val() == 'D1005') {
            if ($.trim($('#sellEndDate').val()) == '') {
                alert('미입력 항목이 있습니다.');
                return false;
            }
            if ($.trim($('#reason').val()) == '') {
                alert('미입력 항목이 있습니다.');
                return false;
            }

            msg = '판매 종료/삭제';
            _data['statDate']   = $('#sellEndDate').val();
            _data['reason']      = $('#reason').val();

        } else {

            if ($('#completeDate').val() == '') {
                alert('미입력 항목이 있습니다.');
                return false;
            }
            msg = '판매 완료';
            _data['statDate']   = $('#completeDate').val();
        }

        if (confirm(msg+'시, 복구 및 판매 되지 않습니다. '+msg+' 하시겠습니까?')) {
            $.ajax({
                url: "${pageContext.request.contextPath}/item/register/sellMng/save",
                type: "POST",
                data : _data,
                success: function(result) {
                    if (result == 'SUCC') {
                        alert('승인 완료되었습니다.');
                        location.href = '${pageContext.request.contextPath}/item/register/sellMng/${sellCarSeq}';
                    }
                }
            });
        }

    }

    /** 미리보기 */
    function beforehandView() {
        window.open('${pageContext.request.contextPath}/item/register/preview/${sellCarSeq}');
    }

    /** 노출 적용 */
    function dispButton() {

        var carStatCd = 'D1010';
        // 노출여부 on 일경우
        if ($('input[name=isVisibled]:checked').length > 0) {
            carStatCd = 'D1002';
        }

        var viewYn = '${result.info.viewYn}';
        if (viewYn == 'Y' && carStatCd == 'D1002') {
            alert('이미 노출 중 입니다.');
            $('#switchBtn').hide();
            return false;
        }
        if (viewYn == 'N' && carStatCd == 'D1010') {
            alert('이미 비노출 중 입니다.');
            $('#switchBtn').hide();
            return false;
        }

        var msg = carStatCd == 'D1010'? '비노출':'노출';
        if (confirm('홈페이지에 ' + msg + ' 하시겠습니까?')) {
            $.ajax({
                url: "${pageContext.request.contextPath}/item/register/sellMng/viewChange",
                type: "POST",
                data : {sellCarSeq: '${sellCarSeq}', carStatCd: carStatCd},
                success: function(result) {
                    if (result == 'SUCC') {
                        alert('홈페이지에 ' + msg + ' 처리되었습니다.');
                        location.href = '${pageContext.request.contextPath}/item/register/sellMng/${sellCarSeq}';
                    }
                }
            });
        }
    }

    /** 노출 취소 */
    function dispCancel() {
        var viewYn = '${result.info.viewYn}';
        if (viewYn == 'Y') {
            $('.onoffswitch-checkbox').prop('checked', true);
        } else {
            $('.onoffswitch-checkbox').prop('checked', false);
        }

        $('#switchBtn').hide();
    }

</script>