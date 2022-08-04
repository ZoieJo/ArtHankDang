<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl.carousel.js"></script>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl-custom.js"></script>

<style>
#owl-carousel-14{width: 30%; float: right;  margin-right: -3%;}
div.owl-dots{display: none;}
#CslrgNm{display: inline-block; width: 180px;}
#CslrgPhNo{display: inline-block; width: 180px;}
#j_img1{width: 88%;}
#s_test1{display: inline-block; width: 180px;}
#j_test1{display: inline-block; width: 180px;}
#j_test2{display: inline-block; width: 180px;}
#j_test3{display: inline-block; width: 180px;}
#j_test4{display: inline-block; width: 180px;}
#enCsb{float: right; margin-right: 10px;}
.owl-carousel .owl-item img {
    display: block;
    height: 700px;
 }
select option[disabled] { background-color: lightblue; font-weight: bold }
 
</style>

<div class="col-sm-12">
	<h3>방문상담예약</h3>
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="${CONTEXT_PATH}" title="아트학당">홈</a></li>
		<li class="breadcrumb-item active">방문상담신청</li>
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
	
	<div class="card" style="width: 70%;" >
		<div class="card-header">
			<div id="menu">			
				<form class="theme-form" >
          	 		<!--등록상담번호 -->	
              	 	<div class="mb-3 draggable ui-draggable ui-draggable-handle">
						<input id="CslNO" type="hidden" value="CslrgNO" name="CslrgNO" class="form-control btn-square">	  
					</div>
					
           	 		<!--이름 -->	
					<div id="s_test1" class="mb-3 draggable ui-draggable ui-draggable-handle">
						<label for="input-text-1"><font style="vertical-align: inherit;">이&nbsp;&nbsp;&nbsp;름 </font></label>&nbsp;
						<input id="CslrgNm" type="text" value=""  name="CslrgNm" class="form-control btn-square"  required>	  
					</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  

           	 		<!--연락처-->	
					<div id="s_test1" class="mb-3 draggable ui-draggable ui-draggable-handle">
						<label for="input-text-1"><font style="vertical-align: inherit;">연락처</font></label>&nbsp;
						<input id="CslrgPhNo" type="text" value="" class="form-control btn-square" required>	  
					</div><br><br>
					
           	 		<!--예약일-->	
            	 		<div id="j_test1" class="mb-3 draggable ui-draggable ui-draggable-handle" onchange="changeDate()"> 
                  	 	<label for="input-day-1"><font style="vertical-align: inherit;" >상담 예약일</font></label><br>
                  		<input id="CslrgDate" class="form-control btn-square" type="date"   min="2022-07-14" max="2022-07-31" required >                     
               		</div> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     
					      

          	 		<!--예약시간-->						
					<div id="j_test2" class="mb-3 draggable ui-draggable ui-draggable-handle">
						<label for="input-day-1">예약 시간</label> 
			 			<select id="CslrgTime" class="form-select digits"required>
				 		    <option value="" style="text-align: center;"> ------------------------------ </option>
					   		<option value="09:00">09:00</option>
					  	 	<option value="10:00">10:00</option>
					   		<option value="11:00">11:00</option>
					   		<option value="13:00">13:00</option>
					   		<option value="14:00">14:00</option>
					   		<option value="15:00">15:00</option>
					   		<option value="16:00">16:00</option>
					   		<option value="17:00">17:00</option>
			 			</select>
		   	  		</div><br><br>
		
					<!-- 과목 선택  -->						
					<div id="j_test3" class="mb-3 draggable ui-draggable ui-draggable-handle">
						<label for="input-day-1">희망과목</label> 
			 			<select id="CslrgSub" class="form-select digits"required>
				 		    <option value="" style="text-align: center;"> ------------------------------</option>
					   		<option value="sub01">편집디자인</option>
					  	 	<option value="sub02">웹디자인</option>
					   		<option value="sub03">영상편집</option>
					   		<option value="sub04">프로그래밍</option>
			 			</select> 
		   	  		</div> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
		   	  		
			   	  	<!--상담구분-->
			   	  	<div id="j_test4" class="mb-3 draggable ui-draggable ui-draggable-handle">
						<label for="input-day-1"><font style="vertical-align: inherit;" >상담 구분</font></label> 
			 			<input id="CslFdCmcd" name="cslfdCmcd" class="form-select digits" value="신규" style="text-align: center;"  disabled>
		   	  		</div><br><br>
		   	  		
           	 		<!--상담신청사유-->	
					<div class="mb-3 draggable ui-draggable ui-draggable-handle">
						<label for="input-text-1"><font style="vertical-align: inherit;">신청사유</font></label>&nbsp;
                 		<textarea id="CslrgCnt"  class="form-control" rows="3" cols="4" placeholder="내용을 입력해주세요." ></textarea>
					</div>
								
			   	  	<!-- 비밀번호 -->	
					<div class="mb-3 draggable ui-draggable ui-draggable-handle" style="width: 180px;" > 
						<label for="input-text-1"><font style="vertical-align: inherit;" >비밀번호</font></label>&nbsp;
						<input id="CslrgPw" type="password" maxlength="4" class="form-control btn-square" placeholder="숫자4자리 입력해주세요" required>	  
					</div>			
					
					
					<div style="visibility: hidden;" class="mb-3 draggable ui-draggable ui-draggable-handle">
						<label for="input-day-1">상담 상태</label> 
			 			<select  id="cslStCmcd" name="cslStCmcd" class="form-select digits"  style="width: 200px">				 		
				   			<option value="cslProcess1" selected>상담 신청중</option>
				  	 		<option value="cslProcess2">상담신청 완료</option>
				   			<option value="cslProcess3">상담 진행중</option>
				   			<option value="cslProcess4">상담 완료</option>
			 			</select>			 		
		   	  		</div>		   					
		   	  		
					<button id="enCsb" type="button" class="btn btn-primary" onclick="newCom()">신   청</button>
					<input type="button"  id="cslCanBtn" class="btn btn-warning" style="float: right; margin-right:  10px"  value="초기화" onclick="history.go(0)">					
				</form>				
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

