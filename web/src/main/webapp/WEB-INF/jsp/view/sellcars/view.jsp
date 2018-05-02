<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-02-19
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<main class="content-wrapper page-sellcars">
    <section class="section section-visual">
        <div class="inner">
            <div class="item">
                <h2 class="page-header">SELL CARS</h2>
                <i class="image" style="background-image:url('${pageContext.request.contextPath}/resources/images/sellcars-top-visual.jpg');"></i>
            </div>
        </div>
    </section>
    <section class="section section-process">
        <div class="inner">
            <ul>
                <li class="active">
                    <em class="step">STEP 1</em>
                    <div><i class="icon icon-round-write-form"></i></div>
                    <strong>내차팔기 신청</strong>
                    <p class="sub-desc">내차팔기를 신청후,<br>차량전문가가 상담 일정을<br>체크하고 예약을 접수합니다.</p>
                </li>
                <li>
                    <em class="step">STEP 2</em>
                    <div><i class="icon icon-round-counseling"></i></div>
                    <strong>차량상담</strong>
                    <p class="sub-desc">전시장으로 내방 후,<br>차량전문가의 점검에 의한<br>확정 매입가를 제시합니다.</p>
                </li>
                <li>
                    <em class="step">STEP 3</em>
                    <div><i class="icon icon-round-payment"></i></div>
                    <strong>판매결정</strong>
                    <p class="sub-desc">전문가와의 상담을 통해<br>최종 내차 판매여부를<br>결정합니다.</p>
                </li>
                <li>
                    <em class="step">STEP 4</em>
                    <div><i class="icon icon-round-check"></i></div>
                    <strong>판매완료</strong>
                    <p class="sub-desc">차량 대금 송금 및<br>최종점검 후<br>내차팔기 완료!</p>
                </li>
            </ul>
        </div>
    </section>
    <section class="section section-form">
        <div class="inner">
            <form id="sellCarForm" method="POST" onsubmit="return false;">
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
                                <th scope="row">소유구분<small class="require">*</small></th>
                                <td>
                                    <span class="radiobtn">
                                        <input type="radio" id="owner-p" name="type" value="개인" required checked="checked"/>
                                        <label for="owner-p"><em>개인</em></label>
                                    </span>
                                    <span class="radiobtn">
                                        <input type="radio" id="owner-co" name="type" value="법인" required />
                                        <label for="owner-co"><em>법인</em></label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">이름<small class="require">*</small></th>
                                <td>
                                    <div class="name-form">
                                        <span class="input-text"><input type="text" name="user" placeholder="상담하실 고객님 이름을 입력하세요." required /></span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">이메일<small class="require">*</small></th>
                                <td>
                                    <div class="multi-form email-form">
                                        <span class="input-text"><input type="text" name="email" required onkeyup="limitEmail(this)"/></span>
                                        <span class="split">@</span>
                                        <span class="input-text"><input type="text" name="emailaddress" id="address" required onkeyup="limitEmail(this)"/></span>
                                        <span class="default-select">
                                            <select name="" id="webaddress">
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
                            <tr>
                                <th scope="row">차량번호<small class="require">*</small></th>
                                <td>
                                    <span class="input-text"><input type="text" name="carNum" placeholder="판매하실 차량번호를 입력하세요." required /></span>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">지점<small class="require">*</small></th>
                                <td>
                                    <span class="default-select size-full">
                                        <select name="exhHallSeq" id="" required>
                                            <option name="exhHallSeq" value="">지점선택</option>
                                            <c:forEach var="branch" items="${branchList}" varStatus="status">
                                                <option name="exhHallSeq" value="${branch.exhHallSeq}">${branch.storeNm}</option>
                                            </c:forEach>
                                        </select>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">연식</th>
                                <td>
                                    <span class="input-text"><input type="number" pattern="[0-9]*" inputmode="numeric" min="0" name="carYear" id="sellCarYear" placeholder="연식을 입력하세요.(예 2018)" /></span>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">주행거리</th>
                                <td>
                                    <span class="input-text"><input type="number" pattern="[0-9]*" inputmode="numeric" min="0" name="carStreet" id="sellCarStreet" placeholder="주행거리를 입력하세요. (예 100000)" /></span>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row" class="vertical-top">추가내용</th>
                                <td>
                                    <span class="input-text">
                                        <textarea name="addText" id="" cols="5" rows="5" placeholder="추가 내용을 입력하세요.&#13;&#10;추가 정보를 입력하시면 빠른 상담을 받으실 수 있습니다."></textarea>
                                    </span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="terms">
                            <p class="tit">
                                <span class="checkbox">
                                    <input type="checkbox" class="checkbox" id="allCheck"><i></i>
                                </span>
                                <label for="allCheck"><em>약관 전체 동의</em></label>
                            </p>
                            <div class="contents">
                                <div class="item">
                                    <p class="tit">
                                        <span class="checkbox">
                                            <input type="checkbox" class="checkbox" name="agree1" id="agree1" value="Y"><i></i>
                                        </span>
                                        <label for="agree1"><em>(필수) 개인정보 수집 및 이용 동의</em></label>
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
                                            <input type="checkbox" class="checkbox" name="agree2" id="agree2" value="Y"><i></i>
                                        </span>
                                        <label for="agree2"><em>(필수) 개인정보 처리 위탁</em></label>
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
                                            <input type="checkbox" class="checkbox" name="agree3" id="agree3" value="Y"><i></i>
                                        </span>
                                        <label for="agree3"><em>(선택) 개인정보 수집 및 이용 동의</em></label>
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
                        <button type="button" id="resetBtn" class="btn large-btn btn-dark btn-radius btn-refresh"><i class="icon icon-util-refresh"></i><em>초기화</em></button>
                        <button type="submit" id="question" class="btn large-btn btn-primary btn-radius"><em>문의하기</em></button>
                    </div>
                </fieldset>
            </form>
        </div>
    </section>
