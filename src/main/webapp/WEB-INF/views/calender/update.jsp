<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	
<form id="id_update" class="form theme-form" method="post" action="${CONTEXT_PATH}/update" >
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="card-body">
    	<div class="row">
        	<div class="col">
            	<div class="mb-3">
                	<label class="form-label" for="exampleFormControlInput1">
                	<font style="vertical-align: inherit;"><font style="vertical-align: inherit;">제목</font></font></label>
                	<input id="id_no"  type="hidden" name="schdNo" value="${vo.schdNo}">
					<input id="id_mem" type="hidden" name="memId" value="${vo.memId}">
                	<input class="form-control" id="id_schdTl" type="text" name="schdTl" value="${vo.schdTl}" required>
                </div>
            </div>
        </div>            
    	<div class="row">
    		<div class="col">
        		<div class="mb-3">
            		<label class="form-label" for="exampleFormControlSelect9"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">일정 구분</font></font></label>
            		<select name="schdCmcd"  class="form-select digits" id="id_schdCmcd">
					
					
					<c:if test="${memAcc =='01'}">					
						<c:if test="${vo.schdCmcd=='sch01'}">
	              			<option value="sch01" selected><font style="vertical-align: inherit;" >개인일정</font></option>
						</c:if>    
						<c:if test="${vo.schdCmcd!='sch01'}">
	              			<option value="sch01"><font style="vertical-align: inherit;" >개인일정</font></option>
						</c:if>  				
						
						<c:if test="${vo.schdCmcd=='sch03'}">
	              			<option value="sch03" selected><font style="vertical-align: inherit;" >기타일정</font></option>
						</c:if>    
						<c:if test="${vo.schdCmcd!='sch03'}">
	              			<option value="sch03"><font style="vertical-align: inherit;" >기타일정</font></option>
						</c:if>  					
              		</c:if>  	
              		
					<c:if test="${memAcc !='01'}">					
						<c:if test="${vo.schdCmcd=='sch01'}">
	              			<option value="sch01" selected><font style="vertical-align: inherit;" >개인일정</font></option>
						</c:if>    
						<c:if test="${vo.schdCmcd!='sch01'}">
	              			<option value="sch01"><font style="vertical-align: inherit;" >개인일정</font></option>
						</c:if>  				
				
						<c:if test="${vo.schdCmcd=='sch02'}">
	              			<option value="sch02" selected><font style="vertical-align: inherit;" >학원일정</font></option>
						</c:if>    
						<c:if test="${vo.schdCmcd!='sch02'}">
	              			<option value="sch02"><font style="vertical-align: inherit;" >학원일정</font></option>
						</c:if>  	
						
						<c:if test="${calPt.schdCmcd=='sch03'}">
	              			<option value="sch03" selected><font style="vertical-align: inherit;" >기타일정</font></option>
						</c:if>    
						<c:if test="${vo.schdCmcd!='sch03'}">
	              			<option value="sch03"><font style="vertical-align: inherit;" >기타일정</font></option>
						</c:if>  	
						
						<c:if test="${vo.schdCmcd=='sch04'}">
	              			<option value="sch04" selected><font style="vertical-align: inherit;" >공휴일</font></option>
						</c:if>    
						<c:if test="${vo.schdCmcd!='sch04'}">
	              			<option value="sch04"><font style="vertical-align: inherit;" >공휴일</font></option>
						</c:if>  					
						<c:if test="${vo.schdCmcd=='sch05'}">
	              			<option value="sch05" selected><font style="vertical-align: inherit;" >상담일정</font></option>
						</c:if>    
						<c:if test="${vo.schdCmcd!='sch05'}">
	              			<option value="sch05"><font style="vertical-align: inherit;" >상담일정</font></option>
						</c:if>  					
              		</c:if>  	
			
            		</select>
          		</div>
        	</div>
    	</div>
    	<div class="row">
    		<div class="col">
        		<div class="mb-3">
           		 	<label class="form-label" for="exampleInputPassword2"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">시작일</font></font>
           		 	<input class="form-control" id="id_schdSd" type="date" name="schdSttDt" value="<fmt:formatDate value="${vo.schdSttDt}" pattern="yyyy-MM-dd"/>" required></label>
           		 	&nbsp; &nbsp; 
           		 	<label class="form-label" for="exampleInputPassword2"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">종료일</font></font>
           		 	<input class="form-control" id="id_schdEd" type="date" name="schdEndDt" value="<fmt:formatDate value="${vo.schdEndDt}" pattern="yyyy-MM-dd"/>" required></label> 
         	 	</div>
        	</div>
   	 	</div>
	    <div class="row">
        	<div class="col">
            	<div class="mb-3">            	
                   	<label class="form-label" for="exampleFormControlInput1"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">내용</font></font></label>
                    <input class="form-control" id="id_schdCnt" type="text"  name="schdCnt" value="${vo.schdCnt}" required>
                </div>
           	</div>
      	</div>
	</div>           
    <div class="card-footer text-end">
		<c:if test="${memAcc=='01'}">		
			<c:if test="${vo.schdCmcd eq'sch02' or vo.schdCmcd eq'sch04' or vo.schdCmcd eq'sch05'}">
		   		<button style="display: none;" class="btn btn-pill btn-warning" id="calChange"  onclick="f_change()"><font style="vertical-align: inherit;">수정</font></button>
		   		<button style="display: none;" class="btn btn-pill btn-danger" id="calBtn2" type="button" onclick="f_delete()"><font style="vertical-align: inherit;">삭제</font></button>	
				<c:if test="${vo.schdCmcd == 'sch05'}">
	 				<input style="float: right;" class="btn btn-pill btn-outline-success" type="button" value="취소" onclick="window.close()" >
					<p style="text-align: left;"  >상담신청 수정은 <u><b>학원</b></u>에  문의바랍니다.</p>
				</c:if>	    				
				<c:if test="${vo.schdCmcd != 'sch05'}">
					<input class="btn btn-pill btn-outline-success" type="button" value="취소"  onClick='window.close()' >
				</c:if>	    				
			</c:if> 
			<c:if test="${vo.schdCmcd ne 'sch02' and vo.schdCmcd ne 'sch04' and vo.schdCmcd ne'sch05'}">
		   		<button  class="btn btn-pill btn-warning" id="calChange"  onclick="f_change()"><font style="vertical-align: inherit;">수정</font></button>
		   		<button  class="btn btn-pill btn-danger" id="calBtn2" type="button" onclick="f_delete()"><font style="vertical-align: inherit;">삭제</font></button>	
				<input class="btn btn-pill btn-outline-success" type="button" value="취소"  onClick='window.close()' >
			</c:if>   
				</c:if>	
		<c:if test="${memAcc!='01'}"> 
			<c:if test="${vo.schdCmcd == 'sch05'}">
	 		<button style="visibility : hidden;" class="btn btn-pill btn-warning" id="calChange"  onclick="f_change()"><font style="vertical-align: inherit;">수정</font></button>
	   		<button style="visibility : hidden;" class="btn btn-pill btn-danger" id="calBtn2" type="button" onclick="f_delete()"><font style="vertical-align: inherit;">삭제</font></button>				
			<input style="float: right;" class="btn btn-pill btn-outline-success" type="button" value="취소" onclick="window.close()" >
			<p style="text-align: left; margin-top: -7%;"  >상담신청은 <u><b>상담관리</b></u>에서 수정해주세요.</p>
			</c:if>
			
			<c:if test="${vo.schdCmcd != 'sch05'}"> 		
	 		<button  class="btn btn-pill btn-warning" id="calChange"  onclick="f_change()"><font style="vertical-align: inherit;">수정</font></button>
	   		<button  class="btn btn-pill btn-danger" id="calBtn2" type="button" onclick="f_delete()"><font style="vertical-align: inherit;">삭제</font></button>
			<input class="btn btn-pill btn-outline-success" type="button" value="취소"  onClick='window.close()' >
	   		</c:if>				
		</c:if>	    
    </div>	    

	