//상담신청
const tokenHeader = '${_csrf.headerName}';
const tokenValue = '${_csrf.token}';

var v_no = document.querySelector("#CslNO");
var v_nm = document.querySelector("#CslrgNm");
var v_pn = document.querySelector("#CslrgPhNo");
var v_dt = document.querySelector("#CslrgDate");
var v_tm = document.querySelector("#CslrgTime");
var v_sub = document.querySelector("#CslrgSub");
var v_cnt = document.querySelector("#CslrgCnt");
var v_pw = document.querySelector("#CslrgPw");
var v_fd = document.querySelector("#CslFdCmcd");
var v_st = document.querySelector("#cslStCmcd");



const newCom =()=>{
//	console.log("입력?");
	
	//유효성검사 : 이름
	if(!v_nm.checkValidity()){
		v_nm.reportValidity();
		return;
	}
	//유효성검사 : 전화번호
	if(!v_pn.checkValidity()){
		v_pn.reportValidity();
		return;
	}
	//유효성검사 : 날짜
	if(!v_dt.checkValidity()){
		v_dt.reportValidity();
		return;
	}
	//유효성검사 : 시간
	if(!v_tm.checkValidity()){
		v_tm.reportValidity();
		return;
	}
	//유효성검사 : 과목
	if(!v_sub.checkValidity()){
		v_sub.reportValidity();
		return;
	}
	//유효성검사 : 비밀번호
	if(!v_pw.checkValidity()){
		v_pw.reportValidity();
		return;
	}
	let NewCslrgData ={
		cslrgNo : v_no.value,
		cslrgNm : v_nm.value,
		cslrgPhNo : v_pn.value,
		cslrgRsvDt : v_dt.value,
		cslrgRsvTm : v_tm.value,
		cslrgSub : v_sub.value,
		cslrgCnt : v_cnt.value,
		cslPrivateNm : v_pw.value,	
		cslFdCmcd : v_fd.value,
		cslStCmcd :	v_st.value	
	}
	console.log(NewCslrgData);
	Swal.fire({
		   title: '상담신청',
		   text: '상담을 신청하시겠습니까?',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   
		   reverseButtons: false, // 버튼 순서 거꾸로
		   
	}).then(result => {
		 if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			let xhr = new XMLHttpRequest();
			xhr.open("post", "${pageContext.request.contextPath}/newCslrg/applyWrite", true);
			xhr.onreadystatechange = function(){
			if(xhr.readyState==4 && xhr.status==200){
				console.log(xhr.responseText);
				Swal.fire('상담이 신청 되었습니다.').then(result =>{
					location.replace('${pageContext.request.contextPath}/newCslrg/cslrdList');
				});	
			 }
		}
		xhr.setRequestHeader(tokenHeader, tokenValue);
		xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		xhr.send(JSON.stringify(NewCslrgData));
		}		
	});
}


function changeDate(){
	
	let f_date = document.querySelector("#CslrgDate");
	let f_time = document.querySelector("#CslrgTime");
	
  	let xhr = new XMLHttpRequest();
  	xhr.open("post", "${pageContext.request.contextPath}/newCslrg/timeList", true);
  	xhr.onreadystatechange = function(){
  		if(xhr.readyState==4 && xhr.status==200){
  			
			console.log(JSON.parse(xhr.responseText));
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
	xhr.send("r_date="+f_date.value); 	
}



//사이드바 포스터 넘김 설정
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
		