</main>
<script type="text/javascript">

    $(function(){

        // 약관 동의 체크박스 전체 선택/해제 (빠른 문의 layer 에서 이벤트 처리)
        $(document).on("click","#allCheck",function(){
            if ( $('#allCheck').is(':checked')) {
                $(':checkbox[id="agree1"]').prop('checked', true);
                $(':checkbox[id="agree2"]').prop('checked', true);
                $(':checkbox[id="agree3"]').prop('checked', true);
            } else {
                $(':checkbox[id="agree1"]').prop('checked', false);
                $(':checkbox[id="agree2"]').prop('checked', false);
                $(':checkbox[id="agree3"]').prop('checked', false);
            }
        })

        //약관동의 체크박스 모두 체크됐을 시 전체동의 체크박스 체크처리
        $(document).on("click","#agree1, #agree2, #agree3",function(){
            if($('#agree1').is(':checked') && $('#agree2').is(':checked') && $('#agree3').is(':checked')) {
                $('#allCheck').prop('checked', true);
            } else {
                $('#allCheck').prop('checked', false);
            }
        });
    });

    //주소 select박스 선택이벤트
    $(document).on("change","#webaddress",function(){
        var webaddress=$(this).val();
        $("#address").val(webaddress);
    });

    //초기화버튼 이벤트
    $(document).on("click","#resetBtn",function(){
        $.ajax({
            url : "${pageContext.request.contextPath}/sellcars/view",
            type: "POST",
            dataType : "html",
            success : function(data){
                $("#sellCarForm").html($(data).find('#sellCarForm').html());
            }
       });
    });

    //숫자외 입력불가 이벤트
    $(document).on("keyup","#sellCarYear, #sellCarStreet",function(){
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

    //내차 팔기 클릭이벤트
    $("#sellCarForm").validate({
        submitHandler: function(form){
            //error표시 삭제
            $("#sellCarForm").find("input").removeClass("form-error");
            $("#sellCarForm").find("select").removeClass("form-error");

            if(!$("#agree1").prop("checked")){
                toast("개인정보 수집 및 이용 동의에 동의하세요.");
                return;
            }

            if(!$("#agree2").prop("checked")){
                toast("개인정보 처리 위탁에 동의하세요.");
                return;
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/sellcars/emailSend",
                type: "POST",
                async: false,
                data : $("#sellCarForm").serialize(),
                success: function(result) {
                    toast("고객님의 문의사항이 접수되었습니다.<br/>답변은 입력하신 이메일로 전송됩니다.");
                }
            });
        }
    });

</script>