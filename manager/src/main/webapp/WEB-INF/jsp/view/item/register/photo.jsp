<%--
  Created by IntelliJ IDEA.
  User: DaDa
  Date: 2018-01-29
  Time: 오전 10:26
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

<div id="container" class="container">
    <div class="wrap-contents">
        <div class="page-control">
            <div class="row">
                <div class="col-xs-3">
                    <span class="page-title"> 매물등록 </span>
                </div>
                <c:if test="${result.carInfo.carStatCd eq null and auth ne 'ADMIN'}">
                    <div class="col-xs-9 text-right" id="requestApply">
                        <small>정보 입력 완료 후, 미리보기 및 승인 요청이 가능합니다.</small>
                        <button type="button" class="btn btn-default" <c:if test="${result.tempSaveYn ne 'Y'}">disabled="disabled"</c:if> onclick="beforehandView()">미리보기</button>
                        <button type="button" class="btn btn-primary" <c:if test="${result.tempSaveYn ne 'Y'}">disabled="disabled"</c:if> onclick="requestApply()">승인 요청</button>
                    </div>
                </c:if>
                <c:if test="${result.carInfo.carStatCd eq 'D1002' and (auth eq 'VW' or auth eq 'ADMIN')}">
                    <div class="col-xs-9 text-right">
                        <small>판매중인 차량이오니, 수정 반영 시 신중하시기 바랍니다.</small>
                        <button type="button" class="btn btn-primary" onclick="tempSave('modify')">수정저장</button>
                    </div>
                </c:if>
                <c:if test="${result.carInfo.carStatCd eq 'D1001' and (auth eq 'VW' or auth eq 'OPERATOR')}">
                    <div class="col-xs-9 text-right">
                        <small>매물 수정 사항이 발생하여, 매물 재승인요청 합니다.</small>
                        <button type="button" class="btn btn-primary" onclick="requestApply()">승인요청</button>
                    </div>
                </c:if>
                <c:if test="${result.carInfo.carStatCd eq 'D1003' and (auth eq 'VW' or auth eq 'OPERATOR')}">
                    <div class="col-xs-9 text-right">
                        <small>반려 사유를 참고하여, 매물 재승인요청 합니다.</small>
                        <button type="button" class="btn btn-primary" onclick="requestApply()">승인요청</button>
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
                            <c:choose>
                                <c:when test="${result.carInfo.carStatCd eq null or result.carInfo.carStatCd eq 'D1003'}">
                                    <li role="presentation" <c:if test="${result.saveYn.price eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/price/${sellCarSeq}')">가격·사고이력</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.option eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/option/${sellCarSeq}')">옵션·전차주</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.perform eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}')">제시·성능점검</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.disc eq 'Y'}">class="complete"</c:if>><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}')">설명</a></li>
                                    <li role="presentation" class="active <c:if test="${result.saveYn.photo eq 'Y'}">complete</c:if>"><a href="javascript:void(0)" onclick="goLocPage('${pageContext.request.contextPath}/item/register/photo/${sellCarSeq}')">사진</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li role="presentation" <c:if test="${result.saveYn.price eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/price/${sellCarSeq}">가격·사고이력</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.option eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/option/${sellCarSeq}">옵션·전차주</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.perform eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/performance/${sellCarSeq}">제시·성능점검</a></li>
                                    <li role="presentation" <c:if test="${result.saveYn.disc eq 'Y'}">class="complete"</c:if>><a href="${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}">설명</a></li>
                                    <li role="presentation" class="active <c:if test="${result.saveYn.photo eq 'Y'}">complete</c:if>"><a href="${pageContext.request.contextPath}/item/register/photo/${sellCarSeq}">사진</a></li>
                                </c:otherwise>
                            </c:choose>
                            <%-- 판매중, 판매완료, 판매종료/삭제 and 최고관리자 --%>
                            <c:if test="${(result.carInfo.carStatCd ne null and result.carInfo.carStatCd ne 'D1001' and result.carInfo.carStatCd ne 'D1003') and (auth eq 'VW' or auth eq 'ADMIN')}">
                                <li role="presentation"><a href="${pageContext.request.contextPath}/item/register/sellMng/${sellCarSeq}">판매관리</a></li>
                            </c:if>
                        </ul>

                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="tab5">
                                <div class="box">

                                    <%-- 승인대기상태 and 최고관리자 --%>
                                    <c:if test="${result.carInfo.carStatCd eq 'D1001' and (auth eq 'VW' or auth eq 'ADMIN')}">
                                        <div class="bs-callout bs-callout-info">
                                            <p class="title">반려사유를 입력하세요.</p>
                                            <div class="form-group">
                                                <textarea name="reson" id="reson" cols="30" rows="5" class="form-control"></textarea>
                                            </div>
                                            <div class="text-right">
                                                <button type="button" class="btn btn-default" onclick="returnApply()">반려</button>
                                                <button type="button" class="btn btn-primary" onclick="approvalApply()">승인</button>
                                            </div>
                                        </div>
                                    </c:if>

                                    <%-- 반려일때 --%>
                                    <c:if test="${result.carInfo.carStatCd eq 'D1003'}">
                                        <div class="bs-callout bs-callout-danger">
                                            <p class="title"><i class="fa fa-warning fa-2x"></i> 반려사유를 확인하세요.</p>
                                            <p>${result.carInfo.reason}</p>
                                        </div>
                                    </c:if>


                                    <div class="box-header">
                                        <p>차량의 상태와 특징을 나타낼 수 있는 사진을 등록하세요. <small>(이미지 형식 : PNG, JPG, JPGE / 권장 사이즈 : 1140*490)</small></p>
                                    </div>
                                    <div class="upload-photo" id="carPhotoLists">
                                        <c:forEach items="${result.info}" var="list">
                                            <div class="item">
                                                <c:choose>
                                                    <c:when test="${list.fileUrl ne '' and list.fileUrl ne null}">
                                                        <div class="dropzone upload">
                                                            <div class="dz-preview dz-file-preview">
                                                                <div class="dz-details">
                                                                    <img data-dz-thumbnail data-dz-remove src="${pageContext.request.scheme}://${list.fileUrl}">
                                                                </div>
                                                            </div>
                                                            <div class="dz-default dz-message"></div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="dropzone upload">
                                                            <div class="dz-default dz-message">
                                                                <p><i class="fa fa-image fa-3x"></i></p>
                                                                <span><span class="asterisk"><c:if test="${list.required eq 'true'}">*</c:if></span>${list.title}</span>
                                                            </div>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <input type="hidden" name="cd" value="${list.cd}">
                                                <input type="hidden" name="imgSeq" value="${list.imgSeq}">
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <small class="help-block">
                                        &middot; 앞 측면, 뒷 측면, 실내, 엔진, 계기판(주행거리 표시) 사진은 필수입니다. (분할사진은 불가합니다.)<br>
                                        &middot; 사진은 1140*490에 최적화되어 있습니다.<br>
                                        &middot; 사진 1개당 10MB까지 업로드 가능합니다.<br>
                                        &middot; 타사이트 광고 및 과도하게 편집되어 있는 사진은 경고 없이 삭제 처리될 수 있습니다.
                                    </small>
                                </div>
                                <div class="btns text-right">
                                    <c:if test="${result.carInfo.carStatCd eq null or result.carInfo.carStatCd eq 'D1003'}">
                                        <button type="button" class="btn btn-default" onclick="goLocPage('${pageContext.request.contextPath}/item/register/disc/${sellCarSeq}')">이전</button>
                                        <button type="button" class="btn btn-default" disabled="disabled">다음</button>
                                        <button type="button" class="btn btn-primary" onclick="tempSave()">임시저장</button>
                                    </c:if>
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



    (function() {

        /** file Upload */
        Dropzone.autoDiscover = false;

        $('#carPhotoLists .upload').each(function(i){
            var upload = new Dropzone($(this).get(0), {
                url: "${pageContext.request.contextPath}/file/upload/dropzone?_csrf=${_csrf.token}",
                acceptedFiles: "image/jpeg,image/png,image/jpg",
                method: 'post',
                params: {'type': 'PHOTO'},
                uploadMultiple: false,
                addRemoveLinks: true,
                autoProcessQueue: true,
                maxFiles: 1
            });
            upload.on('success', function(file, response){
                $('#carPhotoLists .upload').eq(i).parent('.item').find('.dz-preview.dz-file-preview').hide();
                $('#carPhotoLists .upload').eq(i).parent('.item').find('[name=imgSeq]').val(response.fileSeq);
            });
            upload.on('error', function(file, response) {
                if (response == 'You can not upload any more files.') {
                    alert('기존 파일을 삭제한뒤 등록해주세요.');
                } else {
                    alert('Error while uploading file!');
                }
                upload.removeFile(file);
            });
            upload.on('removedfile', function(){
                var _potoCnt = $('#carPhotoLists .upload').eq(i).parent('.item').find('.dz-preview').length;
                if (_potoCnt == 1) {
                    $('#carPhotoLists .upload').eq(i).parent('.item').find('[name=imgSeq]').val('');
                }

            });
        });
    })();

    /** 임시저장 */
    function tempSave(type, url) {

        if (type == 'modify') {
            if(!confirm('수정저장 시, 이전 상태로 복구 불가하며,\n홈페이지에 노출됩니다.\n수정 저장 하시겠습니까?')){
                return false;
            }
        }

        var _data = {};
        _data['sellCarSeq'] = '${result.carInfo.sellCarSeq}';

        var i = 0;
        $('input[name=imgSeq]').each(function(){

            if ($(this).val() != '') {
                _data['carPhotoVos['+i+'].imgSeq'] = $(this).val();
                _data['carPhotoVos['+i+'].photoCd'] = $(this).prev().val();
                i++;
            }

        });

        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/photo/tempSave",
            type: "POST",
            data : _data,
            async: false,
            success: function(result) {
                if (result.rtnStr != 'SUCC') {
                    alert('임시저장에 실패하였습니다.');
                } else {
                    carDefaulSave(type, url);
                }
                /*
                if (result.reqApplyYn == 'Y') {
                    $('#requestApply').children('button').prop('disabled', false);
                } else {
                    $('#requestApply').children('button').prop('disabled', true);
                }
                */
            }
        });
    }

    function carDefaulSave(type, url) {
        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/update/defaultInfo",
            type: "POST",
            async: false,
            data : $('#itemForm').serialize(),
            success: function(result) {
                if("SUCC" == result) {
                    if (type == 'modify') {
                        alert('수정 저장 완료되었습니다.')
                    }

                    if (url != '' && url != null) {
                        location.href = url;
                    } else {
                        location.reload();
                    }
                } else {
                    alert('기본 정보 저장에 실패하였습니다.');
                }
            }
        });
    }

    /** 승인요청 */
    function requestApply() {
        $.ajax({
            url: "${pageContext.request.contextPath}/item/register/carSellStat/requestApply",
            type: "POST",
            data : {sellCarSeq : '${result.carInfo.sellCarSeq}'},
            success: function(result) {
                if (result == 'SUCC') {
                    alert('승인신청되었습니다.');
                    location.reload();
                } else if (result == 'OVERLAP') {
                    alert('이미 승인신청된 매물입니다.');
                    location.reload();
                }
            }
        });
    }

    /** 반려 */
    function returnApply() {
        if ($.trim($('#reson').val()) == '') {
            alert('미입력 항목이 있습니다.');
            return false;
        }

        if (confirm('반려 하시겠습니까?')) {
            $.ajax({
                url: "${pageContext.request.contextPath}/item/register/carSellStat/returnApply",
                type: "POST",
                data : {sellCarSeq : '${result.carInfo.sellCarSeq}', reason : $('#reson').val()},
                success: function(result) {
                    if (result == 'SUCC') {
                        alert('반려 완료되었습니다.');
                        location.reload();
                    } else if (result == 'OVERLAP') {
                        alert('이미 반려된 매물입니다.');
                        location.reload();
                    }
                }
            });
        }
    }

    /** 승인 */
    function approvalApply() {
        if (confirm('승인 하시면, 홈페이지에 노출됩니다.\n승인하시겠습니까?')) {
            $.ajax({
                url: "${pageContext.request.contextPath}/item/register/carSellStat/approvalApply",
                type: "POST",
                data : {sellCarSeq : '${result.carInfo.sellCarSeq}'},
                success: function(result) {
                    if (result == 'SUCC') {
                        alert('승인 완료되었습니다.');
                        location.reload();
                    } else if (result == 'OVERLAP') {
                        alert('이미 승인완료된 매물입니다.');
                        location.reload();
                    }
                }
            });
        }
    }

    function goLocPage(url) {
        tempSave(null, url);
    }

    /** 미리보기 */
    function beforehandView() {
        window.open('${pageContext.request.contextPath}/item/register/preview/${sellCarSeq}');
    }

</script>
