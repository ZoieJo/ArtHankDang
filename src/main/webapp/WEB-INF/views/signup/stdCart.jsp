<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>

#pageDiv {
	text-align: center;
	font-size: 1.2em;
}


.current {
	font-size: 1.5em;
}

.table {
	vertical-align: middle;
}

.card-body.primaryBtn {
	padding-top: 0px;
}

.cursName {
	text-align: left;
}

.cursPrice {
	text-align: right; 
}

.totalPrice {
	border: none;
}

h6 {
    display: inline-block;
}

input#totalPrice {
    border: none;
    text-align: right;
}

.cursName:hover {
	cursor: pointer;
}

</style>

<!-- Page Body Start-->	
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>장바구니 목록</h3>
				<!-- 제목 하단 페이지 경로 -->
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="${CONTEXT_PATH}">홈</a>
					</li>
					<li class="breadcrumb-item">수강신청</li>
					<li class="breadcrumb-item">장바구니</li>
				</ol>
			</div>
		</div>
	</div>
</div>
<!-- 내용 시작 -->
<div class="container-fluid">
	<div class="row starter-main">
		<!-- 카드 1 시작 -->
		<div class="col-sm-12">
			<div class="card">
				<div class="card-header pb-0"></div>
				<div class="card-body" style="padding-top: 0px;">
					<h6>강의 목록</h6>
					<form>
						<table class="table" style="text-align: center;">
							<thead>
								<tr class="table-light">
									<td class="col-1"><input type="checkbox" name="cartNo" onclick="f_selectAll(this)" value="" disabled></td>
									<th class="col-1">No</th>
									<th class="col-2">강의명</th>
									<th class="col-1">강사</th>
									<th class="col-1">시작일</th>
									<th class="col-1">수강료</th>
									<th class="col-1">취소</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${cartList.size() == 0}">
									<tr>
										<td colspan="7">장바구니에 담긴 항목이 없습니다</td>
									</tr>
								</c:if>
								<c:if test="${cartList.size() != 0}">
									<c:forEach var="course" items="${cartList}" varStatus="status">
										<tr>
											<td><input type="checkbox" name="cartNo" value="${course.cursNo}" onclick="priceSum(this.form)"></td>
											<td>${status.index + 1}</td>
											<td class="cursName" onclick="showDetail('${course.cursNo}')">${course.cursNm}</td>
											<td>${course.empNm}</td>
											<td><fmt:formatDate value="${course.cursSttDt}" pattern="yyyy-MM-dd" /></td>
											<td class="cursPrice" style="display: none;">${course.cursSuPri}</td>
											<td style="text-align: right;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${course.cursSuPri}"/></td>
											<td><button class="btn btn-danger btn-sm" type="button" onclick="deleteCurs('${course.cartNo}','${course.cursNm}')">취소</button></td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
				</form>
				</div>
				
				<div class="card-body" style="padding-top: 0px;">
					<table class="table table-borderless" style="text-align: right;vertical-align: middle;">
						<tbody>
							<tr>
								<th>
									<h6>총 결제 금액 : </h6>
									<input type="text" id="totalPrice" value="0" readonly="readonly"> 원
								</th>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="card-body primaryBtn" style="text-align:right;">
					<button class="btn btn-outline-primary" type="button" onclick="f_order()">결제</button>
				</div>
				
				<form id="cartForm" action="${CONTEXT_PATH}/stdSignup/order" method="post">
					<sec:csrfInput/>
					<input type="hidden" name="cursNo" id="id_cursNo" value="">
					<input type="hidden" name="totalPrice" id="id_tp" value="">
				</form>

<%-- 				<form method="post" action="${CONTEXT_PATH}/stdSignup/compleOrder" id="id_completeForm"> --%>
<!-- 					<input type="hidden" name="ordNo" id="id_ordNo" value="ORD00033">  -->
<%-- 					<input type="hidden" name="stuId" value="${USERNAME}"> --%>
<%-- 					<sec:csrfInput/> --%>
<!-- 					<input type="submit" value="전송 테스트"> -->
<!-- 				</form> -->
			</div>
		</div>
		<!-- 카드 1 끝 -->
	</div>


</div>



<script>

	console.log("${cursInfo}");

	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';

	const c_orderForm = document.querySelector("#cartForm");
	const c_cursNo = document.querySelector("#id_cursNo");
	const c_tp = document.querySelector("#id_tp");
	const c_totalPrice = document.querySelector("#totalPrice");
	
	// 강의 정보 상세보기
	function showDetail(cursNo){
		window.open("${CONTEXT_PATH}/stdSignup/detail?cursNo="+cursNo,"_blank", "width=600, height=700 left=250, top=250");
	}

	
	function deleteCurs(cartNo, cursNm) {
		
// 		let ck = confirm("<" + cursNm + ">를 장바구니에서 삭제하시겠습니까?");

		
// 		if(!ck){
// 			console.log("취소함");
// 			return;
// 		}
		
	 	Swal.fire({
		   title: '장바구니에서 삭제하시겠습니까?',
		   text: '확인을 클릭할 시 해당 강의가 장바구니에서 삭제됩니다.',
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
			   let xhr = new XMLHttpRequest();
				xhr.open("post", "${CONTEXT_PATH}/stdSignup/deleteCurs", true);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						Swal.fire('성공적으로 삭제했습니다.', '', 'success').then(result =>{
							location.reload();
						});
					}
				}
				xhr.setRequestHeader(tokenHeader, tokenValue);
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
				xhr.send("cartNo="+cartNo);
		   }else{
			   return;
		   }
		});


// 		let xhr = new XMLHttpRequest();
// 		xhr.open("post", "${CONTEXT_PATH}/stdSignup/deleteCurs", true);
// 		xhr.onreadystatechange = function(){
// 			if(xhr.readyState == 4 && xhr.status == 200){
// 				alert(xhr.responseText);
// 				location.reload();
// 			}
// 		}
// 		xhr.setRequestHeader(tokenHeader, tokenValue);
// 		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
// 		xhr.send("cartNo="+cartNo);
		
	}
	
	function f_order(){
		
		event.preventDefault();
		
		let cursNo = [];
		
		const cursNumber = 'input[name="cartNo"]:checked';
		const selectedEls = document.querySelectorAll(cursNumber);
		
		let count = 0;

		// 선택된 목록에서 value 찾기
		selectedEls.forEach((el) =>{
			console.log(el);
			cursNo.push(el.value);
			count++;
		});
		
		console.log("count >>>>>>>>>> " + count);
		
		if(count <= 0){
			Swal.fire({
				  icon: 'warning',  // 여기다가 아이콘 종류를 쓰면 됩니다.                     
				  title: '강의를 하나 이상 선택하세요.',    
				  text: '', 
				})
			return;
		}
		

		c_cursNo.value = cursNo;
		c_tp.value = c_totalPrice.value;

		console.log(c_cursNo.value);

		c_orderForm.submit();
		

		
	}
	
	function f_selectAll(selectAll){
		const checkboxes = document.getElementsByName('cartNo');

		console.log(selectAll);

		checkboxes.forEach((checkbox) => {
			checkbox.checked = selectAll.checked;
		})
		
	}

	function priceSum(frm){
		let sum = 0;
		let count = frm.cartNo.length;
		let cursPrice = document.querySelectorAll(".cursPrice");


		for(let i = 0 ; i < count ; i++){
			if(frm.cartNo[i].checked == true){
				sum += parseInt(cursPrice[i-1].childNodes[0].nodeValue);
			}
		}
		
		c_totalPrice.value = sum;

	}


</script>
<!-- Container-fluid Ends-->
