<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    <style>
    .pagination {
    	justify-content: center;
    }
    </style>
          <div class="container-fluid">
            <div class="page-header">
              <div class="row">
                <div class="col-sm-6">
                  <h3>교직원 리스트</h3>
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">홈</a></li>
                    <li class="breadcrumb-item">회원관리</li>
                    <li class="breadcrumb-item">교원 및 직원 정보관리</li>
                  </ol>
                </div>
                <div class="col-sm-6">
                  <!-- Bookmark Start-->
                </div>
              </div>
            </div>
          </div>
          <!-- Container-fluid starts-->
          <div class="container-fluid list-products">
              <!-- Individual column searching (text inputs) Starts-->
		<div class="container-fluid">
            <div class="row">
              <div class="col-sm-12">
                <div class="card">
                <br>
            <div class="row" style="padding: 20px;">
            <form action="${pageContext.request.contextPath}/employee/list" method="get" id="searchEmployee">
            <div class="input-group mb-3">
			<span>
            <select class="form-select" aria-label="Default select example" id="searchType">
			  <option value="0" selected="selected">검색 분류</option>
			  <option value="name">이름</option>
			  <option value="phNo">전화번호</option>
			</select>
			</span>
			  <input type="text" class="form-control" id="searchText" placeholder="이름 또는 전화번호를 입력하세요." aria-label="Recipient's username" aria-describedby="button-addon2">
			  <button class="btn btn-primary" type="submit" id="button-addon2">검색</button>
			</div>
			</form>
			</div>
                <br>
                <br>
                  <div class="table-responsive">
                    <table class="table" style="text-align: center;">
                      <thead>
                          <tr>
                            <th>교직원번호</th>
                            <th>이름</th>
                            <th>전화번호</th>
                            <th>직급</th>
                            <th>내용</th>
                          </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="employee" items="${employeeList}" varStatus="status">
                        	<c:if test="${employee.empPosiNm == 'POSI01'}">
                        <c:set var="empPosiNm" value="사장"/>
                        	</c:if>
                        	<c:if test="${employee.empPosiNm == 'POSI02'}">
                        <c:set var="empPosiNm" value="부장"/>
                        	</c:if>
                        	<c:if test="${employee.empPosiNm == 'POSI03'}">
                        <c:set var="empPosiNm" value="차장"/>
                        	</c:if>
                        	<c:if test="${employee.empPosiNm == 'POSI04'}">
                        <c:set var="empPosiNm" value="과장"/>
                        	</c:if>
                        	<c:if test="${employee.empPosiNm == 'POSI05'}">
                        <c:set var="empPosiNm" value="대리"/>
                        	</c:if>
                        	<c:if test="${employee.empPosiNm == 'POSI06'}">
                        <c:set var="empPosiNm" value="사원"/>
                        	</c:if>
                       	<c:if test="${employee.empDepNm == 'EDU' }">
							<c:set var="empDepNm" value="교육부서"/>
		                  </c:if>
		                  <c:if test="${employee.empDepNm == 'BUS' }">
							<c:set var="empDepNm" value="경영부서"/>
		                  </c:if>
		                  <c:if test="${employee.empDepNm == 'MAN' }">
							<c:set var="empDepNm" value="관리부서"/>
		                  </c:if>
                        	<tr>
                        		<td>${employee.empId}</td>
                        		<td>${employee.empNm}</td>
                        		<td>${employee.empPhNo}</td>
                        		<td>${empPosiNm}</td>
                        		<td>
