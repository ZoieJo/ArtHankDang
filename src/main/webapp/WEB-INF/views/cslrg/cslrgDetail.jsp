<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl.carousel.js"></script>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl-custom.js"></script>

<style>
#CslrgNm{display: inline-block; width: 180px;}
#CslrgPhNo{display: inline-block; width: 180px;}
#CslrgSub{display: inline-block; width: 180px;}
#passWd{display: inline-block;  width: 180px;}
#sub{display: inline-block;}
#j_img1{width: 88%;}
div.owl-dots{display: none;}
#cslApl {display: inline-block;}
#csl_D {display: inline-block;}
#j_fdCmcd{display: inline-block;}
#j_stCmcd{display: inline-block;}
#j_img1{width: 88%;}
select option[disabled] { background-color: lightblue; font-weight: bold }
.owl-carousel .owl-item img { display: block; height: 730px;}
#owl-carousel-14{width: 30%; float: right;  margin-right: -3%;}

</style>






<div class="col-sm-12">
	<c:if test="detailNo.cslStCmcd == '상담완료'">
		<c:if test="${memStu == '01'}">
	
		<h3>상담신청 내역 </h3>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="${CONTEXT_PATH}" title="아트학당">홈</a></li>
			<li class="breadcrumb-item"><a href="${CONTEXT_PATH}/cslrg/cslList" title="내상담내역">상담목록</a></li>	
			<li class="breadcrumb-item active">상담신청내역</li>		
		</ol>
	
	</c:if>
	
	</c:if>
	
	<c:if test="${memStu == '02'}">
		<c:if test="${detailNo.cslStCmcd == '상담완료'}">			
		<h3>상담내역 관리</h3>	
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="${CONTEXT_PATH}" title="아트학당">홈</a></li>
			<li class="breadcrumb-item"><a href="${CONTEXT_PATH}/cslrcd/cslrcdSub" title="상담결과관리">상담결과관리</a></li>	
			<li class="breadcrumb-item active">상담내역</li>
		</ol>
		</c:if>
		<c:if test="${detailNo.cslStCmcd != '상담완료'}">			
		<h3>상담신청 관리</h3>	
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="${CONTEXT_PATH}" title="아트학당">홈</a></li>
			<li class="breadcrumb-item"><a href="${CONTEXT_PATH}/cslrcd/cslrcdSub" title="상담신청관리">상담신청 관리</a></li>	
			<li class="breadcrumb-item active">상담신청 내역</li>
		</ol>
		</c:if>
	</c:if>
	
<!-- 사이드 이미지 첨부  -->
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

	<div class="card" style="width: 70%; height: 730px;">
		<div class="card-header">
			<div id="menu">
<!-- 상담신청 ----------------------------------------------------------------------------------------------------------------------->
							
<!--  상담신청 Form -->
			<form class="theme-form" id="replyApply">			

<!--상담현황 구분별 -->
				<c:if test="${detailNo.cslStCmcd != '상담완료'}">
<!-- 삭제 버튼 -->
					<input id="cslCanBtn" value="삭제" type="button" class="btn btn-danger btn-lg" style="float: right; " onclick="f_delete()">
<!-- 수정 버튼 -->				
	 				<c:if test="${memStu == '01'}">
	 					<c:if test="${detailNo.cslStCmcd=='신청중'}">
							<input id="cslAppBtn" type="button" class="btn btn-warning btn-lg" style="float: right; margin-right: 10px;" onclick="f_test1()" value="수정">
						</c:if>
					</c:if>		
										
	 				<c:if test="${memStu == '02'}">
					<input id="cslAppBtn" type="button" class="btn btn-warning btn-lg" style="float: right; margin-right: 10px;" onclick="f_test1()" value="수정">
					</c:if>
				</c:if>
		
