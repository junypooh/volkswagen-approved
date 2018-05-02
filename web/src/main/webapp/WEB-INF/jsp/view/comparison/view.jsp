<%--
  Created by IntelliJ IDEA.
  User: choi
  Date: 2018-02-22
  Time: 오후 1:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="popup-wrapper popup-comparison">
	<!-- s:header -->
	<header class="header">
		<h1><a href="${pageContext.request.contextPath}/">Volkswagen Approved</a></h1>
		<h2>비교하기</h2>
	</header>
	<!-- //e:header -->

	<!-- s:container -->
	<div class="container">
		<!-- s:content-wrapper -->
		<main class="content-wrapper">
			<div class="comparsion">
				<dl class="target target-left">
					<dt>모델</dt>
					<dd data-title="모델">
						<div class="vehicles">
						    <c:if test="${firstResult.info.certYn eq 'Y'}">
							    <span class="label label-auth"><i class="icon icon-label-auth"></i><em class="hidden">공식인증</em></span>
							</c:if>
							<figure class="img">
								<a href="${pageContext.request.contextPath}/item/${firstResult.info.sellCarSeq}"><span><img src="${pageContext.request.scheme}://${firstResult.info.fileUrl}" alt=""></span></a>
							</figure>
							<div class="content">
							    <div>
                                    <strong class="model">${firstResult.info.mak} ${firstResult.info.detailModel}</strong>
                                    <span>${firstResult.info.rating} ${firstResult.info.detailRating}</span>
								</div>
							</div>
						</div>
					</dd>
					<dt>가격</dt>
					<dd data-title="가격">
						<div class="price">
							<span>
								<strong><fmt:formatNumber value="${firstResult.info.sellPrice}" pattern="#,###"/></strong>만원
								<c:if test="${firstResult.info.monPayment > 0}">(월 <fmt:formatNumber value="${firstResult.info.monPayment}" pattern="#,###"/>만원 부터~)</c:if>
							</span>
						</div>
					</dd>
					<dt>연식</dt>
					<dd data-title="연식">
					    <jsp:useBean id="toDay" class="java.util.Date" />
                        <fmt:formatDate value="${toDay}" pattern="yyyy" var="year"/>
                        <c:set var="divYear" value="${year-2008}" />
                        <c:set var="oldYear" value="${(firstResult.info.fromYear-2008)/divYear*100}" />
						<div class="gauge">
							<span class="bar" <c:choose><c:when test="${oldYear < 0}">style="width: 0%"</c:when><c:when test="${oldYear > 100}">style="width: 100%"</c:when><c:otherwise>style="width: ${oldYear}%"</c:otherwise></c:choose>></span>
							<small class="min">2008년 이하</small>
							<strong>${firstResult.info.fromYear}년</strong>
							<small class="max">${year}년</small>
						</div>
					</dd>
					<dt>주행거리</dt>
					<dd data-title="주행거리">
					    <c:set var="driveDist" value="${firstResult.info.driveDist/150000*100}" />
						<div class="gauge">
							<span class="bar" <c:choose><c:when test="${driveDist < 0}">style="width: 0%"</c:when><c:when test="${driveDist > 100}">style="width: 100%"</c:when><c:otherwise>style="width: ${driveDist}%"</c:otherwise></c:choose>></span>
							<small class="min">0km</small>
							<strong><fmt:formatNumber value="${firstResult.info.driveDist}" pattern="#,###"/>km</strong>
							<small class="max">15만km 이상</small>
						</div>
					</dd>
					<dt>배기량</dt>
					<dd data-title="배기량">${firstResult.carInfo.disp}cc</dd>
					<dt>변속기</dt>
					<dd data-title="변속기">${firstResult.info.gear}</dd>
					<dt>연료</dt>
					<dd data-title="연료">${firstResult.info.fuel}</dd>
					<dt>옵션</dt>
					<dd data-title="옵션">
						<ul class="list-option">
						    <c:forEach items="${firstResult.majorOptions}" var="majorOption">
                                <li>
                                    <span class="img">
                                        <c:choose>
                                            <c:when test="${not empty majorOption.sellCarSeq}">
                                                <img src="${pageContext.request.scheme}://${fileUrlPath}${majorOption.thumImgOnFile.filePath}${majorOption.thumImgOnFile.fileNm}" alt="">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.scheme}://${fileUrlPath}${majorOption.thumImgOffFile.filePath}${majorOption.thumImgOffFile.fileNm}" alt="">
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span>${majorOption.optNm}</span>
                                </li>
						    </c:forEach>
						</ul>
					</dd>
					<dt>사고유무</dt>
					<dd data-title="사고유무"><c:choose><c:when test="${firstResult.priceInfo.accidHisYn eq 'Y'}">유</c:when><c:when test="${firstResult.priceInfo.accidHisYn eq 'N'}">무</c:when><c:otherwise>비공개</c:otherwise></c:choose></dd>
					<dt>차량위치</dt>
					<dd data-title="차량위치">
						<strong>${firstResult.branchVo.branch.storeNm}</strong>
						<ul>
							<li>
								<span>주소</span> ${firstResult.branchVo.branch.detailAddr}
							</li>
							<li>
								<span>전화</span> ${firstResult.branchVo.branch.tel}
							</li>
						</ul>
					</dd>
				</dl>
				<dl class="target target-right">
					<dt>모델</dt>
					<dd data-title="모델">
						<div class="vehicles">
						    <c:if test="${lastResult.info.certYn eq 'Y'}">
							    <span class="label label-auth"><i class="icon icon-label-auth"></i><em class="hidden">공식인증</em></span>
							</c:if>
							<figure class="img">
								<a href="${pageContext.request.contextPath}/item/${lastResult.info.sellCarSeq}"><span><img src="${pageContext.request.scheme}://${lastResult.info.fileUrl}" alt=""></span></a>
							</figure>
							<div class="content">
							    <div>
                                    <strong class="model">${lastResult.info.mak} ${lastResult.info.detailModel}</strong>
                                    <span>${lastResult.info.rating} ${lastResult.info.detailRating}</span>
								</div>
							</div>
						</div>
					</dd>
					<dt>가격</dt>
					<dd data-title="가격">
						<div class="price">
							<span>
								<strong><fmt:formatNumber value="${lastResult.info.sellPrice}" pattern="#,###"/></strong>만원
								<c:if test="${lastResult.info.monPayment > 0}">(월 <fmt:formatNumber value="${lastResult.info.monPayment}" pattern="#,###"/>만원 부터~)</c:if>
							</span>
						</div>
					</dd>
					<dt>연식</dt>
					<dd data-title="연식">
						<div class="gauge">
						    <c:set var="oldYear" value="${(lastResult.info.fromYear-2008)/divYear*100}" />
							<span class="bar" <c:choose><c:when test="${oldYear < 0}">style="width: 0%"</c:when><c:when test="${oldYear > 100}">style="width: 100%"</c:when><c:otherwise>style="width: ${oldYear}%"</c:otherwise></c:choose>></span>
							<small class="min">2008년 이하</small>
							<strong>${lastResult.info.fromYear}년</strong>
							<small class="max">2018년</small>
						</div>
					</dd>
					<dt>주행거리</dt>
					<dd data-title="주행거리">
					    <c:set var="driveDist" value="${lastResult.info.driveDist/150000*100}" />
						<div class="gauge">
							<span class="bar" <c:choose><c:when test="${driveDist < 0}">style="width: 0%"</c:when><c:when test="${driveDist > 100}">style="width: 100%"</c:when><c:otherwise>style="width: ${driveDist}%"</c:otherwise></c:choose>></span>
							<small class="min">0km</small>
							<strong><fmt:formatNumber value="${lastResult.info.driveDist}" pattern="#,###"/>km</strong>
							<small class="max">15만km 이상</small>
						</div>
					</dd>
					<dt>배기량</dt>
					<dd data-title="배기량">${lastResult.carInfo.disp}cc</dd>
					<dt>변속기</dt>
					<dd data-title="변속기">${lastResult.info.gear}</dd>
					<dt>연료</dt>
					<dd data-title="연료">${lastResult.info.fuel}</dd>
					<dt>옵션</dt>
					<dd data-title="옵션">
						<ul class="list-option">
						    <c:forEach items="${lastResult.majorOptions}" var="majorOption">
                                <li>
                                    <span class="img">
                                        <c:choose>
                                            <c:when test="${not empty majorOption.sellCarSeq}">
                                                <img src="${pageContext.request.scheme}://${fileUrlPath}${majorOption.thumImgOnFile.filePath}${majorOption.thumImgOnFile.fileNm}" alt="">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.scheme}://${fileUrlPath}${majorOption.thumImgOffFile.filePath}${majorOption.thumImgOffFile.fileNm}" alt="">
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span>${majorOption.optNm}</span>
                                </li>
						    </c:forEach>
						</ul>
					</dd>
					<dt>사고유무</dt>
					<dd data-title="사고유무"><c:choose><c:when test="${lastResult.priceInfo.accidHisYn eq 'Y'}">유</c:when><c:when test="${lastResult.priceInfo.accidHisYn eq 'N'}">무</c:when><c:otherwise>비공개</c:otherwise></c:choose></dd>
					<dt>차량위치</dt>
					<dd data-title="차량위치">
						<strong>${lastResult.branchVo.branch.storeNm}</strong>
						<ul>
							<li>
								<span>주소</span> ${lastResult.branchVo.branch.detailAddr}
							</li>
							<li>
								<span>전화</span> ${lastResult.branchVo.branch.tel}
							</li>
						</ul>
					</dd>
				</dl>
			</div>
			<div class="btns">
				<button type="button" class="icon icon-util-share" title="공유하기" onclick="layerOpen('layer-share')"></button>
				<button type="button" class="icon icon-util-print" title="프린트하기"></button>
			</div>
		</main>
		<!-- //e:content-wrapper -->
	</div>
	<!-- //e:container -->
	<a href="#none" class="btn-top"><i class="icon icon-arrow-top">맨 위로 가기</i></a>

	<!-- s:footer -->
	<footer class="footer">
		<div class="inner">
			<p class="copy">
				&copy; Volkswagen 2018
			</p>
		</div>
	</footer>
	<!-- //e:footer -->
