<%--
    통계관리/서비스별 접속수
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="container" class="container">
    <div class="wrap-contents">
        <div class="page-control">
            <div class="row">
                <div class="col-xs-12">
                    <span class="page-title"> 유입 경로</span>
                </div>
            </div>
        </div>
        <div class="contents">
            <!--  기간 구분 -->
            <div class="tabs-statistics">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active" onclick="dateService()">
                        <a href="#days" aria-controls="days" role="tab" data-toggle="tab">일별</a>
                    </li>
                    <li role="presentation" onclick="monthService()">
                        <a href="#months" aria-controls="months" role="tab" data-toggle="tab">월별</a>
                    </li>
                    <li role="presentation" onclick="yearService()">
                        <a href="#years" aria-controls="years" role="tab" data-toggle="tab">연도별</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="days">
                        <div class="wrap-calendar form-inline day-calendar">
                            <div class="input-group">
                                <div class="input-icon">
                                    <i class="fa fa-calendar"></i>
                                    <input type="text" class="form-control datetimepicker" name="timeStart" id="dateStart" value="" placeholder="from">
                                </div>
                                <span class="input-group-addon">~</span>
                                <div class="input-icon">
                                    <i class="fa fa-calendar"></i>
                                    <input type="text" class="form-control datetimepicker" name="timeEnd" id="dateEnd" value="" placeholder="to">
                                </div>
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" onclick="dateSearchBtn()"><i class="fa fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>

                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="months">
                        <div class="wrap-calendar form-inline month-calendar">
                            <div class="input-group">
                                <div class="input-icon">
                                    <i class="fa fa-calendar"></i>
                                    <input type="text" class="form-control datetimepicker" name="timeStart" id="monthStart" value="" placeholder="from">
                                </div>
                                <span class="input-group-addon">~</span>
                                <div class="input-icon">
                                    <i class="fa fa-calendar"></i>
                                    <input type="text" class="form-control datetimepicker" name="timeEnd" id="monthEnd" value="" placeholder="to">
                                </div>
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" onclick="monthSearchBtn()"><i class="fa fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="years">
                        <div class="wrap-calendar form-inline year-calendar">
                            <div class="input-group">
                                <div class="input-icon">
                                    <i class="fa fa-calendar"></i>
                                    <input type="text" class="form-control datetimepicker" name="timeStart" id="yearStart" value="" placeholder="from">
                                </div>
                                <span class="input-group-addon">~</span>
                                <div class="input-icon">
                                    <i class="fa fa-calendar"></i>
                                    <input type="text" class="form-control datetimepicker" name="timeEnd" id="yearEnd" value="" placeholder="to">
                                </div>
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" onclick="yearSearchBtn()"><i class="fa fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--  //기간 구분 -->

            <!-- 데이터 노출 -->
            <div class="card">
                <div class="tools">
                    <div class="row">
                        <div class="col-xs-6">
                            <strong>집계 기간</strong> : <span id="perSpan"></span>
                        </div>
                        <div class="col-xs-6 text-right">
                            <strong>합계</strong> :
                            <span id="totalCount">
                               <c:choose>
                                   <c:when test="${not empty list}">
                                       <c:forEach var="totalCnt" items="${list}" varStatus="status">
                                           <c:if test="${status.last}">
                                               <fmt:formatNumber value="${totalCnt.pc + totalCnt.mo}" pattern="#,###"/>
                                           </c:if>
                                       </c:forEach>
                                   </c:when>
                                   <c:otherwise>
                                       0
                                   </c:otherwise>
                               </c:choose>
                            </span>건
                        </div>
                    </div>
                </div>
                <table class="table table-bordered table-vertical table-statistics">
                    <colgroup>
                        <col style="width: 25%">
                        <col style="width: 25%">
                        <col style="width: 25%">
                        <col style="width: 25%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>유입경로</th>
                            <th>접속수 (PC)</th>
                            <th>접속수 (Mobile)</th>
                            <th>비율</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="flow" items="${list}" varStatus="status">
                            <c:if test="${!status.last}">
                                <tr>
                                    <th scope="row">${flow.refererSite}</th>
                                    <td><fmt:formatNumber value="${flow.pc}" pattern="#,###"/></td>
                                    <td><fmt:formatNumber value="${flow.mo}" pattern="#,###"/></td>
                                    <td>${flow.per} %</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <c:forEach var="flow" items="${list}" varStatus="status">
                            <c:if test="${status.last}">
                                <tr>
                                    <th scope="row">${flow.refererSite}</th>
                                    <td><fmt:formatNumber value="${flow.pc}" pattern="#,###"/></td>
                                    <td><fmt:formatNumber value="${flow.mo}" pattern="#,###"/></td>
                                    <td>${flow.per} %</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tfoot>
                </table>
            </div>
            <!-- //데이터 노출 -->
        </div>
    </div>
