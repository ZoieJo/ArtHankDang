<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
  #step_1, #step_2, #step_3, #step_4 {
    pointer-events: none;
  }
</style>
<div class="container-fluid">
            <div class="row">
              <div class="col-sm-12">
                <div class="card">
                  <div class="card-header">
                    <h5>교직원 회원가입</h5><span>교직원의 정보를 입력해주세요 !</span>
                  </div>
                  <div class="card-body">
                    <div class="stepwizard">
                      <div class="stepwizard-row setup-panel">
                        <div class="stepwizard-step"><a class="btn btn-primary" href="#step-1" id="step_1">1</a>
                          <p>Step 1</p>
                        </div>
                        <div class="stepwizard-step"><a class="btn btn-light" href="#step-2" id="step_2">2</a>
                          <p>Step 2</p>
                        </div>
                        <div class="stepwizard-step"><a class="btn btn-light" href="#step-3" id="step_3">3</a>
                          <p>Step 3</p>
                        </div>
                        <div class="stepwizard-step"><a class="btn btn-light" href="#step-4" id="step_4">4</a>
                          <p>Step 4</p>
                        </div>
                      </div>
                    </div>
                    <form action="${pageContext.request.contextPath}/employee/join" method="POST">
                     <sec:csrfInput />
                      <div class="setup-content" id="step-1">
                        <div class="col-xs-12">
                          <div class="col-md-12">
                            <div class="form-group">
                              <label>이름</label>
				                  <div class="small-group">
				                    <div class="input-group"><span class="input-group-text"><i class="icon-user"></i></span>
				                      <input class="form-control" type="text" required="" placeholder="name" name="empNm" id="empNm">
				                    </div>
				                  </div>
                            </div>
                            <div class="form-group">
			                  <label>전화번호</label>
			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-mobile-screen"></i></span>
			                    <input class="form-control" type="tel" required="" placeholder="010XXXXXXXX" name="empPhNo" id="empPhNo">
			                  </div>
			                </div>
                            <button class="btn btn-primary nextBtn pull-right" type="button" id="btn1" disabled>Next</button>
                          </div>
                        </div>
                      </div>
                      
                      <div class="setup-content" id="step-2">
                        <div class="col-xs-12">
                          <div class="col-md-12">
                            <div class="form-group">
			                  <label>이메일</label>
			                  <div class="input-group"><span class="input-group-text"><i class="icon-email"></i></span>
			                    <input class="form-control" type="email" required="" placeholder="test@naver.com" name="empEmail" id="empEmail">
			                  </div>
			                </div>
                            <div class="form-group">
			                  <label>주민번호</label>
			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-id-card"></i></span>
			                    <input class="form-control" type="text" required="" placeholder="XXXXXX-XXXXXXX" name="empRrn" id="empRrn">
			                  </div>
			                </div>
                            <button class="btn btn-primary nextBtn pull-right" type="button" disabled id="btn2">Next</button>
                          </div>
                        </div>
                      </div>
                      
                      <div class="setup-content" id="step-3">
                        <div class="col-xs-12">
                          <div class="col-md-12">
                            <div class="form-group">
			                  <label>주소</label>
			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
			                    <input class="form-control" type="text" required="" placeholder="우편번호" onclick="findAddr()" id="empPostNo" name="empPostNo">
			                 </div>
			                 </div>
			                 <div class="form-group">
			                 <div class="input-group">
								<input class="form-control" type="text" required="" placeholder="도로명주소" onclick="findAddr()" id="empAddr" name="empAddr">
							</div>
							</div>
							<div class="form-group">
							<div class="input-group">
								<input class="form-control" type="text" required="" placeholder="상세주소" name="empAddrDtl" id="empAddrDtl">
							</div>
			                </div>
                            <button class="btn btn-primary nextBtn pull-right" type="button" disabled id="btn3">Next</button>
                          </div>
                        </div>
                      </div>
                      
                      <div class="setup-content" id="step-4">
                        <div class="col-xs-12">
                          <div class="col-md-12">
                          <div class="form-group">
				                <label>교육분야</label>
				                <div class="input-group"><span class="input-group-text"><span class="group-select"><i class="fa-solid fa-graduation-cap"></i></span></span>
									<select class="form-select" aria-label="Default select example" name="empCmcd" id="empCmcd">
										<option value="0">교육 분야를 선택해주세요 !</option>
										<option value="03">직원</option>
										<option value="02">교원</option>
									</select>
				                </div>
				                </div>
                          <div class="form-group">
				                <label>근무분야</label>
				                <div class="input-group"><span class="input-group-text"><span class="group-select"><i class="fa-solid fa-graduation-cap"></i></span></span>
									<select class="form-select" aria-label="Default select example" name="empDepNm" id="empType">
										<option value="0">근무 부서를 선택해주세요 !</option>
										<option value="BUS">경영부서</option>
										<option value="MAN">관리부서</option>
										<option value="EDU">교육부서</option>
									</select>
				                </div>
				                </div>
                          <div class="form-group">
				                <label>과목</label>
				                <div class="input-group"><span class="input-group-text"><span class="group-select"><i class="fa-solid fa-graduation-cap"></i></span></span>
									<select class="form-select" aria-label="Default select example" name="TcrIcSub" id="TcrIcSub">
										<option value="0">과목을 선택해주세요 ! (교육부서만 선택)</option>
										<c:forEach var="sub" items="${subList }" varStatus="status">
										<option value="${sub.subNm }">${sub.subNm }</option>
										</c:forEach>
									</select>
				                </div>
				                </div>
                            <button class="btn btn-secondary pull-right" disabled id="btn4" type="submit">Finish!</button>
                          </div>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
