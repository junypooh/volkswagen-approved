<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-02-20
  Time: 오후 2:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- layer : quick 빠른 문의-->
<div class="layer-wrap layer-vehicle layer-qna-quick" id="qnaQuick">
    <div class="layer">
        <div class="layer-content">
            <div class="layer-header">
                <p class="layer-title">빠른 문의</p>
            </div>
            <div class="layer-body">
                <form id="fastInquiryForm" method="POST" onsubmit="return false;">
                    <section class="section section-form" id="quickBody">
                        <div class="inner">
                            <p class="desc">궁금한 사항은 언제든 문의주세요.<br>해당하는 차량정보에 대하여 이메일로 발송됩니다.</p>
                            <fieldset>
                                <legend>신청서 작성</legend>
                                <strong class="warning-msg"><small class="require">*</small>필수항목을 모두 입력해주세요.</strong>
                                <div class="tb-form tb-write">
                                    <table summary="">
                                        <colgroup>
                                            <col >
                                            <col width="80%">
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <td colspan="2">
                                                <span class="input-text"><input type="text" name="name" required placeholder="상담하실 고객님의 이름을 입력해주세요.*" /></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <span class="input-text"><input type="text" name="email" id="quickEmail" required onkeyup="limitEmail(this)" placeholder="이메일 주소를 입력해 주세요.*" /></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <span class="default-select size-full">
                                                    <select name="branch" id="quickBranch" required>
                                                        <option value="">문의하실 지점을 선택해주세요.*</option>
                                                        <c:forEach var="branch" items="${branchList}">
                                                            <option value="${branch.exhHallSeq}">${branch.storeNm}</option>
                                                        </c:forEach>
                                                    </select>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <span class="input-text"><input type="text" name="mak" placeholder="문의하실 제조사를 입력해주세요.*" required /></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <span class="input-text"><input type="text" name="model" placeholder="문의하실 모델을 입력해주세요.*" required /></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>주행거리</th>
                                            <td>
                                                <div class="multi-form">
                                                    <span class="input-text"><input type="number" pattern="[0-9]*" inputmode="numeric" min="0" name="strDriveDist" id="quickStrDriveDist" placeholder="0"></span>
                                                    <em class="split">~</em>
                                                    <span class="input-text"><input type="number" pattern="[0-9]*" inputmode="numeric" min="0" name="endDriveDist" id="quickEndDriveDist" placeholder="150,000"></span>
                                                </div>
                                                <em class="unit">km</em>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>가격대</th>
                                            <td>
                                                <div class="multi-form">
                                                    <span class="input-text"><input type="number" pattern="[0-9]*" inputmode="numeric" min="0" name="strPrice" id="quickStrPrice" placeholder="0"></span>
                                                    <em class="split">~</em>
                                                    <span class="input-text"><input type="number" pattern="[0-9]*" inputmode="numeric" min="0" name="endPrice" id="quickEndPrice" placeholder="100,000,000"></span>
                                                </div>
                                                <em class="unit">원</em>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>연식</th>
                                            <td>
                                                <div class="multi-form">
                                                    <span class="input-text"><input type="number" pattern="[0-9]*" inputmode="numeric" min="0" name="strProdYear" id="quickStrProdYear" placeholder="2008" maxlength="4"></span>
                                                    <em class="split">~</em>
                                                    <span class="input-text"><input type="number" pattern="[0-9]*" inputmode="numeric" min="0" name="endProdYear" id="quickEndProdYear" placeholder="2018" maxlength="4"></span>
                                                </div>
                                                <em class="unit">년</em>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>사고유무</th>
                                            <td>
                                                <span class="radiobtn">
                                                    <input type="radio" id="accidYnY" name="accidYn" value="전체" checked="checked"/>
                                                    <label for="accidYnY"><em>전체</em></label>
                                                </span>
                                                <span class="radiobtn">
                                                    <input type="radio" id="accidYnN" name="accidYn" value="무사고" />
                                                    <label for="accidYnN"><em>무사고</em></label>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="vertical-top">추가내용</th>
                                            <td>
                                                <span class="input-text size-full">
                                                    <textarea name="addContents" cols="5" rows="5" placeholder="추가 내용을 입력하세요.&#13;&#10;추가 정보를 입력하시면 빠른 상담을 받으실 수 있습니다."></textarea>
                                                </span>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="terms">
                                        <p class="tit">
                                        <span class="checkbox">
                                            <input type="checkbox" class="checkbox" name="quickAllCheck" id="quickAllCheck"><i></i>
                                        </span>
                                            <label for="quickAllCheck"><em>약관 전체 동의</em></label>
                                        </p>
                                        <div class="contents">
                                            <div class="item">
                                                <p class="tit">
                                                    <span class="checkbox">
                                                        <input type="checkbox" class="checkbox" name="agree1" id="quickAgree1" value="Y"><i></i>
                                                    </span>
                                                    <label for="quickAgree1"><em>(필수) 개인정보 수집 및 이용 동의</em></label>
                                                    <button type="button" class="btn btn-accordion">열기</button>
                                                </p>
                                                <div class="con">
                                                    <div>
                                                        <ol>
                                                            <li>
                                                                <strong>1.  개인정보 수집·이용 목적</strong>
                                                                <p> - 고객의 중고차 문의에 대한 상담 및 기타 판매 및 구매 관련 정보 제공 등 </p>
                                                            </li>
                                                            <li>
                                                                <strong>2. 항목</strong>
                                                                <p> - 성명/ 휴대전화번호/ 이메일/ 관심모델</p>
                                                            </li>
                                                            <li>
                                                                <strong>3. 보유·이용기간</strong>
                                                                <p> - 수집 · 이용 목적 달성시까지</p>
                                                            </li>
                                                        </ol>
                                                        <small>※ 귀하는 위 사항에 대하여 동의를 하지 않을 수 있으나, 위 정보는 기재된 서비스 제공을 위해서 필요한 최소한의 개인정보이므로 동의를 해 주셔야 위 수집 및 이용목적에 기재된 서비스를 이용하실 수 있습니다.</small>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="item">
                                                <p class="tit">
                                                    <span class="checkbox">
                                                        <input type="checkbox" class="checkbox" name="agree2" id="quickAgree2" value="Y"><i></i>
                                                    </span>
                                                    <label for="quickAgree2"><em>(필수) 개인정보 처리 위탁</em></label>
                                                    <button type="button" class="btn btn-accordion">열기</button>
                                                </p>
                                                <div class="con">
                                                    <div>
                                                        <ol>
                                                            <li>
                                                                <strong>1.  수탁 업체</strong>
                                                                <p> - 아우디 폭스바겐 코리아 주식회사 </p>
                                                            </li>
                                                            <li>
                                                                <strong>2. 항목</strong>
                                                                <p> - Volkswagen Approved 를 통하여 개인정보 수집 업무 및 인증 딜러사 전송</p>
                                                            </li>
                                                        </ol>
                                                        <small>※ 귀하는 위 사항에 대하여 동의를 하지 않을 수 있으나, 동의를 거부하시는 경우 위탁 업무 내용에 나열된 각종 서비스의 제공이 제한될 수 있습니다.</small>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="item">
                                                <p class="tit">
                                                    <span class="checkbox">
                                                        <input type="checkbox" class="checkbox" name="agree3" id="quickAgree3" value="Y"><i></i>
                                                    </span>
                                                    <label for="quickAgree3"><em>(선택) 개인정보 수집 및 이용 동의</em></label>
                                                    <button type="button" class="btn btn-accordion">열기</button>
                                                </p>
                                                <div class="con">
                                                    <div>
                                                        <ol>
                                                            <li>
                                                                <strong>1.  개인정보 수집·이용 목적</strong>
                                                                <p> - 광고 등 홍보 및 마케팅 활용 </p>
                                                            </li>
                                                            <li>
                                                                <strong>2. 항목</strong>
                                                                <p> - 성명 / 휴대전화 번호 / 이메일 / 관심모델 / 선택 딜러사</p>
                                                            </li>
                                                            <li>
                                                                <strong>3. 보유·이용기간</strong>
                                                                <p> - 상담 신청 후 3년 </p>
                                                            </li>
                                                        </ol>
                                                        <small>※ 귀하는 위 사항에 대하여 동의를 하지 않을 수 있으나, 동의를 거부하시는 경우 제공 목적에 나열된 각종 서비스의 제공이 제한될 수 있습니다.</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="btns">
                                    <button type="button" id="quickClearButton" class="btn large-btn btn-dark btn-radius btn-refresh"><i class="icon icon-util-refresh"></i><em>초기화</em></button>
                                    <button type="submit" id="inquiryButton" class="btn large-btn btn-primary btn-radius"><em>문의하기</em></button>
                                </div>
                            </fieldset>
                        </div>
                    </section>
                </form>
            </div>
        </div>
        <button type="button" class="btn btn-layer-close" data-trigger="layer-close" onclick="closeQuick()"><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
    </div>
