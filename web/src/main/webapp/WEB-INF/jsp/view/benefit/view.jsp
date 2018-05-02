<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-02-13
  Time: 오후 1:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<main class="content-wrapper page-benefit">
    <section class="section section-visual">
        <div class="inner">
            <div class="item">
                <h2 class="is-mobile"><span>BENEFIT</span></h2>
                <i class="image" style="background-image:url('${pageContext.request.contextPath}/resources/images/benefit-top-visual.jpg');"></i>
                <div class="content">
                    <h2>Volkswagen Approved BENEFIT</h2>
                    <p class="description">폭스바겐의 공식 인증 중고차는 시간이 흘러도 변함없는<br>폭스바겐만의 가치를 두번째 고객에게 전달합니다.</p>
                    <p class="description">폭스바겐 공인 테크니션들이 꼼꼼하게 점검한 차량을 제공함과 동시에 <br>특별한 폭스바겐 공식 인증 중고차만의 다양한 혜택을 만나보실 수 있습니다. </p>
                </div>
            </div>
        </div>
    </section>
    <section class="section section-tab">
        <div class="inner">
            <nav class="tab">
                <strong>혜택</strong>
                <button type="button" class="tab-item tab-1 active">88가지 품질점검</button>
                <button type="button" class="tab-item tab-2 ">연장 보증</button>
                <button type="button" class="tab-item tab-3 ">보상 판매</button>
                <button type="button" class="tab-item tab-4 ">금융 상품</button>
            </nav>
        </div>
    </section>
    <section class="section section-tab-content">
        <section id="tab-cont-1" class="section section-check">
            <div class="inner">
                <h3 class="is-mobile"><span>88가지 품질점검</span></h3>
                <div class="content">
                    <h3>Technical quality check<strong>88가지 품질점검</strong></h3>
                    <p>Volkswagen Approved 중고차량의 품질을 유지하기 위해 88가지의 품질점검을 시행합니다.<br>또한 고객님께서 직접 확인해 보실 수 있도록 점검내역을 제공해 드립니다.</p>
                    <a href="#none" class="btn btn-primary btn-radius" data-trigger="layer" data-target="#qualityLayer">88가지 품질점검표 상세보기</a>
                </div>
                <span class="img">
							<img src="${pageContext.request.contextPath}/resources/images/benefit-item-1.jpg" alt="">
						</span>
            </div>
        </section>
        <section id="tab-cont-2" class="section section-warranty">
            <div class="inner">
                <h3 class="is-mobile"><span>연장 보증</span></h3>
                <div class="content">
                    <h3>Warranty Plus <strong>연장 보증</strong></h3>
                    <p>Volkswagen Approved 차량을 구매 해주신 고객님이 안심하고 차량을 운행할 수 있도록 폭스바겐 파이낸셜 서비스와 협업하여
                        구매시점부터 추가 연장보증을 제공합니다.</p>
                    <p>Volkswagen Approved 차량에 대한 연장보증은 공식 딜러사를 통해서만
                        제공되며 주행거리 제한 등 상세한 사항은 담당자에게
                        문의해 주시기 바랍니다.</p>
                    <%--<a href="#none" class="btn btn-primary btn-radius" data-trigger="layer" data-target="#warrantyLayer">연장보증 상세보기</a>--%>
                    <a href="javascript:toast('준비중입니다.');" class="btn btn-primary btn-radius">연장보증 상세보기</a>
                </div>
                <span class="img">
							<img src="${pageContext.request.contextPath}/resources/images/benefit-item-2.jpg" alt="">
						</span>
            </div>
        </section>
        <section id="tab-cont-3" class="section section-trade">
            <div class="inner">
                <h3 class="is-mobile"><span>보상 판매</span></h3>
                <div class="content">
                    <h3>Trade in <strong>보상 판매</strong></h3>
                    <p>폭스바겐의 신차 또는 인증 중고차를 구매 하시는 고객님의 편의를 위해 기존 보유 차량의 보상판매 서비스를 제공합니다.</p>
                    <p>고객님의 기존 보유 차량을 가지고 오시면 폭스바겐 인증중고차만의 투명하고 객관적인 평가를 통해 만족하실 수 있는 가치로 보상해 드립니다.</p>
                </div>
                <span class="img">
							<img src="${pageContext.request.contextPath}/resources/images/benefit-item-3.jpg" alt="">
						</span>
            </div>
        </section>
        <section id="tab-cont-4" class="section section-finance">
            <div class="inner">
                <h3 class="is-mobile"><span>금융 상품</span></h3>
                <div class="content">
                    <h3>Finance Options <strong>금융 상품</strong></h3>
                    <p>보다 쉽게 인증중고차량을 구매 하실 수 있도록 다양한 리스, 할부 등의 금융상품을 폭스바겐 파이낸셜서비스 코리아와 함께 제공합니다.</p>
                    <a href="javascript:;" target="_blank" class="btn btn-primary btn-radius" data-trigger="layer" data-target="#financeLayer">금융상품 상세보기</a>
                </div>
                <span class="img">
							<img src="${pageContext.request.contextPath}/resources/images/benefit-item-4.jpg" alt="">
						</span>
                <div class="tips">
                    <div class="item">
                        <h4>내 자금상황에 딱 맞춘! <strong>할부 상품</strong></h4>
                        <ul>
                            <li><i class="icon icon-check"></i> 고객 명의로 차량을 등록하려는 고객님</li>
                            <li><i class="icon icon-check"></i> 자유로운 할부기간을 누리고 싶으신 고객님</li>
                        </ul>
                    </div>
                    <div class="item">
                        <h4>실속있는 세제혜택을 맘껏 누리는! <strong>리스 상품</strong></h4>
                        <ul>
                            <li><i class="icon icon-check"></i> 초기자금에 대한 부담을 덜고 싶으신 고객님</li>
                            <li><i class="icon icon-check"></i> 관리 부담을 최소화 하고 싶으신 고객님</li>
                        </ul>
                    </div>
                    <div class="item">
                        <h4>편리하고 합리적으로 사용할 수 있는! <strong>리스 승계</strong></h4>
                        <ul>
                            <li><i class="icon icon-check"></i> 복잡한 절차 걱정 없이 이용하고 싶은 고객님</li>
                            <li><i class="icon icon-check"></i> 더 효율적인 비용으로 이용하고 싶은 고객님</li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
    </section>

    <!-- layer : qualityLayer 품질점검 -->
    <div class="layer-wrap layer-quality" id="qualityLayer">
        <div class="layer">
            <div class="layer-content">
                <div class="layer-header">
                    <p class="layer-title">Multi-Point Check List</p>
                </div>
                <div class="layer-body">
                    <div class="guide">
                        <p>폭스바겐 공인 테크니션들이  88가지의 품질점검을 꼼꼼하게 시행하여 품질을 유지합니다.</p>
                        <span class="img">
									<img src="${pageContext.request.contextPath}/resources/images/car_check.png" alt="">
								</span>
                        <div class="list-check">
                            <ol>
                                <li>기본점검</li>
                                <li>실내 점검</li>
                                <li>진단기 점검</li>
                                <li>등화류 점검</li>
                                <li>차량 전방 및 엔진룸 점검</li>
                                <li>소모품 점검</li>
                                <li>시운전 점검</li>
                                <li>베이/리프팅 점검</li>
                            </ol>
                        </div>
                    </div>
                    <div class="detail-check">
                        <div class="item">
                            <ol>
                                <li>
                                    <strong>01. 기본점검</strong>
                                    <ol class="list-all">
                                        <li>1) 차량 등록증과 차대 번호가 일치 합니까?</li>
                                        <li>2) DMS에 규정된 정기 점검의 정비 이력이 있습니까?</li>
                                        <li>3) 차량의 구조적 손상 또는 침수여부를 점검합니다.</li>
                                        <li>4) 리콜, 무상수리 실시여부를 확인합니다.</li>
                                    </ol>
                                </li>
                                <li>
                                    <strong>02. 실내 점검 </strong>
                                    <ol class="list-all">
                                        <li>5) 스티어링 휠의 컨트롤 버튼 상태 점검</li>
                                        <li>6) 경적 작동 점검 </li>
                                        <li>7) 계기판 조명 및 디스플레이 점검(조명 조절기 포함) </li>
                                        <li>8) 시계 작동 상태 점검 및 트립컴퓨터 상태 점검</li>
                                        <li>9) 도어등, 실내등 점검</li>
                                        <li>10) 앞 좌석 시트 작동상태 및 메모리 기능 점검</li>
                                        <li>11) 안전벨트 작동 및 상태 점검</li>
                                        <li>12) 사이드 미러 작동 및 메모리 점검 </li>
                                        <li>13) 썬루프 작동상태 점검 </li>
                                        <li>14) 글로브 박스 작동 및 미등 점검</li>
                                        <li>15) 사용자 설명서,서비스 플랜,보증서 보유 점검</li>
                                        <li>16) 실내에 부착된 안전관련 라벨 부착 상태 및 손상점검</li>
                                        <li>17) 페달 고무 찢어짐/마모 상태 점검</li>
                                        <li>18) 엔터테인먼트 점검 (CD / tuner / DVD / media / Bluetooth)</li>
                                        <li>19) 스티어링 휠 조정 및 작동 상태 확인 </li>
                                        <li>20) 중앙 잠금 장치 기능 점검</li>
                                        <li>21) 배터리 상태 점검</li>
                                        <li>22) 에어컨 작동 및 냉각성능 점검 (냉매량 점검)</li>
                                        <li>23) 히터 작동 상태 및 소음점검</li>
                                        <li>24) 실내 트림,대시보드,핸들,팔걸이 손상 점검</li>
                                        <li>25)  카페트,플러워매트 손상 점검(트렁크 포함)</li>
                                    </ol>
                                </li>
                                <li>
                                    <strong>03. 진단기 점검</strong>
                                    <ol class="list-all">
                                        <li>26) 진단기 온라인 프로토콜 점검 (고장코드)</li>
                                        <li>27) 엔진과 미션 최신 소프트웨어 업데이트 </li>
                                    </ol>
                                </li>
                                <li>
                                    <strong>04. 등화류 점검</strong>
                                    <ol class="list-all">
                                        <li>28) 전조등 점검</li>
                                        <li>29) 상향등 점검</li>
                                        <li>30) 안개등 앞/뒤 점검</li>
                                        <li>31) 주간 주행등 점검</li>
                                        <li>32) 방향지시등 앞/뒤 점검</li>
                                        <li>33) 비상점멸표시등 점검</li>
                                        <li>34) 번호판등 점검 </li>
                                        <li>35) 후미등 점검</li>
                                        <li>36) 제동등 점검</li>
                                        <li>37) 후진등 점검</li>
                                    </ol>
                                </li>
                                <!-- </ol>
                            </div>
                            <div class="item">
                                <ol> -->
                                <li>
                                    <strong>05. 차량 전방 및 엔진룸 점검</strong>
                                    <ol class="list-all">
                                        <li>38) 워셔액 유량 점검</li>
                                        <li>39) 엔진 오일 유량 및 오염상태 점검 (필요 시 교환)</li>
                                        <li>40) 브레이크 오일 유량 상태 및 누유 점검 (엔진룸 점검, 필요 시 교환)</li>
                                        <li>41) 냉각수량 및 오염점검</li>
                                        <li>42) 모든 키의 작동 점검 (키의 모든 기능 점검)</li>
                                        <li>43) V 벨트 마모와 장력 점검</li>
                                        <li>44) 전면 유리 손상 점검</li>
                                        <li>45) 후면 유리 손상 점검</li>
                                        <li>46) 우측 외관 점검(우측 루프 포함)</li>
                                        <li>47) 좌측 외관 점검(좌측 루프 포함)</li>
                                        <li>48) 와이퍼 모터 기능점검 (뒤와이퍼 포함)</li>
                                        <li>49) 윈도우 모터 작동 상태 및 소음점검</li>
                                        <li>50) 에어컨 가스 호스 누설 점검 (냉매 회수 충전량 점검) </li>
                                        <li>51) 연료 라인의 누설과 손상 점검</li>
                                        <li>52) 비상 삼각대 점검</li>
                                        <li>53) 엔진 후드 잠금 장치 점검</li>
                                        <li>54) 비상 수리 공구 및 락 휠 너트 점검</li>
                                        <li>55) 휠 너트의 토크 확인</li>
                                        <li>56) 도어 경첩 윤활(모든 도어와 부트 포함)</li>
                                        <li>57) 파워스티어링 오일의 유량 및 누출여부 점검</li>
                                    </ol>
                                </li>
                                <li>
                                    <strong>06. 소모품 점검</strong>
                                    <ol class="list-all">
                                        <li>58) 실내 공기 필터 점검</li>
                                        <li>59) 앞 브레이크 패드 및 디스크 점검</li>
                                        <li>60) 뒤 브레이크 패드 및 디스크 점검 </li>
                                        <li>61) 타이어 공기압 및 마모량 점검 (앞,뒤,좌,우, 스페어)</li>
                                        <li>62) 타이어 X자 위치 교환, 필요시 타이어 교체</li>
                                    </ol>
                                </li>
                                <li>
                                    <strong>07. 시운전 점검</strong>
                                    <ol class="list-all">
                                        <li>63) 휠얼라이먼트 점검 </li>
                                        <li>64) 휠 밸런스 점검 </li>
                                        <li>65) 엔진 작동 점검 </li>
                                        <li>66) 클러치 작동 및 상태 점검 </li>
                                        <li>67) 변속기 및 트랙션 컨트롤 작동 점검 및 소음점검</li>
                                        <li>68) 스티어링 조향성능 및 주행 안정성 점검</li>
                                        <li>69) 브레이크 시스템 작동 점검(ABS포함)</li>
                                        <li>70) 주차브레이크 작동 점검 </li>
                                        <li>71) 계기판 속도게이지 작동 점검</li>
                                        <li>72) 정속 주행 장치 작동 점검</li>
                                        <li>73) 주행거리계, 트립 카운터 작동 점검 </li>
                                        <li>74) 자동 잠금 및 언덕 밀림 방지 점검</li>
                                        <li>75) 연료게이지, 연료 소비율 작동 점검</li>
                                        <li>76) 네비게이션 작동 점검(필요시 업데이트) </li>
                                        <li>77) 차량 소음 점검  </li>
                                    </ol>
                                </li>
                                <li>
                                    <strong>08. 베이/리프팅 점검</strong>
                                    <ol class="list-all">
                                        <li>78) 브레이크 시스템 라인 및 호스 손상 누유 점검 (리프팅 후)</li>
                                        <li>79) 주차 브레이크의 기능점검</li>
                                        <li>80) 주요부품의 부식 및 상태 점검</li>
                                        <li>81) 엔진부 누유 점검</li>
                                        <li>82) 쇼크 업소버 누설 점검 </li>
                                        <li>83) 배기구 상태 점검, 카탈릭 컨버터(촉매 변환기) 외관 및 상태점검 </li>
                                        <li>84) 스티어링 기어 유격점검</li>
                                        <li>85) 스티어링 조인트 점검</li>
                                        <li>86) 드라이브 샤프트 마모/상태 점검</li>
                                        <li>87) 4모션차량의 경우 할덱스, 디퍼런셜의 작동상태 및 누유, 소음점검</li>
                                        <li>88) 변속기 오일누유 및 유량, 공회전시 작동상태 점검</li>
                                    </ol>
                                </li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <button type="button" class="btn btn-layer-close" data-trigger="layer-close" ><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
        </div>
    </div>
    <!-- //layer : qualityLayer 품질점검 -->
    <!-- layer : warrantyLayer 연장보증 -->
    <div class="layer-wrap layer-warranty" id="warrantyLayer">
        <div class="layer">
            <div class="layer-content">
                <div class="layer-header">
                    <p class="layer-title">Warranty Plus</p>
                </div>
                <div class="layer-body">
                    <p>Volkswagen Approved 차량은 구매시점부터 1년 또는 구매시점 이후 주행거리 2만 km 중 선도래하는 시점까지 연장보증을 제공합니다.</p>
                    <small class="symbol"><i class="asterisk"> *</i> 단, 제조사 보증 기간과 겹치는 경우 제조사 보증 조건이 적용됩니다.</small>

                    <div class="table table-responsive">
                        <p class="table-title">서비스 대상 부품</p>
                        <table>
                            <colgroup>
                                <col style="width: 18%">
                                <col>
                            </colgroup>
                            <thead>
                            <tr>
                                <th>서비스 대상 부품</th>
                                <th class="text-center">세부 내역</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>엔진</th>
                                <td data-title="엔진">
                                    실린더 블록, 크랭크케이스, 실린더 헤드, 실린더 헤드 가스켓, 로터리 엔진 케이스, 오일팬, 오일 압력 스위치, 오일 필터 케이스 및 오일 회로에 연결되는 전체 내부 부품/핵심 부품(조인트 및 가스켓 제외), 플라이휠 및 톱니 림이 장착된 드라이브 풀리, 크랭크샤프트 진동 댐퍼, 클램핑 장치 및 인장/리버스 풀리를 장착한 캠샤프트 벨트 또는 드라이브 체인, 흡입관 기계 부품, 제어장치가 포함된 터보차저. 주변 부품과 함께 캠샤프트 벨트나 드라이브 체인에 예정된 정비 간격이 유지되지 않을 경우, 본 서비스 대상에서 제외됩니다
                                </td>
                            </tr>
                            <tr>
                                <th>수동 및 자동 변속기</th>
                                <td data-title="수동 및 자동 변속기">
                                    기어박스 케이스 및 전체 내부 부품, 토크 컨버터, 변속기 제어장치, 전자 유압 스위치 기어 장치
                                </td>
                            </tr>
                            <tr>
                                <th>차동차축</th>
                                <td data-title="차동차축">
                                    전체 내부 부품, 전자 및 기계 차동 잠금장치를 비롯한 차축 변속기 하우징(전륜 및 후륜 구동)
                                </td>
                            </tr>
                            <tr>
                                <th>차축 드라이브 및 <br>차축 서스펜션</th>
                                <td data-title="차축 드라이브 및 차축 서스펜션">
                                    카아던 샤프트(Cardan shafts), 액슬 드라이브 샤프트, 드라이빙 조인트(실 제외), 휠 베어링, 휠 허브
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="item">
                        <p class="item-title">보상한도</p>
                        <div>
                            <p>공식 서비스센터 입고 시점 해당 자동차 모델의 잔존가치 (보험개발원 차량기준가액표 기준)</p>
                            <small class="symbol"><i class="asterisk">*</i> 차량기준가액표는 보험개발원에서 분기별로 제공합니다. (본 페이지 하단 파일 참고)</small>
                        </div>
                    </div>
                    <div class="item">
                        <p class="item-title">보상하지 않는 범위</p>
                        <div>
                            <ol class="list-decimal">
                                <li>
                                    산화 및 부식 손해 / 배기 시스템 / 내장 부품 / 브레이크 및 클러치 / 유리 / 비순정부품 / 고무 부품 / 섀시 / 가스켓 / 연료시스템 오염 / 휠 / 헤드라이트 / 각종 소음 / 소모성부품(필터, 스파크 러그, 벨트, 배터리, 윤활제, 부동액, 쇼크업쇼버, 전구류, 브레이크 라이닝(패드) 및 디스크, 클러치 디스크, 에어컨 가스 등) 등 서비스약관에 기재된 부품
                                </li>
                                <li>
                                    외부 충격 사고 / 자동차 개조, 변경에 의한 고장 / 서비스 대상 부품으로 인해 발생한 서비스 미대상 부품의 손해 등 서비스약관에 기재된 사항
                                </li>
                            </ol>
                            <small class="symbol"><i>※</i> Warranty Plus 서비스를 적용받기 위해서는 제조사가 제공한 사용자 설명서에 따라 차량을 유지/관리하고, 공식 서비스센터에서 정기 점검 및 정비를 받으셔야함을 알려드립니다</small>
                        </div>
                    </div>
                    <div class="item">
                        <p class="item-title">보상절차</p>
                        <div class="steps">
                            <ol>
                                <li>
                                    <div>
                                        <span>STEP 1</span>
                                        <strong>차량고장 발생</strong>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <span>STEP 2</span>
                                        <strong>공식 서비스 센터 입고</strong>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <span>STEP 3</span>
                                        <strong>보상가능 여부 확인</strong>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <span>STEP 4</span>
                                        <strong>차량수리</strong>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <span>STEP 5</span>
                                        <strong>차량 출고</strong>
                                    </div>
                                </li>
                            </ol>
                        </div>
                        <ul class="list-bullet">
                            <li>차량 이상 발생시 Volkswagen 공식 서비스 센터에 방문하시어, 가입 내역 확인 후 수리를 받으실 수 있습니다. <br>(공식 서비스 센터 외에서는 보상을 받으실 수 없습니다.)</li>
                            <li>해당 부품 수급 등 Volkswagen 및 공식 서비스센터 사정상 수리가 지연될 수 있습니다. </li>
                        </ul>
                    </div>
                    <div class="item">
                        <strong class="item-title">Warranty Plus (Powertrain Plan) 서비스 약관</strong>
                        <a class="btn sub-btn btn-dark btn-radius btn-link" href="https://www.vwfs.co.kr/vwfs/sc/ps/extensionGuarantee" target="_blank">바로가기</a>
                    </div>
                    <div class="item">
                        <strong class="item-title">보상한도 (보험개발원 차량기준가액표)</strong>
                        <a class="btn sub-btn btn-dark btn-radius btn-link" href="https://www.vwfs.co.kr/vwfs/sc/ps/extensionGuarantee" target="_blank">바로가기</a>
                    </div>
                    <div class="notice">
                        <ul class="list-bullet">
                            <li> 자세한 사항은 별도 서비스 약관을 참조 바랍니다.</li>
                            <li> 택시 및 렌터카 등 영업용 차량은 가입이 불가능 합니다.</li>
                            <li> 본 서비스는 DB손해보험㈜와 제휴하여 제공 됩니다.</li>
                            <li> Warranty Plus에 관한 문의는 Volkswagen Warranty Plus 전담상담센터 1566-0743으로 문의주시기 바랍니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
            <button type="button" class="btn btn-layer-close" data-trigger="layer-close" ><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
        </div>
    </div>
    <!-- //layer : warrantyLayer 연장보증 -->

    <!-- layer : Finance Options 금융상품 -->
    <div class="layer-wrap layer-finance" id="financeLayer">
        <div class="layer">
            <div class="layer-content">
                <div class="layer-header">
                    <p class="layer-title">VW Approved 금융상품</p>
                </div>
                <div class="layer-body">
                    <p>고객의 편의에 맞는 다양한 금융상품을 제공합니다.</p>

                    <div class="tab-finance">
                        <span>
                            <a href="#product1">
                                <em><i>초기비용/상환기간이 자유로운</i><strong>Classic 할부</strong></em>
                            </a>
                        </span>
                        <span>
                            <a href="#product2">
                                <em><i>리스편의성과 자금운용 혜택이 동시에!</i><strong>금융리스</strong></em>
                            </a>
                        </span>
                        <span>
                            <a href="#product3">
                                <em><i>부담을 덜어주는</i><strong>운용리스</strong></em>
                            </a>
                        </span>
                    </div>

                    <!-- Classic 할부 -->
                    <div class="item" id="product1">
                        <p class="item-title">Classic 할부</p>
                        <div class="item-content fill">
                            <div class="box">
                                <p>Classic 할부 "자금사정에 맞춰 초기비용 및 상환기간을 자유롭게 선택!"</p>
                                <ul class="list-dash">
                                    <li>가장 많이 이용하는 자동차 금융 상품으로, 매월 같은 월 할부금을 납부하는 원리금균등상환 방식의 금융상품 입니다.</li>
                                    <li>납부 회차가 더해 갈수록 상환하는 원금을 높아지고, 할부 이자는 줄어들지만, 실제로 납부하는 월 할부금은 매월 똑같아 자금관리가 용이합니다.</li>
                                    <li>약정 계약 기간 동안 매월 동일한 월 할부금을 납부하신 후 차량을 완전하게 소유 가능합니다.<br><small>(최저 7.5% 저금리 적용, 선납금 0%, 60개월 기준)</small></li>
                                </ul>
                            </div>
                        </div>
                        <p class="item-subtitle">Classic 할부 혜택</p>
                        <ul class="finance-benefits">
                            <li>
                                <div>
                                    <i class="icon icon-piechart"></i>
                                    <strong>[부담없는 초기비용]</strong>
                                    <span>재정 상황에 맞추어 자유롭게 초기비용을 조정할 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-calendar"></i>
                                    <strong>[자유로운 계약기간]</strong>
                                    <span>최장 60개월까지 편의에 따라 자유로운 선택이 가능합니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-board-person"></i>
                                    <strong>[고객 명의로 차량등록]</strong>
                                    <span>차량 등록 시 고객 명의로 등록되어 회계장부상 자산으로 등록할 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-saving"></i>
                                    <strong>[실속 있는 세제 혜택]</strong>
                                    <span>사업자의 경우, 월별 이자와 차량 감가상각에 대한 세금 혜택을 누릴 수 있습니다.</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- // Classic 할부 -->

                    <!-- 금융리스 -->
                    <div class="item" id="product2">
                        <p class="item-title">금융리스</p>
                        <div class="item-content fill">
                            <div class="box">
                                <p>금융리스 "리스의 편의성과 자금운용의 혜택을 동시에!"</p>
                                <ul class="list-dash">
                                    <li>리스는 금융사가 고객이 원하시는 차량을 대신 구입하고, 고객은 금융사에 매월 약정 이용료를 내고 차를 빌려 타는 방법을 말합니다.</li>
                                    <li>금융사 명의로 차량을 등록하여, 계약 만기 후 고객명의로 차량 명의 이전을 통해 소유하거나, 계약 기간 중 리스계약을 차량과 함께 승계할 수 있습니다.<small> (최저 7.5% 저금리 적용, 선납금 0%, 60개월 기준)</small></li>
                                </ul>
                            </div>
                        </div>
                        <p class="item-subtitle">금융리스 혜택</p>
                        <ul class="finance-benefits">
                            <li>
                                <div>
                                    <i class="icon icon-piechart"></i>
                                    <strong>[부담없는 초기비용]</strong>
                                    <span>재정 상황에 맞추어 자유롭게 초기비용을 조정할 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-calendar"></i>
                                    <strong>[자유로운 계약기간]</strong>
                                    <span>최장 60개월까지 편의에 따라 자유로운 선택이 가능합니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-board-dollar"></i>
                                    <strong>[고객 명의로 차량등록]</strong>
                                    <span>차량 등록 시 고객 명의로 등록되어 회계장부상 자산으로 등록할 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-number-plate"></i>
                                    <strong>[일반 번호판 사용]</strong>
                                    <span>영업용 번호판이 아닌 일반 번호판으로 사용하기 때문에 '내차' 에 대한 만족과 품위 유지할 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-board-person"></i>
                                    <strong>[만기 후, 차량 유지]</strong>
                                    <span>만기 후 본인 명의로 차량을 완전 소유할 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-saving"></i>
                                    <strong>[실속 있는 세제 혜택]</strong>
                                    <span>사업자의 경우, 월별 이자와 차량 감가상각에 대한 세금 혜택을 누릴 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-board-exchange"></i>
                                    <strong>[유리한 조건, 승계가능]</strong>
                                    <span>(계약중) 차량을 양도하는경우 비용 없이 더 좋은 조건으로 양도 할 수 있습니다.</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- // 금융리스 -->

                    <div class="table">
                        <p class="table-title">중고차 금융 조건</p>
                        <!-- pc -->
                        <table>
                            <colgroup>
                                <col style="width: 18%">
                                <col>
                                <col>
                                <col>
                                <col class="pc">
                                <col class="pc">
                                <col class="pc">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th rowspan="2">&nbsp;</th>
                                    <th colspan="3">18개월 이하</th>
                                    <th colspan="3" class="pc">18개월 초과</th>
                                </tr>
                                <tr>
                                    <th>Classic 할부</th>
                                    <th>금융리스</th>
                                    <th>운용리스</th>
                                    <th class="pc">Classic 할부</th>
                                    <th class="pc">금융리스</th>
                                    <th class="pc">운용리스</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th>차량가 (예시)</th>
                                    <td>31,100,000</td>
                                    <td>31,100,000</td>
                                    <td>31,100,000</td>
                                    <td class="pc">31,100,000</td>
                                    <td class="pc">31,100,000</td>
                                    <td class="pc">31,100,000</td>
                                </tr>
                                <tr>
                                    <th>선납률 (%)</th>
                                    <td>30%</td>
                                    <td>30%</td>
                                    <td>30%</td>
                                    <td class="pc">30%</td>
                                    <td class="pc">30%</td>
                                    <td class="pc">30%</td>
                                </tr>
                                <tr>
                                    <th>선납금 (￦)</th>
                                    <td>9,330,000</td>
                                    <td>9,330,000</td>
                                    <td>9,330,000</td>
                                    <td class="pc">9,330,000</td>
                                    <td class="pc">9,330,000</td>
                                    <td class="pc">9,330,000</td>
                                </tr>
                                <tr>
                                    <th>기간</th>
                                    <td>36</td>
                                    <td>36</td>
                                    <td>36</td>
                                    <td class="pc">36</td>
                                    <td class="pc">36</td>
                                    <td class="pc">36</td>
                                </tr>
                                <tr>
                                    <th>잔가 (%)</th>
                                    <td>-</td>
                                    <td>-</td>
                                    <td>30%</td>
                                    <td class="pc">-</td>
                                    <td class="pc">-</td>
                                    <td class="pc">30%</td>
                                </tr>
                                <tr>
                                    <th>금리 (%)</th>
                                    <td>8.40%</td>
                                    <td>8.15%</td>
                                    <td>-</td>
                                    <td class="pc">9.41%</td>
                                    <td class="pc">9.16%</td>
                                    <td class="pc">-</td>
                                </tr>
                                <tr>
                                    <th>월납입금 <sup>*</sup></th>
                                    <td>686,216</td>
                                    <td>683,700</td>
                                    <td>501,654</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //pc -->

                        <!-- mobile -->
                        <table class="mobile">
                            <colgroup>
                                <col style="width: 18%">
                                <col>
                                <col>
                                <col>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th rowspan="2">&nbsp;</th>
                                    <th colspan="3">18개월 초과</th>
                                </tr>
                                <tr>
                                    <th>Classic 할부</th>
                                    <th>금융리스</th>
                                    <th>운용리스</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th>차량가 (예시)</th>
                                    <td>31,100,000</td>
                                    <td>31,100,000</td>
                                    <td>31,100,000</td>
                                </tr>
                                <tr>
                                    <th>선납률 (%)</th>
                                    <td>30%</td>
                                    <td>30%</td>
                                    <td>30%</td>
                                </tr>
                                <tr>
                                    <th>선납금 (￦)</th>
                                    <td>9,330,000</td>
                                    <td>9,330,000</td>
                                    <td>9,330,000</td>
                                </tr>
                                <tr>
                                    <th>기간</th>
                                    <td>36</td>
                                    <td>36</td>
                                    <td>36</td>
                                </tr>
                                <tr>
                                    <th>잔가 (%)</th>
                                    <td>-</td>
                                    <td>-</td>
                                    <td>30%</td>
                                </tr>
                                <tr>
                                    <th>금리 (%)</th>
                                    <td>9.41%</td>
                                    <td>9.16%</td>
                                    <td>-</td>
                                </tr>
                                <tr>
                                    <th>월납입금 <sup>*</sup></th>
                                    <td>696,441</td>
                                    <td>693,902</td>
                                    <td>516,815</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- //mobile -->

                        <p class="text-right"><small>* 운용리스는 등록비용 포함</small></p>
                    </div>


                    <!-- 운용리스 -->
                    <div class="item" id="product3">
                        <p class="item-title">운용리스</p>
                        <div class="item-content fill">
                            <div class="box">
                                <p>운용리스 "차량 소유의 부담은 없애고, 간편하게 월 리스료만 내기!"</p>
                                <ul class="list-dash">
                                    <li>차량을 소유하는 의미 보다는 임대의 성격이 강한 리스 상품으로 계약 기간 동안 매월 정액의 리스료를 내고 차량을 운행하는 상품입니다.</li>
                                    <li>리스료 산정 시 잔존가치 (리스 만기 시 임의로 책정된 중고차 가격)를 제외하여 저렴한 월 리스료로 차량 운행이 가능하며, 만기 시 차량을 반납하고 신차로 교체하시려는 고객님께 유리합니다.</li>
                                    <li>리스료 비용처리 편의성 및 세제 혜택을 누릴 수 있는 상품입니다.</li>
                                </ul>
                            </div>
                        </div>
                        <p class="item-subtitle">운용리스 혜택</p>
                        <ul class="finance-benefits">
                            <li>
                                <div>
                                    <i class="icon icon-lease-option"></i>
                                    <strong>[다양한 사용 조건]</strong>
                                    <span>월 리스료, 기간, 만기 처리 등을 원하시는 조건으로 선택할 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-saving"></i>
                                    <strong>[용이한 비용처리 및 세제 혜택]</strong>
                                    <span>사업자의 경우, 월별 손비 처리가 가능하여 세제 해택을 받으실 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-board-dollar"></i>
                                    <strong>[금융사 명의로 차량등록]</strong>
                                    <span>금융사 명으로 차량이 등록 되어 익명성이 보장됩니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-bar-graph"></i>
                                    <strong>[건전한 재무구조 효과]</strong>
                                    <span>차입금이 발생되지 않아 부채 비율이 감소하는 효과를 누리실 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-piechart-money"></i>
                                    <strong>[저렴한 초기비용]</strong>
                                    <span>부대비용까지 리스료에 포함하여 초기비용 감소효과가 발생합니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-number-plate"></i>
                                    <strong>[일반 번호판 사용]</strong>
                                    <span>영업용 번호판이 아닌 일반 번호판으로 사용하기 때문에 '내차' 에 대한 만족과 품위 유지할 수 있습니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-board-won"></i>
                                    <strong>[간편한 회계처리]</strong>
                                    <span>리스료에 부가세가 부과되지 않아 회계처리가 간편합니다.</span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <i class="icon icon-car-care"></i>
                                    <strong>[차량관리 편리성]</strong>
                                    <span>잔존가치에 대한 변동 위험이 없어 편리하게 차량을 관리할 수 있습니다.</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- // 운용리스 -->

                    <div class="notice">
                        <ul class="list-bullet">
                            <li> 상기 금융상품은 조건에 따라 변동될 수 있습니다.</li>
                            <li> 자세한 사항은 폭스바겐 파이낸셜 서비스 코리아로 문의해주시기 바랍니다.</li>
                            <li class="point"> 폭스바겐파이낸셜 서비스 코리아 고객센터 1588-8420 (09 ~ 18시, 토/일요일, 공휴일 휴무)</li>
                        </ul>
                    </div>
                </div>
            </div>
            <button type="button" class="btn btn-layer-close" data-trigger="layer-close" ><i class="icon icon-layer-close"></i><span class="hidden">닫기</span></button>
        </div>
    </div>
    <!-- //layer : Finance Options 금융상품 -->
