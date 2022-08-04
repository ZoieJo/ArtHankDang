<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl.carousel.js"></script>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl-custom.js"></script>

<style>
.imgT {
	display: block;
	max-width: 120%;
	max-height: 80%;
	width: 100%;
	height: auto;
}

/* div.owl-dots{display: none;}  */

button.btn.btn-success{background-color: #3db39d;}

.mkhover:hover {
	background-color: rgba(45, 151, 196, 0.1);
}

.owl-carousel .owl-item .imgT {
	   max-width: 100%;
	   margin: 0 auto;
}
table {
	table-layout: fixed;
}
table tr > td{
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}
#amtTable{
	table-layout: inherit;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}
</style>
<script type="text/javascript">
	let nl = '${nl}';
</script>

				<!-- Page Body Start-->
				<!-- 내용 시작 -->
				<div class="container-fluid">
					<div class="row starter-main">

						<!-- 메인 화면에 보여줄 곳 -->
						<div class="container-fluid">
							<div class="col-sm-12">
								<div class="card">
									<div class="card-body" id="test_id">
										<div class="owl-carousel owl-theme owl-loaded owl-drag owl-view" id="owl-carousel-14">
											<div class="owl-stage-outer owl-height" style="height: 80%;">
												<div class="owl-stage" style="">
													<div class="owl-item">
														<div class="item">															
															<img class="imgT" src="${RESOURCES_PATH}/assets/images/slider/test_1.png">
														</div>
													</div>
													<div class="owl-item" >
														<div class="item">
															<img class="imgT" src="${RESOURCES_PATH}/assets/images/slider/test_2.png">
														</div>
													</div>
													<div class="owl-item">
														<div class="item">
															<img class="imgT" src="${RESOURCES_PATH}/assets/images/slider/test_3.png">
														</div>
													</div>
													<div class="owl-item">
														<div class="item">
															<img class="imgT" src="${RESOURCES_PATH}/assets/images/slider/test_4.png">
														</div>
													</div>
													<div class="owl-item">
														<div class="item">
															<img class="imgT"  src="${RESOURCES_PATH}/assets/images/slider/test_5.png">
														</div>
													</div>
													<div class="owl-item active">
														<div class="item">
															<img class="imgT" src="${RESOURCES_PATH}/assets/images/slider/test_6.png">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>

								<!-- 바디 끝 -->


							</div>
						</div>
						<!-- 끝 -->
						<!-- 공지사항 -->
						<div class="col-sm-12 col-xl-6">
							<div class="card card-absolute">
								<div class="card-header bg-danger">
									<h5 class="text-white">공지사항</h5>
								</div>
								<div class="card-body"  style="height: 380px;">
									<!-- 공지사항 테이블 뿌려주기 -->
									<div class="table-responsive">
										<table class="table">
											<thead>
												<tr style="text-align: center; font-weight: bold;">
													<th scope="col" style="width: 70%;">제목</th>
<!-- 													<th scope="col" style="width: 20%;">작성자</th> -->
													<th scope="col" style="width: 30%;">작성일</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${ntclist}">
													<tr class="mkhover" style="cursor: pointer;"
														onclick="goDBdtl('${item.bdNo}')">
														<td style="width: 70%;">${item.bdTL}</td>
