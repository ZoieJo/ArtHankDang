<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

	
<form class="form theme-form" method="post" action="${CONTEXT_PATH}/write" >
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="card-body">
    	<div class="row">
        	<div class="col">
            	<div class="mb-3">
                	<label class="form-label" for="exampleFormControlInput1">
                	<font style="vertical-align: inherit;"><font style="vertical-align: inherit;">제목</font></font></label>
                	<input id="id_no"  type="hidden" name="schdNo" value="0">
					<input id="id_mem" type="hidden" name="memId" value="${USERNAME}">
                	<input class="form-control" id="id_schdTl" type="text" name="schdTl" placeholder="일정 제목을 입력하세요" required>
                </div>
            </div>
        </div>            
    	<div class="row">
    		<div class="col">
        		<div class="mb-3">
            		<label class="form-label" for="exampleFormControlSelect9"><font style="vertical-align: inherit;">일정 구분</font></label>
            		<select  name="schdCmcd" class="form-select digits" id="id_schdCmcd">          
              	
              		<option value="sch01"><font style="vertical-align: inherit;" >개인일정</font></option>
              	
              		<c:if test="${memAcc!='01'}">
              		<option value="sch02"><font style="vertical-align: inherit;">학원일정</font></option>
              		</c:if>  			                	
              		
              		<option value="sch03"><font style="vertical-align: inherit;">기타일정</font></option>
              		
              		<c:if test="${memAcc!='01'}">
              		<option value="sch04"><font style="vertical-align: inherit;">공휴일</font></option>
              		</c:if>  		
              	
              		<c:if test="${memAcc!='01'}">	                	
              		<option value="sch05"><font style="vertical-align: inherit;">상담일정</font></option>
              		</c:if>  		
              		
              		
              		</select>
          		</div>
        	</div>
    	</div>
    	<div class="row">
    		<div class="col">
        		<div class="mb-3">
           		 	<label class="form-label" for="exampleInputPassword2"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">시작일</font></font>
           		 	<input class="form-control" id="id_schdSd" type="date" name="schdSttDt" required></label>
           		 	&nbsp; &nbsp; 
           		 	<label class="form-label" for="exampleInputPassword2"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">종료일</font></font>
           		 	<input class="form-control" id="id_schdEd" type="date" name="schdEndDt" required></label>           	                  	
         	 	</div>
        	</div>
   	 	</div>
	    <div class="row">
        	<div class="col">
            	<div class="mb-3">
                   	<label class="form-label" for="exampleFormControlInput1"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">내용</font></font></label>
                    <input class="form-control" id="id_schdCnt" type="text"  name="schdCnt" placeholder="일정내용을 입력하세요" required>
                </div>
           	</div>
      	</div>
	</div>           
    <div class="card-footer text-end">
      <button class="btn btn-primary" id="calBtn" type="submit" onclick="f_writer()"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">등록</font></font></button>
      <input class="btn btn-outline-danger" type="button" value="닫기"  onClick='window.close()' >
    </div>	    
</form>
	              
                
<script>
const tokenHeader = '${_csrf.headerName}';
const tokenValue = '${_csrf.token}';

//input ID가져오기
var no_id = document.querySelector("#id_no"); 				// 일정번호
var mem_id= document.querySelector("#id_mem"); 				// 아이디
var schdCmcd_id = document.querySelector("#id_schdCmcd");		// 공통구분
var schdSD_id = document.querySelector("#id_schdSd");			// 시작일
var schdEd_id = document.querySelector("#id_schdEd");			// 종료일
var schdCnt_id = document.querySelector("#id_schdCnt");		// 내용
var schdTl_id = document.querySelector("#id_schdTl");			// 제목
//console.log("${USERNAME}");
  
const f_writer = () => {
	event.preventDefault();
	
//들어가는 값 유효성 검사	
	// 제목 
	if(!schdTl_id.checkValidity()){
		schdTl_id.reportValidity();
		return;
	}	
	// 시작일
	if(!schdSD_id.checkValidity()){
		schdSD_id.reportValidity();
		return;
	}
	// 종료일
	if(!schdEd_id.checkValidity()){
		schdEd_id.reportValidity();
		return;
	}
	// 내용
	if(!schdCnt_id.checkValidity()){
		schdCnt_id.reportValidity();
		return;
	}
	//일정 등록시 종료일 확인
	if(schdEd_id.value < schdSD_id.value){
		alert("종료일을 확인해주세요.");		
		return;
	}
		
		
	let CalendarData = {
			schdNo: no_id.value,
			memId: mem_id.value,
			schdTl: schdTl_id.value,
			schdCnt: schdCnt_id.value,
			schdSttDt: schdSD_id.value,
			schdEndDt: schdEd_id.value,
			schdCmcd: schdCmcd_id.options[schdCmcd_id.selectedIndex].value
	}	
	
	console.log(CalendarData);
	
	
	Swal.fire({
		   title: '일정등록',
		   text: '일정을 등록하시겠습니까?',
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
			 //Ajax 방식  일정 등록
			 	let xhr = new XMLHttpRequest();
			 	xhr.open("post", "${pageContext.request.contextPath}/schd/write", true);
			 	xhr.onreadystatechange = function(){
			 		if(xhr.readyState == 4 && xhr.status ==200){
		 			 Swal.fire('일정이 등록되었습니다.').then(result => {
	//			 			console.log("연결확인 >>>" + xhr.responseText); 		
				 		  	//일정 등록 확인 후, 창 닫기
				 		  	window.opener.location.replace(window.opener.location.href);
				 		  	self.close();			 				 
			 			 });

			 		} 
			 	} 			
			 	xhr.setRequestHeader(tokenHeader, tokenValue);
			 	xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
			  	xhr.send(JSON.stringify(CalendarData)); 
		   }
		});
 	}
	
 

</script>                
                