</form>
	              
                  
<script>

console.log("${vo.schdCmcd}");

const tokenHeader = '${_csrf.headerName}';
const tokenValue = '${_csrf.token}';
const no_id = document.querySelector("#id_no"); 				// 일정번호
const mem_id= document.querySelector("#id_mem"); 				// 아이디
const schdCmcd_id = document.querySelector("#id_schdCmcd");		// 공통구분
const schdSD_id = document.querySelector("#id_schdSd");			// 시작일
const schdEd_id = document.querySelector("#id_schdEd");			// 종료일
const schdCnt_id = document.querySelector("#id_schdCnt");		// 내용
const schdTl_id = document.querySelector("#id_schdTl");			// 제목

const f_change = () => {
	event.preventDefault();	
	
	console.log("수정클릭 확인");
	
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
	
//	console.log(CalendarData);

	
//Ajax 방식  일정 수정 등록
	Swal.fire({
		   title: '일정 수정',
		   text: '일정을 수정 하시겠습니까?',
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
			 	xhr.open("post", "${pageContext.request.contextPath}/schd/update", true);

			 	xhr.onreadystatechange = function(){
			 		if(xhr.readyState == 4 && xhr.status ==200){
//			 			console.log("수정확인 >>>" + xhr.responseText);
			 			Swal.fire('일정수정되었습니다.').then(result =>{
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


const f_delete = () =>{
	
// 	console.log("삭제 함수 호출");
 	
 	
 	Swal.fire({
 	   title: '일정삭제',
 	   text: '일정을 삭제하시겠습니까?',
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
 			xhr.open("post", "${pageContext.request.contextPath}/schd/delete", true);
 			xhr.onreadystatechange = function(){
 				
 				if(xhr.readyState ==4 && xhr.status==200){
// 					alert(xhr.responseText);
 				   Swal.fire('일정이 삭제되었습니다.').then(result => {
 					   
 				 	window.opener.location.replace(window.opener.location.href);
 				  	self.close();
 				   });
 				   
 				}
 			}
 			
 			xhr.setRequestHeader(tokenHeader, tokenValue);
 			xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
 			xhr.send("schdNo=${vo.schdNo}");
 		
 	   
 	   
 	   }
 	}); 	
 
	}

 

</script>                
                  