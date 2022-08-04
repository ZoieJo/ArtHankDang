<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<c:set var="member" scope="session" value="${member}" />
<c:set var="memberCode" scope="session" value="${memberCode}" />
<div class="container-fluid">
	<div class="edit-profile">
		<div class="row">
			<div class="col-xl-4">
				<div class="card">
					<div class="card-header pb-0">
						<h4 class="card-title mb-0">계정 정보</h4>
						
						<div class="card-options">
							<a class="card-options-collapse" href="#"
								data-bs-toggle="card-collapse"><i class="fe fe-chevron-up"></i></a><a
								class="card-options-remove" href="#"
								data-bs-toggle="card-remove"><i class="fe fe-x"></i></a>
						</div>
						
					</div>
					<div class="card-body">
						<form action="${pageContext.request.contextPath}/employee/updatePw" method="post" id="updateEmployeeForm">
						<sec:csrfInput/>
							<div class="row mb-2">
								<div class="profile-title">
									<div class="media">
										<img class="img-70 rounded-circle" alt=""
											src="https://dummyimage.com/100/b5b5b5/ffffff&text=Profile+Pic">
										<div class="media-body">
											<h3 class="mb-1 f-20 txt-primary">${member.getEmpNm()}</h3>
											<c:if test="${memberCode == 2 }">
											<p class="f-12">직원</p>
											</c:if>
											<c:if test="${memberCode ==3 }">
											<p class="f-12">교원</p>
											</c:if>
										</div>
									</div>
								</div>
							</div>
							<div class="mb-3">
								<label class="form-label">아이디</label> <input
									class="form-control" value="${member.getEmpId()}" disabled="disabled">
								<input type="hidden" name="memId" value="${member.getEmpId() }">
							</div>
							<div class="mb-3">
								<label class="form-label">비밀번호 변경</label> <input
									class="form-control" type="password" value="password" name="memPw">
							</div>
							<div class="form-footer">
								<button class="btn btn-primary btn-block" id="updateEmployeeBtn">비밀번호 재설정</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-xl-8">
				<form class="card" action="${pageContext.request.contextPath}/employee/updateInfo" method="post" id="updateEmployeeInfoForm">
				<input type="hidden" name="EmpId" value="${member.getEmpId() }">
				<sec:csrfInput/>
					<div class="card-header pb-0">
						<h4 class="card-title mb-0">회원 정보</h4>
						<div class="card-options">
							<a class="card-options-collapse" href="#"
								data-bs-toggle="card-collapse"><i class="fe fe-chevron-up"></i></a><a
								class="card-options-remove" href="#"
								data-bs-toggle="card-remove"><i class="fe fe-x"></i></a>
						</div>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-md-5">
								<div class="mb-3">
									<label class="form-label">이름</label>
									<input class="form-control" type="text" value="${member.getEmpNm() }" name="EmpNm" >
								</div>
							</div>
							<div class="col-sm-6 col-md-5">
								<div class="mb-3">
									<label class="form-label">전화번호</label> <input
										class="form-control" type="text" value="${member.getEmpPhNo() }" name="EmpPhNo">
								</div>
							</div>
							<div class="col-sm-6 col-md-10">
								<div class="mb-3">
									<label class="form-label">이메일</label> <input
										class="form-control" type="email"
										value="${member.getEmpEmail() }" name="EmpEmail">
								</div>
							</div>
							<div class="col-md-12">
								<div class="mb-3 clearfix">
									<label class="form-label">주소</label>
									<button type=button class="btn btn-light btn-sm px-2 float-right" id="addrSearchBtn">검색</button>
									<input id="addr" class="form-control" type="text" value="${member.getEmpAddr() }" name="EmpAddr" readonly>
								</div>
							</div>
							<div class="col-sm-6 col-md-8">
								<div class="mb-3">
									<label class="form-label">상세주소</label> <input id="addrDetail"
										class="form-control" type="text" value="${member.getEmpAddrDtl() }" name="EmpAddrDtl">
								</div>
							</div>
							<div class="col-sm-6 col-md-4">
								<div class="mb-3">
									<label class="form-label">우편번호</label> <input id="addrCode"
										class="form-control" type="text" value="${member.getEmpPostNo() }" name="EmpPostNo"
										readonly>
								</div>
							</div>
							<div class="col-md-12" id="addrSearchFrame"></div>
							<c:if test="${memCode > 1 }">
							<div class="col-sm-12 col-md-12">
								<div class="mb-3">
									<label class="form-label">입사일</label> <input
										class="form-control" type="text" placeholder="Last Name">
								</div>
							</div>
							</c:if>