<%--                               	<button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalLong${status.index }">상세</button> --%>
			               		<button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalLong${status.index}">상세</button>
			               		</td>
            		       	</tr>
                			<div class="modal fade" id="exampleModalLong${status.index }" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
	                      	<div class="modal-dialog" role="document">
	                        <div class="modal-content">
                         	 <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">${employee.empNm }님 상세정보</h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <form action="${pageContext.request.contextPath }/employee/updateEmpInfo" method="post" id="updateForm">
                          <sec:csrfInput/>
                          <div class="modal-body">
                          <div class="form-group">
                              <label>이름</label>
				                  <div class="small-group">
				                    <div class="input-group"><span class="input-group-text"><i class="icon-user"></i></span>
				                      <input class="form-control" type="text" value="${employee.empNm }" name="empNm" disabled placeholder="name" id="i_empNm">
				                    </div>
				                  </div>
                            </div>
                          <div class="form-group">
                              <label>주민번호</label>
				                  <div class="small-group">
				                    <div class="input-group"><span class="input-group-text"><i class="icon-user"></i></span>
				                      <input class="form-control" type="text" value="${employee.empRrn }" name="empRrn" readonly placeholder="name">
				                    </div>
				                  </div>
                            </div>
                          <div class="form-group">
                              <label>전화번호</label>
				                  <div class="small-group">
				                    <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-mobile-screen"></i></span>
				                      <input class="form-control" type="text" value="${employee.empPhNo }" name="empPhNo" disabled placeholder="name" id="i_empPhNo">
				                    </div>
				                  </div>
                            </div>
                            <div class="form-group">
			                  <label>이메일</label>
			                  <div class="input-group"><span class="input-group-text"><i class="icon-email"></i></span>
			                    <input class="form-control" type="email" value="${employee.empEmail }" name="empEmail" disabled placeholder="test@naver.com" id="i_empEmail">
			                  </div>
			                </div>
                            <div class="form-group">
			                  <label>부서</label>
			                  <div class="input-group"><span class="input-group-text"><i class="icofont icofont-briefcase-alt-1"></i></span>
			                    <input class="form-control" type="text" value="${empDepNm }" readonly>
			                  </div>
			                </div>
                            <div class="form-group">
			                  <label>직급</label>
			                  <div class="input-group"><span class="input-group-text"><i class="icofont icofont-businessman"></i></span>
			                    <input class="form-control" type="text" value="${empPosiNm }" readonly>
			                  </div>
			                </div>
		                    <div class="form-group">
			                  <label>우편번호</label>
			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
			                    <input class="form-control" type="text" value="${employee.empPostNo }" name="empPostNo" readonly="readonly" placeholder="우편번호" id="empPostNo">
			                 </div>
			                 </div>
		                    <div class="form-group">
			                  <label>주소</label>
			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
			                    <input class="form-control" type="text" value="${employee.empAddr }" name="empAddr" readonly placeholder="주소" id="empAddr">
			                 </div>
			                 </div>
		                    <div class="form-group">
			                  <label>상세주소</label>
			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
			                    <input class="form-control" type="text" value="${employee.empAddrDtl }" name="empAddrDtl" disabled placeholder="상세주소" id="i_empDtlAddr">
			                 </div>
			                 </div>
                          </div>
                          <input type="hidden" value="${employee.empId }" name="empId">
                          </form>
                          <div class="modal-footer">
                            <button class="btn btn btn-warning" type="button" onclick="updateEmpInfo()" id="updateEmpInfoBtn">수정</button>
                            <button class="btn btn-info" type="button" data-bs-dismiss="modal">닫기</button>
<!--                             <button class="btn btn-primary" type="button" id="submit_btn">수정완료</button> -->
                          </div>
                        </div>
                      </div>
                    </div>
