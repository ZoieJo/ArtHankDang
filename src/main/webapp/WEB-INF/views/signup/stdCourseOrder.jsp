<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script src="/arthakdang/resources/assets/js/jquery-3.5.1.min.js"></script>

<style>
.checkout-details {
	border: 1px solid #e6edef;
	padding: 25px;
}

.order-place {
	margin-top: 20px;
	text-align: right;
}

.order-place .btn {
	width: 20%;
	padding: 6px 15px;
}

input.form-control:read-only {
	background-color: transparent;
}
</style>

<script>
	document.cookie="safeCookie1=foo; SameSite=Lax";
	document.cookie = "safeCookie2=foo";
	document.cookie = "crossCookie=bar;SameSite=None; Secure";
</script>

<c:set var="totalPrice" value="0"/>

<!-- Page Body Start-->
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>결제</h3>
			</div>
		</div>
	</div>
</div>
<!-- 내용 시작 -->
<div class="container-fluid">
	<div class="card">
		<div class="card-header pb-0">
			<h5>주문 정보</h5>
		</div>
		<div class="card-body">
			<div class="row">
				<div class="col-xl-6 col-sm-12">
					<form>
						<div class="row">
							<div class="mb-3">
								<label for="inputEmail4">이름</label> <input class="form-control"
									id="inputEmail4" type="text" value="${member.stuNm}"
									data-bs-original-title="" title="" readonly>
							</div>
						</div>
						<div class="row">
							<div class="mb-3 col-sm-6">
								<label for="inputEmail5">전화번호</label> <input
									class="form-control" id="inputEmail5" type="tel"
									value="${member.stuPhNo}" data-bs-original-title="" title=""
									readonly>
							</div>
							<div class="mb-3 col-sm-6">
								<label for="inputPassword7">이메일</label> <input
									class="form-control" id="inputPassword7" type="email"
									value="${member.stuEmail}" data-bs-original-title="" title=""
									readonly>
							</div>
						</div>
						<div class="row">
							<label for="inputAddress5">주소</label>
							<div class="mb-3">
								<input class="form-control" id="inputAddress5" type="text"
									value="${member.stuAddr}" data-bs-original-title="" title=""
									readonly>
							</div>
							<div class="mb-3 col-sm-6">
								<input class="form-control" id="inputAddress1" type="text"
									value="${member.stuAddrDtl}" data-bs-original-title="" title=""
									readonly>
							</div>
							<div class="mb-3 col-sm-6">
								<input class="form-control" id="inputAddress2" type="text"
									value="${member.stuPostNo}" data-bs-original-title="" title=""
									readonly>
							</div>
						</div>
					</form>
				</div>
				<div class="col-xl-6 col-sm-12">
					<div class="checkout-details">
						<div class="order-box">
							<div class="title-box">
								<div class="checkbox-title">
									<h4 class="mb-0">강의 정보</h4>
									<span>수강료</span>
								</div>
							</div>
							<ul class="qty">
								<c:forEach var="cursInfo" items="${cursInfo}" varStatus="status">
									<c:set var="totalPrice" value="${totalPrice + cursInfo.cursSuPri}"/>
									<li>${cursInfo.cursNm} <span>￦ <fmt:formatNumber type="number" maxFractionDigits="3" value="${cursInfo.cursSuPri}"/></span></li>
								</c:forEach>
							</ul>

							<ul class="sub-total total">
								<li>총 결제 금액 <span class="count">￦ <fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}"/></span></li>
							</ul>

							<div class="order-place">
								<a class="btn btn-danger" onclick="f_cancelOrder()">취소</a>
								<a class="btn btn-primary" onclick="requestPay()" data-bs-original-title=""
									title="">결제하기</a>
							</div>
							
							<!-- 결제 취소 버튼 모달창 -->
							<div class="modal fade" id="exampleModalCenter" tabindex="-1" aria-labelledby="exampleModalCenter" style="display: none;" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">결제를 취소하시겠습니까?</h5>
											<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close" data-bs-original-title="" title=""></button>
										</div>
										<div class="modal-body">
											<p>결제를 취소하고 강의 목록으로 돌아가시겠니까?</p>
										</div>
										<div class="modal-footer">
											<button class="btn btn-secondary" type="button" data-bs-dismiss="modal" data-bs-original-title="" title="">결제 계속 진행</button>
											<button class="btn btn-primary" type="button" data-bs-original-title="" title="" onclick="f_cancelOrder()">결제 취소</button>
										</div>
									</div>
								</div>
							</div>
							<!-- 결제 취소 모달 끝 -->
							
							<form method="post" action="${CONTEXT_PATH}/stdSignup/compleOrder" id="id_completeForm">
								<sec:csrfInput/>
								<input type="hidden" name="ordNo" id="id_ordNo" value="">
								<input type="hidden" name="stuId" value="${USERNAME}">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>