<!-- 							<div class="col-md-12"> -->
<!-- 								<div> -->
<!-- 									<label class="form-label">희망분야</label> -->
<!-- 									<div class="row"> -->
<!-- 										<div class="form-group m-t-15 m-checkbox-inline mb-0"> -->
<!-- 											<div class="checkbox checkbox-dark"> -->
<!-- 												<input class="checkbox_animated" id="inline-1" -->
<!-- 													type="checkbox"> <label for="inline-1">자격증</label> -->
<!-- 											</div> -->
<!-- 											<div class="checkbox checkbox-dark"> -->
<!-- 												<input class="checkbox_animated" id="inline-2" -->
<!-- 													type="checkbox"> <label for="inline-2">프로그래밍</label> -->
<!-- 											</div> -->
<!-- 											<div class="checkbox checkbox-dark"> -->
<!-- 												<input class="checkbox_animated" id="inline-3" -->
<!-- 													type="checkbox"> <label for="inline-3">편집디자인</label> -->
<!-- 											</div> -->
<!-- 											<div class="checkbox checkbox-dark"> -->
<!-- 												<input class="checkbox_animated" id="inline-4" -->
<!-- 													type="checkbox"> <label for="inline-4">영상편집</label> -->
<!-- 											</div> -->
<!-- 											<br> -->
<!-- 											<div class=""> -->
<!-- 											<label for="inline-5">그 외:</label> -->
<!-- 												<input id="inline-5" type="text" placeholder="">  -->
<!-- 											</div> -->

<!-- 										</div> -->
<!-- 									</div> -->

<!-- 								</div> -->
<!-- 							</div> -->
						</div>
					</div>
					<div class="card-footer text-end">
						<button class="btn btn-primary" type="button" id="updateEmployeeInfoBtn">수정하기</button>
					</div>
				</form>
				<form action="${pageContext.request.contextPath}/employee/delete" method="post" id="deleteEmployeeForm">
				<sec:csrfInput/>
				<input type="hidden" value="${member.getEmpId() }" name="empId">
				<button class="btn btn-primary" type="button" id="deleteEmployeeBtn">탈퇴하기</button>
			</form>
			</div>
		</div>
	</div>
</div>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	// 우편번호 찾기 찾기 화면을 넣을 element
	var element_wrap = document.getElementById('addrSearchFrame');

	let foldDaumPostcode = function() {
		// iframe을 넣은 element를 안보이게 한다.
		element_wrap.style.display = 'none';
	}

	let execDaumPostcode = function() {

		event.preventDefault();

		// 현재 scroll 위치를 저장해놓는다.
		var currentScroll = Math.max(document.body.scrollTop,
				document.documentElement.scrollTop);
		new daum.Postcode({
			oncomplete : function(data) {
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
			onresize : function(size) {
				element_wrap.style.height = size.height + 'px';
			},
			width : '80%',
			height : '80%'
		}).embed(element_wrap);

		// iframe을 넣은 element를 보이게 한다.
		element_wrap.style.display = 'block';
	}

	let addrSearchBtn = document.querySelector("#addrSearchBtn");
	addrSearchBtn.onclick = execDaumPostcode;
	
	const updateEmployeeBtn = document.querySelector("#updateEmployeeBtn");
	const updateEmployeeForm = document.querySelector("updateEmployeeForm");
	const updateEmployeePw = () => {
		if(confirm("비밀번호를 변경하시겠습니까 ?")) {
			updateEmployeeForm.submit();
		} else {
			event.preventDefault();			
			alert("변경 취소 되었습니다.");
		}
	}
	updateEmployeeBtn.addEventListener("click", updateEmployeePw);
	
	const updateEmployeeinfoBtn = document.querySelector("#updateEmployeeInfoBtn");
	const updateEmployeeInfoForm = document.querySelector("#updateEmployeeInfoForm");
	const updateEmployeeInfo = () => {
		if(confirm("회원 정보를 변경하시겠습니까 ?")) {
			updateEmployeeInfoForm.submit();
		} else {
			event.preventDefault();
			alert("회원정보 변경을 취소하였습니다.");
		}
	}
	updateEmployeeinfoBtn.addEventListener("click", updateEmployeeInfo);
	
	const deleteEmployeeBtn = document.querySelector("#deleteEmployeeBtn");
	const deleteEmployeeForm = document.querySelector("#deleteEmployeeForm");
	const deleteEmployeeInfo = () => {
		if(confirm("회원 정보를 탈퇴하시겠습니까 ?")) {
			deleteEmployeeForm.submit();
		} else {
			event.preventDefault();
			return;
		}
	}
	deleteEmployeeBtn.addEventListener("click", deleteEmployeeInfo);
</script>