<%--                     <div class="modal fade" id="exampleModalLong${status.index}1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true"> --%>
<%--                     <form action="${pageContext.request.contextPath }/employee/updateInfo" method="post"> --%>
<%--                     <input type="hidden" name="empId" value="${employee.empId }"> --%>
<%--                     <sec:csrfInput/> --%>
<!-- 	                      	<div class="modal-dialog" role="document"> -->
<!-- 	                        <div class="modal-content"> -->
<!--                          	 <div class="modal-header"> -->
<%--                             <h5 class="modal-title" id="exampleModalLongTitle">${employee.empNm }님 상세정보</h5> --%>
<!--                             <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!--                           </div> -->
<!--                           <div class="modal-body"> -->
<!--                           <div class="form-group"> -->
<!--                               <label>이름</label> -->
<!-- 				                  <div class="small-group"> -->
<!-- 				                    <div class="input-group"><span class="input-group-text"><i class="icon-user"></i></span> -->
<%-- 				                      <input class="form-control" type="text" value="${employee.empNm }" placeholder="name" name="empNm" id="empNm"> --%>
<!-- 				                    </div> -->
<!-- 				                  </div> -->
<!--                             </div> -->
<!--                           <div class="form-group"> -->
<!--                               <label>전화번호</label> -->
<!-- 				                  <div class="small-group"> -->
<!-- 				                    <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-mobile-screen"></i></span> -->
<%-- 				                      <input class="form-control" type="text" value="${empdent.empPhNo }" placeholder="name" name="empPhNo" id="empPhNo"> --%>
<!-- 				                    </div> -->
<!-- 				                  </div> -->
<!--                             </div> -->
<!--                             <div class="form-group"> -->
<!-- 			                  <label>이메일</label> -->
<!-- 			                  <div class="input-group"><span class="input-group-text"><i class="icon-email"></i></span> -->
<%-- 			                    <input class="form-control" type="email" value="${employee.empEmail }" placeholder="test@naver.com" name="empEmail" id="empEmail"> --%>
<!-- 			                  </div> -->
<!-- 			                </div> -->
<!-- 		                    <div class="form-group"> -->
<!-- 			                  <label>우편번호</label> -->
<!-- 			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span> -->
<%-- 			                    <input class="form-control" type="text" value="${employee.empPostNo }" onclick="findAddr()"  placeholder="우편번호" id="empPostNo" name="empPostNo"> --%>
<!-- 			                 </div> -->
<!-- 			                 </div> -->
<!-- 		                    <div class="form-group"> -->
<!-- 			                  <label>주소</label> -->
<!-- 			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span> -->
<%-- 			                    <input class="form-control" type="text" value="${employee.empAddr }"onclick="findAddr()" placeholder="주소" id="empAddr" name="empAddr"> --%>
<!-- 			                 </div> -->
<!-- 			                 </div> -->
<!-- 		                    <div class="form-group"> -->
<!-- 			                  <label>상세주소</label> -->
<!-- 			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span> -->
<%-- 			                    <input class="form-control" type="text" value="${employee.empAddrDtl }"  placeholder="상세주소" id="empAddrDtl" name="empAddrDtl"> --%>
<!-- 			                 </div> -->
<!-- 			                 </div> -->
<!--                           </div> -->
<!--                           <div class="modal-footer"> -->
<!--                             <button class="btn btn-primary" type="submit" id="submit_btn">수정완료</button> -->
<!--                             <button class="btn btn-info" type="button" data-bs-dismiss="modal">닫기</button> -->
<!--                           </div> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                       </form> -->
<!--                     </div> -->
                     </c:forEach>
                        </tbody>
                    </table>
                    <br>
                    <br>
                    <br>
                    <div>
                    <form action="${pageContext.request.contextPath}/employee/list" id="id_pageForm">
					<input type="hidden" id="empNm" name="empNm" value="${empNm }">
					<input type="hidden" id="empPhNo" name="empPhNo" value="${empPhNo }">
					<input type="hidden" name="pageNum" value="${pageNum}">
					<input type="hidden" name="pageSize" value="pageSize">
					</form>
                    <c:set var="curPage" value="${pageVO.employeeListPageVO.pageNum}" />
					<c:set var="pageSize" value="${pageVO.employeeListPageVO.pageSize}" />
<%-- 					<p>현재페이지 : ${curPage}</p> --%>
				 	<nav aria-label="...">
                    <ul class="pagination pagination-primary">
					<c:if test="${pageVO.isPrevious() == true}">
				 	<li class="page-item disabled"><a class="page-link" onclick="f_pre()" href="javascript:void(0)" tabindex="-1">이전</a></li>
					</c:if>
					<c:if test="${pageVO.isPrevious() == false}">
					 <li class="page-item"><a class="page-link" onclick="f_pre()" href="javascript:void(0)" tabindex="-1">이전</a></li>
					</c:if>
					<c:forEach var="pageNum" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
					<c:if test="${pageNum == curPage}"> <!-- 사용자가 선택한 페이지와 현재페이지가 같을때 -->
					<li class="page-item active"><a class="page-link" onclick="f_sendPage('${pageNum}', '${pageSize}')" href="javascript:void(0)"><span class="sr-only">(current)</span>${pageNum}</a></li>
					</c:if>
					<c:if test="${pageNum != curPage}"> <!-- 사용자가 선택한 페이지와 현재페이지가 다를때 -->
					<li class="page-item"><a class="page-link" onclick="f_sendPage('${pageNum}', '${pageSize}')" href="javascript:void(0)"><span class="sr-only">(current)</span>${pageNum}</a></li>
					</c:if>
					</c:forEach>
					<c:if test="${pageVO.isNext() == true}">
				  	<li class="page-item"><a class="page-link" onclick="f_next(${pageVO.endPage+1})" href="javascript:void(0)">다음</a></li>	
					</c:if>
					<c:if test="${pageVO.isNext() == false}">
				  	<li class="page-item disabled"><a class="page-link" onclick="f_next(${pageVO.endPage+1})" href="javascript:void(0)">다음</a></li>	
					</c:if>
					</ul>
                    </nav>
					</div>
					<br>
                  </div>
                </div>
              </div>
            </div>
          </div>
           </div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');