</div>

<!-- layer : share 공유하기-->
<div class="layer-wrap layer-share" id="share">
    <div class="layer layer-md layer-bg">
        <div class="layer-content">
            <div class="layer-header">
                <p class="layer-title">차량 비교하기</p>
            </div>
            <div class="layer-body">
                <p>차량정보를 공유할 SNS를 선택해 주세요.</p>
                <ul class="list-sns">
                    <li class="facebook">
                        <a href="javascript:share('facebook')">
                            <span><i class="icon icon-sns-facebook"></i></span>
                            <strong>페이스북</strong>
                        </a>
                    </li>
                    <li class="twitter">
                        <a href="javascript:share('twitter')">
                            <span><i class="icon icon-sns-twitter"></i></span>
                            <strong>트위터</strong>
                        </a>
                    </li>
                    <li class="kakao">
                        <a href="javascript:share('kakao')">
                            <span><i class="icon icon-sns-kakaotalk"></i></span>
                            <strong>카카오톡</strong>
                        </a>
                    </li>
                    <li class="mail">
						<a href="javascript:;" data-trigger="layer" data-target=".layer-mail" onclick="share('mail');">
                            <span><i class="icon icon-sns-mail"></i></span>
                            <strong>메일</strong>
                        </a>
                    </li>
                </ul>
                <div class="copy">
                    <p>※ 주소를 마우스 클릭하시면 클립보드로 복사하실 수 있습니다.</p>
                    <div class="url">
						<a href="javascript:void(0)" onclick="$('#shareLayerCloseBtn').click();$('#btnCopy').click()">${shareUrl}</a>
                        <input type="hidden" name="shareUrl" id="shareUrl" value="${shareUrl}">
                        <%--<button type="button" class="btn btn-deepdark btn-radius btn-copy" id="btnCopy" onclick="urlCopy()"><em>URL 복사하기</em></button>--%>
                        <button type="button" class="btn btn-deepdark btn-radius btn-copy" id="btnCopy" data-clipboard-action="copy" data-clipboard-target="#shareUrl"><em>URL 복사하기</em></button>
                    </div>
                </div>
            </div>
        </div>
        <button type="button" class="btn btn-layer-close" data-trigger="layer-close" id="shareLayerCloseBtn"><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
    </div>
