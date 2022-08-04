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
                  <h3>학생 리스트</h3>
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">홈</a></li>
                    <li class="breadcrumb-item">회원관리</li>
                    <li class="breadcrumb-item">학생 정보관리</li>
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
            <div class="row">
            <form action="${pageContext.request.contextPath}/student/list" id="searchStudent" method="get">
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
                  <div class="table-responsive">
                    <table class="table" style="text-align: center;">
                        <thead>
                          <tr>
                            <th>회원번호</th>
                            <th>이름</th>
                            <th>전화번호</th>
                            <th>희망분야</th>
                            <th>내용</th>
                          </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="student" items="${studentList}" varStatus="status">
                        	<tr>
                        		<td>${student.stuId}</td>
                        		<td>${student.stuNm}</td>
                        		<td>${student.stuPhNo}</td>
                        		<td>${student.stuIntFd}</td>
                        		<td>
                              	<button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalLong${status.index}">상세</button>
<%-- 			               		<button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalLong${status.index}1">수정</button> --%>
			               		</td>
            		       	</tr>
                			<div class="modal fade" id="exampleModalLong${status.index}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
	                      	<div class="modal-dialog" role="document">
	                        <div class="modal-content">
                         	 <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">${student.stuNm }님 상세정보</h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                          <form action="${pageContext.request.contextPath }/student/update" method="post" id="updateForm">
                          <sec:csrfInput/>
                          <div class="form-group">
                              <label>이름</label>
				                  <div class="small-group">
				                    <div class="input-group"><span class="input-group-text"><i class="icon-user"></i></span>
				                      <input class="form-control" type="text" value="${student.stuNm }" disabled placeholder="name" name="stuNm" id="stuNm">
				                    </div>
				                  </div>
                            </div>
                          <div class="form-group">
                              <label>전화번호</label>
				                  <div class="small-group">
				                    <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-mobile-screen"></i></span>
				                      <input class="form-control" type="text" value="${student.stuPhNo }" disabled placeholder="name" name="stuPhNo" id="stuPhNo">
				                    </div>
				                  </div>
                            </div>
                            <div class="form-group">
			                  <label>이메일</label>
			                  <div class="input-group"><span class="input-group-text"><i class="icon-email"></i></span>
			                    <input class="form-control" type="email" value="${student.stuEmail }" disabled placeholder="test@naver.com" name="stuEmail" id="stuEmail">
			                  </div>
			                </div>
		                    <div class="form-group">
			                  <label>우편번호</label>
			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
			                    <input class="form-control" type="text" value="${student.stuPostNo }" readonly placeholder="우편번호" id="stuPostNo" name="stuPostNo">
			                 </div>
			                 </div>
		                    <div class="form-group">
			                  <label>주소</label>
			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
			                    <input class="form-control" type="text" value="${student.stuAddr }" readonly placeholder="주소" id="stuAddr" name="stuAddr">
			                 </div>
			                 </div>
		                    <div class="form-group">
			                  <label>상세주소</label>
			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
			                    <input class="form-control" type="text" value="${student.stuAddrDtl }" disabled placeholder="상세주소" id="stuAddrDtl" name="stuAddrDtl">
			                 </div> 
			                 </div>
			                 <input type="hidden" value="${student.stuId }" name="stuId">
	                         </form>
                          </div>
                          <div class="modal-footer">
                            <button class="btn btn-warning" type="button" onclick="updateStuInfo()" id="updateStuInfoBtn">수정</button>
                            <button class="btn btn-info" type="button" data-bs-dismiss="modal">닫기</button>
                          </div>
                        </div>
                      </div>
                    </div>