<!--상담현황 구분별 -->
				<c:if test="${detailNo.cslStCmcd == '상담완료'}">
					<input id="cslCanBtn" value="삭제" type="button" class="btn btn-danger btn-lg" style="loat: right; display: none; " onclick="f_delete()">
<!-- 수정 버튼 -->				
	 				<c:if test="${memStu == '01'}">
	 					<c:if test="${detailNo.cslStCmcd=='신청중'}">
							<input id="cslAppBtn" type="button" class="btn btn-warning btn-lg" style="float: right; margin-right: 10px; display: none;" onclick="f_test1()" value="수정">
						</c:if>
					</c:if>							
	 				<c:if test="${memStu == '02'}">
					<input id="cslAppBtn" type="button" class="btn btn-warning btn-lg" style="float: right; margin-right: 10px; display: none;" onclick="f_test1()" value="수정">
					</c:if>
				</c:if>
				
				
<!-- 목록 버튼  -->	
				<c:if test="${memStu == '01'}">				
				<button id="cslbacBtn" type="button" class="btn btn-primary btn-lg" style="float: right; margin-right: 10px;" onclick="location.href='<%=request.getContextPath()%>/cslrg/cslList'">목록</button>										
				</c:if>				
				<c:if test="${memStu == '02'}">	
					<c:if test="${detailNo.cslStCmcd == '상담완료'}">					
						<button id="cslbacBtn" type="button" class="btn btn-primary btn-lg" style="float: right; margin-right: 10px;" onclick="location.href='<%=request.getContextPath()%>/cslrcd/cslrcdSub'">목록</button>										
					</c:if>
					<c:if test="${detailNo.cslStCmcd != '상담완료'}">					
						<button id="cslbacBtn" type="button" class="btn btn-primary btn-lg" style="float: right; margin-right: 10px;" onclick="location.href='<%=request.getContextPath()%>/cslrcd/cslrcdList'">목록</button>										
					</c:if>
				</c:if>
				<c:if test="${memStu == '03'}">	
					<c:if test="${detailNo.cslStCmcd == '상담완료'}">					
						<button id="cslbacBtn" type="button" class="btn btn-primary btn-lg" style="float: right; margin-right: 10px;" onclick="location.href='<%=request.getContextPath()%>/cslrcd/cslrcdSub'">목록</button>										
					</c:if>
					<c:if test="${detailNo.cslStCmcd != '상담완료'}">					
						<button id="cslbacBtn" type="button" class="btn btn-primary btn-lg" style="float: right; margin-right: 10px;" onclick="location.href='<%=request.getContextPath()%>/cslrcd/cslrcdList'">목록</button>										
					</c:if>
				</c:if>
				

				
<!-- 상담신청내역 NO -->
				<c:if test="${detailNo.cslFdCmcd != '신규'}">			
               	<div class="mb-3 draggable ui-draggable ui-draggable-handle">
                <br><h5>신청 내역</h5><hr>                
                   	<input id="cslNo" type="hidden" name="cslrgNo" value="${detailNo.cslrgNo}"><br>
					<label for="input-text-1"><font style="vertical-align: inherit;">상&nbsp;담&nbsp;자&nbsp;:</font></label>&nbsp;                    
                    <input id="cslStu" class="form-control btn-square" type="text"  value="${detailNo.stuId}" name="stuId" style="width:190px;" disabled>  	                
                </div>
				<br>
				</c:if>
				
				<c:if test="${detailNo.cslFdCmcd == '신규'}">			
				<div class="mb-3 draggable ui-draggable ui-draggable-handle">
                <br><h5>신청 내역</h5><hr>                
	                   	<input id="cslNo" type="hidden" name="cslrgNo" value="${detailNo.cslrgNo}"><br>
						<label for="input-text-1"><font style="vertical-align: inherit;">이&nbsp;&nbsp;&nbsp;름  :</font></label>&nbsp;
						<input id="CslrgNm" type="text" value="${detailNo.cslrgNm}" name="CslrgNm" class="form-control btn-square"  disabled>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
						<label for="input-text-1"><font style="vertical-align: inherit;">연락처  :</font></label>&nbsp;
						<input id="CslrgPhNo" type="text" value="${detailNo.cslrgPhNo}" class="form-control btn-square">						
				</div><br>
				</c:if>
				