</div>
<script type="text/javascript">
    $(function(){

        // 약관 동의 체크박스 전체 선택/해제
        // 레이어이기 한꺼번에 처리 (매물 상세 문의하기 약관, 내차 팔기 약관)
        $(document).on("click","#quickAllCheck",function(){
            if ( $('#quickAllCheck').is(':checked')) {
                $(':checkbox[id="quickAgree1"]').prop('checked', true);
                $(':checkbox[id="quickAgree2"]').prop('checked', true);
                $(':checkbox[id="quickAgree3"]').prop('checked', true);
            } else {
                $(':checkbox[id="quickAgree1"]').prop('checked', false);
                $(':checkbox[id="quickAgree2"]').prop('checked', false);
                $(':checkbox[id="quickAgree3"]').prop('checked', false);
            }
        });

        //약관동의 체크박스 모두 체크됐을 시 전체동의 체크박스 체크처리
        $(document).on("click","#quickAgree1, #quickAgree2, #quickAgree3",function(){
            if($('#quickAgree1').is(':checked') && $('#quickAgree2').is(':checked') && $('#quickAgree3').is(':checked')) {
                $('#quickAllCheck').prop('checked', true);
            } else {
                $('#quickAllCheck').prop('checked', false);
            }
        });

        // 레이어이기 한꺼번에 처리 (매물 상세 문의하기 약관, 내차 팔기 약관)
        $('.btn-accordion').on('click', function (){
            $(this).parents('.item').toggleClass('active').siblings().removeClass('active');
        });

        //문의하기버튼 이벤트
        $("#fastInquiryForm").validate({
            submitHandler: function(form) {
                //error표시 삭제
                $("#fastInquiryForm").find("input").removeClass("form-error");
                $("#fastInquiryForm").find("select").removeClass("form-error");

                if(!$("#quickAgree1").prop("checked")){
                    toast("개인정보 수집 및 이용 동의에 동의하세요.");
                    return;
                }

                if(!$("#quickAgree2").prop("checked")){
                    toast("개인정보 처리 위탁에 동의하세요.");
                    return;
                }


                $('#fastInquiryForm').submit(function() {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/layer/quick/inquiry",
                        type: "POST",
                        data: $("#fastInquiryForm").serialize(),
                        async: false,
                        success: function(result) {
                            toast("빠른문의가 완료되었습니다.<br/>답변은 입력하신 이메일로 전송됩니다");
                        }
                    });
                });
            }
        });

        //숫자외 입력불가 이벤트
        $(document).on("keyup","#quickStrDriveDist, #quickEndDriveDist, #quickStrPrice, #quickEndPrice, #quickStrProdYear, #quickEndProdYear",function(){
            $(this).val($(this).val().replace(/[^0-9]/g,""));
        });

        //이메일 입력시 한글불가 이벤트
        $(document).on("keyup","#quickEmail",function(){
            $(this).val($(this).val().replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g,""));
        });

        //클리어버튼 이벤트
        $(document).on("click", "#quickClearButton", function(){
            $.ajax({
                url : "${pageContext.request.contextPath}/layer/quick",
                type: "POST",
                dataType : "html",
                success : function(data){
                    $("#quickBody").html($(data).find('#quickBody').html());
                }
           });
        });
    });

    function closeQuick() {
        //$('#qnaQuick').toggle();
        //setLnbOn();
    }

</script>
<!-- //layer : quick 빠른 문의 -->