</main>
<script>
	$(function() {
		$('[data-trigger="layer"]').layer();

		var $tabs = $('.tab-item'),
			$tabWrap = $('.section-tab'),
			$sections = $('.section-tab-content .section'),
			sectionMap = null;

		function createMap() {
			sectionMap = $sections.map(function() {
				var _gap = $(window).width() > 846 ? $tabs.height() + 10 : 0;
				return $(this).offset().top - _gap;
			});
		}

		function scrollEvent() {
			var scrollTop = $(this).scrollTop();

			if(scrollTop >= $tabWrap.offset().top) {
				$tabWrap.addClass('sticky');
			} else {
				$tabWrap.removeClass('sticky');
			}

			$.each(sectionMap,function(index,top){
				if(scrollTop >= top){
					$tabs.eq(index).addClass('active').siblings().removeClass('active');
					$sections.eq(index).addClass('current').siblings().removeClass('current');
				}
				if(scrollTop < sectionMap[0]) {
					$sections.removeClass('current');
				}
			});
		}

		$(window).on('scroll.tab', scrollEvent);

		createMap();
		$(window).on('load', createMap);

		$(".tab-item").on('click', function() {
			var index = $(".tab-item").index(this);
			$(this).addClass('active').siblings().removeClass('active');
			$(window).off('scroll.tab', scrollEvent);
			$('html,body').animate({
				scrollTop: $(".section-tab-content .section").eq(index).offset().top -50
			}, 'slow', function() {
				$(window).on('scroll.tab', scrollEvent);
			});
		});

		var $layerFinance = $('.layer-finance'),
			$finances = $layerFinance.find('.item'),
			financeMap = null;

		$layerFinance.on('layer.open', function() {
			financeMap = $finances.map(function() {
				return $(this).offset().top - $(window).scrollTop();
			});
		});

		$('.tab-finance a').on('click', function(e) {
			e.preventDefault();
			var index = $(this).parent().index();

			$layerFinance.animate({
				scrollTop: financeMap[index]
			});
		});
	});
</script>