<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="${CONTEXT_PATH}/css/fac.css">

<sec:authorize access="hasAnyRole('STUDENT', 'TEACHER', 'EMPLOYEE')">
  <sec:authentication var="USER" property="principal.username" scope="request" />
</sec:authorize>

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<script src="${CONTEXT_PATH}/assets/js/datepicker/date-picker/datepicker-kr.js"></script>
<style>
.text-gray{
	font-size: 12px;
}
.text-light-gray{
	font-size: 12px;
}
</style>
<!-- 페이지 바운더리 출력 -->
<div class="facWrap">
	<div class="mainBody" style="margin: 30px;">
		<div class="container-fluid">
			<div class="page-header">
				<div class="row">
					<div class="col-sm-6">
						<h3>강의실 예약 현황</h3>
						<ol class="breadcrumb" style="text-align: center;">
		                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">홈</a></li>
<!-- 		                    <li class="breadcrumb-item"><a href="#">시설 대여 관리</a></li> -->
		                    <li class="breadcrumb-item"><a href="#">강의실 예약 현황</a></li>
	                  	</ol>
					</div>
					<div class="col-sm-6">
					</div>
				</div>
			</div>
		</div>
		<div class="containe-fluid">
			<div class="justify-content-end">
				<sec:csrfInput />
					<div class="col-sm-12">
				<div class="tui-datepicker-input">
					<input id="datePicker" class="form-control datepicker-here digits" placeholder="" type="text" value="${hiyahoDay}" />
					<i class="fa fa-calendar"></i>
				</div>
		
		<!-- 		<button class="btn btn-primary btn-sm" type="button">예약</button> -->
			</div>
				<div id="wrapper" class="d-flex justify-content-center"
					style="margin-top: -1px;"></div>
					</div>
		
			<div class="timetable-img text-center">
				<img src="img/content/timetable.png" alt="">
			</div>
		
		<!-- 테이블 -->
			<div class="table-responsive">
				<table class="table table-bordered text-center">
					<thead>
						<tr class="bg-light-gray">
							<th class="text-uppercase">강의실</th>
									<th class="facility">301</th>
									<th class="facility">302</th>
									<th class="facility">303</th>
									<th class="facility">304</th>
									<th class="facility">305</th>
									<th class="facility">306</th>
									<th class="facility">307</th>
									<th class="facility">308</th>
									<th class="facility">309</th>
						</tr>
					</thead>
					<tbody>
		   				<c:forEach items="${hiyaho}" var="eachRow">
							<tr>
								<th class="align-middle" style="text-align: center;">${eachRow.get(0)}</th>					
								<c:forEach var="i" begin="1" end="9"> 
								
								<c:if test="${eachRow.get(i) == '예약가능'}">
								<td onclick="modal_setval($(this));" data-toggle="modal" data-target="#reservation_form_modal">
									<button id="makeReserve" onClick="makeReservation('${hiyahoDay}', '${eachRow.get(0)}','${300 + i}', '${USER}')" style="background-color:transparent;border: 0px;">
			            				<span style="background-color:#02c2c7; padding: 3px; border-radius: 5px; margin-bottom: 3px; color: white; font-size: 14px; display:inline-block;">예약하기</span>
									</button>
									
									<div class="text-light-gray">예약정보가 <br>없습니다.</div>
								</td>
								</c:if>
								
								<c:if test="${eachRow.get(i) != '예약가능'}">
									<td onclick="modal_setval($(this));" data-toggle="modal" data-target="#reservation_form_modal">
		<!-- 	           					<span style="background-color:orange;" class="text-nowrap bg-orange padding-5px-tb padding-15px-lr border-radius-5 margin-10px-bottom text-white font-size16 xs-font-size13">예약완료</span> -->
			           					<span style="background-color:orange; padding: 3px; border-radius: 5px; margin-bottom: 3px; color: white; font-size: 16; display:inline-block;" >예약완료</span>
										<c:if test="${eachRow.get(i).memId == USER}">
											<button style="background-color:red;border:1px solid red;color:white;border-radius:5px;" onClick="deleteReservation('${eachRow.get(i).facirsvNo}', '${eachRow.get(i).memId}')"> X </button>
										</c:if>
										<c:if test="${eachRow.get(i).memId != USER}">
											<sec:authorize access="hasRole('EMPLOYEE')">
												<button style="background-color:red;border:1px solid red;color:white;border-radius:5px;"  onClick="deleteReservation('${eachRow.get(i).facirsvNo}', '${eachRow.get(i).memId}')"> X </button>
											</sec:authorize>
										</c:if>
										<div class="font-size11 text-gray">예약번호 | ${eachRow.get(i).facirsvNo}</div>
										<div class="font-size11 text-gray">Id  | ${eachRow.get(i).memId}</div>
									</td>
								</c:if>
								</c:forEach>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<script>

var datepicker;

var date = $("#datePicker").val();

$(function(){
    datepicker=$( "#datePicker").datepicker({
    	dateFormat: 'yy-mm-dd',
    	language: 'kr',
    	autoclose: true,
    	todayHighlight: true,
    	minDate: 0
    	
    });
    
    datepicker.on('change', ()=>{
		var clickDate = datepicker.val();
		location.replace("${CONTEXT_PATH}/fac/main?fbi=" + clickDate);
    });
});


$.each($('.reserv-table select'), function(i, v){
	$(this).on('change', function(i, v){
		$(this).css('background-color', $('option:selected', this).css('background-color'));
	});
});


	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';
	
	function deleteReservation(facirsvNo, memId){
		let xhr = new XMLHttpRequest();
        xhr.open("get","${CONTEXT_PATH}/fac/delete?facirsvNo=" + facirsvNo + "&memId=" + memId ,true);
        xhr.onreadystatechange = function(){
            if(xhr.readyState == 4 && xhr.status == 200){
        		console.log((xhr.responseText));    
        		
        		const Toast = Swal.mixin({
                     toast: true,
                     position: 'center-center',
                     showConfirmButton: false,
                     timer: 2000,
                     timerProgressBar: true,
                     didOpen: (toast) => {
                         toast.addEventListener('mouseenter', Swal.stopTimer),
                         toast.addEventListener('mouseleave', Swal.resumeTimer)
                     }
                 })

                 Toast.fire({
                     icon: 'warning',
                     title: '예약 취소 중입니다.'
                 }).then((result) =>{
                	 if(result.dismiss === Toast.DismissReason.timer){
        				location.reload();
                	 }
                 });

            };

        }
        xhr.setRequestHeader(tokenHeader, tokenValue);
        xhr.setRequestHeader('Content-type','application/json;charset=utf-8')

        xhr.send();
	}
	
	function makeReservation(facirsvDt, facirsvTm, faciNo, memId){
        let xhr = new XMLHttpRequest();
        xhr.open("get","${CONTEXT_PATH}/fac/reserve?facirsvDt=" + facirsvDt + "&facirsvTm=" + facirsvTm + "&faciNo=FAC" + faciNo + "&memId=" + memId ,true);
        xhr.onreadystatechange = function(){
            if(xhr.readyState == 4 && xhr.status == 200){
        		console.log((xhr.responseText));    
        		
            	Swal.fire({
                    icon: 'info',
                    title: '예약하시겠습니까?',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: '확인',
                    cancelButtonText: '취소'
                }).then((result) => {
                    if (result.isConfirmed) {
                    	location.reload();
                    }
                });
        		
            };

        }
        xhr.setRequestHeader(tokenHeader, tokenValue);
        xhr.setRequestHeader('Content-type','application/json;charset=utf-8');

        xhr.send();
	}
</script>