<!-- 상담신청일  -->                 
                <div id="cslApl"  class="mb-3 draggable ui-draggable ui-draggable-handle" onchange="cslrgChange()">  
                   	<label for="input-day-1"><font style="vertical-align: inherit;" >상담 신청일</font></label><br>                   	
                   	<input id="cslDate" value="<fmt:formatDate value="${detailNo.cslrgRsvDt}"   pattern="yyyy-MM-dd"/>"
                   	 class="form-control btn-square" type="date" min="2022-07-14" max="2022-07-31"  style=" width: 180px" required>                     
                </div> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
<!-- 상담시간  -->                 	
				<div id="csl_D" class="mb-3 draggable ui-draggable ui-draggable-handle">
					<label for="input-day-1"><font style="vertical-align: inherit;" >상담 시간</font></label> 
			 		<select name="cslrgTime" id="cslTime" class="form-select digits" style="width: 180px"  required>			 	
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
				
<!-- 상담구분(학업/진로)/(취업)/(기타)  -->				
				<div id="j_fdCmcd" class="mb-3 draggable ui-draggable ui-draggable-handle">
					<label for="input-day-1"><font style="vertical-align: inherit;" >상담 구분</font></label> 
			 		<select id="cslDis" name="cslfdCmcd" class="form-select digits"  style="width: 180px;" required>
				   		<c:if test="${memStu =='02'}">
					   		<option value="cslField1"><font style="vertical-align: inherit;">학업</font></option>
					  	 	<option value="cslField2"><font style="vertical-align: inherit;" >취업</font></option>
					   		<option value="cslField3"><font style="vertical-align: inherit;" >기타</font></option>
					   		<option value="cslField4"><font style="vertical-align: inherit;" >신규</font></option>
				   		</c:if>			   				   		
				   		<c:if test="${memStu == '01'}">
					   		<option value="cslField1"><font style="vertical-align: inherit;">학업</font></option>
					  	 	<option value="cslField2"><font style="vertical-align: inherit;" >취업</font></option>
					   		<option value="cslField3"><font style="vertical-align: inherit;" >기타</font></option>
				   		</c:if>	   				   		
				   		<c:if test="${memStu == '03'}">
					   		<option value="cslField1"><font style="vertical-align: inherit;">학업</font></option>
					  	 	<option value="cslField2"><font style="vertical-align: inherit;" >취업</font></option>
					   		<option value="cslField3"><font style="vertical-align: inherit;" >기타</font></option>
					   		<option value="cslField4"><font style="vertical-align: inherit;" >신규</font></option>
				   		</c:if>
			 		</select>
		   	  	</div>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   		   	  	
<!-- 상담현황  -->		   	  		
				<div id="j_stCmcd" class="mb-3 draggable ui-draggable ui-draggable-handle">
		   	  		<label for="input-day-1"><font style="vertical-align: inherit;" >상담  현황</font></label><br>
		   	  		<input id="j_cslStCmcd" type="text" class="form-control" name="cslStCmcd" value="${detailNo.cslStCmcd}" style="width: 180px;" disabled>
		   	  	</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
