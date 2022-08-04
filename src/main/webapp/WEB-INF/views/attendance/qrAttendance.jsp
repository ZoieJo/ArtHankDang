<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

		<!-- Page Body Start-->
		<!-- 페이지 타이틀 시작 -->
		<div class="container-fluid">
			<div class="page-header">
				<div class="row">
					<div class="col-sm-12">
						<h3>출석 입력</h3>
						<!-- 제목 하단 페이지 경로 -->
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">Home</a></li>
							<li class="breadcrumb-item">강의 관리</li>
							<li class="breadcrumb-item active">출석 입력</li>
						</ol>
					</div>
				</div>
			</div>
		</div>
		<!-- 페이지 타이틀 끝 -->
		<!-- 내용 시작 -->
		<div class="container-fluid">
			<div class="row starter-main">
				<div class="col-sm-12">
					<div class="card">
						<div class="card-header pb-0">
							<h5>수업 제목</h5>

						</div>

						<div class="card-body">


							<div id="frame">
								<div id="loadingMessage" class="alert alert-info text-center">
									<h5 class="mb-0">
										<i class="fa-solid fa-video-slash"></i>비디오 스트림에 액세스 할 수 없습니다.<br>웹캠을
										활성화해 주세요.
									</h5>
								</div>
								<div class="cameraView align-center text-center">
									<canvas id="canvas" style=""></canvas>
								</div>
							</div>

							<sec:csrfInput />
							<div class="row">
								<div class="col-sm-6">
									<h4 class="inline">현재 시각 : </h4><h4 id="clock" class="text-warn"> </h4>
								</div>
								<div class="col-sm-6 d-flex flex-column-reverse">
									<button type="button" class="btn btn-primary btn-lg text-center"
										onclick="openCamera();">카메라 켜기</button>
								</div>
							</div>
							<br>
							<div id="test" width="100%">

								<h6>QR 코드 스캔 결과</h6>
								<div id="output">
									<div id="outputMessage"></div>
									<div id="outputLayer" hidden>
										<div id="outputData">
											<h5 id="checkInStuName"></h5><h5>학생 출석 완료</h5>
											<div class="row">
												<div class="col-12 col-lg-4 text-center img-box">
												  <img class="img-fluid rounded-circle" alt=""
													src="https://avatars.dicebear.com/api/micah/.svg">
												</div>
								  
												<div class="col-12 col-lg-8 my-1 p-2">
												  <h6>학번 : </h6>
												  <h6>이름 : </h6>
												</div>
								  
											  </div>

										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
				<!-- 카드 1 끝 -->
			</div>
		</div>
		<!-- Container-fluid Ends-->

		<script src="/arthakdang/js/ajax.js"></script>
		<script src="/arthakdang/js/jsQR.js"></script>
		<script type="text/javascript">
		
			var studentData = document.getElementById("outputData");
			var clock = document.querySelector("#clock");

			function getTime() {
				var date = new Date();
				var timeArr = [padZero(date.getHours()), padZero(date.getMinutes()), padZero(date.getSeconds())];
				clock.innerText = timeArr.join(' : ');
			}

			function padZero(p_num) {
				return p_num.toString().length < 2 ? ('0' + p_num) : p_num;
			}

			// 쿼리스트링에서 데이터를 추출하는 함수
			function makeData(p_str) {
				// 추출할 키워드
				// 인식한 데이터 형식 : "time=0982439023&code=258490&userid=student"
				var keywords = ["time", "code", "userid"];
				// 리턴할 데이터를 저장할 빈 객체
				var result = {}

				// 추출할 키워드를 배열에서 하나씩 불러와 파싱 
				for (var i = 0; i < keywords.length; i++) {
					// 추출할 키워드
					var keyword = keywords[i];
					// 파싱을 시작할 인덱스, 쿼리스트링에서 키워드가 시작하는 곳을 indexOf로 찾아냄
					var startIdx = p_str.indexOf(keyword);
					// 끝 인덱스, & 전까지 추출할 것이므로 startIdx 뒤의 '&' 위치를 indexOf로 찾아냄
					var endIdx = p_str.indexOf('&', startIdx);
					
					// "time=0982439023&code=258490&userid=student"에서 time을 찾는 경우,
					//  t(시작) . . . . &(끝)
					

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
						facingMode: "environment",
						width: "1280px"
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
							//outputData.innerHTML = code.data;
							var token = document.querySelector("input[name=_csrf]").value;
							var v_data = makeData(code.data);
							v_data['cursNo'] = '${cursNo}'
							console.log(v_data);
							var v_json = {
								url: "${CONTEXT_PATH}/attend/checkin",
								method: "post",
								data: JSON.stringify(v_data),
								contentType: "application/json; charset=utf-8",
								async: true,
								dataType: "json",
								csrf: token,
								success: function (p_data) {
									console.log("ckk : " + p_data);
									alert(p_data.msg);
									studentData.innerHTML = p_data.studentVO.stuId;
									setTimeout(openCamera, 1000);
									return;
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

			getTime();
			setInterval(getTime, 1000);
		</script>