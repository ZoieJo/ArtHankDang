<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl.carousel.js"></script>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl-custom.js"></script>

<style>
#j_img1{width: 88%;}
div.owl-dots{display: none;}
#cslApl {display: inline-block;}
#csl_D {display: inline-block;}
select option[disabled] { background-color: #dff9fb; font-weight: bold }

.owl-carousel .owl-item img { display: block; height: 700px;}
#owl-carousel-14{width: 30%; float: right;  margin-right: -3%;}
</style>

<div class="col-sm-12">
<h3>상담 신청</h3>
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="${CONTEXT_PATH}" data-bs-original-title="아트학당" title="아트학당">홈</a></li>
		<li class="breadcrumb-item active">상담신청</li>
	</ol>
	<div  class="owl-carousel owl-theme owl-loaded owl-drag" id="owl-carousel-14" >
		<div class="owl-stage-outer owl-height">
			<div class="owl-stage" style="transition: all 0.25s ease 0s;">				
				<div id="id_owl" class="owl-item">
					<div class="item" style="">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample1.png" >
					</div>
				</div>	
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample2.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample3.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample4.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample5.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample6.png" >
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="card" style="width: 70%;">
		<div class="card-header">
			<div id="menu">
			<!------------------------------------------------------------- 상담신청 ------------------------------------------------------------->
							
			<!--  상담신청 Form -->
			<form class="theme-form" id="replyApply">
				<button id="cslAppBtn" type="button" class="btn btn-primary btn-lg" style="float: right;"  onclick="cslInput()">신청</button>
				<input type="button"  id="cslCanBtn" class="btn btn-warning btn-lg" style="float: right; margin-right: 10px " value="초기화" onclick="history.go(0)">
				<button id="cslbacBtn" type="button" class="btn btn-info btn-lg" style="float: right; margin-right: 10px"  onclick="location.href='<%=request.getContextPath()%>/cslrg/cslList'">목록</button>										
              	<br><br><hr>
			
               	<div class="mb-3 draggable ui-draggable ui-draggable-handle">
                   	<input id="cslNo" type="hidden" name="cslrgNo"> <!-- 상담신청내역 NO -->
                   	<br>
					<label for="input-text-1"><font style="vertical-align: inherit;">이름</font></label>&nbsp;                    
                   	<input id="cslstNM" class="form-control btn-square" type="text" value="${member.stuNm}" style="width: 150px;" disabled>  	                	
                   	<input id="cslStu" class="form-control btn-square" type="hidden" value="${member.stuId}">  	                	
                </div>
				<br><br>    
                 
                <div id="cslApl"  class="mb-3 draggable ui-draggable ui-draggable-handle" onchange="cslrgChange()">  
                   	<label for="input-day-1"><font style="vertical-align: inherit;" >상담 신청일</font></label><br>
                  	<input id="cslDate" class="form-control btn-square" type="date"  min="2022-07-14" max="2022-07-31"  style=" width: 200px" required>                     
                </div>       
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;           
                 	
                 	
				<div id="csl_D" class="mb-3 draggable ui-draggable ui-draggable-handle">
					<label for="input-day-1"><font style="vertical-align: inherit;" >상담 시간</font></label> 
			 		<select id="cslTime" class="form-select digits" style="width: 200px" required>
			 		    <option value="" >----------------------------</option>
				   		<option value="09:00">09:00</option>
				  	 	<option value="10:00">10:00</option>
				   		<option value="11:00">11:00</option>
				   		<option value="13:00">13:00</option>
				   		<option value="14:00">14:00</option>
				   		<option value="15:00">15:00</option>
				   		<option value="16:00">16:00</option>
				   		<option value="17:00">17:00</option>
			 		</select>
		   	  	</div>
				<br><br>    
				<br>
				<div class="mb-3 draggable ui-draggable ui-draggable-handle">
					<label for="input-day-1"><font style="vertical-align: inherit;" >상담 구분</font></label> 
			 		<select id="cslDis" name="cslfdCmcd" class="form-select digits"  style="width: 200px" required>
			 		    <option value="">----------------------------</option>
				   		<c:if test="${memStu =='01'}">
					   		<option value="cslField1"><font style="vertical-align: inherit;">학업</font></option>
					  	 	<option value="cslField2"><font style="vertical-align: inherit;" >취업</font></option>
					   		<option value="cslField3"><font style="vertical-align: inherit;" >기타</font></option>
				   		</c:if>				   		
				   		<c:if test="${memStu != '01'}">
					   		<option value="cslField4"><font style="vertical-align: inherit;" >신규</font></option>
				   		</c:if>				   		
			 		</select>
		   	  	</div>

				<br><br>                   
                 
               	<div class="mb-3 draggable ui-draggable ui-draggable-handle">
                  	<label for="select-1"><font style="vertical-align: inherit;">신청 내용</font></label>
                 		<textarea id="cslCnt"  class="form-control" rows="3" cols="4"  placeholder="내용을 입력해주세요."></textarea>
				</div>
				
				<sec:authorize access="hasRole('STUDENT')">
				<div style="visibility: hidden;"  class="mb-3 draggable ui-draggable ui-draggable-handle">
					<label for="input-day-1"><font style="vertical-align: inherit;" >상담상태 </font></label> 
			 		<select  id="cslStCmcd" name="cslStCmcd" class="form-select digits"  style="width: 200px">				 		
				   		<option value="cslProcess1" selected>상담 신청중</option>
				  	 	<option value="cslProcess2">상담신청 완료</option>
				   		<option value="cslProcess3">상담 진행중</option>
				   		<option value="cslProcess4">상담 완료</option>
			 		</select>			 		
		   	  	</div>		   	  	
				</sec:authorize>				 
				
				<input id="cslEmpId" type="hidden" name="empId" value="" > <!-- 교직원ID -->
				<input id="cslRsn" type="hidden" name="cslrgRsn"> <!-- 상담결과(내용) -->								
              </form>
			</div>
		</div>
	</div>
</div>	
						

	
	
<script type="text/javascript">		

//console.log("확인해봅시다..넘어옴?" + ${memStu});

const tokenHeader = '${_csrf.headerName}';
const tokenValue = '${_csrf.token}';

//form ID별 값설정하기.
var no = document.querySelector("#cslNo");
var stuId = document.querySelector("#cslStu");
var stu  = document.querySelector("#cslStu");
var date = document.querySelector("#cslDate");
var time = document.querySelector("#cslTime");
var dis = document.querySelector("#cslDis");
var cnt = document.querySelector("#cslCnt");
var emp = document.querySelector("#cslEmpId");
var stCmcd = document.querySelector("#cslStCmcd");
//console.log("확인<<<" + stCmcd);
var rsn = document.querySelector("#cslRsn");
var cslScd = document.querySelector("#cslStCmcd"); 

//상담신청 작성 버튼
function cslInput(){
//	console.log("신청버튼 클릭");	
//	console.log(stCmcd);


//유효성 검사

	//상담신청일	
	if(!date.checkValidity()){
		date.reportValidity();
		return;
	}	
	//상담시간
	if(!time.checkValidity()){
		time.reportValidity();
		return;
	}
	//상담구분
	if(!dis.checkValidity()){
		dis.reportValidity();
		return;
	}	

 	let CslrgData = {
 		stuId : stuId.value,
		cslrgNo : no.value,
 		cslrgRsvDt: date.value ,
 		cslrgRsvTm: time.value,
 		cslFdCmcd: dis.value,
 		cslrgCnt : cnt.value,
 		empId : emp.value,
 		cslStCmcd : stCmcd.value,
 		cslrgRsn: rsn.value
 	}

// console.log(CslrgData);
 	

 	Swal.fire({
 	   title: '상담신청',
 	   text: '상담이 신청됩니다.',
 	   icon: 'warning',
 	   
 	   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
 	   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
 	   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
 	   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
 	   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
 	   
 	   reverseButtons: false, // 버튼 순서 거꾸로
 	   
 	}).then(result => {
 	   // 만약 Promise리턴을 받으면,
 	   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
 		  let xhr = new XMLHttpRequest();
 		  	xhr.open("post", "${pageContext.request.contextPath}/cslrg/applyWrite", true);
 		  	xhr.onreadystatechange = function(){
 		  		if(xhr.readyState==4 && xhr.status==200){
// 		  			console.log(xhr.responseText);
 		  			Swal.fire('상담이 신청되었습니다.').then(result => {
 		  			location.replace('${pageContext.request.contextPath}/cslrg/cslList');
 		  				
 		  			});
 		  		}
 		  	}
 		  	xhr.setRequestHeader(tokenHeader, tokenValue);
 		  	xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
 		 	xhr.send(JSON.stringify(CslrgData));
 		  	
 	   
 	      Swal.fire('승인이 완료되었습니다.', '', 'success');
 	   }
 	});

} 