<!-- 상담담당자  -->																
				<c:if test="${detailNo.cslStCmcd=='신청완료'}">				
					<br><br>
					<div id="empIdSt" class="mb-3 draggable ui-draggable ui-draggable-handle">
						<label for="input-text-1"><font style="vertical-align: inherit;">상담담당자  :</font></label>&nbsp;
		            	<input id="cslEmpId"class="form-control btn-square" type="text"  value="${detailNo.empId}"   name="empId"  style="width:190px;" disabled>  
		   	  		</div>				
				</c:if>
				<c:if test="${detailNo.cslStCmcd!='신청완료'}">				
					<br><br>
					<div id="empIdSt" class="mb-3 draggable ui-draggable ui-draggable-handle" style="display: none;">
						<label for="input-text-1"><font style="vertical-align: inherit;">상담담당자  :</font></label>&nbsp;
		            	<input id="cslEmpId"class="form-control btn-square" type="text"  value="${detailNo.empId}"   name="empId"  style="width:190px;" disabled>  
		   	  		</div>				
				</c:if>
		   	  	
<!-- 희망과목:신규  -->
		   	  	<c:if test="${detailNo.cslFdCmcd == '신규'}">	
		   	  		<div id="sub" class="mb-3 draggable ui-draggable ui-draggable-handle">
						<br>	   	  		
						<label for="input-day-1">희망과목</label><br>
			 			<select id="CslrgSub" class="form-select digits"required>
					   		<option value="sub01">편집디자인</option>
					  	 	<option value="sub02">웹디자인</option>
					   		<option value="sub03">영상편집</option>
					   		<option value="sub04">프로그래밍</option>
			 			</select> 
		   	  		</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
<!-- 비밀번호설정 : 신규  -->				
					<div id="passWd" class="mb-3 draggable ui-draggable ui-draggable-handle">
		   	  			<label for="input-day-1" style=""><font style="vertical-align: inherit;" >비밀번호</font></label><br>
		   	  				<input id="cslPrivateNm" type="text" class="form-control" name="cslPrivateNm" value="${detailNo.cslPrivateNm}">		   	  		
		   	  		</div>	
		   	  		
		   	  	</c:if>
<!-- 신청내용  -->              
			<c:if test="${detailNo.cslStCmcd == '상담완료'}">					  
               	<div class="mb-3 draggable ui-draggable ui-draggable-handle">
                  	<br>
                  	<label for="select-1"><font style="vertical-align: inherit;">신청 내용</font></label><br>
                 		<textarea id="cslCnt"  rows="3" cols="4"  class="form-control" placeholder="내용을 입력해주세요."  disabled>${detailNo.cslrgCnt}</textarea>
				</div>
				<br>
					<div style="text-align: left; color: blue; ">
						<h6>상담이 완료되었습니다.</h6>
					</div>
		
					
					<div style="text-align: right; ">
						<font style="vertical-align: inherit;">상담문의 : (042)535-5354</font>
					</div>
					<br>
			</c:if>
			<c:if test="${detailNo.cslStCmcd != '상담완료'}">					  
               	<div class="mb-3 draggable ui-draggable ui-draggable-handle">
                  	<br>
                  	<label for="select-1"><font style="vertical-align: inherit;">신청 내용</font></label><br>
                 		<textarea id="cslCnt"  rows="3" cols="4"  class="form-control" placeholder="내용을 입력해주세요." >${detailNo.cslrgCnt}</textarea>
				</div>
			</c:if>


<!-- 상담 상태  -->			
				<sec:authorize access="hasRole('STUDENT')">
				<div style="visibility: hidden;"  class="mb-3 draggable ui-draggable ui-draggable-handle">
					<label for="input-day-1"><font style="vertical-align: inherit;" >상담상태 </font></label> 
			 		<select  id="cslStCmcd" name="cslStCmcd" class="form-select digits"  style="width: 200px">				 		
				   		<option value="cslProcess1" selected>신청중</option>
				  	 	<option value="cslProcess2">신청완료</option>
				   		<option value="cslProcess3">상담진행중</option>
				   		<option value="cslProcess4">상담완료</option>
			 		</select>			 		
		   	  	</div>		   	  	
				</sec:authorize>	
				
						