<!-- latest jquery-->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 개인정보 체크 확인
// const check = document.querySelector("#checkbox1");
// const submit_btn = document.querySelector("#submit_btn");
// const joinempForm = document.querySelector("#joinempForm");

// const f_joinSubmit = () => {
// 	console.log(check);
//   	if(!check.checked) {
//     	alert("개인정보 수집에 동의해주세요.");
//     	return;
//   	}
//   joinempForm.submit();
// }
// submit_btn.onclick = f_joinSubmit;

// step 1 유효성검사
const btn1 = document.querySelector("#btn1");
var empNm = document.querySelector("#empNm");
var empPhNo = document.querySelector("#empPhNo");
empNm.addEventListener("keyup", listener1);
empPhNo.addEventListener("keyup", listener1);

function listener1() {
    switch (!(empNm.value && empPhNo.value)) {
        case true: btn1.disabled = true; break;
        case false: btn1.disabled = false; break;
    }
}

// step2 유효성검사
const btn2 = document.querySelector("#btn2");
var empEmail = document.querySelector("#empEmail");
var empRrn = document.querySelector("#empRrn");
empEmail.addEventListener("keyup", listener2);
empRrn.addEventListener("keyup", listener2);
var step2Result = false;
function listener2() {
    switch (!(empEmail.value && empRrn.value)) {
        case true: btn2.disabled = true; 
		step2Result = true;
		break;
		case false: btn2.disabled = false;
		break;
    }
}
// step3 유효성검사

const btn3 = document.querySelector("#btn3");
var emppostNo = document.querySelector("#empPostNo");
var empAddr = document.querySelector("#empAddr");
var empAddrDtl = document.querySelector("#empAddrDtl");
empAddrDtl.addEventListener("keyup", listener3);

function findAddr() {
	 new daum.Postcode({
	    oncomplete: function(data) {
	       console.log(data);
	       empPostNo.value = data.zonecode;
	       empAddr.value = data.roadAddress;
	    }
	 }).open();
	};

function listener3() {
    switch (!(empPostNo.value)) {
        case true: btn3.disabled = true; break;
        case false: btn3.disabled = false; break;
    }
}

// step4 유효성검사
var empType = document.querySelector("#empType");
var empCmcd = document.querySelector("#empCmcd");
var TcrIcSub = document.querySelector("#TcrIcSub");
empType.addEventListener("click", listener4);
empCmcd.addEventListener("click", listener4);
function listener4() {
	console.log(empType.value);
    switch (empType.value == 0 && empCmcd.value == 0) {
        case true: btn4.disabled = true; break;
        case false: btn4.disabled = false; break;
    }
}
</script>