<%-- 														<td style="width: 20%; text-align: center;">${item.bdWTR}</td> --%>
														<td style="width: 30%; text-align: center;">
															<fmt:formatDate value="${item.bdWtDt}"
																pattern="yyyy-MM-dd" />
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
									<!-- 더보기 버튼 -->
									<div class="card-footer" style="text-align: right; padding: 0px; border: none; margin-top: 20px;">
										<button class="btn btn-outline-danger-2x"  type="button" onclick="goBD()">더보기 &nbsp;<i class="fa-duotone fa-plus"></i></button>
									</div>
								</div>
							</div>
						</div>
						<!-- 비회원 = 취업 -->
						<sec:authorize access="!hasAnyRole('STUDENT, TEACHER, EMPLOYEE')">
							<div class="col-sm-12 col-xl-6" >
								<div class="card card-absolute" style="height: 390px;">
									<div class="card-header bg-success">
										<h5 class="text-white">GoodJob 취업정보</h5>
									</div>
									<div class="card-body">
										<div class="owl-carousel owl-theme owl-loaded owl-drag" id="owl-carousel-14">
											<div class="owl-stage-outer owl-height owl-goodjob">
												<div class="owl-stage" style="">
													<div class="owl-item active">
														<div class="item" >
															<img src="${RESOURCES_PATH}/image/main1.png" style="height: 250px;">
														</div>
													</div>
													<div class="owl-item ">
														<div class="item">
															<img src="${RESOURCES_PATH}/image/main2.png" style="height: 250px;">
														</div>
													</div>
													<div class="owl-item ">
														<div class="item">
															<img src="${RESOURCES_PATH}/image/main3.png" style="height: 250px;">
														</div>
													</div>
												</div>
											</div>
										</div>
									<!-- 더보기 버튼 -->
									</div>									
									<div class="card-footer"style="border: none; text-align: right; padding: 0px; border: none; margin-right: 30px; margin-top: -25px">
										<button class="btn btn-outline-primary-2x" type="button" onclick="goGJ()"><b>바로가기</b> &nbsp;<i class="fa fa-share-square-o"></i></button>
									</div>									
									<br>
								</div>
							</div>
						</sec:authorize>
						
						<sec:authorize access="isAuthenticated()">
							<!-- 학생 = 출결 -->
							<sec:authorize access="hasRole('STUDENT')">
								<div class="col-sm-12 col-xl-6">
									<div class="card card-absolute">
										<div class="card-header bg-success">
											<h5 class="text-white">내 출결 현황</h5>
										</div>
										<div class="card-body" style="height:380px;">
											<table class="table" id="amtTable" style="text-align:center;">
												<thead>
													<tr style="text-align:center; font-weight:bold;">
														<th scope="col">강의명</th>
														<th scope="col">출석</th>
														<th scope="col">지각</th>
														<th scope="col">조퇴</th>
														<th scope="col">병결</th>
														<th scope="col">결석</th>
													</tr>
												</thead>
												<tbody>										
													<c:forEach var="item" items="${atdList}" end="5">
														<c:if test="${empty item}">
															<tr style="cursor: pointer;">
																<td colspan="6">** 수강중인 강의가 없습니다 **</td>
															</tr>
														</c:if>
														<c:if test="${!empty item}">
															<tr class="mkhover" onclick="goAtd('${item.cursNo}')" style="cursor: pointer; text-align: center;">
																<th style="width: 40%; text-align: left; font-weight: bold;">${item.cursNm}</th>
																<td style="width: 12%; text-align: center;">${item.checkinDay}</td>
																<td style="width: 12%; text-align: center;">${item.lateDay}</td>
																<td style="width: 12%; text-align: center;">${item.earlyDepartDay}</td>
																<td style="width: 12%; text-align: center;">${item.illnessDay}</td>
																<td style="width: 12%; text-align: center;">${item.absentDay}</td>
															</tr>
														</c:if>
													</c:forEach>
												</tbody>
											</table>
											<!-- 더보기 버튼 -->
											<div class="card-footer" style="text-align: right; padding: 0px; border: none; margin-top: 10px;">
												<button type="button" class="btn btn-outline-success-2x" onclick="goAtdDtl()">
													<span class="undefined"></span>더보기 &nbsp;<i class="fa-duotone fa-plus"></i>
												</button>
											</div>											
										</div>
									</div>
								</div>
							</sec:authorize>
							<!-- 교원 = 내강의리스트 -->
							<sec:authorize access="hasRole('TEACHER')">
								<div class="col-sm-12 col-xl-6">
									<div class="card card-absolute">
										<div class="card-header bg-success">
											<h5 class="text-white">내 강의 리스트</h5>
										</div>
										<!-- 내 강의 리스트 뿌려주기 -->
										<div class="card-body">
											<table class="table" style="text-align: center;">
												<thead>
													<tr style="text-align: center; font-weight: bold;">
														<th scope="col">NO</th>
														<th scope="col">강의명</th>
														<th scope="col">강의시작날짜</th>
														<th scope="col">강의종료날짜</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="item" items="${myleclist}" begin="1" end="5"
														step="1">
														<c:if test="${empty item}">
															<tr style="cursor: pointer;">
																<td colspan="4">** 진행중인 강의가 없습니다 **</td>
															</tr>
														</c:if>
														<c:if test="${!empty item}">
															<tr class="mkhover" style="cursor: pointer;"
																onclick="goMyLec()">
																<td style="width: 20%;">${item.cursNo}</td>
																<td style="width: 30%;">${item.cursNm }</td>
																<td style="width: 25%; text-align: center;">
																	<fmt:formatDate pattern="yyyy-MM-dd"
																		value="${item.cursSttDt}" />
																</td>
																<td style="width: 25%; text-align: center;">
																	<fmt:formatDate pattern="yyyy-MM-dd"
																		value="${item.cursEndDt}" />
																</td>
															</tr>
														</c:if>
													</c:forEach>
												</tbody>
											</table>
											<!-- 더보기 버튼 -->
											<div class="card-footer" style="text-align: right; padding: 0px; border: none; margin-top: 10px;">
												<button type="button" class="btn btn-outline-success-2x" onclick="goMyLec()">
													<span class="undefined"></span>더보기 &nbsp;<i class="fa-duotone fa-plus"></i>
												</button>
											</div>											
										</div>
									</div>
								</div>
							</sec:authorize>
							<!-- 직원 = 상담신청리스트 -->
							<sec:authorize access="hasRole('EMPLOYEE')">
								<div class="col-sm-12 col-xl-6">
									<div class="card card-absolute">
										<div class="card-header bg-success">
											<h5 class="text-white">상담신청현황</h5>
										</div>
										<div class="card-body">

											<!-- 상담신청 현황 뿌려주기 -->
											<div class="table-responsive">
												<table class="table" style="text-align: center;">
													<thead>
														<tr style="text-align: center; font-weight: bold;">
															<th scope="col">NO</th>
															<th scope="col">상담구분</th>
															<th scope="col">신청자</th>
															<th scope="col">신청일시</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="item" items="${cslrglist}" begin="1" end="5"
															step="1">
															<c:if test="${empty item}">
																<tr style="cursor: pointer;">
																	<td colspan="4">** 신청중인 상담이 없습니다 **</td>
																</tr>
															</c:if>
															<c:if test="${!empty item}">
																<tr class="mkhover" style="cursor: pointer;"
																	onclick="goCslrgDtl('${item.cslrgNo}')">
																	<td style="width: 25%;">${item.cslrgNo}</td>
																	<td style="width: 20%;">${item.cslFdCmcd }</td>
																	<td style="width: 25%; text-align: center;">
																		${item.stuId}</td>
																	<td style="width: 30%; text-align: center;">
																		<fmt:formatDate pattern="yyyy-MM-dd"
																			value="${item.cslrgRsvDt}" />
																		(${item.cslrgRsvTm})
																	</td>
																</tr>
															</c:if>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<!-- 더보기 버튼 -->
											<div class="card-footer" style="text-align: right; padding: 0px; border: none; margin-top: 10px;">
												<button type="button" class="btn btn-outline-success-2x" onclick="goCslrg()">
													<span class="undefined"></span>더보기 &nbsp;<i class="fa-duotone fa-plus"></i>
												</button>
											</div>											
										</div>
									</div>
								</div>
							</sec:authorize>
						</sec:authorize>
					</div>
				</div>