<!--상담결과입력 버튼 생성  -->				
				<c:if test="${detailNo.cslStCmcd == '신청완료'}">
				<br><br>
					<c:if test="${memStu == '02'}">				
					<button class="btn btn-primary btn-lg" type="button"  style="float: right; margin-top: -5%;" onclick="clrgRslt()">상담내용입력</button>	
					</c:if>
				</c:if>				
			
				<c:if test="${detailNo.cslStCmcd == '상담완료'}">
					<c:if test="${memStu == '02'}">		
					<br><br>		
					<button class= "btn btn-warning btn-lg" type="button"  style="float: right; margin-top: -5%;" onclick="clrgRslt()">상담수정</button>	
					</c:if>
			
					<c:if test="${memStu == '03'}">				
					<button class= "btn btn-warning btn-lg" type="button"  style="float: right;  margin-right: 15px; margin-top: 3%;"   onclick="clrgRslt()">상담내용</button>	
					</c:if>
			
				</c:if>								
				</form>
			</div>
		</div>
		
<!-- 상담결과 입력  -->
		<div onload="init()" class="modal fade bd-example-modal-lg show" id="exampleModalCenter" tabindex="-1" aria-labelledby="myLargeModalLabel" style="display: ; padding-right: 17px;" role="dialog" aria-modal="true" aria-hidden="true">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div id="id_test" class="modal-header">
								<h5 class="modal-title">상담 결과</h5>
								<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close" onclick="location.reload()"></button>
							</div>
							
							<c:if test="${memStu == '03'}">		
								<c:if test="${detailNo.cslStCmcd == '상담완료'}">		
								<div  class="modal-body"  style="text-align: center; display: inline-block;">								
									<textarea  id="id_rsn" rows="10" cols="100" disabled style="background-color:#dff9fb;">${detailNo.cslrgRsn}</textarea>
								</div>
								</c:if>
							</c:if>							
							<c:if test="${memStu != '03'}">		
								<c:if test="${detailNo.cslStCmcd == '상담완료'}">		
								<div  class="modal-body"  style="text-align: center; display: inline-block;">								
									<textarea  id="id_rsn" rows="10" cols="100"  style="background-color:#dff9fb;">${detailNo.cslrgRsn}</textarea>
								</div>
								</c:if>
							</c:if>							
							<c:if test="${memStu != '03'}">		
								<c:if test="${detailNo.cslStCmcd == '신청완료'}">		
								<div  class="modal-body"  style="text-align: center; display: inline-block;">								
									<textarea  id="id_rsn" rows="10" cols="100" style="background-color:#dff9fb;">${detailNo.cslrgRsn}</textarea>
								</div>
								</c:if>
							</c:if>							
							
							
							<div class="modal-footer">							
 								<c:if test="${detailNo.cslStCmcd == '신청완료'}">
 									<button class="btn btn-primary" type="button"  onclick="resultCnt()">작성</button>
 								</c:if> 	
 								
 								<c:if test="${detailNo.cslStCmcd == '상담완료'}">			
	 								<c:if test="${memStu == '02'}"> 												
 									<button class="btn btn-primary" type="button"  onclick="resultUp()">수정</button>
 									</c:if>
 									
	 								<c:if test="${memStu == '03'}"> 												
 										<button class="btn btn-primary" style="display: none;"  onclick="resultUp()">수정</button>
 									</c:if>
 									
								</c:if>
								<button class="btn btn-secondary" type="button" data-bs-dismiss="modal"  onclick="location.reload()">취소</button>
							</div>
						</div>
					</div>
				</div>
			</div>	
		</div>	
	
<script type="text/javascript">		
console.log("${detailNo}");

const tokenHeader = '${_csrf.headerName}';
const tokenValue = '${_csrf.token}';

//form ID별 값설정하기.
var no = document.querySelector("#cslNo");
var stuId = document.querySelector("#cslStu");
var date = document.querySelector("#cslDate");
var time = document.querySelector("#cslTime");
var dis = document.querySelector("#cslDis");
var cnt = document.querySelector("#cslCnt");
var emp = document.querySelector("#cslEmpId");
var stCmcd = document.querySelector("#j_cslStCmcd");
var stCmcdValue;
var stRsnValue;