<script>

	console.log("${orderNo}");

	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';
	
	const c_completeForm = document.querySelector("#id_completeForm");
	const c_ordNo = document.querySelector("#id_ordNo");

	// let data = {
	// 	pg : 'inicis',
	// 	pay_method : 'card',
	// 	merchant_uid : 'pay_'+new Date().getTime(),
	// 	name : '수강료 결제',
	// 	amount : '${totalPrice}',
	// 	buyer_email : '${member.stuEmail}',
	// 	buyer_name : '${member.stuNm}',
	// 	buyer_tel : '${member.stuPhNo}',
	// 	buyer_addr : '${member.stuAddr}',
	// 	buyer_postcode : '${member.stuPostNo}'
	// }

	// console.log(data);

	function requestPay(){

		event.preventDefault();

		var IMP = window.IMP;	// 생략 가능
		IMP.init('imp50501649');	// 본인 가맹점 식별코드 삽입

		IMP.request_pay({
			pg : 'inicis',
			pay_method : 'card',
			merchant_uid : '${orderNo}',
			name : '아트학당_수강료 결제',
			amount : '${totalPrice}',
			buyer_email : '${member.stuEmail}',
			buyer_name : '${member.stuNm}',
			buyer_tel : '${member.stuPhNo}',
			buyer_addr : '${member.stuAddr}',
			buyer_postcode : '${member.stuPostNo}'
		},function(rsp){	// callback
			if(rsp.success){
				let msg = '결제가 완료되었습니다.';
				
				let pymDt = new Date(rsp.paid_at*1000);
				
				let data = {
					pymNo : rsp.imp_uid,
					ordNo : rsp.merchant_uid,
					pymDt : pymDt,
					pymMtd : rsp.pay_method,
					pymCmcd : rsp.status,
					pymAmt : rsp.paid_amount
				};
				
				let xhr = new XMLHttpRequest();
				xhr.open("post", "${CONTEXT_PATH}/stdSignup/completeOrder", true);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
// 						alert('${CONTEXT_PATH}/' + xhr.responseText);
						// location.href = '${CONTEXT_PATH}/' + xhr.responseText;
// 						c_completeForm.action = '${CONTEXT_PATH}/' + xhr.responseText;
						c_ordNo.value = rsp.merchant_uid;
						c_completeForm.submit();


					}
				}
				xhr.setRequestHeader(tokenHeader, tokenValue);
				xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
				xhr.send(JSON.stringify(data));


			} else {
				// 결제 실패 시 로직
				let msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
				Swal.fire('결제에 실패하였습니다.', rsp.error_msg + ".<br>강의 목록으로 돌아갑니다." , 'error').then(result =>{
					deleteOrder();
				});
			}

		});
	}
	
	function f_cancelOrder() {
		
		Swal.fire({
			   title: '주문을 취소하시겠습니까?',
			   text: '확인을 클릭할 시 주문이 취소되고, 강의 목록으로 이동합니다.',
			   icon: 'question',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: true, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   deleteOrder();
			   }else{
				   return;
			   }
			});

	}
	
	function deleteOrder(){
		let xhr = new XMLHttpRequest();
		xhr.open("post", "${CONTEXT_PATH}/stdSignup/cancelOrder", true);
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				location.href='${CONTEXT_PATH}/stdSignup/curslist';
			}
		}
		xhr.setRequestHeader(tokenHeader, tokenValue);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		xhr.send("ordNo=${orderNo}");
	}
	
</script>
<!-- Container-fluid Ends-->
