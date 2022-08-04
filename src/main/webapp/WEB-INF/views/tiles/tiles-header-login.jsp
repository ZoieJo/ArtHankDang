<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<script>
				let wsocket;
				// 문서 로드시 시작 -> 웹소켓 연결
				$(document).ready(function () {
					connectWS();

					wsocket.onopen = function () {
						console.log("웹소켓 연결 성공");
					}

					wsocket.onmessage = function (evt) {
						let data = evt.data;
						// console.log("서버에서 데이터 받음" + data);

						const Toast = Swal.mixin({
							toast: true,
							position: 'bottom-end',
							color: '#28004d',
							showConfirmButton: false,
							timer: 4000,
							timerProgressBar: true,
							didOpen: (toast) => {
								toast.addEventListener('mouseenter', Swal.stopTimer)
								toast.addEventListener('mouseleave', Swal.resumeTimer)
							}
						});

						Toast.fire({
							icon: 'info',
							text: data
						});
						wsocket.onclose = function () {
							console.log("웹소켓 연결 해제");
						}
					}

				});
				// 웹소켓 연결 메소드
				function connectWS() {
					console.log("연결 시도!!!");
					wsocket = new WebSocket('ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/echo');
				}

				// 메시지 전송 메소드
				function sendMessage(p_msg) {
					wsocket.send(p_msg);
				}

			</script>

			<!-- Page Header Start-->
			<div class="page-main-header">
				<div class="area">
					<ul class="circles">
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
					</ul>
				</div>
				<div class="main-header-right row m-0">

					<!-- 아트학당 로고 넣을 곳(헤더 맨 왼쪽 빈 공간) -->
					<div class="main-header-left" style="font-family: 국립박물관문화재단클래식B; font-size: 24px; padding: 25px;">
						<div class="logo-wrapper" style="margin: 0; padding: 0;">
							<a href="${CONTEXT_PATH}/" style="color: rgb(111,79,40)"><img class="img-fluid"
									src="${RESOURCES_PATH}/logo/favicon-32x32.png" alt="">&nbsp;아트학당</a>
						</div>

						<div class="dark-logo-wrapper">
							<a href="${CONTEXT_PATH}/"><img class="img-fluid"
									src="${RESOURCES_PATH}/logo/favicon-32x32.png" alt="">&nbsp;아트학당</a>
						</div>

						<div class="toggle-sidebar">
							<i class="status_toggle middle" data-feather="align-center" id="sidebar-toggle"></i>
						</div>

					</div>

					<!-- 헤더 맨 오른쪽 로고 모여 있는 곳 -->
					<div class="nav-right col pull-right right-menu p-0" id="headerDisp">


						<ul class="nav-menus">
							<sec:authorize access="isAuthenticated()">
								<li id="id_navMemName">
									<!-- 로그인 후 회원 이름 넣기 -->

									<p style="margin-bottom: 0; cursor:pointer; font-weight: bold;" title="마이페이지로 바로가기">
										${USER.memberDetail.getMemName()} 님
										<sec:authorize access="hasRole('STUDENT')">(학생)</sec:authorize>
										<sec:authorize access="hasRole('TEACHER')">(교원)</sec:authorize>
										<sec:authorize access="hasRole('EMPLOYEE')">(직원)</sec:authorize>
									</p>


								</li>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">

								<!-- 학생헤더 -->
								<%-- <sec:authorize access="hasRole('STUDENT')"> --%>
									<!-- 벨모양 로고 : 실시간 알림 -->
									<!-- 					<li class="onhover-dropdown" class="btn btn-primary position-relative"> -->
									<!-- 						<div class="notification-box"> -->
									<!-- 							<i data-feather="bell"></i><span class="dot-animated"></span> -->
									<!-- 						</div> -->

									<!-- 알림 받은 것들 -->
									<!-- 						<ul class="notification-dropdown onhover-show-div"> -->
									<!-- 							<li><p class="f-w-700 mb-0">총 알림 수<span class="pull-right badge badge-warning badge-pill text-dark">4</span></p></li> -->
									<!-- 게시글 알림 알림 -->
									<!-- 							<li class="noti-primary"> -->
									<!-- 								<div class="media"> -->
									<!-- 									<span class="notification-bg bg-light-primary"><i data-feather="message-circle"></i></span> -->
									<!-- 									<div class="media-body"> -->
									<!-- 										<p>내 게시글 댓글<span class="pull-right badge badge-primary badge-pill text-dark">3</span></p> -->
									<!-- 										<span>10 minutes ago</span> -->
									<!-- 									</div> -->
									<!-- 								</div> -->
									<!-- 							</li> -->
									<!-- 공지사항 알림 -->
									<!-- 							<li class="noti-secondary"> -->
									<!-- 								<div class="media"> -->
									<!-- 									<span class="notification-bg bg-light-secondary"><i data-feather="check-circle"></i></span> -->
									<!-- 									<div class="media-body"> -->
									<!-- 										<p>실시간 알림<span class="pull-right badge badge-primary badge-pill text-dark">1</span></p> -->
									<!-- 										<span>실시간 알림 테스트</span> -->
									<!-- 									</div> -->
									<!-- 								</div> -->
									<!-- 							</li> -->
									<!-- 						</ul> -->
									<!-- 					</li> -->
									<%-- </sec:authorize> --%>

										<!-- 교직원 헤더 -->
										<sec:authorize access="!hasRole('STUDENT')">
											<!-- 전제 실시간 알림 보내기 -->
											<li>
												<div class="notification-box">
													<span class="text-dark" id="modalOn" style="cursor:pointer;"
														title="전체알람보내기"><i data-feather="send"></i></span>
												</div>
											</li>
											<!-- MMS 메시지 보내기 -->
											<li>
												<div class="notification-box">
													<sec:authorize access="hasRole('EMPLOYEE')">
														<a href="${CONTEXT_PATH}/msg/employee/page">
															<span class="text-dark" style="cursor:pointer;"
																title="메시지보내기"><i data-feather="mail"></i></span>
														</a>
													</sec:authorize>
													<sec:authorize access="hasRole('TEACHER')">
														<a href="${CONTEXT_PATH}/msg/teacher/page">
															<span class="text-dark" style="cursor:pointer;"
																title="메시지보내기"><i data-feather="mail"></i></span>
														</a>
													</sec:authorize>
												</div>
											</li>
											<!-- 메시지(쪽지) 로고 -->
											<c:set var="cl" value="${ckList}" />
											<li class="onhover-dropdown">
												<div class="notification-box">
													<a href="${CONTEXT_PATH}/note/write" id="nteAlm">
														<i data-feather="message-square"></i>
														<c:if test="${!empty cl}">
															<p class="badge badge-light text-dark" style="margin: 0px;">
																${listSize }</p>
														</c:if>
													</a>
												</div>
												<ul class="chat-dropdown onhover-show-div">
													<c:if test="${!empty cl}">
														<c:forEach var="item" items="${ckList}" begin="0" step="1"
															end="3">
															<li onclick="noteFun('${item.nteNo}')">
																<div class="media-body">
																	<span
																		style="font-weight: bold;">${item.empNm}</span>
																	<p class="f-12 light-font"
																		style="text-align:left; white-space:nowrap; text-overflow:ellipsis; overflow:hidden; margin:0;">
																		${item.nteTl}</p>
																</div>
															</li>
														</c:forEach>
													</c:if>
													<c:if test="${empty cl}">
														<li>
															<div class="media-body">
																<span style="font-family:ngB;font-weight: bold;"><i class="icon-alert"></i>&nbsp;받은쪽지함</span>
																<p class="f-12 light-font" style="font-family:ng;text-align:left; white-space:nowrap; text-overflow:ellipsis; overflow:hidden; margin:0;">
																	쪽지를 모두 읽었거나 존재하지 않습니다.</p>
															</div>
														</li>
													</c:if>
													<li class="text-center" id="seeAll"><a class="f-w-700">받은 쪽지 모두 보기</a></li>
												</ul>
											</li>
										</sec:authorize>
										<!-- 로그아웃 버튼 -->
										<li class="onhover-dropdown p-0">
											<button class="btn btn-primary-light" type="button" onclick="logout()">
												<i data-feather="log-out"></i>Log out
											</button>
										</li>
										<form id="id_logoutForm" action="${CONTEXT_PATH}/logout" method="post">
											<sec:csrfInput />
										</form>

										<!--전체알림모달-->
										<div class="modal fade show" id="exampleModalfat" tabindex="-1"
											aria-labelledby="exampleModalLabel"
											style="display: none; padding-right: 17px; font-family: ngB;"
											aria-hidden="true" aria-modal="true" role="dialog">
											<div class="modal-dialog" role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="exampleModalLabel2">실시간 전체 알림</h5>
														<button class="btn-close" type="button" data-bs-dismiss="modal"
															aria-label="Close" id="closeModal"></button>
													</div>
													<div class="modal-body">
														<div class="mb-3">
															<label class="col-form-label"
																for="message-text">공지내용</label>
															<textarea class="form-control" id="message-text" cols="5"
																style="height: 42px;" required></textarea>
														</div>
													</div>
													<div class="modal-footer">
														<button class="btn btn-primary" type="button"
															id="sendBtn">전송</button>
														<button class="btn btn-info" type="button"
															data-bs-dismiss="modal" id="modalClose">닫기</button>
													</div>
												</div>
											</div>
										</div>
										<!-- 로그인 이후 스크립트 -->
										<script>
											/* 받은 쪽지함으로 바로가기 */
											const c_seeAll = document.querySelector("#seeAll");
											if (c_seeAll) {
												c_seeAll.onclick = function () {
													location.href = '${CONTEXT_PATH}/note/rvNte';
												}
											}
											