</div>
<!-- //layer : share 공유하기 -->

<!-- layer : sendMail 메일 보내기-->
<div class="layer-wrap layer-mail" id="sendMail">
    <div class="layer layer-md layer-bg">
        <div class="layer-content">
            <div class="layer-header">
                <p class="layer-title">메일 보내기</p>
            </div>
            <div class="layer-body">
                <form id="comMailForm" method="POST" onsubmit="return false;">
                    <fieldset>
                        <div class="tb-form tb-write">
                            <table summary="">
                                <colgroup>
                                    <col >
                                    <col width="80%">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th scope="row">이름<small class="require">*</small></th>
                                    <td>
                                        <span class="input-text"><input type="text" placeholder="받는분의 이름을 입력해주세요." id="mailUserNm" required/></span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">이메일<small class="require">*</small></th>
                                    <td>
                                        <div class="multi-form email-form">
                                            <span class="input-text"><input type="text" id="mailId" required onkeyup="limitEmail(this)"/></span>
                                            <span class="split">@</span>
                                            <span class="input-text"><input type="text" id="mailDomain" required onkeyup="limitEmail(this)"/></span>
                                            <span class="default-select">
                                                <select name="" id="mailDomainCombo" onchange="$('#mailDomain').val(this.value)">
                                                    <option value="">직접입력</option>
                                                    <option value="naver.com">naver.com</option>
                                                    <option value="daum.net">daum.net</option>
                                                    <option value="gmail.com">gmail.com</option>
                                                    <option value="hotmail.com">hotmail.com</option>
                                                    <option value="nate.com">nate.com</option>
                                                </select>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="submit">
                            <p>※ 입력하신 정보는 이메일 전송 외의 목적으로 사용되지 않습니다.</p>
                            <button type="submit" class="btn btn-deepdark btn-radius" id="sendMailBtn"><em>보내기</em></button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
        <button type="button" class="btn btn-layer-close" data-trigger="layer-close" onclick="layerClose('layer-mail')"><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
    </div>
