<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script src="/arthakdang/resources/assets/js/jquery-3.5.1.min.js"></script>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script> -->

<style>
.table {
	vertical-align: middle;
}

#pageDiv {
	text-align: center;
	font-size: 1.2em;
}


.current {
	font-size: 1.5em;
}

#searchBox {
	float: right;
	width: 25%;
}

#orderForm {
	width: 40%;
}

#orderForm button {
	width: 100%;
}

.btn.sbtn {
    padding: 0px;
    width: 40%;
    height: 35px;
}

.cursName {
	text-align: left;
}

.cursName:hover {
	cursor: pointer;
}

.cursPrice {
	text-align: right; 
}

.btn-secondary.disabled, .btn-secondary:disabled {
    background-color: #84817A!important;
    border-color: #84817A!important;
}


</style>

<c:set var="curPage" value="${pageDTO.cursPageCondDTO.pageNum}" />
<c:set var="pageSize" value="${pageDTO.cursPageCondDTO.pageSize}" />
<c:set var="keyword" value="${pageDTO.cursPageCondDTO.keyword}"/>

<!-- Page Body Start-->
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>강의 목록</h3>
				<!-- 제목 하단 페이지 경로 -->
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
					<a href="${CONTEXT_PATH}/">홈</a></li>
					<li class="breadcrumb-item">수강신청</li>
					<li class="breadcrumb-item">강의목록</li>
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
				<div class="card-header pb-0">
					<div class="input-group mb-3" id="searchBox">
<!-- 						<select class="form-select"> -->
<!-- 							<option selected>분류</option> -->
<!-- 							<option value="cursNm">제목</option> -->
<!-- 							<option value="empNm">강사</option> -->
<!-- 						</select> -->
						<input type="text" class="form-control" placeholder="검색할 강의명을 입력해주세요."
							aria-label="Recipient's username" aria-describedby="basic-addon2" id="id_keyword" onkeypress="if(window.event.keyCode == 13){searchCourse('${curPage}','${pageSize}')}" value="${keyword}">
						<div class="input-group-append">
							<button class="btn btn-secondary" type="button" onclick="searchCourse('${curPage}','${pageSize}')">검색</button>
						</div>
					</div>
				</div>
				<div class="card-body" style="padding-top: 0px;">
					<table class="table" style="text-align: center;">
						<thead>
							<tr class="table-light">
								<th class="col-1">No</th>
								<th class="col-2">강의명</th>
								<th class="col-1">강사</th>
								<th class="col-1">시작일</th>
								<th class="col-1">종료일</th>
								<th class="col-1">수강료</th>
								<th class="col-2">수강신청</th>
							</tr>
						</thead>


						<tbody>
						<c:if test="${cursList.size() == 0 }">
							<tr>
								<td colspan="7">강의가 존재하지 않습니다.</td>
							</tr>
						</c:if>
							<c:forEach var="course" items="${cursList}" varStatus="status">
								<c:if test="${not empty course.ordNo}">
								</c:if>
								<c:if test="${empty course.ordNo}">
									<tr>
										<td>${status.index + 1}</td>
										<td class="cursName" onclick="showDetail('${course.cursNo}')">${course.cursNm}</td>
										<td>${course.empNm}</td>
										<td><fmt:formatDate value="${course.cursSttDt}" pattern="yy/MM/dd" /></td>
										<td><fmt:formatDate value="${course.cursEndDt}" pattern="yy/MM/dd" /></td>
										<td class="cursPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${course.cursSuPri}"/></td>
										<td><c:if test="${empty course.cartNo}">
												<button class="btn btn-warning sbtn" type="button" onclick="f_putCart('${course.cursNo}','${course.cursNm}')">장바구니</button>
											</c:if> <c:if test="${not empty course.cartNo}">
												<!-- disable -->
												<button class="btn btn-secondary sbtn" type="button" onclick="f_putCart('${course.cursNo}','${course.cursNm}')" disabled>장바구니</button>
											</c:if>
											<form method="post" action="${CONTEXT_PATH}/stdSignup/order"
												style="display: inline-block;" id="orderForm">
												<input type="hidden" value="${course.cursNo}" name="cursNo">
												<input type="hidden" value="${course.cursSuPri}" name="totalPrice">
												<sec:csrfInput />
												<button class="btn btn-primary sbtn" type="submit">신청</button>
											</form></td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>

					<br>

					<div id="pageDiv">


						<form id="id_pageForm" action="${CONTEXT_PATH}/stdSignup/curslist">
							<input type="hidden" name="pageNum" value="">
							<input type="hidden" name="pageSize" value="">
							<input type="hidden" name="keyword" value="">
						</form>

						<nav aria-label="...">
						<ul class="pagination justify-content-center pagination-primary">

						<!-- 이전 버튼 -->
						<c:if test="${pageDTO.isPrevious() == true}">
							<li class="page-item"><a class="page-link" onclick="f_prev()" >이전</a></li>
						</c:if>
						<c:if test="${pageDTO.isPrevious() == false}">
							<!-- disable -->
							<li class="page-item disabled"><a class="page-link" onclick="f_prev()" >이전</a></li>
						</c:if>

						<!-- 페이지 넘버 버튼 -->
							<c:forEach var="pageNum" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
								<c:if test="${pageNum == curPage }">
									<li class="page-item active"><a class="page-link" onclick="f_sendPage('${pageNum}','${pageSize}')">${pageNum}<span class="sr-only">(current)</span></a></li>
