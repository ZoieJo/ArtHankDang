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
                    <h5>수강생 회원가입</h5><span>수강생의 정보를 입력해주세요 !</span>
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
                    <form action="${pageContext.request.contextPath}/student/join" method="POST" id="studentForm">
                    <sec:csrfInput />
                      <div class="setup-content" id="step-1">
                        <div class="col-xs-12">
                          <div class="col-md-12">
                            <div class="form-group">
                              <label>이름</label>
				                  <div class="small-group">
				                    <div class="input-group"><span class="input-group-text"><i class="icon-user"></i></span>
				                      <input class="form-control" type="text" required="" placeholder="name" name="stuNm" id="stuNm">
				                    </div>
				                  </div>
                            </div>
                            <div class="form-group">
			                  <label>전화번호</label>
			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-mobile-screen"></i></span>
			                    <input class="form-control" required type="tel" placeholder="010XXXXXXXX" name="stuPhNo" id="stuPhNo">
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
			                    <input class="form-control" type="email" placeholder="test@naver.com" name="stuEmail" id="stuEmail">
			                  </div>
			                </div>
                            <div class="form-group">
				                <label>희망분야</label>
				                <div class="input-group"><span class="input-group-text"><span class="group-select"><i class="fa-solid fa-graduation-cap"></i></span></span>
									<select class="form-select" aria-label="Default select example" name="stuIntFd" id="stuIntFd">
										<option value="0">희망 분야를 선택해주세요 !</option>
										<option value="자격증">자격증</option>
										<option value="프로그래밍">프로그래밍</option>
										<option value="편집디자인">편집디자인</option>
										<option value="영상편집디자인">영상편집디자인</option>
									</select>
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
			                    <input class="form-control" type="text" required placeholder="우편번호" onclick="findAddr()" id="stuPostNo" name="stuPostNo">
			                 </div>
			                 </div>
			                 <div class="form-group">
			                 <div class="input-group">
								<input class="form-control" type="text" required placeholder="도로명주소" onclick="findAddr()" id="stuAddr" name="stuAddr">
							</div>
							</div>
							<div class="form-group">
							<div class="input-group">
								<input class="form-control" type="text" required placeholder="상세주소" id="stuAddrDtl" name="stuAddrDtl">
							</div>
			                </div>
                            <button class="btn btn-primary nextBtn pull-right" type="button" disabled id="btn3">Next</button>
                          </div>
                        </div>
                      </div>
                      
                      <div class="setup-content" id="step-4">
                      <div class="form_group">
			                <label>담당멘토</label>
			                <div class="input-group"><span class="input-group-text"><span class="group-select"><i class="fa-solid fa-person-chalkboard"></i></span></span>
			                	<select class="form-select" aria-label="Default select example" name="icEmpId" id="icEmpId">
									<option value="0">담당멘토를 선택해주세요 !</option>
									<c:forEach var="employee" items="${employeeList }" varStatus="status">
									<option value="${employee }">${employee }</option>
									</c:forEach>
								</select>
			                </div>
			                </div>
                            <br>
                            <input type="hidden" value="" name="stuAddr" id="stuAddrReal">
                            <button class="btn btn-secondary pull-right" disabled id="btn4" type="submit">Finish!</button>
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
// const joinStuForm = document.querySelector("#joinStuForm");

// const f_joinSubmit = () => {
// 	console.log(check);
//   	if(!check.checked) {
//     	alert("개인정보 수집에 동의해주세요.");
//     	return;
//   	}
//   joinStuForm.submit();
// }
// submit_btn.onclick = f_joinSubmit;

// step 1 유효성검사
const btn1 = document.querySelector("#btn1");
var stuNm = document.querySelector("#stuNm");
var stuPhNo = document.querySelector("#stuPhNo");
var regPhone = /^01([0])-?([0-9]{4})-?([0-9]{4})$/;

stuNm.addEventListener("keyup", listener1);
stuPhNo.addEventListener("keyup", listener1);


function listener1() {
    switch (!(stuNm.value && regPhone.test(stuPhNo.value))) {
        case true: 
        	btn1.disabled = true; break;
        case false: 
        	btn1.disabled = false; break;
    	}
	} 

// step2 유효성검사
const btn2 = document.querySelector("#btn2");
var stuEmail = document.querySelector("#stuEmail");
var stuIntFd = document.querySelector("#stuIntFd");
stuEmail.addEventListener("keyup", listener2);
stuIntFd.addEventListener("click", listener2);
var step2Result = false;
function listener2() {
    switch (!(stuEmail.value && stuIntFd.value != 0)) {
        case true: btn2.disabled = true; 
		step2Result = true;
		break;
		case false: btn2.disabled = false;
		break;
    }
}
// step3 유효성검사

const btn3 = document.querySelector("#btn3");
var stuPostNo = document.querySelector("#stuPostNo");
var stuAddr = document.querySelector("#stuAddr");
var stuAddrDtl = document.querySelector("#stuAddrDtl");
stuAddrDtl.addEventListener("keyup", listener3);

function findAddr() {
	 new daum.Postcode({
	    oncomplete: function(data) {
	       console.log(data);
	       stuPostNo.value = data.zonecode;
	       stuAddr.value = data.roadAddress;
	    }
	 }).open();
	};

function listener3() {
    switch (!(stuPostNo.value)) {
        case true: btn3.disabled = true; break;
        case false: btn3.disabled = false; break;
    }
}

// step4 유효성검사
var icEmpId = document.querySelector("#icEmpId");
icEmpId.addEventListener("click", listener4);

function listener4() {
	console.log(icEmpId.value);
    switch (icEmpId.value == 0) {
        case true: btn4.disabled = true; break;
        case false: btn4.disabled = false; break;
    }
}
// // 주소 하나로 합치기
// const btn4 = document.querySelector("#btn4");
// const studentForm = document.querySelector("#studentForm");
// var stuAddrReal = document.querySelector("#stuAddrReal");
// const plusAddr = () => {
//   event.preventDefault();

//   stuAddrReal.value = stuAddr.value + " " + stuAddrDtl.value + "(" + stuPostNo.value + ")";
  
//   studentForm.submit();
// }
// btn4.addEventListener("click", plusAddr);
</script>