</div>

<!-- layer : toast message -->
<div class="layer-wrap layer-toast" id="toast">
    <div class="layer layer-sm">
        <div class="layer-content">
            <div class="layer-body">
                <i class="icon icon-success"></i>
                <p>Text를 설정해주세요.</p>
                <!--<button type="button" class="btn btn-primary btn-radius" data-trigger="layer-close">확인</button>-->
            </div>
        </div>
        <!--<button type="button" class="btn btn-layer-close" data-trigger="layer-close"><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>-->
    </div>
    <i class="layer-dim fade"></i>
</div>
<!-- //layer : toast message -->

<!-- //layer : sendMail 메일 보내기 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $('[data-trigger="layer"]').layer();

    var clipboard = new ClipboardJS('#btnCopy', {
        text: function(trigger) {
            var clipText = $("#shareUrl").val();
            if ( clipText == null || clipText == "" ) clipText = " ";
            return clipText;
        }
    });
    clipboard.on('success', function(e) {
        vwa.shareHistorySend('url');
        $('#shareLayerCloseBtn').click();
        toast('URL 복사가 완료되었습니다.');
    });
    clipboard.on('error', function(e) {
        toast('URL 복사가 실패되었습니다.');
    });

    Kakao.init('${kakaoClientId}');



    // 프린트
    $('.icon-util-print').on('click', function() {
        createPrintContent({
            init: function(layer) {
                layer.on('layer.close', function() {
                    $html.removeClass('layer-type-print');
                }).find('.icon-util-print').on('click', function() {
                    //vwa.hideLoading();
                    window.print();
                });
            },
            before: function() {
                //vwa.showLoading();
                $html.addClass('layer-type-print');
            }
        });
    });

    //메일보내기
    $("#comMailForm").validate({
        submitHandler: function(form){
            //error표시 삭제
            $("#comMailForm").find("input").removeClass("form-error");

            $.ajax({
                url: "${pageContext.request.contextPath}/comparison/share/mail",
                type: "POST",
                data: {firstSellCarSeq: ${firstResult.info.sellCarSeq}, lastSellCarSeq: ${lastResult.info.sellCarSeq}, mailUserNm: $('#mailUserNm').val(), mailAddr: $('#mailId').val() + '@' + $('#mailDomain').val()},
                success: function(result) {
                    $('#mailUserNm').val('');
                    $('#mailId').val('');
                    $('#mailDomain').val('');
                    $('#mailDomainCombo').val('');
                    vwa.shareHistorySend('mail');
                    toast('메일을 성공적으로 전송했습니다.');
                    $('.layer-mail').data('layer').close();
                }
            });
        }
    });
});