// 											function noteFun(parm) {
// 												Swal.fire({
// 													icon: 'success',
// 													title: '알림',
// 													text: parm
// 												});
// 											}

											$('#sendBtn').click(function () {
												let msgCnt = document.querySelector('#message-text').value;
												console.log('#######################################', $('#message-text').val());
												console.log(msgCnt);
												sendMessage(msgCnt);
											});

											$('#modalOn').on('click', function () {
												$('#exampleModalfat').show();
											});
											$('#modalClose').on('click', function () {
												$('#exampleModalfat').hide();
											});
											$('#closeModal').on('click', function () {
												$('#exampleModalfat').hide();
											});


										</script>
							</sec:authorize>


							<sec:authorize access="isAnonymous()">
								<!-- 로그인 버튼 -->
								<li class="onhover-dropdown p-0" onclick="gologin()">
									<button class="btn btn-light" type="button" style="">
										<i data-feather="log-in"></i>Log in
									</button>
								</li>
							</sec:authorize>
						</ul>
					</div>

					<div class="d-lg-none mobile-toggle pull-right w-auto" style="cursor:pointer;">
						<i data-feather="more-horizontal"></i>
					</div>

				</div>
			</div>
			<!-- Page Header Ends ============================================================================= -->
			<script>
				// 로그인 버튼
				function gologin() {
					location.href = '${CONTEXT_PATH}/login';
				}
				
				
				const c_memName = document.querySelector("#id_navMemName");
				if(c_memName){
					c_memName.onclick = function () {
						location.href = '${CONTEXT_PATH}/mypage/main';
					}
				}

				const c_form = document.querySelector("#id_logoutForm");
				const logout = function () {
					event.preventDefault();
					Swal.fire({
						title: '로그아웃 확인',
						text: '정말 로그아웃 하시겠습니까?',
						icon: 'info',
						showCancelButton: true,
						confirmButtonText: '확인',
						cancelButtonText: '취소',
						reverseButtons: false // 버튼 순서 거꾸로
					}).then(result => {
						if (result.isConfirmed) {
							const Toast = Swal.mixin({
								toast: true,
								position: 'center-center',
								showConfirmButton: false,
								timer: 1500,
								timerProgressBar: true,
								didOpen: (toast) => {
									toast.addEventListener('mouseenter', Swal.stopTimer),
										toast.addEventListener('mouseleave', Swal.resumeTimer)
								}
							})

							Toast.fire({
								icon: 'success',
								title: '로그아웃 되었습니다.'
							}).then((result) => {
								if (result.dismiss === Toast.DismissReason.timer) {

									c_form.submit();
								}
							});


						}
					});
				}
			</script>