//상담결과 내용
var resultRsn = document.querySelector("#id_rsn");

var memberGuvun = '${memStu}';
var rsn = document.querySelector("#cslRsn");
var cslScd = document.querySelector("#cslStCmcd"); 

//console.log("상담 구분 >>>>>>>>> ${detailNo.cslFdCmcd}");

let fdCmcd = "";

if("${detailNo.cslFdCmcd}" == "학업"){
	fdCmcd = "cslField1";
}else if("${detailNo.cslFdCmcd}" == "취업"){
	fdCmcd = "cslField2";
}else if("${detailNo.cslFdCmcd}" == "기타"){
	fdCmcd = "cslField3";
}else if("${detailNo.cslFdCmcd}" == "신규"){
	fdCmcd = "cslField4";
}

let c_sub = "";

if("${detailNo.cslrgSub}" == "편집디자인"){
	c_sub = "sub01";
}else if("${detailNo.cslrgSub}" == "웹디자인"){
	c_sub = "sub02";
}else if("${detailNo.cslrgSub}" == "영상편집"){
	c_sub = "sub03";
}else if("${detailNo.cslrgSub}" == "프로그래밍"){
	c_sub = "sub04";
}else {
	c_sub = '${detailNo.cslrgSub}';
}
//console.log("fdCmcd >>>>>>>>> " + fdCmcd);
 
//seletBox 값 가져오기
$("#cslTime").val("${detailNo.cslrgRsvTm}").prop("selected", true);
$("#cslDis").val(fdCmcd).prop("selected", true);
$("#CslrgSub").val(c_sub).prop("selected", true);



//수정버튼 클릭
function f_test1(){

	let f_date = document.querySelector("#cslDate");
  	let f_time = document.querySelector("#cslTime");

	
//	console.log("수정버튼 생성");
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

	if (!stCmcd) {
		stCmcdValue = '';
	}else {
		if(stCmcd.value == '신청중'){
			stCmcdValue = 'cslProcess1';
		}else if(stCmcd.value == '신청완료'){
			stCmcdValue = 'cslProcess2';			
		}else if(stCmcd.value == '상담진행중'){
			stCmcdValue = 'cslProcess3';			
		}else{
			stCmcdValue = 'cslProcess4';			
		}
	}
	
	if (!rsn) {
		stRsnValue = '';
	}else {
		stRsnValue = rsn.value;	
	}
	
	
 	let cslrgData = {
 	 		stuId : stuId.value,
 			cslrgNo : no.value,
 	 		cslrgRsvDt: date.value ,
 	 		cslrgRsvTm: time.value,
 	 		cslFdCmcd: dis.value,
 	 		cslrgCnt : cnt.value,
 	 		empId : emp.value,
 	 		cslStCmcd : stCmcdValue,
 	 		cslrgRsn: stRsnValue
 	} 	
  	Swal.fire({
  	   title: '상담신청 수정',
  	   text: '수정내용이 반영됩니다.',
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
  	   		if(memberGuvun=='01'){
  	   			console.log("학생이다?",memberGuvun)
  				xhr.open("post", "${pageContext.request.contextPath}/cslrg/updateCslrg", true);
  	   		}  	   
  	   		if(memberGuvun=='02'){
  	   			console.log("직장인?",memberGuvun)
  				xhr.open("post", "${pageContext.request.contextPath}/cslrcd/updateDetailCslrcd", true);
  	 		}
  	   
  			xhr.onreadystatechange = function(){	
  				if(xhr.readyState ==4 && xhr.status==200){
  					console.log(xhr.responseText);
  					Swal.fire('상담신청이 수정되었습니다.').then(result=>{  
  						if(memberGuvun=='01'){  							
		  			 		location.replace('${pageContext.request.contextPath}/cslrg/cslList');  				
		  			 		return
  						}
  						if(memberGuvun=='02'){  							
		  			 		location.replace('${pageContext.request.contextPath}/cslrcd/cslrcdList');  				
		  			 		return
  						}
  				});
  			}
  		}	
  		xhr.setRequestHeader(tokenHeader, tokenValue);
  		xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
  		xhr.send(JSON.stringify(cslrgData));  	      
  	   }
  	});
}
 	