<%--                     <div class="modal fade" id="exampleModalLong${status.index}1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true"> --%>
<%--                     <form action="${pageContext.request.contextPath }/student/update" method="post"> --%>
<%--                     <input type="hidden" name="stuId" value="${student.stuId }"> --%>
<%--                     <sec:csrfInput/> --%>
<!-- 	                      	<div class="modal-dialog" role="document"> -->
<!-- 	                        <div class="modal-content"> -->
<!--                          	 <div class="modal-header"> -->
<%--                             <h5 class="modal-title" id="exampleModalLongTitle">${student.stuNm }님 상세정보</h5> --%>
<!--                             <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!--                           </div> -->
<!--                           <div class="modal-body"> -->
<!--                           <div class="form-group"> -->
<!--                               <label>이름</label> -->
<!-- 				                  <div class="small-group"> -->
<!-- 				                    <div class="input-group"><span class="input-group-text"><i class="icon-user"></i></span> -->
<%-- 				                      <input class="form-control" type="text" value="${student.stuNm }" placeholder="name" name="stuNm" id="stuNm"> --%>
<!-- 				                    </div> -->
<!-- 				                  </div> -->
<!--                             </div> -->
<!--                           <div class="form-group"> -->
<!--                               <label>전화번호</label> -->
<!-- 				                  <div class="small-group"> -->
<!-- 				                    <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-mobile-screen"></i></span> -->
<%-- 				                      <input class="form-control" type="text" value="${student.stuPhNo }" placeholder="name" name="stuPhNo" id="stuPhNo"> --%>
<!-- 				                    </div> -->
<!-- 				                  </div> -->
<!--                             </div> -->
<!--                             <div class="form-group"> -->
<!-- 			                  <label>이메일</label> -->
<!-- 			                  <div class="input-group"><span class="input-group-text"><i class="icon-email"></i></span> -->
<%-- 			                    <input class="form-control" type="email" value="${student.stuEmail }"placeholder="test@naver.com" name="stuEmail" id="stuEmail"> --%>
<!-- 			                  </div> -->
<!-- 			                </div> -->
<!-- 		                    <div class="form-group"> -->
<!-- 			                  <label>우편번호</label> -->
<!-- 			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span> -->
<%-- 			                    <input class="form-control" type="text" value="${student.stuPostNo }" placeholder="우편번호" onclick="findAddr()" id="stuPostNo" name="stuPostNo"> --%>
<!-- 			                 </div> -->
<!-- 			                 </div> -->
<!-- 		                    <div class="form-group"> -->
<!-- 			                  <label>주소</label> -->
<!-- 			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span> -->
<%-- 			                    <input class="form-control" type="text" value="${student.stuAddr }" onclick="findAddr()" placeholder="주소" id="stuAddr" name="stuAddr"> --%>
<!-- 			                 </div> -->
<!-- 			                 </div> -->
<!-- 		                    <div class="form-group"> -->
<!-- 			                  <label>상세주소</label> -->
<!-- 			                  <div class="input-group"><span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span> -->
<%-- 			                    <input class="form-control" type="text" value="${student.stuAddrDtl }"  placeholder="상세주소" id="stuAddrDtl" name="stuAddrDtl"> --%>
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
                    <form action="${pageContext.request.contextPath}/student/list" id="id_pageForm">
                    <input type="hidden" id="stuNm" name="stuNm" value="${stuNm }">
                    <input type="hidden" id="stuPhNo" name="stuPhNo" value="${stuPhNo }">
					<input type="hidden" name="pageNum" value="${pageNum}">
					<input type="hidden" name="pageSize" value="pageSize">
					</form>
                    <c:set var="curPage" value="${pageVO.studentListPageVO.pageNum}" />
					<c:set var="pageSize" value="${pageVO.studentListPageVO.pageSize}" />
					<nav aria-label="...">
                    <ul class="pagination pagination-primary">
					<c:if test="${pageVO.isPrevious() == true}">
					 <li class="page-item"><a class="page-link" onclick="f_pre()" href="javascript:void(0)" tabindex="-1">이전</a></li>
					</c:if>
					<c:if test="${pageVO.isPrevious() == false}">
				 	<li class="page-item disabled"><a class="page-link" onclick="f_pre()" href="javascript:void(0)" tabindex="-1">이전</a></li>
					</c:if>
					<c:forEach var="pageNum" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
					<c:if test="${pageNum == curPage}"> <!-- 사용자가 선택한 페이지와 현재페이지가 같을때 -->
					<li class="page-item active"><a class="page-link" onclick="f_sendPage('${pageNum}', '${pageSize}')" href="javascript:void(0)">${pageNum}</a></li>
					</c:if>
					<c:if test="${pageNum != curPage}"> <!-- 사용자가 선택한 페이지와 현재페이지가 다를때 -->
					<li class="page-item"><a class="page-link" onclick="f_sendPage('${pageNum}', '${pageSize}')" href="javascript:void(0)">${pageNum}</a></li>
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
<script>
const stuAddr = document.querySelector("#stuAddr");
const stuPostNo = document.querySelector("#stuPostNo");

function findAddr() {
	 new daum.Postcode({
	    oncomplete: function(data) {
	       console.log(data);
	       stuPostNo.value = data.zonecode;
	       stuAddr.value = data.roadAddress;
	    }
	 }).open();
	};
const pageForm = document.querySelector("#id_pageForm");
const stuNm = document.querySelector("#stuNm");
const stuPhNo = document.querySelector("#stuPhNo");
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
const searchStudent = document.querySelector("#searchStudent");

const searchContent = () => {
	event.preventDefault();
	console.log(searchType.value);
	if(searchType.value == "0") {
		 Swal.fire({
		      title: '검색 실패 !',
		      text: '검색분류를 선택하세요 !',
		      icon: 'warning',
	    });
		return;
	} else if(searchType.value == "name") {
		searchText.name = "stuNm";
// 		alert(searchText.name);
		stuNm.value = searchText.value;
	} else {
		searchText.name = "stuPhNo";
// 		alert(searchText.name);
		stuPhNo.value = searchText.value;
	}
// 	alert(searchText.value);
	searchStudent.submit();
}
searchBtn.addEventListener("click", searchContent);

const submit_btn = document.querySelector("#submit_btn");

const updateStuInfo = () => {
	$("#stuNm").attr("disabled", false);
	$("#stuPhNo").attr("disabled", false);
	$("#stuEmail").attr("disabled", false);
	$("#stuAddrDtl").attr("disabled", false);
	document.querySelector("#stuPostNo").addEventListener("click", findAddr);
	document.querySelector("#stuAddr").addEventListener("click", findAddr);
	document.querySelector("#updateStuInfoBtn").innerText = "수정완료";
	document.querySelector("#updateStuInfoBtn").id = "updateStuInfoBtn2";
	document.querySelector("#updateStuInfoBtn2").addEventListener("click", updateFormSubmit);
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
