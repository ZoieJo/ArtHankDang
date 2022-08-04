<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
			<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

				<sec:csrfInput />
				<!-- fullCalendar -->
				<link href="${RESOURCES_PATH}/assets/fullcalendar/lib/main.css" rel='stylesheet'>
				<script src="${RESOURCES_PATH}/assets/fullcalendar/lib/main.js"></script>
				<c:set var="member" scope="request" value="${member}" />
				<c:set var="memberCode" scope="session" value="${memberCode}" />
				<!-- Page Body Start-->
				<div class="container-fluid">

					<div class="page-header">

						<div class="row d-flex">

							<div class="col-sm-6">
								<h2>마이페이지</h2>
								<!-- 제목 하단 페이지 경로 -->
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">홈</a></li>
									<li class="breadcrumb-item"><a href="${CONTEXT_PATH}/mypage/main">마이페이지</a></li>
								</ol>
							</div>

							<div class="col-sm-6"></div>
						</div>
					</div>
				</div>

				<!-- 내용 시작 -->
				<div class="container-fluid">
					<div class="row starter-main">

						<div class="row">
							<div class="col-lg-6 col-12">
								<div class="card">
									<div class="card-header pb-0 d-flex justify-content-between">
										<div class="">
											<h5>회원 정보</h5>
										</div>
										<div class="align-items-center">
											<button type="button" class="btn btn-primary px-2" data-bs-toggle="modal"
												data-original-title="test" data-bs-target="#resetPwModal"><i
													class="fa-solid fa-unlock-keyhole"></i> 비밀번호 변경</button>
											<a href="${CONTEXT_PATH}/mypage/memberinfo/detail" class="setting">
												<button type="button" class="btn btn-secondary px-2"><i
														class="fa-solid fa-pen-to-square"></i> 수정</button>
											</a>
										</div>

									</div>

									<div class="card-body">
										<div class="">
											<div class="col-12 col-lg-12 text-center img-box">
												<img class="img-fluid rounded-circle w-50" alt=""
													src="https://avatars.dicebear.com/api/micah/${USERNAME}.svg">
											</div>
											<c:choose>
												<c:when test="${memberCode == 1}">
													<div class="col-12 col-lg-12 my-1 p-2">
														<h6>${member.getStuNm()}</h6>
														<hr class="dashed">
														학생<br>
														${member.getStuEmail()}<br>
														${member.getStuPhNo()}<br>
														${member.getStuAddr()}&nbsp;${member.getStuAddrDtl()}<br>
														${member.getStuIntFd()}

													</div>
												</c:when>
												<c:when test="${memberCode > 1}">
													<div class="col-12 col-lg-8 my-1 p-2">
														<h6>${member.getEmpNm()}</h6>
														<hr class="dashed">교직원<br>
														${member.getEmpEmail()}<br>
														${member.getEmpPhNo()}<br>
														${member.getEmpAddr()}&nbsp;${member.getEmpAddrDtl()}<br>
														
													</div>
												</c:when>
											</c:choose>
										</div>

									</div>
								</div>

							</div>
							<div class="col-lg-6 col-12">
								<div class="card" style="height:94.3%;">
									<div class="card-header">
										<input type="button" id="id_day"
											class="btn btn-pill btn-primary btn-air-primary" value="일정 등록"
											onclick="dayInput()">
										<div align="right">
										</div>
										<div id="calendar" style="max-width: 1500px;">
										</div>
									</div>
								</div>
							</div>

							<script type="text/javascript">
								const tokenHeader = '${_csrf.headerName}';
								const tokenValue = '${_csrf.token}';
								const calendarEl = document.getElementById('calendar');
								const bColors = ['#16a085', '#8e44ad', '#dfe4ea', '#ee5253', '#f1c40f'];
								const tColors = ['white', 'white', 'black', 'white', 'black'];
								var calendar;



								document.addEventListener('DOMContentLoaded', function () {


									//Ajax 방식  일정 리스트
									let evtDatas = [];
									let xhr = new XMLHttpRequest();
									xhr.open("get", "${pageContext.request.contextPath}/schd/callist", true);
									xhr.onreadystatechange = function () {
										if (xhr.readyState == 4 && xhr.status == 200) {
											let recDatas = JSON.parse(xhr.responseText);
											// 			console.log(recDatas);
											for (var i = 0; i < recDatas.length; i++) {
												let evt = {};
												evt.title = recDatas[i].schdTl;
												evt.start = recDatas[i].schdSttDt;
												evt.end = recDatas[i].schdEndDt;
												evt.id = recDatas[i].schdNo
												//				console.log(parseInt(recDatas[i].schdCmcd.substr(3,2))-1);
												// 				console.log(bColors[parseInt(recDatas[i].schdCmcd.substr(3,2))-1]);
												evt.backgroundColor = bColors[parseInt(recDatas[i].schdCmcd.substr(3, 2)) - 1];
												evt.textColor = tColors[parseInt(recDatas[i].schdCmcd.substr(3, 2)) - 1];
												evt.borderColor = bColors[parseInt(recDatas[i].schdCmcd.substr(3, 2)) - 1];


												evtDatas.push(evt);
											}
											// 			console.log("최종확인");
											// 			console.log(evtDatas);


											//Calendar 설정 
											calendar = new FullCalendar.Calendar(calendarEl, {
												headerToolbar: {
													left: '',
													center: 'title',
													right: ''
												},
												events: evtDatas,
												navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
												nowIndicator: true, // 현재 시간 마크
												dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
												locale: 'ko', // 한국어 설정
												eventClick: function (event) {
													// 					console.log("넘어오지?");
													console.log(event.event.id);
													window.open("${pageContext.request.contextPath}/schd/calendar/update?username=${USERNAME}&schdNo=" + event.event.id, "_blank", "width=550, height=407, top=200");
												}
											});
											calendar.render();
										}
									}
									xhr.setRequestHeader(tokenHeader, tokenValue);
									xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
									xhr.send();
								});



								//일정추가 버튼 + 버튼 모달?
								function dayInput() {
									//console.log("버튼연결확인!")
									window.open("${pageContext.request.contextPath}/schd/calendar/write?username=${USERNAME}", "_blank", "width=550, height=410, top=200");
								}
							</script>



							<!-- 메인 화면에 보여줄 곳 -->
							<div class="col-sm-12">
								<div class="card">
									<!--  카드헤더 -->
									<div class="card-header pb-0">
										<h5>진행 중인 강의</h5>
									</div>
									<!-- 카드 바디 -->
									<div class="card-body">
										<table class="table table-hover" style="text-align: center;">
											<thead>
												<tr class="table-light">
													<th class="col-1">No</th>
													<th class="col-1">과목</th>
													<th class="col-3">강의명</th>
													<th class="col-1">수강정원</th>
													<th class="col-1">강의실</th>
													<th class="col-2">시작일</th>
													<th class="col-2">종료일</th>
												</tr>
											</thead>


											<tbody>
												<c:forEach var="curs" items="${cursList}" varStatus="status">
													<c:if test="${memberCode > 1}">
														<tr
															onclick="location.href='${CONTEXT_PATH}/atdManagement/list?cursNo=${curs.cursNo}'">
													</c:if>
													<c:if test="${memberCode == 1}">
														<tr
															onclick="location.href='${CONTEXT_PATH}/attendance/detail?cursNo=${curs.cursNo}'">
													</c:if>

													<fmt:formatDate value="${curs.cursEndDt}" pattern="yyyy-MM-dd"
														var="endDt" />
													<fmt:formatDate value="${curs.cursSttDt}" pattern="yyyy-MM-dd"
														var="startDt" />
													<td>${status.index+1}</td>
													<td>${curs.subNm}</td>
													<td>${curs.cursNm}</td>
													<td>${curs.cursSuNum}명</td>
													<td>${curs.faciNm}</td>
													<td>${startDt}</td>
													<td>${endDt}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>

									</div>
								</div>
								<!-- 끝 -->
							</div>
						</div>
					</div>
					<button class="btn btn-danger" id="id_withDrawalBtn">탈퇴하기</button>
					<br>
					<br>
					<br>
				</div>
				<div class="modal fade" id="resetPwModal" tabindex="-1" aria-labelledby="exampleModalLabel"
					aria-hidden="true" style="display: none;">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="d-flex flex-row-reverse" style="z-index: 9999;">
							<!-- 		<button class="btn-close modal-header position-absolute" type="button" data-bs-dismiss="modal" aria-label="Close" data-bs-original-title="" title="" style=""></button> -->
						</div>
						<div class="modal-content">
							<div class="modal-header">
								<h5>비밀번호 재설정</h5>
							</div>
							<div class="modal-body">
								<div class="tab-content" id="top-tabContent">
									<p>현재 비밀번호와 변경할 비밀번호를 입력해주세요</p>
									<form id="id_findForm2">
										<div class="">
											<label class="form-label">현재 비밀번호</label> <input class="form-control"
												type="password" placeholder="********" value="" name="currentPw"
												required>
											<br>
											<label class="form-label">새 비밀번호</label> <input class="form-control"
												type="password" placeholder="********" value="" name="newPw" required>
											<br>
											<label class="form-label">새 비밀번호 확인</label> <input class="form-control"
												type="password" placeholder="********" value="" name="newPwConfirm"
												required>

											<br>
											<sec:csrfInput />
										</div>
										<br>
										<div class="row d-flex justify-content-between px-2" id="id_smsInputDiv2"></div>
									</form>


								</div>


							</div>
							<div class="modal-footer">
								<button class="btn btn-primary" type="button" onclick="f_changePassword()"
									data-bs-original-title="" title="">확인</button>
								<button class="btn btn-info" type="button" data-bs-dismiss="modal"
									data-bs-original-title="" title="">취소</button>
							</div>
						</div>
					</div>
				</div>
				<!-- Container-fluid Ends-->
				<script src="${CONTEXT_PATH}/js/ajax.js"></script>
				<script>



					const c_withDrawalBtn = document.querySelector("#id_withDrawalBtn");
					const f_withDrawalCheck = function () {
						console.log("button!");
						let v_json = {
							url: "${CONTEXT_PATH}/mypage/resign",
							method: "get",
							async: true,
							success: function (p_data) {
								console.log("받은 데이터 : " + p_data);
								console.log("type : " + typeof (p_data));
								if (p_data == "true") {
									Swal.fire({
										icon: 'error',
										title: '탈퇴 실패',
										text: '현재 진행 중인 강의가 있어 회원탈퇴가 불가능합니다. 상담을 통해 탈퇴 진행 바랍니다.',
										footer: '<a href="${CONTEXT_PATH}/cslrg/write" class="link">상담 신청하러 가기</a>'
									});
									return;
								}

								Swal.fire({
									title: '탈퇴하기',
									text: "정말 탈퇴하시겠습니까?",
									icon: 'warning',
									showCancelButton: true,
									confirmButtonText: '확인',
									cancelButtonText: '취소',
									customClass: {
										cancelButton: 'btn btn-info',
										confirmButton: 'btn btn-primary'
									}
								}).then((result) => {
									if (result.isConfirmed) {
										f_withDraw();
									}
								});
							}

						};
						f_ajax(v_json);
					};

					const f_withDraw = function () {
						let v_json = {
							url: "${CONTEXT_PATH}/mypage/resign",
							method: "post",
							async: true,
							csrf: true,
							success: function (p_data) {
								if (!p_data) {
									Swal.fire(
										'탈퇴 실패',
										'탈퇴 과정에서 오류가 발생했습니다. 다시 시도해 주세요.',
										'error'
									);
									return;
								}

								Swal.fire(
									'탈퇴 완료',
									'회원 탈퇴되었습니다. 지금까지 아트학당을 이용해 주셔서 감사합니다.',
									'success'
								);

								setTimeout(function () {
									f_ajax({
										url: "${CONTEXT_PATH}/logout",
										method: "POST",
										async: true,
										csrf: true,
										success: function () {
											location.href = "${CONTEXT_PATH}/";
										}
									});
								}, 1000);

							}
						}
						f_ajax(v_json);
					};


					const f_changePassword = function () {

						let currentPw = document.querySelector("input[name=currentPw]").value;
						let newPw = document.querySelector("input[name=newPw]").value;
						let newPwConfirm = document.querySelector("input[name=newPwConfirm]").value;

						if (newPw != newPwConfirm) {
							Swal.fire('오류', '새 비밀번호와 비밀번호 확인이 일치하지 않습니다.', 'error');
							return;
						}

						if (newPw == currentPw) {
							Swal.fire('주의', '새 비밀번호는 현재 비밀번호와 같을 수 없습니다.', 'warning');
							return;
						}

						v_data = {
							currentPw: currentPw,
							newPw: newPw
						};

						console.log(v_data);

						v_json = {
							url: "${CONTEXT_PATH}/mypage/resetPassword",
							method: "post",
							async: true,
							data: JSON.stringify(v_data),
							contentType: "application/json;charset=utf-8",
							csrf: true,
							success: function (p_data) {
								console.log(p_data);

								if (p_data == 0) {
									Swal.fire(
										'비밀번호 변경 실패',
										'기존 비밀번호가 일치하지 않습니다.',
										'error'
									);
									return;
								}

								if (p_data == 1) {
									Swal.fire(
										'비밀번호 변경 실패',
										'오류가 발생했습니다. 비밀번호가 변경되지 않았습니다.',
										'error'
									);
									return;
								}

								Swal.fire(
									'비밀번호 변경 성공',
									'변경에 성공했습니다.',
									'success'
								);

								$('#resetPwModal').modal('hide');

							}
						};

						f_ajax(v_json);
					};

					c_withDrawalBtn.addEventListener("click", f_withDrawalCheck);
				</script>