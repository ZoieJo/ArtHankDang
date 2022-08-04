<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

			<div class="container-fluid">
				<div class="edit-profile">
					<div class="row">
					
						<div class="col-xl-12">
							<form class="card" id="id_memberInfoForm">
								<div class="card-header pb-0">
									<h4 class="card-title mb-0">회원 정보</h4>
									<div class="card-options">
										<a class="card-options-collapse" href="#" data-bs-toggle="card-collapse"><i
												class="fe fe-chevron-up"></i></a><a class="card-options-remove" href="#"
											data-bs-toggle="card-remove"><i class="fe fe-x"></i></a>
									</div>
								</div>
								<div class="card-body">
									<div class="row">

										<div class="col-sm-6 col-md-6">
											<div class="mb-3">
												<label class="form-label">아이디</label> <button
													class="btn btn-primary btn-sm mx-2 px-2 py-1 invisible"
													id="id_accontInfoBtn">&nbsp;</button><input class="form-control"
													placeholder="202200000000" value="${member.getStuId()}" readonly>
											</div>
										</div>
										<!-- <div class="col-sm-6 col-md-6">
											<div class="mb-3">
												<label class="form-label">비밀번호</label><button
													class="btn btn-primary btn-sm mx-2 px-2 py-1"
													id="id_accontInfoBtn">비밀번호
													재설정</button>
												<input class="form-control" type="password" value="********" readonly>
											</div>
										</div> -->

										<div class="col-md-4">
											<div class="mb-3">
												<label class="form-label">이름</label> <input class="form-control"
													type="text" placeholder="이름" value="${member.getStuNm()}"
													name="stuNm" readonly required>
											</div>
										</div>
										<div class="col-sm-6 col-md-3">
											<div class="mb-3">
												<label class="form-label">전화번호</label> <input class="form-control"
													type="text" placeholder="01000000000" value="${member.getStuPhNo()}"
													name="stuPhNo" required>
											</div>
										</div>
										<div class="col-sm-6 col-md-5">
											<div class="mb-3">
												<label class="form-label">이메일</label> <input class="form-control"
													type="email" placeholder="your-email@arthakdang.com"
													value="${member.getStuEmail()}" name="stuEmail" required>
											</div>
										</div>
										<div class="col-md-12">
											<div class="mb-3 clearfix">
												<label class="form-label">주소</label>
												<button type=button class="btn btn-light btn-sm px-2 py-1 float-right"
													id="addrSearchBtn">검색</button>
												<input id="addr" class="form-control" type="text"
													placeholder="주소를 검색하세요" value="${member.getStuAddr()}"
													name="stuAddr" readonly>
											</div>
										</div>
										<div class="col-sm-6 col-md-8">
											<div class="mb-3">
												<label class="form-label">상세주소</label> <input id="addrDetail"
													class="form-control" type="text" placeholder="상세주소"
													value="${member.getStuAddrDtl()}" name="stuAddrDtl">
											</div>
										</div>
										<div class="col-sm-6 col-md-4">
											<div class="mb-3">
												<label class="form-label">우편번호</label> <input id="addrCode"
													class="form-control" type="text" placeholder="Postal Code"
													value="${member.getStuPostNo()}" name="stuPostNo" readonly>
											</div>
										</div>
										<div class="col-md-12 addrSearchFrame" id="addrSearchFrame"
											style="display:none;">
											<i class="fa-regular fa-x" id="id_foldWrapBtn"
												style="cursor:pointer;position:absolute;z-index:1;display:none"
												onclick="foldDaumPostcode()" alt="접기 버튼"></i>
										</div>
										<br>
										<div class="col-md-12">

											<label class="form-label">희망분야</label>
											<div class="form-group m-0 m-checkbox-inline">
												<div class="animate-chk">
													<div class="row">
														<div class="col-sm-6 d-flex justify-content-around">
															<label class="" for="chk-ani">
																<input class="checkbox_animated" id="chk-ani"
																	type="checkbox" name="stuIntFd" value="자격증"> 자격증
															</label>
															<label class="" for="chk-ani1">
																<input class="checkbox_animated" id="chk-ani1"
																	type="checkbox" name="stuIntFd" value="프로그래밍"> 프로그래밍
															</label>
															<label class="" for="chk-ani2">
																<input class="checkbox_animated" id="chk-ani2"
																	type="checkbox" name="stuIntFd" value="편집디자인"> 편집디자인
															</label>
															<label class="" for="chk-ani3">
																<input class="checkbox_animated" id="chk-ani3"
																	type="checkbox" name="stuIntFd" value="웹디자인"> 웹디자인
															</label>
														</div>
														<div class="col-sm-6 d-flex justify-content-start">
															<div class="row">
																<label class="col-3 m-0" for="chk-ani4">
																	<input class="checkbox_animated" id="chk-ani4"
																		type="checkbox" name="stuIntFdOption" value="">
																	그외:
																</label>
																<div class="col-9">
																	<input class="form-control" id="stuIntFdOptionText"
																		type="text" name="stuIntFd" disabled>
																</div>
															</div>
														</div>
													</div>
												</div>
												<br>

												<sec:csrfInput />
											</div>
										</div>
									</div>
								</div>
								<div class="card-footer text-end">
									<button id="id_memberInfoBtn" class="btn btn-primary" type="submit">수정하기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script src='${RESOURCES_PATH}/js/ajax.js'></script>
			<script>

				const c_stuIntFdBox = document.querySelectorAll("input[name=stuIntFd]");
				const c_stuIntFdOptionBox = document.querySelector("input[name=stuIntFdOption]");
				const c_stuIntFdOptionText = document.querySelector("input[name=stuIntFd][type=text]");

				const c_memberInfoBtn = document.querySelector("#id_memberInfoBtn");
				const c_accountInfoBtn = document.querySelector("#id_accountInfoBtn");
				const c_foldWrapBtn = document.querySelector("#id_foldWrapBtn");

				const f_memberInfoSubmit = function () {

					event.preventDefault();

					let memberInfoForm = document.querySelector("#id_memberInfoForm");

					memberInfoForm.action = "${CONTEXT_PATH}/mypage/memberinfo/edit"
					memberInfoForm.method = "post";

					memberInfoForm.submit();
				};


				c_memberInfoBtn.addEventListener("click", f_memberInfoSubmit);

				// 우편번호 찾기 찾기 화면을 넣을 element
				var element_wrap = document.getElementById('addrSearchFrame');

				let foldDaumPostcode = function () {
					// iframe을 넣은 element를 안보이게 한다.
					element_wrap.style.display = 'none';
				};

				let execDaumPostcode = function () {

					event.preventDefault();

					// 현재 scroll 위치를 저장해놓는다.
					var currentScroll = Math.max(document.body.scrollTop,
						document.documentElement.scrollTop);
					new daum.Postcode({
						oncomplete: function (data) {
							// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== '' && data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("addrDetail").value = extraAddr;

							} else {
								document.getElementById("addrDetail").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('addrCode').value = data.zonecode;
							document.getElementById("addr").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("addrDetail").focus();

							// iframe을 넣은 element를 안보이게 한다.
							// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
							element_wrap.style.display = 'none';


							// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
							document.body.scrollTop = currentScroll;
						},
						// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
						onresize: function (size) {
							element_wrap.style.height = size.height + 'px';
						},
						width: '80%',
						height: '100%'
					}).embed(element_wrap);

					// iframe을 넣은 element를 보이게 한다.

					element_wrap.style.display = 'block';
					c_foldWrapBtn.style.left = element_wrap.style.width + 'px';
					c_foldWrapBtn.style.display = '';
				};

				const f_Validator = function () {
					const c_phoneExpression = /^[0-9]+$/;
					const c_emailExpression = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
				};

				// 컨트롤러로 값을 전송하기 전 보낼 전화번호의 '-'을 제거하는 함수
				const f_phExtractor = function () {
					let text = document.getElementById('text').value;

					let regNumber = /[^0-9]/g;
					let phoneData = text.replace(regNumber, "");
				};

				// 컨트롤러에서 받은 학생 관심사 정보(,로 구분)를 파싱해 화면에 출력하는 함수
				const f_stuIntFdParser = function () {
					console.log("parser init");
					let stuIntFdStr = '${member.getStuIntFd()}';
					let stuIntFdArr = stuIntFdStr.split(",");
					c_stuIntFdBox.forEach(function (element, index, array) {
						console.log("checking... : " + element.value);
						for (let i = 0; i < stuIntFdArr.length; i++) {
							if (stuIntFdArr[i] == element.value) {
								element.checked = true;
								console.log("count : " + index);
								console.log("checked : " + stuIntFdArr[i]);
								stuIntFdArr.splice(i, 1);
							}
						}
					});
					if(stuIntFdArr.length) {
						console.log("last : " + stuIntFdArr);
					}

				};


				let addrSearchBtn = document.querySelector("#addrSearchBtn");
				addrSearchBtn.onclick = execDaumPostcode;
				f_stuIntFdParser();
			</script>