// 공유하기
function share(type) {
    if(type == 'facebook') {
        window.open(
            'http://www.facebook.com/sharer/sharer.php?t=[폭스바겐 인증중고차] 비교하신 차량정보입니다&u=${shareUrl}',
            'sns-facebook',
            'width=600, height=260'
        );
        vwa.shareHistorySend(type);
    } else if(type == 'twitter') {
        window.open(
            'https://twitter.com/intent/tweet?text=[폭스바겐 인증중고차] 비교하신 차량정보입니다&url=${shareUrl}&image=${pageContext.request.scheme}://${result.info.fileUrl}',
            'sns-twitter',
            'width=600, height=260'
        );
        vwa.shareHistorySend(type);
    } else if(type == 'kakao') {
        Kakao.Link.sendScrap({
            requestUrl: '${shareUrl}'
        });
        vwa.shareHistorySend(type);
    } else if(type == 'mail') {
        $('.layer-share').data('layer').close();
    }
}

var $html = $('html');

function createPrintContent(options) {
    var $printArea = $('.popup-comparison'),
        $printHtml = $printArea.clone().wrapAll("<div/>").parent().html(),
        $printLayer = $($.utils.layerTemplate()).appendTo($printArea).addClass('layer-print');

    $html.addClass('create-print-image');

    $printLayer.find('.layer-body').html($printHtml);
    $printLayer.layer();

    if(options && options.init) {
        options.init($printLayer);
    }

    if(options && options.before) {
        options.before();
    }

    setTimeout(function() {
        html2canvas(document.querySelector('.layer-print .layer'), {
            useCORS: true,
            logging: false,
            //foreignObjectRendering: true,
            //async: false,
            //allowTaint: true,
        }).then(function(canvas) {
            canvas.setAttribute('id', 'print-image');
            document.body.appendChild(canvas);
            $html.addClass('has-print').removeClass('create-print-image');
            //console.log(canvas.toDataURL('image/jpeg', 1.0));
            if(options && options.after) {
                options.after(canvas);
            }
        });
    }, 10);

    $printLayer.find(".icon-util-share").remove();
    $printLayer.find(".btn-top").remove();

    $printLayer.on('layer.close', function() {
        $printLayer.remove();
        $('#print-image').remove();
        $html.removeClass('create-print-image').removeClass('has-print');
    });
}

// 레이어 Open
function layerOpen(classNm) {
    $('.' + classNm).one('layer.close', function() {
        $(this).removeData('layer');
    }).layer();
}

// 레이어 Close
function layerClose(classNm) {
    var $html = $('html');
    $html.removeClass('show-layer');
    $('.' + classNm).removeClass('active')
}

// url copy
function urlCopy() {
    try {
        var copyText = document.getElementById("shareUrl");
        copyText.select();
        document.execCommand("Copy");
        vwa.shareHistorySend('url');
        $('#shareLayerCloseBtn').click();
        toast('URL 복사가 완료되었습니다.');
    } catch (e) {
        toast('URL 복사가 실패되었습니다.');
    }
}
</script>