const empAddr = document.querySelector("#empAddr");
const empPostNo = document.querySelector("#empPostNo");
function findAddr() {
	 new daum.Postcode({
	    oncomplete: function(data) {
	       console.log(data);
	       empPostNo.value = data.zonecode;
	       empAddr.value = data.roadAddress;
	    }
	 }).open();
	};
const pageForm = document.querySelector("#id_pageForm");
const empNm = document.querySelector("#empNm");
const empPhNo = document.querySelector("#empPhNo");
const f_sendPage = (pageNum, pageSize) => { // 매개변수 담기
	event.preventDefault(); // a태그의 link기능 막기
	// 매개변수 값을 input의 값에 넣어주기
	document.querySelector("input[name=pageNum]").value = pageNum;
	document.querySelector("input[name=pageSize]").value = pageSize;
	pageForm.submit(); // form 전송
}
const f_next = (p_nextPageNum) => {
// 	location.replace("${contextPath}/list?pageNum=" + p_nextPageNum);
	document.querySelector("input[name=pageNum]").value = p_nextPageNum;
  	document.querySelector("input[name=pageSize]").value = '${pageSize}';
	pageForm.submit(); // form 전송
}

const f_pre = () => {
// 	location.replace("${contextPath}/list?pageNum=" + p_nextPageNum);
	document.querySelector("input[name=pageNum]").value = '${pageVO.startPage -1}';
	document.querySelector("input[name=pageSize]").value = '${pageSize}';
	pageForm.submit(); // form 전송
} 

const searchBtn = document.querySelector("#button-addon2");
const searchType = document.querySelector("#searchType");
var searchText = document.querySelector("#searchText");
const searchEmployee = document.querySelector("#searchEmployee");
const searchContent = () => {
	event.preventDefault();
	console.log(searchType.value);
	if(searchType.value == "0") {
// 		alert("검색분류를 선택하세요 !");
		 Swal.fire({
	      title: '검색 실패 !',
	      text: '검색분류를 선택하세요 !',
	      icon: 'warning',
    });
		return;
	} else if(searchType.value == "name") {
		searchText.name = "empNm";
// 		alert(searchText.name);
		empNm.value = searchText.value;
	} else {
		searchText.name = "empPhNo";
// 		alert(searchText.name);
		empPhNo.value = searchText.value;
	}
// 	alert(searchText.value);
	searchEmployee.submit();
}
searchBtn.addEventListener("click", searchContent);

const updateEmpInfo = () => {
	$("#i_empNm").attr("disabled", false);
	$("#i_empPhNo").attr("disabled", false);
	$("#i_empEmail").attr("disabled", false);
	$("#i_empDtlAddr").attr("disabled", false);
	document.querySelector("#empPostNo").addEventListener("click", findAddr);
	document.querySelector("#empAddr").addEventListener("click", findAddr);
	document.querySelector("#updateEmpInfoBtn").innerText = "수정완료";
	document.querySelector("#updateEmpInfoBtn").id = "updateEmpInfoBtn2";
	document.querySelector("#updateEmpInfoBtn2").addEventListener("click", updateFormSubmit);
}

const updateForm = document.querySelector("#updateForm");
const updateFormSubmit = () => {
	Swal.fire({
	      title: '정보를 변경하시겠습니까 ?',
	      text: "입력한 회원 정보를 변경하시겠습니까 ?",
	      icon: 'warning',
	      showCancelButton: true,
	      confirmButtonColor: '#3085d6',
	      cancelButtonColor: '#d33',
	      confirmButtonText: '확인',
	      cancelButtonText: '취소',
	      reverseButtons: false, // 버튼 순서 거꾸로
	      
	    }).then((result) => {
	      if (result.isConfirmed) {
	        Swal.fire(
	          '변경완료',
	          '변경이 완료되었습니다.',
	          'success'
	        )
	      updateForm.submit();
	      }
	    })
}
</script>
<!-- latest jquery-->

