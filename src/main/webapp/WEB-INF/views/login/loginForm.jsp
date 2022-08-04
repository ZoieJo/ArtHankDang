<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


	<link href="${RESOURCES_PATH}/css/root-style.css" rel="stylesheet" type="text/css">
		<section>
			<div class="container-fluid p-0">
				<div class="row">
					<div class="col-12">
						<div class="login-card">


							<div class="">
								<ul class="nav nav-tabs bg-white nav-success justify-content rounded-top" id="icon-tab"
									role="tablist">
									<li class="nav-item col"><a class="nav-link active" id="icon-home-tab"
											data-bs-toggle="tab" href="#icon-home" role="tab" aria-controls="icon-home"
											aria-selected="true"><i class="icofont icofont-ui-home"></i>ID/PW</a></li>
									<li class="nav-item col"><a class="nav-link" id="profile-icon-tab"
											data-bs-toggle="tab" href="#profile-icon" role="tab"
											aria-controls="profile-icon" aria-selected="false"><i
												class="icofont icofont-man-in-glasses"></i>QR학생증</a></li>
									<li class="nav-item col"><a class="nav-link" id="contact-icon-tab"
											data-bs-toggle="tab" href="#contact-icon" role="tab"
											aria-controls="contact-icon" aria-selected="false"><i
												class="icofont icofont-contacts"></i>OTP인증</a></li>
								</ul>
								<div class="tab-content" id="icon-tabContent">
									<div class="tab-pane fade show active" id="icon-home" role="tabpanel"
										aria-labelledby="icon-home-tab">
										<form class="theme-form login-form rounded-bottom"
											action="${CONTEXT_PATH}/login" method="post">
											<h4>Login</h4>
											<h6>아트학당 서비스를 이용하려면 로그인이 필요합니다.</h6>
											<div class="msgblock">
												<!-- 로그인 알림메시지 블록 -->
											</div>
											<div class="form-group">
												<label>아이디</label>
												<div class="input-group">
													<span class="input-group-text"><i class="icon-user"></i></span>
													<input class="form-control" type="text" required="required"
														placeholder="학번 입력" name="username">
												</div>
											</div>
											<div class="form-group">
												<label>비밀번호</label>
												<div class="input-group">
													<span class="input-group-text"><i class="icon-lock"></i></span>
													<input class="form-control" type="password" name="password"
														required="required" placeholder="*********">
												</div>
											</div>
											<div class="form-group">
												<div class="d-flex justify-content-between">
													<div class="animate-chk">
														<label for="remember-me" class="d-block"> <input
																id="remember-me" name="remember-me" type="checkbox"
																class="checkbox_animated">Remember me
														</label>
													</div>
													<div class="">
														<a class="link" id="id_findLink" data-bs-toggle="modal"
															data-original-title="test" data-bs-target="#exampleModal"
															data-bs-original-title="" title="">아이디/비밀번호 찾기</a>
													</div>
												</div>
											</div>
											<div class="form-group">
												<button class="btn btn-primary btn-block" type="submit">로그인</button>
											</div>

											<input type="hidden" id="_csrf" name="${_csrf.parameterName}"
												value="${_csrf.token}" />
										</form>

									</div>
									<div class="tab-pane fade" id="profile-icon" role="tabpanel"
										aria-labelledby="profile-icon-tab">
										<form class="theme-form login-form rounded-bottom"
											action="${CONTEXT_PATH}/login" method="post">
											<h4>QR Login</h4>
											<h6>모바일 QR학생증을 웹캠으로 스캔해 로그인 할 수 있습니다.</h6>
											<div class="msgblock">
												<!-- 로그인 알림메시지 블록 -->
											</div>
											<div class="form-group">
												<div id="frame">
													<div id="loadingMessage" class="alert alert-info text-center">
														<h5 class="mb-0">
															<i class="fa-solid fa-video-slash"></i>비디오 스트림에 액세스 할 수
															없습니다.<br>웹캠을 활성화해 주세요.
														</h5>
													</div>
													<canvas id="canvas"></canvas>
												</div>

												<sec:csrfInput />
												<br />
												<button type="button" class="btn btn-primary btn-lg"
													onclick="openCamera();">카메라 켜기</button>
												<div></div>
												<div id="test" width="100%">
													<h6>QR 코드 스캔 결과</h6>
													<div id="output">
														<div id="outputMessage"></div>
														<div id="outputLayer" hidden>
															<span id="outputData"></span>
														</div>
													</div>
												</div>

											</div>
										</form>
										<script src="/arthakdang/js/jsQR.js"></script>
										<script type="text/javascript">
											// 쿼리스트링에서 데이터를 추출하는 함수
											function makeData(p_str) {
												var keywords = ["time", "code", "userid"];
												var result = {};
												for (var i = 0; i < keywords.length; i++) {
													var keyword = keywords[i];
													var startIdx = p_str.indexOf(keyword);
													var endIdx = p_str.indexOf('&', startIdx);

													var value = p_str.slice((startIdx + keyword.length + 1), endIdx);
													if (i == keywords.length - 1) {
														value = p_str.slice((startIdx + keyword.length + 1));
													}
													//console.log('key = ' + keyword + ', value = ' + value);
													result[keyword] = value;
												}
												//console.log(result);
												return result;
											}

											// 스캔
											function startScan() {
												var video = document.createElement("video");
												var canvasElement = document.getElementById("canvas");
												var canvas = canvasElement.getContext("2d");
												var loadingMessage = document.getElementById("loadingMessage");
												var outputContainer = document.getElementById("output");
												var outputMessage = document.getElementById("outputMessage");
												var outputData = document.getElementById("outputData");

												function drawLine(begin, end, color) {
													canvas.beginPath();
													canvas.moveTo(begin.x, begin.y);
													canvas.lineTo(end.x, end.y);
													canvas.lineWidth = 4;
													canvas.strokeStyle = color;
													canvas.stroke();
												}

												// 카메라 사용시
												navigator.mediaDevices.getUserMedia({
													video: {
														facingMode: "environment"
													}
												}).then(function (stream) {
													video.srcObject = stream;
													video.setAttribute("playsinline", true); // iOS 사용시 전체 화면을 사용하지 않음을 전달
													video.play();
													requestAnimationFrame(tick);
												});

												function tick() {
													loadingMessage.innerHTML = "<h5><i class='fa-solid fa-hourglass'></i> 카메라를 켜는 중입니다...</h5>"

													if (video.readyState === video.HAVE_ENOUGH_DATA) {
														loadingMessage.hidden = true;
														canvasElement.hidden = false;
														outputContainer.hidden = false;

														// 읽어들이는 비디오 화면의 크기
														canvasElement.height = video.videoHeight;
														canvasElement.width = video.videoWidth;
														canvas.drawImage(video, 0, 0, canvasElement.width,
															canvasElement.height);

														var imageData = canvas.getImageData(0, 0, canvasElement.width,
															canvasElement.height);
														var code = jsQR(imageData.data, imageData.width,
															imageData.height, {
															inversionAttempts: "dontInvert",
														});

														// QR코드 인식에 성공한 경우
														if (code) {
															// 인식한 QR코드의 영역을 감싸는 사용자에게 보여지는 테두리 생성
															drawLine(code.location.topLeftCorner,
																code.location.topRightCorner, "#FF0000");
															drawLine(code.location.topRightCorner,
																code.location.bottomRightCorner, "#FF0000");
															drawLine(code.location.bottomRightCorner,
																code.location.bottomLeftCorner, "#FF0000");
															drawLine(code.location.bottomLeftCorner,
																code.location.topLeftCorner, "#FF0000");

															outputMessage.hidden = true;
															outputData.parentElement.hidden = false;

															// QR코드 메시지 출력
															outputData.innerHTML = code.data;
															var token = document.querySelector("input[name=_csrf]").value;
															var v_data = makeData(code.data);
															console.log(v_data);
															var v_json = {
																url: "${CONTEXT_PATH}/qrLogin",
																method: "post",
																data: JSON.stringify(v_data),
																contentType: "application/json; charset=utf-8",
																async: true,
																csrf: token,
																success: function (p_data) {
																	if (!p_data) {
																		location.href = "/arthakdang/"
																		return;
																	}
																	alert(p_data);
																	setTimeout(openCamera, 1000);

																}

															}
															f_ajax(v_json);

															// setTimeout(openCamera, 1000);
															// return을 써서 함수를 빠져나가면 QR코드 프로그램이 종료된다.
															// 카메라를 멈추고 1초 뒤 스캔이 다시 실행되도록 setTimeout 설정함
															return;
														}
														// QR코드 인식에 실패한 경우
														else {
															outputMessage.hidden = false;
															outputData.parentElement.hidden = true;
														}
													}
													requestAnimationFrame(tick);
												}
											}

											// 카메라 열기
											function openCamera() {
												console.log('function called');
												startScan();
											}
										</script>
									</div>
									<div class="tab-pane fade" id="contact-icon" role="tabpanel"
										aria-labelledby="contact-icon-tab">
										<form class="theme-form login-form rounded-bottom"
											action="${CONTEXT_PATH}/login" method="post">
											<h4>OTP Login</h4>
											<h6>일회용 비밀번호(OTP)로 로그인 하려면 사전에 마이페이지에서 등록이 필요합니다.</h6>
											<div class="msgblock">
												<!-- 로그인 알림메시지 블록 -->
											</div>
											<div class="form-group">
												<label>OTP 입력</label>
												<div class="input-group">
													<span class="input-group-text"><i class="icon-user"></i></span>
													<input class="form-control" type="text" required="required"
														placeholder="6자리 숫자" name="userInput">
												</div>
											</div>
											<div class="form-group">
												<button class="btn btn-primary btn-block" type="submit">로그인</button>
											</div>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
									</div>
								</div>
							</div>


						</div>
					</div>
				</div>
			</div>
		</section>

		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="d-flex flex-row-reverse" style="z-index: 9999;">
					<!-- 		<button class="btn-close modal-header position-absolute" type="button" data-bs-dismiss="modal" aria-label="Close" data-bs-original-title="" title="" style=""></button> -->
				</div>
				<div class="modal-content">
					<div class="">
						<ul class="nav nav-tabs border-tab mb-2" id="top-tab" role="tablist">
							<li class="nav-item"><a class="nav-link active" id="top-home-tab" data-bs-toggle="tab"
									href="#top-home" role="tab" aria-controls="top-home" aria-selected="true"><i
										class="icofont icofont-ui-home"></i>아이디 찾기</a></li>
							<li class="nav-item"><a class="nav-link" id="profile-top-tab" data-bs-toggle="tab"
									href="#top-profile" role="tab" aria-controls="top-profile" aria-selected="false"><i
										class="icofont icofont-man-in-glasses"></i>비밀번호 찾기</a></li>
						</ul>
					</div>
					<div class="modal-body">
						<div class="tab-content" id="top-tabContent">
							<div class="tab-pane fade show active" id="top-home" role="tabpanel"
								aria-labelledby="top-home-tab">
								<p>회원가입 시 사용한 전화번호를 입력해 주세요.</p>
								<form id="id_findForm1">
									<div class="row d-flex justify-content-between px-2">
										<select class="form-select form-control-sm w-25" name="memCmcd"
											id="id_memCmcdSelect">
											<option value="01" selected>학생</option>
											<option value="02">교직원</option>
										</select> <input class="form-control form-control-sm w-50" type="text"
											name="memPh" id="id_phoneNumber" placeholder="01000000000" required
											value="">
										<button class="btn btn-secondary w-25" type="button"
											id="id_findIdBtn">찾기</button>
									</div>
									<br>
									<div class="row d-flex justify-content-between px-2" id="id_smsInputDiv1"></div>
								</form>
							</div>
							<div class="tab-pane fade" id="top-profile" role="tabpanel"
								aria-labelledby="profile-top-tab">
								<p>회원 아이디와 전화번호를 입력해 주세요.</p>
								<form id="id_findForm2">
									<div class="row d-flex justify-content-between px-2">
										<select class="form-select form-control-sm w-25 align-center" name="memCmcd"
											id="id_memCmcdSelect">
											<option value="01" selected>학생</option>
											<option value="02">교직원</option>
										</select>
										<div class="col">
											<input class="form-control form-control-sm w-100" type="text" name="memId"
												id="id_memId" placeholder="학번, 아이디" required value=""> <input
												class="form-control form-control-sm w-100" type="text" name="memPh"
												id="id_phoneNumber" placeholder="01000000000" required value="">
										</div>
										<button class="btn btn-secondary w-25 align-center" type="button"
											id="id_findPwBtn">찾기</button>
										<sec:csrfInput />
									</div>
									<br>
									<div class="row d-flex justify-content-between px-2" id="id_smsInputDiv2"></div>
								</form>
							</div>

						</div>


					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" type="button" data-bs-dismiss="modal" data-bs-original-title=""
							title="">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<script src="/arthakdang/js/jsQR.js"></script>
		<script src="/arthakdang/js/ajax.js"></script>
		<script>
			const c_findIdBtn = document.querySelector("#id_findIdBtn");
			const c_findPwBtn = document.querySelector("#id_findPwBtn");
			const c_findIdForm = document.querySelector("#id_findForm1");
			const c_findPwForm = document.querySelector("#id_findForm2");
			const c_findLink = document.querySelector("#id_findLink");
			let secondFlag = false;

			// 로그인 알림메시지 스크립트
			let errorMsg = function () {

				let msg = document.querySelector(".msgblock")
				console.log(msg);

				msg.innerHTML = "<i data-feather='alert-triangle'></i> ${msg}";
				msg.style.color = "#FFFFFF";
				msg.setAttribute("class", "alert alert-danger");
			};

			if ('${msg}') {
				errorMsg();
			}

			const f_viewSeconds = function () {
				let secondBlock = document
					.querySelector(".tab-pane.show.active h5#id_seconds");
				let sec = parseInt(secondBlock.innerHTML);
				if (sec <= 0) {
					secondFlag = false;
					c_findIdBtn.disabled = "";
					c_findIdBtn.innerText = "재전송";
					c_findPwBtn.disabled = "";
					c_findPwBtn.innerText = "재전송";
					return;
				}
				if (secondFlag) {

					secondBlock.innerHTML = sec - 1;

					console.log("function called" + sec);
					setTimeout(f_viewSeconds, 1000);
				}

			}

			const f_resetPw = function (memId, memPh, memCmcd) {
				console.log("resetPw called");
				let v_json = {
					url: "${CONTEXT_PATH}/find/pw/update",
					method: "POST",
					async: true,
					csrf: true,
					contentType: "application/json; charset=utf-8",
					data: JSON.stringify({
						memId: memId,
						memPh: memPh,
						memCmcd: memCmcd
					}),
					success: function (p_data) {
						if (p_data == false) {
							c_findPwForm.innerHTML = "비밀번호 초기화에 실패했습니다. 다시 시도해 주세요.";
						}
						c_findPwForm.innerHTML = "임시 비밀번호를 문자로 보내드렸습니다. 로그인 후 비밀번호를 재설정 해주세요.";
					}
				};
				f_ajax(v_json);
			}

			const f_verifySMS = function (p_num) {
				let form = document.querySelector("#id_findForm" + p_num);
				let memCmcd = form.querySelector("#id_memCmcdSelect")
				let memId = form.querySelector("#id_memId");
				let memPh = form.querySelector("#id_phoneNumber");
				let input = form.querySelector("#id_smsInput");
				let v_url = "/arthakdang/find/verify?memCmcd=" + memCmcd.value
					+ "&memPh=" + memPh.value + "&inputNum=" + input.value;
				console.log(form);
				let v_json = {
					url: v_url,
					method: "GET",
					async: true,
					success: function (p_data) {

						if (!p_data) {
							Swal.fire("","인증번호가 일치하지 않습니다.","warning");
							return;
						}

						secondFlag = false;
						// alert(p_data);
						if (p_num == 1) {
							c_findIdForm.innerHTML = ("<h5>회원님의 아이디는 " + p_data + " 입니다.</h5>");
							//	+ "<br><a class='link'>로그인 하러가기</a>";
						}
						if (p_num == 2) {
							f_resetPw(memId.value, memPh.value, memCmcd.value);

						}
					}
				}
				f_ajax(v_json);
				console.log(v_url);
			}

			const f_appendSmsForm = function (p_num) {
				let smsDiv = document.querySelector("#id_smsInputDiv" + p_num);
				smsDiv.innerHTML = "";
				const txt = "<div class='text-danger text-center align-self-center col'>"
					+ "<h5 class='m-0 d-inline' id='id_seconds'>60</h5>초</div>"
					+ "<input type='text' id='id_smsInput' class='form-control form-control-sm w-50'>"
					+ "<button class='btn btn-light w-25' type='button' onclick='f_verifySMS("
					+ p_num + ")'>인증</button>";
				smsDiv.innerHTML = txt;
				if (!secondFlag) {
					secondFlag = true;
					f_viewSeconds();
				}
				c_findIdBtn.disabled = "true";
				c_findPwBtn.disabled = "true";

			}

			const f_findId = function () {
				let form = document.querySelector("#id_findForm1");
				let memCmcd = form.querySelector("#id_memCmcdSelect")
				let memPh = form.querySelector("#id_phoneNumber");

				let v_url = "/arthakdang/find/id?memCmcd=" + memCmcd.value + "&memPh="
					+ memPh.value;

				let v_json = {
					url: v_url,
					method: "GET",
					async: true,
					success: function (p_data) {
						if (p_data == 'true') {
							f_appendSmsForm(1);
							return;
						}
						Swal.fire("",p_data, "warning");
					}
				}

				f_ajax(v_json);

			}

			const f_findPw = function () {
				let form = document.querySelector("#id_findForm2");
				let memCmcd = form.querySelector("#id_memCmcdSelect");
				let memId = form.querySelector("#id_memId");
				let memPh = form.querySelector("#id_phoneNumber");

				let v_url = "/arthakdang/find/pw?memId=" + memId.value + "&memCmcd="
					+ memCmcd.value + "&memPh=" + memPh.value;

				let v_json = {
					url: v_url,
					method: "GET",
					async: true,
					success: function (p_data) {
						if (p_data == 'true') {
							f_appendSmsForm(2);
							return;
						}
						Swal.fire("",p_data, "warning");
					}
				}

				f_ajax(v_json);

			}

			const f_modalReset = function () {

				const pwFormTxt = "<div class='row d-flex justify-content-between px-2'>"
					+ "<select class='form-select form-control-sm w-25 align-center' name='memCmcd'id='id_memCmcdSelect'>"
					+ "<option value='01' selected>학생</option><option value='02'>교직원</option>"
					+ "</select><div class='col'><input class='form-control form-control-sm w-100' type='text'"
					+ "name='memId' id='id_memId' placeholder='학번, 아이디' required value=''>"
					+ "<input class='form-control form-control-sm w-100' type='text'"
					+ "name='memPh' id='id_phoneNumber' placeholder='01000000000' required value=''>"
					+ "</div> <button class='btn btn-secondary w-25 align-center' type='button'"
					+ "id='id_findPwBtn' onclick='f_findPw()'>찾기</button></div><br>"
					+ "<div class='row d-flex justify-content-between px-2'id='id_smsInputDiv2'></div>";

				const idFormTxt = "<div class='row d-flex justify-content-between px-2'>"
					+ "<select class='form-select form-control-sm w-25' name='memCmcd' id='id_memCmcdSelect'>"
					+ "<option value='01' selected>학생</option><option value='02'>교직원</option>"
					+ "</select> <input class='form-control form-control-sm w-50' type='text'"
					+ "name='memPh' id='id_phoneNumber' placeholder='01000000000' required value=''>"
					+ "<button class='btn btn-secondary w-25' type='button' id='id_findIdBtn' onclick='f_findId()'>찾기</button>"
					+ "</div><br><div class='row d-flex justify-content-between px-2'id='id_smsInputDiv1'></div>";

				if (true) {
					c_findPwForm.innerHTML = pwFormTxt;
					c_findIdForm.innerHTML = idFormTxt;
				}

			}
			// c_findIdBtn.addEventListener("click", f_findId);
			// c_findPwBtn.addEventListener("click", f_findPw);
			c_findLink.addEventListener("click", f_modalReset);
		</script>