function cslrgChange(){
  	
	let f_date = document.querySelector("#cslDate");
  	let f_time = document.querySelector("#cslTime");  	
  	
	
//	console.log("날짜 변경");
  	let xhr = new XMLHttpRequest();
  	xhr.open("post", "${pageContext.request.contextPath}/cslrg/timeList", true);
  	xhr.onreadystatechange = function(){
  		if(xhr.readyState==4 && xhr.status==200){
//  			console.log(xhr.responseText);
  			
  			let recvTimes= JSON.parse(xhr.responseText);
  			
  			/*초기화 */
	  		for(var i=0; i<f_time.options.length; i++){
  	  	  		f_time.options[i].disabled = false;
  	  		}	
  			
  			for(var j=0; j<recvTimes.length; j++){
  	  			for(var i=0; i<f_time.options.length; i++){
  	  	  			if( recvTimes[j] == f_time.options[i].value){
  	  	  			  f_time.options[i].disabled = true;
  	  	  			}
  	  			}	
  			}  			
   		}  		
  	}
  	xhr.setRequestHeader(tokenHeader, tokenValue);
  	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 	
  	
//  	console.log("값" + f_date.value); 	
  	xhr.send("r_date="+f_date.value); 	
}

// 사이드바 설정
$(".owl-carousel").owlCarousel({
		items : 1,
		center : true,
		loop : true,
		dots : true,
		autoplay : true,
		autoplayTimeout : 3000,
		autoplayHoverPause : true,
		rewind : false,
		mouseDrag : true,
		touchDrag : true,
		nav : false
	});
	$(window).on('load scroll resize', function() {
		setTimeout(function() {
			var w = $('.starter-main .owl-carousel.owl-loaded').css('width');
			$('.starter-main .owl-carousel .owl-item .item').css('width', w);
		}, 300);
	});

</script>