//삭제버튼 클릭
const f_delete = () =>{	
	
	console.log("삭제버튼 클릭");
	
	//일정 삭제 확인 요청  	
	Swal.fire({
	   title: '상담신청  삭제',
	   text: '상담신청이 진짜 삭제됩니다. 진짜 삭제되시나요?',
	   icon: 'warning',
	   
	   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
	   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
	   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
	   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
	   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
	   
	   reverseButtons: false, // 버튼 순서 거꾸로
	   
	}).then(result => {
	   // 만약 Promise리턴을 받으면,
	   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면

			let xhr = new XMLHttpRequest(); 	
			xhr.open("post", "${pageContext.request.contextPath}/cslrg/deleteCslrgSchd", true);
			xhr.onreadystatechange = function(){		
				if(xhr.readyState ==4 && xhr.status==200){
					Swal.fire('상담신청이 삭제되었습니다').then(result=>{
						if(memberGuvun=='01'){  							
							location.replace('${pageContext.request.contextPath}/cslrg/cslList');				
		  			 		return
  						}
  						if(memberGuvun=='02'){  							
		  			 		location.replace('${pageContext.request.contextPath}/cslrcd/cslrcdList');  				
		  			 		return
  						}						
					});
				}
			}	
			xhr.setRequestHeader(tokenHeader, tokenValue);
			xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xhr.send("cslrgNo=${detailNo.cslrgNo}");
	
	   }
	});
}

//상담결과 입력버튼 이벤트
const clrgRslt = () => {
	$("#exampleModalCenter").modal('show');	
}

//상담결과 입력
const resultCnt = ()=>{
	
	console.log("상담입력 작성 버튼 클릭");	
 
	let cslrgCnt = {
		cslrgNo : no.value,
 	 	cslrgRsn: resultRsn.value 	 	
 	}
	console.log(cslrgCnt);
	let xhr = new XMLHttpRequest();
	xhr.open("post", "${pageContext.request.contextPath}/cslrcd/cslrgResultCnt", true);
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status==200){
			Swal.fire('상담이 입력되었습니다.','','success').then(result=>{
				location.replace('${pageContext.request.contextPath}/cslrcd/cslrcdSub');								
			});
		}
	}
	xhr.setRequestHeader(tokenHeader, tokenValue);
  	xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); 	
	xhr.send(JSON.stringify(cslrgCnt)); 	
		
}


//상담결과내용 수정
const resultUp = ()=>{
	
	console.log("상담입력 작성 버튼 클릭");	
 
	let cslrgCnt = {
		cslrgNo : no.value,
 	 	cslrgRsn: resultRsn.value 	 	
 	}
	console.log(cslrgCnt);
	let xhr = new XMLHttpRequest();
	xhr.open("post", "${pageContext.request.contextPath}/cslrcd/cslrgResultCnt", true);
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status==200){
			Swal.fire('상담이 수정되었습니다.','','success').then(result=>{
				location.replace('${CONTEXT_PATH}/cslrg/detail?cslrgNo=${detailNo.cslrgNo}');								
			});
		}
	}
	xhr.setRequestHeader(tokenHeader, tokenValue);
  	xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8'); 	
	xhr.send(JSON.stringify(cslrgCnt)); 	
		
}



//상담목록에서 detail 확인 할때 상담시간 가져오기 위한 설정
window.onload = function(){	
	cslrgChange();
}

//일정 변경시, 시간체크
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


//사아드바 돌리장
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