<!-- Container-fluid Ends-->
<script src="${CONTEXT_PATH}/js/ajax.js"></script>
<script type="text/javascript">



	/* 내 강의 출석 상세 */
	function goAtd(p_cursNo){
		console.log("p_cursNo 확인 : ", p_cursNo);
		location.href= '${CONTEXT_PATH}/attendance/detail?cursNo=' + p_cursNo;
	}
	/* 내 강의 출석 리스트로 */
	function goAtdDtl(){
		location.href= '${CONTEXT_PATH}/attendance/main';
	}
	
	/* 공지사항 상세 페이지 */
	function goDBdtl(p_bdNo) {
		console.log(p_bdNo);
		location.href = '${CONTEXT_PATH}/notice/detail?bdNo=' + p_bdNo;
	}
	/* 공지사항 리스트 페이지로 */
	function goBD() {
		location.href = '${CONTEXT_PATH}/notice/main';
	}
	/* GoodJob 바로가기 */
	function goGJ() {
		window.open('http://192.168.145.8:8080/goodjob/');
	}
	/* 상담신청 현황 상세 페이지 */
	function goCslrgDtl(p_cslrgNo) {
		location.href = '${CONTEXT_PATH}/cslrg/detail?cslrgNo=' + p_cslrgNo;
	}
	/* 상담신청 현황 리스트 페이지로 */
	function goCslrg() {
		location.href = '${CONTEXT_PATH}/cslrcd/cslrcdList';
	}
	/* 내 강의 리스트 관리 페이지로 */
	function goMyLec() {
		location.href = '${CONTEXT_PATH}/lecture/mylecture';
	}

	$(".owl-view").owlCarousel({
		items: 1,
		center: true,
		loop: true,
		dots: true,
		autoplay: true,
		autoplayTimeout: 3000,
		autoplayHoverPause: true,
		rewind: false,
		mouseDrag: true,
		touchDrag: true,
		nav: false
	});
	
	$(".owl-goodjob").owlCarousel({
		items: 1,
		center: true,
		loop: true,
		dots: true,
		autoplay: true,
		autoplayTimeout: 4500,
		autoplayHoverPause: true,
		rewind: false,
		mouseDrag: true,
		touchDrag: true,
		nav: false
	});

// 	$(window).on('load scroll resize', function () {
// 		setTimeout(function () {
// 			var w = $('.starter-main .owl-carousel.owl-loaded').css('width');
// 			$('.starter-main .owl-carousel .owl-item .item').css('width', w);
// 		}, 300);
// 	});

	// 	$( document ).ready( function() {
	//         $( '.owl-nav' ).addClass( 'disabled' );
	//     });
</script>
<sec:authorize access="isAuthenticated()">
<script>

	const f_newUser = function () {
		f_ajax({
			url: "${CONTEXT_PATH}/mypage/new",
			method: "get",
			async: true,
			success: function(p_data) {
				f_goToMypage(p_data);
			}
		});
	}

	const f_goToMypage = function (p_data) {
		

		if (p_data==false) {
			Swal.fire({
				title: '회원 정보 등록',
				text: "회원 정보가 등록되어 있지 않습니다. 지금 마이페이지에서 등록할까요?",
				icon: 'question',
				showCancelButton: true,
				confirmButtonText: '예',
				cancelButtonText: '아니오',
				customClass: {
					cancelButton: 'btn btn-danger',
					confirmButton: 'btn btn-primary'
				}
			}).then((result) => {
				if (result.isConfirmed) {
					location.href = '${CONTEXT_PATH}/mypage/main'
				}
			});
		}
	}

	f_newUser();
</script>
</sec:authorize>