<%-- 									<a class="paginate_button current" onclick="f_sendPage('${pageNum}','${pageSize}')">&nbsp;${pageNum}&nbsp;</a> --%>
								</c:if>
								<c:if test="${pageNum != curPage }">
									<li class="page-item"><a class="page-link" onclick="f_sendPage('${pageNum}','${pageSize}')">${pageNum}</a></li>
								</c:if>
							</c:forEach>

						<!-- 다음 버튼 -->
						<c:if test="${pageDTO.isNext() == true}">
							<li class="page-item"><a class="page-link" onclick="f_next('${pageDTO.endPage+1}')">다음</a></li>
						</c:if>
						<c:if test="${pageDTO.isNext() == false}">
							<!-- disable -->
							<li class="page-item disabled"><a class="page-link" onclick="f_next('${pageDTO.endPage+1}')">다음</a></li>
						</c:if>
                        
                      	</ul>
                    	</nav>



					</div>
				</div>
				<div class="modal fade" id="exampleModalCenter" tabindex="-1"
					aria-labelledby="exampleModalCenter" style="display: none;"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">등록이 완료되었습니다.</h5>
								<button class="btn-close" type="button" data-bs-dismiss="modal"
									aria-label="Close" data-bs-original-title="" title="" onclick="location.reload()"></button>
							</div>
							<div class="modal-body">
								<p>장바구니 목록으로 이동하시겠습니까?</p>
							</div>
							<div class="modal-footer">
								<button class="btn btn-primary" type="button"
									data-bs-original-title="" title="" onclick="location.href = '${CONTEXT_PATH}/stdSignup/cartlist'">장바구니로 가기</button>
								<button class="btn btn-secondary" type="button"
									data-bs-dismiss="modal" data-bs-original-title="" title="" onclick="location.reload()">취소</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 카드 1 끝 -->
	</div>


</div>



<script>

// 	console.log("${cursList}");
	
	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';

	const pageForm = document.querySelector("#id_pageForm");

	// 페이지 숫자를 눌렀을 때 실행되는 함수
	const f_sendPage = (p_pageNum, p_pageSize) =>{
		event.preventDefault();
		document.querySelector("input[name=pageNum]").value = p_pageNum;
		document.querySelector("input[name=pageSize]").value = p_pageSize;
		document.querySelector("input[name=keyword]").value = '${keyword}';
		pageForm.submit();
	}
	
	// 이전 버튼을 클릭하였을 경우 실행되는 함수
	const f_prev = () =>{
		document.querySelector("input[name=pageNum]").value = '${pageDTO.startPage - 1}';
		document.querySelector("input[name=pageSize]").value = '${pageSize}';
		document.querySelector("input[name=keyword]").value = '${keyword}';
		pageForm.submit();
	}
	
	// 다음 버튼을 클릭하였을 경우 실행되는 함수
	const f_next = (p_nextPageNum) => {
		document.querySelector("input[name=pageNum]").value = p_nextPageNum;
		document.querySelector("input[name=pageSize]").value = '${pageSize}';
		document.querySelector("input[name=keyword]").value = '${keyword}';
		pageForm.submit();
	}
	
	const f_putCart = (cursNo, cursNm) =>{
		
		console.log("cursNo >>>>>> " , cursNo);
		
		let xhr = new XMLHttpRequest();
		xhr.open("get", "${CONTEXT_PATH}/stdSignup/putCart?cursNo="+cursNo, true);
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				Swal.fire('장바구니에 성공적으로 담았습니다', '담은 강의 : ' + cursNm, 'success').then(result =>{
					$("#exampleModalCenter").modal('show');
				});
				

			}
		}
		xhr.setRequestHeader(tokenHeader, tokenValue);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		xhr.send();
	}
	
	const searchCourse = (curPage, pageSize) =>{
		let l_keyword = document.querySelector("#id_keyword").value;
		document.querySelector("input[name=keyword]").value = l_keyword;
		document.querySelector("input[name=pageNum]").value = curPage;
		document.querySelector("input[name=pageSize]").value = pageSize;
		pageForm.submit();
	}
	
	// 강의 정보 상세보기
	function showDetail(cursNo){
		window.open("${CONTEXT_PATH}/stdSignup/detail?cursNo="+cursNo,"_blank", "width=600, height=700 left=250, top=250");
	}
	

	
// 	// 수강신청 결제버튼 
// 	function orderCourse(cursNo){
		
// 		let data = {
// 			"cursNo" : [cursNo]
// 		}

		
// 		let xhr = new XMLHttpRequest();
// 		xhr.open("post", "${CONTEXT_PATH}/stdSignup/order", true);
// 		xhr.onreadystatechange = function(){
// 			if(xhr.readyState == 4 && xhr.status == 200){
// // 				location.href = "${CONTEXT_PATH}/stdSignup/order";
// 			}
// 		}
// 		xhr.setRequestHeader(tokenHeader, tokenValue);
// 		xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
// 		xhr.send(JSON.stringify(data));

// 	}


</script>
<!-- Container-fluid Ends-->