</div>

<script type="text/javascript">

    (function() {

        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1
        var day = date.getDate();

        if(month < 10){
            month = "0"+month;
        }

        if(day < 10){
            day = "0"+day;
        }

        var today = year + '-' + month + '-' +day;
        var todayMonth = year + '-' + month;

        $('.day-calendar .datetimepicker').val(today);
        $('.month-calendar .datetimepicker').val(todayMonth);
        $('.year-calendar .datetimepicker').val(year);

        $('#perSpan').text($('.day-calendar .datetimepicker').val() + ' ~ ' + $('.day-calendar .datetimepicker').val());

        $('.day-calendar .datetimepicker').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: "kr"
        });
        $('.month-calendar .datetimepicker').datetimepicker({
            format: 'YYYY-MM',
            viewMode: 'months',
            locale: "kr"
        });
        $('.year-calendar .datetimepicker').datetimepicker({
            format: 'YYYY',
            viewMode: 'years',
            locale: "kr"
        });

    })();

    function dateService(){

        $.ajax({
            url: "${pageContext.request.contextPath}/statics/flow",
            type: "POST",
            data : {startDate:$('#dateStart').val(), endDate:$('#dateEnd').val()},
            success: function(result) {

                $('#perSpan').text($('#dateStart').val() + ' ~ ' + $('#dateEnd').val());
                $('tbody').empty().append($(result).find('tbody').html());
                $('tfoot').empty().append($(result).find('tfoot').html());
                $('#totalCount').empty().append($(result).find('#totalCount').html());

            }
        });

    }

    function monthService(){

        $.ajax({
            url: "${pageContext.request.contextPath}/statics/monthAccessPath",
            type: "POST",
            data : {startDate:$('#monthStart').val(), endDate:$('#monthEnd').val()},
            success: function(result) {

                $('#perSpan').text($('#monthStart').val() + ' ~ ' + $('#monthEnd').val());
                $('tbody').empty().append($(result).find('tbody').html());
                $('tfoot').empty().append($(result).find('tfoot').html());
                $('#totalCount').empty().append($(result).find('#totalCount').html());

            }
        });

    }

    function yearService(){

      $.ajax({
            url: "${pageContext.request.contextPath}/statics/yearAccessPath",
            type: "POST",
            data : {startDate:$('#yearStart').val(), endDate:$('#yearEnd').val()},
            success: function(result) {

                $('#perSpan').text($('#yearStart').val() + ' ~ ' + $('#yearEnd').val());
                $('tbody').empty().append($(result).find('tbody').html());
                $('tfoot').empty().append($(result).find('tfoot').html());
                $('#totalCount').empty().append($(result).find('#totalCount').html());

            }
        });

    }

    function dateSearchBtn(){

        /* 유효성check*/
        var startValue = $('#dateStart').val();
        var endValue = $('#dateEnd').val();

        var strDate = new Date(startValue);
        var endDate = new Date(endValue);

        if(startValue == '' || startValue == null || endValue == '' || endValue == null){

            alert("조회 기간을 잘못 선택하셨습니다.");

            return;

        }

        if(strDate.getTime() > endDate.getTime()) {

            alert("조회 기간을 잘못 선택하셨습니다.");

            return false;

        }

        dateService();

    }

    function monthSearchBtn(){

        /* 유효성check */
        var startValue = $('#monthStart').val();
        var endValue = $('#monthEnd').val();

        var strMonth = new Date(startValue);
        var endMonth = new Date(endValue);

        if(startValue == '' || startValue == null || endValue == '' || endValue == null){

            alert("조회 기간을 잘못 선택하셨습니다.");

            return;

        }

        if(strMonth.getTime() > endMonth.getTime()){

            alert("조회 기간을 잘못 선택하셨습니다.");

            return;

        }

        monthService();

    }

    function yearSearchBtn(){

         /* 유효성check */
         var startValue = $('#yearStart').val();
         var endValue = $('#yearEnd').val();

         var strYear = new Date(startValue);
         var endYear = new Date(endValue);

         if(startValue == '' || startValue == null || endValue == '' || endValue == null){

             alert("조회 기간을 잘못 선택하셨습니다.");

             return;

         }

         if(strYear.getTime() > endYear.getTime()){

             alert("조회 기간을 잘못 선택하셨습니다.");

             return;

         }

        yearService();

    }
</script>
