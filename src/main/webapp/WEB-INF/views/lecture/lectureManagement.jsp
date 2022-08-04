<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
			<br>
				<h3>전체강의관리</h3>
					<ol class="breadcrumb" style="text-align: center;">
                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">홈</a></li>
                    <li class="breadcrumb-item">강의</li>
                    <li class="breadcrumb-item">전체강의관리</li>
                  </ol>
			</div>
			<div class="col-sm-6">
			</div>
		</div>
	</div>
</div>
  <div class="col-sm-12">
                <div class="card">
                  <div class="card-header">
                    <div class="col-md-4 mb-3" style="float: right;">
                    <div class="input-group">
                    <input class="form-control" type="text" name="cursNm" id="searchCursNm" placeholder="강의명을 입력하세요.">
                    <button class="btn btn-secondary" onclick="searchLecture(this)" value="${pageNum }">검색</button>
                  	</div>
                    </div>
                  </div>
                  <div class="table-responsive">
                    <table class="table" style="text-align: center;">
                      <thead>
                        <tr>
                          <th scope="col">선택</th>
                          <th scope="col">순번</th>
                          <th scope="col">과목</th>
                          <th scope="col">강의명</th>
                          <th scope="col">강사명</th>
                          <th scope="col">강의시작일</th>
                          <th scope="col">강의종료일</th>
                          <th scope="col">강의가격</th>
                        </tr>
                      </thead>
                      <tbody id="cursList">
                      <!-- foreach start -->
                      <c:forEach var="lecture" items="${lectureList }" varStatus="status">
                        <tr>
                          <th scope="row"><input class="checkbox_animated" type="checkbox" onclick="lectureInfo(this)" value="${lecture.cursNo }" id="cursNo" name="cursNo"></th>
                          <td>${lecture.cursNo }</td>
                          <td>${lecture.subNm }</td>
                          <td>${lecture.cursNm }</td>
                          <td>${lecture.empNm }</td>
                          <td><fmt:formatDate value="${lecture.cursSttDt}" type="date" pattern="yyyy-MM-dd" /></td>
                          <td><fmt:formatDate value="${lecture.cursEndDt}" type="date" pattern="yyyy-MM-dd" /></td>
                          <td><fmt:formatNumber value="${lecture.cursSuPri }" pattern="#,###"/></td>
                        </tr>
                        </c:forEach>
                        <!-- foreach end -->
                      </tbody>
                    </table>
                    <br>
<!--                      <div class="card-body"> -->
<!--                     <nav aria-label="..."> -->
<!--                       <ul class="pagination pagination-primary"> -->
<!--                         <li class="page-item disabled"><a class="page-link" href="javascript:void(0)" tabindex="-1">Previous</a></li> -->
<!--                         <li class="page-item"><a class="page-link" href="javascript:void(0)">1</a></li> -->
<!--                         <li class="page-item active"><a class="page-link" href="javascript:void(0)">2 <span class="sr-only">(current)</span></a></li> -->
<!--                         <li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li> -->
<!--                         <li class="page-item"><a class="page-link" href="javascript:void(0)">Next</a></li> -->
<!--                       </ul> -->
<!--                     </nav> -->
<!--                   </div> -->
                  <div class="card-body" id="pageDiv">
                    <input type="hidden" id="hiddenCurPage">
					<input type="hidden" name="pageNum" value="${pageNum}">
					<input type="hidden" name="pageSize" value="pageSize">
                    <nav aria-label="...">
                      <ul class="pagination pagination-primary">
                    <c:set var="curPage" value="${pageVO.lectureListPageCountVO.pageNum}" />
					<c:set var="pageSize" value="${pageVO.lectureListPageCountVO.pageSize}" />
					<c:if test="${pageVO.isPrevious() == true}">
					<li class="page-item"><a class="page-link" onclick="f_pre()" href="javascript:void(0)" tabindex="-1">이전</a></li>
					</c:if>
					<c:if test="${pageVO.isPrevious() == false}">
					<li class="page-item disabled"><a class="page-link" href="javascript:void(0)" tabindex="-1">이전</a></li>
					</c:if>
					<c:forEach var="pageNum" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
					<c:if test="${pageNum == curPage}"> <!-- 사용자가 선택한 페이지와 현재페이지가 같을때 -->
					<li class="page-item"><a class="page-link" href="#" onclick="f_sendPage('${pageNum}', '${pageSize}', this)">${pageNum}</a></li>
					</c:if>
					<c:if test="${pageNum != curPage}"> <!-- 사용자가 선택한 페이지와 현재페이지가 다를때 -->
					<li class="page-item"><a class="page-link" href="#" onclick="f_sendPage('${pageNum}', '${pageSize}', this)">${pageNum}</a></li>
					</c:if>
					</c:forEach>
					<c:if test="${pageVO.isNext() == true}">
					 <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="f_next(${pageVO.endPage+1})">다음</a></li>
					</c:if>
					<c:if test="${pageVO.isNext() == false}">
					 <li class="page-item disabled"><a class="page-link" href="javascript:void(0)" onclick="f_next(${pageVO.endPage+1})">다음</a></li>
					</c:if>
					</ul>
                    </nav>
                  </div>
                  </div>
                </div>
              </div>
 				<div class="card">
                  <div class="card-header pb-0">
                    <h5>강의 상세정보</h5>
                  </div>
                  <div class="card-body">
                      <div class="col">
                    <div class="row">
                          <div class="col-3 mb-3">
                            <label class="form-label">과목명</label>
                            <div class="input-group">
                              <input class="form-control" type="text" readonly id="lec_subNm">
                            </div>
                            </div>
                          </div>
                      </div>
                      <div class="row">
                          <div class="col-3 mb-3">
                            <label class="form-label">강의명</label>
                            <div class="input-group">
                              <input class="form-control" type="text" readonly id="lec_cursNm">
                            </div>
                              </div>
                              <div class="col-3 mb-3">
                              <label class="form-label">강사명</label>
                              <div class="input-group">
                              <input class="form-control" type="text" readonly id="lec_empNm">
                              </div>
                          </div>
                              <div class="col-3 mb-3">
                              <label class="form-label">강의가격</label>
                              <div class="input-group">
                              <input class="form-control" type="text" readonly id="lec_cursPri">
                              </div>
                          </div>
                      </div>
                      <div class="row">
                          <div class="col-4 mb-3">
                            <label class="form-label">강의시작일</label>
                            <div class="input-group">
                              <input class="form-control" type="text" readonly id="lec_sttDt">
                            </div>
                              </div>
                              <div class="col-4 mb-3">
                              <label class="form-label">강의종료일</label>
                              <div class="input-group">
                              <input class="form-control" type="text" readonly id="lec_endDt">
                              </div>
                          </div>
                      </div>
                      <div class="row">
                          <div class="col-12 mb-3">
                            <label class="form-label">강의내용</label>
                            <div class="input-group">
                              <textarea class="form-control" rows="5" cols="50" readonly id="lec_cnt"></textarea>
                            </div>
                          </div>
                      </div>
                    <input type="hidden" id="cursNoList" name="cursNo">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target=".bd-example-modal-lg" id="studentList" onclick="lectureStudentList()">수강중인 수강생</button>
                    <button class="btn btn-info" onclick="refreshSearch()">초기화</button>
                    </div>
                  </div>
                  <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                      <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h4 class="modal-title" id="myLargeModalLabel">수강생 리스트</h4>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                            <div class="input-group mb-3">
                             <input type="text" class="form-control" id="searchText" placeholder="수강생 이름을 검색하세요." aria-label="Recipient's username" aria-describedby="button-addon2">
		  					<button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="searchStudent()">검색</button>
		  					</div>
	  					 <div class="col-sm-12">
                <div class="card">
                  <div class="table-responsive">
                    <table class="table table-sm">
                      <thead>
                        <tr>
                          <th scope="col">#</th>
                          <th scope="col">이름</th>
                          <th scope="col">전화번호</th>
                        </tr>
                      </thead>
                      <tbody id="studenListTbody">
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
<script src="${pageContext.request.contextPath}/assets/js/jquery-3.5.1.min.js"></script>
<script>
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');

const lectureInfo = (p_ckBox) => {
	console.log(p_ckBox);
	console.log(p_ckBox.value);
	
	let cursNos = document.querySelectorAll("#cursNo");
	if(p_ckBox.checked){
		for(let i = 0; i < cursNos.length; i++) {
			$(cursNos[i]).prop("checked", false);
			}
		$(p_ckBox).prop("checked", true);
		} else {
		$(p_ckBox).prop("checked", false);
		}
	
	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
        },
		url : "${pageContext.request.contextPath}/lecture/management/lectureInfo",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNo" : p_ckBox.value}),
		success : function(data) {
			console.log(data);

			document.querySelector("#lec_subNm").value = data.subNm;
			document.querySelector("#lec_cursNm").value = data.cursNm;
			document.querySelector("#lec_empNm").value = data.empNm;
			document.querySelector("#lec_cursPri").value = data.cursSuPri.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			document.querySelector("#lec_sttDt").value = data.cursSttDt;
			document.querySelector("#lec_endDt").value = data.cursEndDt;
			document.querySelector("#lec_cnt").value = data.curspnCnt.replace(/<br>/g, "");
			
			document.querySelector("#cursNoList").value = data.cursNo;
		},
		error : function(error) {
			console.log(error);
		},
		dateType : 'json'
	});
};

const studentList = document.querySelector("#studentList");

const lectureStudentList = () => {
	
	let cursNos = document.querySelectorAll("#cursNo");

	let cursNo = document.querySelector("#cursNoList").value;
	document.querySelector("#searchText").value = "";
		
	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
     	},
		url : "${pageContext.request.contextPath}/lecture/management/studentList",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNo" : cursNo}),
		success : function(data) {
			console.log(data);
			let studentBody = "";
			for(let i = 1; i <= data.length; i++) {
				studentBody += "<tr>";
				studentBody += "<th scope='row'>" + i + "</th>";
				studentBody += "<td>" + data[i-1].stuNm + "</td>"
				studentBody += "<td>" + data[i-1].stuPhNo + "</td>"
				studentBody += "</tr>";
			}
            document.querySelector("#studenListTbody").innerHTML = studentBody;
		},
		error : function(xhr) {
		},
		dataType : "json"
	});
};

const searchStudent = () => {
	console.log("click");
	let cursNo = document.querySelector("#cursNoList").value;
	console.log("cursNo" + cursNo);
	let stuNm = document.querySelector("#searchText").value;
	console.log("stuNm" + stuNm);
	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
     	},
		url : "${pageContext.request.contextPath}/lecture/management/searchStudent",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNo" : cursNo,
								"stuNm" : stuNm}),
		success : function(data) {
			console.log(data);
			let studentBody = "";
			for(let i = 1; i <= data.length; i++) {
				studentBody += "<tr>";
				studentBody += "<th scope='row'>" + i + "</th>";
				studentBody += "<td>" + data[i-1].stuNm + "</td>"
				studentBody += "<td>" + data[i-1].stuPhNo + "</td>"
				studentBody += "</tr>";
			}
            document.querySelector("#studenListTbody").innerHTML = studentBody;
		},
		error : function(xhr) {
		},
		dataType : "json"
	});
};

const refreshSearch = () => {
	let cursNos = document.querySelectorAll("#cursNo");
	for(let i = 0; i < cursNos.length; i++) {
		$(cursNos[i]).prop("checked", false);
	}
	
	document.querySelector("#lec_subNm").value = "";
	document.querySelector("#lec_cursNm").value = "";
	document.querySelector("#lec_empNm").value = "";
	document.querySelector("#lec_cursPri").value = "";
	document.querySelector("#lec_sttDt").value = "";
	document.querySelector("#lec_endDt").value = "";
	document.querySelector("#lec_cnt").value = "";
	document.querySelector("#cursNoList").value = "";
	document.querySelector("#searchCursNm").value = "";
	document.querySelector("#cursList").innerHTML =
		`<c:forEach var="lecture" items="${lectureList }" varStatus="status">
         <tr>
         <th scope="row"><input class="checkbox_animated" type="checkbox" onclick="lectureInfo(this)" value="${lecture.cursNo }" id="cursNo" name="cursNo"></th>
         <td>${lecture.cursNo }</td>
         <td>${lecture.subNm }</td>
         <td>${lecture.cursNm }</td>
         <td>${lecture.empNm }</td>
         <td><fmt:formatDate value="${lecture.cursSttDt}" type="date" pattern="yyyy-MM-dd" /></td>
         <td><fmt:formatDate value="${lecture.cursEndDt}" type="date" pattern="yyyy-MM-dd" /></td>
         <td>${lecture.cursSuPri }</td>
         </tr>
      	 </c:forEach>`;
	document.querySelector("#pageDiv").innerHTML = 
		` <input type="hidden" id="hiddenCurPage">
					<input type="hidden" name="pageNum" value="${pageNum}">
					<input type="hidden" name="pageSize" value="pageSize">
                    <nav aria-label="...">
                      <ul class="pagination pagination-primary">
                    <c:set var="curPage" value="${pageVO.lectureListPageCountVO.pageNum}" />
					<c:set var="pageSize" value="${pageVO.lectureListPageCountVO.pageSize}" />
					<c:if test="${pageVO.isPrevious() == true}">
					<li class="page-item"><a class="page-link" onclick="f_pre()" href="javascript:void(0)" tabindex="-1">이전</a></li>
					</c:if>
					<c:if test="${pageVO.isPrevious() == false}">
					<li class="page-item disabled"><a class="page-link" href="javascript:void(0)" tabindex="-1">이전</a></li>
					</c:if>
					<c:forEach var="pageNum" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
					<c:if test="${pageNum == curPage}"> <!-- 사용자가 선택한 페이지와 현재페이지가 같을때 -->
					<li class="page-item active"><a class="page-link" href="#" onclick="f_sendPage('${pageNum}', '${pageSize}', this)">${pageNum}</a></li>
					</c:if>
					<c:if test="${pageNum != curPage}"> <!-- 사용자가 선택한 페이지와 현재페이지가 다를때 -->
					<li class="page-item"><a class="page-link" href="#" onclick="f_sendPage('${pageNum}', '${pageSize}', this)">${pageNum}</a></li>
					</c:if>
					</c:forEach>
					<c:if test="${pageVO.isNext() == true}">
					 <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="f_next(${pageVO.endPage+1})">다음</a></li>
					</c:if>
					<c:if test="${pageVO.isNext() == false}">
					 <li class="page-item disabled"><a class="page-link" href="javascript:void(0)" onclick="f_next(${pageVO.endPage+1})">다음</a></li>
					</c:if>
					</ul>
                    </nav>`; 
}


const searchLecture = (thisPage) => {
	let cursNm = document.querySelector("#searchCursNm").value;
	if(cursNm == "") {
		Swal.fire({
		      title: '검색 실패 !',
		      text: '강의명을 입력하세요 !',
		      icon: 'warning',
	    });
		return;
	}
	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
     	},
		url : "${pageContext.request.contextPath}/lecture/management/searchLecture",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNm" : cursNm}),
		success : function(data) {
			console.log(data);
			document.querySelector("#cursList").innerHTML = "";
			document.querySelector("#pageDiv").innerHTML = "";
			let studentBody = "";
			let pageDivBody = "";
			for(let i = 0; i < data.lectureList.length; i++) {
				studentBody += "<tr>"
				studentBody += "<th scope='row'><input class='checkbox_animated' type='checkbox' onclick='lectureInfo(this)' value=" + data.lectureList[i].cursNo + " id='cursNo' name='cursNo'></th>";
                studentBody += "<td>" + data.lectureList[i].cursNo + "</td>";
                studentBody += "<td>" + data.lectureList[i].subNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].empNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursSttDt + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursEndDt + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursSuPri.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","); + "</td>";
              	studentBody += "</tr>";
			}
			pageDivBody += "<input type='hidden' id='hiddenCurPage'>";
          	pageDivBody += "<input type='hidden' name='pageNum' value=" + data.pageVO.lectureListPageCountVO.pageNum +  ">";
          	pageDivBody += "<input type='hidden' name='pageSize' value=" + data.pageVO.lectureListPageCountVO.pageSize + ">";
          	pageDivBody += "<nav aria-label='...'>";
          	pageDivBody += " <ul class='pagination pagination-primary'>";
          	if(data.pageVO.next == true) {
          	pageDivBody += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='f_pre(" + (data.pageVO.startPage-1) + ")' tabindex='-1'>이전</a></li>";
          	} else {
       		pageDivBody += "<li class='page-item disabled'><a class='page-link' href='javascript:void(0)' tabindex='-1'>이전</a></li>";
          	}
			for(let i = data.pageVO.startPage; i <= data.pageVO.endPage; i++) {
				if(data.pageVO.lectureListPageCountVO.pageNum == thisPage.innerText) {
					pageDivBody += "<li class='page-item'><a class='page-link' href='#' onclick='f_sendPage(" + data.pageVO.lectureListPageCountVO.pageNum + ", " + data.pageVO.lectureListPageCountVO.pageSize + ", this)'>" + i + "</a></li>";
				} else {
					pageDivBody += "<li class='page-item'><a class='page-link' href='#' onclick='f_sendPage(" + data.pageVO.lectureListPageCountVO.pageNum + ", " + data.pageVO.lectureListPageCountVO.pageSize + ", this)'>" + i + "</a></li>";
				}
			}
			if(data.pageVO.next == true) {
				pageDivBody += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='f_next(" + (data.pageVO.endPage+1) + ")'>다음</a></li>";
			} else {
				pageDivBody += "<li class='page-item disabled'><a class='page-link' href='javascript:void(0)'>다음</a></li>";
			}
			pageDivBody += "</ul>";
			pageDivBody += "</nav>";
			pageDivBody += "</div>";
			
        document.querySelector("#cursList").innerHTML = studentBody;
        document.querySelector("#pageDiv").innerHTML = pageDivBody;
		},
		error : function(xhr) {
		},
		dataType : "json"
	});
}

const pageForm = document.querySelector("#id_pageForm");
// const f_sendPage = (pageNum, pageSize) => { // 매개변수 담기
// 	event.preventDefault(); // a태그의 link기능 막기
// 	// 매개변수 값을 input의 값에 넣어주기
// 	document.querySelector("input[name=pageNum]").value = pageNum;
// 	document.querySelector("input[name=pageSize]").value = pageSize;
// 	pageForm.submit(); // form 전송
// }
const f_next = (p_nextPageNum) => {
// 	location.replace("${contextPath}/list?pageNum=" + p_nextPageNum);
// 	document.querySelector("input[name=pageNum]").value = p_nextPageNum;
//   	document.querySelector("input[name=pageSize]").value = '${pageSize}';
  	let cursNm = document.querySelector("#searchCursNm").value;
  	
  	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
     	},
		url : "${pageContext.request.contextPath}/lecture/management/page",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNm" : cursNm,
								"pageNum" : p_nextPageNum}),
		success : function(data) {
			let thisPage = data.pageVO.lectureListPageCountVO.pageNum; 
			console.log(data);
			document.querySelector("#cursList").innerHTML = "";
			document.querySelector("#pageDiv").innerHTML = "";
			let studentBody = "";
			let pageDivBody = "";
			for(let i = 0; i < data.lectureList.length; i++) {
				studentBody += "<tr>"
				studentBody += "<th scope='row'><input class='checkbox_animated' type='checkbox' onclick='lectureInfo(this)' value=" + data.lectureList[i].cursNo + " id='cursNo' name='cursNo'></th>";
                studentBody += "<td>" + data.lectureList[i].cursNo + "</td>";
                studentBody += "<td>" + data.lectureList[i].subNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].empNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursSttDt + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursEndDt + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursSuPri.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","); + "</td>";
              	studentBody += "</tr>";
			}
			pageDivBody += "<input type='hidden' id='hiddenCurPage'>";
          	pageDivBody += "<input type='hidden' name='pageNum' value=" + data.pageVO.lectureListPageCountVO.pageNum +  ">";
          	pageDivBody += "<input type='hidden' name='pageSize' value=" + data.pageVO.lectureListPageCountVO.pageSize + ">";
          	pageDivBody += "<nav aria-label='...'>";
          	pageDivBody += " <ul class='pagination pagination-primary'>";
          	if(data.pageVO.previous == true) {
          	pageDivBody += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='f_pre()' tabindex='-1'>이전</a></li>";
          	} else {
       		pageDivBody += "<li class='page-item disabled'><a class='page-link' href='javascript:void(0)' tabindex='-1'>이전</a></li>";
          	}
			for(let i = data.pageVO.startPage; i <= data.pageVO.endPage; i++) {
				if(data.pageVO.lectureListPageCountVO.pageNum == thisPage) {
					pageDivBody += "<li class='page-item'><a class='page-link' href='#' onclick='f_sendPage(" + data.pageVO.lectureListPageCountVO.pageNum + ", " + data.pageVO.lectureListPageCountVO.pageSize + ", this)'>" + i + "</a></li>";
				} else {
					pageDivBody += "<li class='page-item'><a class='page-link' href='#' onclick='f_sendPage(" + data.pageVO.lectureListPageCountVO.pageNum + ", " + data.pageVO.lectureListPageCountVO.pageSize + ", this)'>" + i + "</a></li>";
				}
			}
			if(data.pageVO.next == true) {
				pageDivBody += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='f_next(" + (data.pageVO.endPage+1) + ")'>다음</a></li>";
			} else {
				pageDivBody += "<li class='page-item disabled'><a class='page-link' href='javascript:void(0)'>다음</a></li>";
			}
			pageDivBody += "</ul>";
			pageDivBody += "</nav>";
			pageDivBody += "</div>";
			
        document.querySelector("#cursList").innerHTML = studentBody;
        document.querySelector("#pageDiv").innerHTML = pageDivBody;
		},
		error : function(xhr) {
		},
		dataType : "json"
	});
  	
}

const f_pre = (page) => {
// // 	location.replace("${contextPath}/list?pageNum=" + p_nextPageNum);
// 	document.querySelector("input[name=pageNum]").value = '${pageVO.startPage -1}';
// 	document.querySelector("input[name=pageSize]").value = '${pageSize}';
// 	pageForm.submit(); // form 전송
  	let cursNm = document.querySelector("#searchCursNm").value;
  	
  	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
     	},
		url : "${pageContext.request.contextPath}/lecture/management/page",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNm" : cursNm,
								"pageNum" : page}),
		success : function(data) {
			let thisPage = data.pageVO.lectureListPageCountVO.pageNum; 
			console.log(data);
			document.querySelector("#cursList").innerHTML = "";
			document.querySelector("#pageDiv").innerHTML = "";
			let studentBody = "";
			let pageDivBody = "";
			for(let i = 0; i < data.lectureList.length; i++) {
				studentBody += "<tr>"
				studentBody += "<th scope='row'><input class='checkbox_animated' type='checkbox' onclick='lectureInfo(this)' value=" + data.lectureList[i].cursNo + " id='cursNo' name='cursNo'></th>";
                studentBody += "<td>" + data.lectureList[i].cursNo + "</td>";
                studentBody += "<td>" + data.lectureList[i].subNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].empNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursSttDt + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursEndDt + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursSuPri.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","); + "</td>";
              	studentBody += "</tr>";
			}
			pageDivBody += "<input type='hidden' id='hiddenCurPage'>";
          	pageDivBody += "<input type='hidden' name='pageNum' value=" + data.pageVO.lectureListPageCountVO.pageNum +  ">";
          	pageDivBody += "<input type='hidden' name='pageSize' value=" + data.pageVO.lectureListPageCountVO.pageSize + ">";
          	pageDivBody += "<nav aria-label='...'>";
          	pageDivBody += " <ul class='pagination pagination-primary'>";
          	if(data.pageVO.previous == true) {
          	pageDivBody += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='f_pre(" + (data.pageVO.startPage-1) + ")' tabindex='-1'>이전</a></li>";
          	} else {
       		pageDivBody += "<li class='page-item disabled'><a class='page-link' href='javascript:void(0)' tabindex='-1'>이전</a></li>";
          	}
			for(let i = data.pageVO.startPage; i <= data.pageVO.endPage; i++) {
				if(data.pageVO.lectureListPageCountVO.pageNum == thisPage) {
					pageDivBody += "<li class='page-item'><a class='page-link' href='#' onclick='f_sendPage(" + data.pageVO.lectureListPageCountVO.pageNum + ", " + data.pageVO.lectureListPageCountVO.pageSize + ", this)'>" + i + "</a></li>";
				} else {
					pageDivBody += "<li class='page-item'><a class='page-link' href='#' onclick='f_sendPage(" + data.pageVO.lectureListPageCountVO.pageNum + ", " + data.pageVO.lectureListPageCountVO.pageSize + ", this)'>" + i + "</a></li>";
				}
			}
			if(data.pageVO.next == true) {
				pageDivBody += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='f_next(" + (data.pageVO.endPage+1) + ")'>다음</a></li>";
			} else {
				pageDivBody += "<li class='page-item disabled'><a class='page-link' href='javascript:void(0)'>다음</a></li>";
			}
			pageDivBody += "</ul>";
			pageDivBody += "</nav>";
			pageDivBody += "</div>";
			
        document.querySelector("#cursList").innerHTML = studentBody;
        document.querySelector("#pageDiv").innerHTML = pageDivBody;
		},
		error : function(xhr) {
		},
		dataType : "json"
	});
} 

const f_sendPage = (pageNum, pageSize, thisPage) => {
	event.preventDefault();
	console.log("thispage > ", thisPage.innerText);
// 	document.querySelector("input[name=pageNum]").value = pageNum;
	document.querySelector("input[name=pageSize]").value = pageSize;
	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
     	},
		url : "${pageContext.request.contextPath}/lecture/management/page",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"pageNum" : thisPage.innerText
							  , "cursNm" : document.querySelector("#searchCursNm").value}),
		success : function(data) {
			console.log(data);
			document.querySelector("#cursList").innerHTML = "";
			document.querySelector("#pageDiv").innerHTML = "";
			let studentBody = "";
			let pageDivBody = "";
			for(let i = 0; i < data.lectureList.length; i++) {
				studentBody += "<tr>"
				studentBody += "<th scope='row'><input class='checkbox_animated' type='checkbox' onclick='lectureInfo(this)' value=" + data.lectureList[i].cursNo + " id='cursNo' name='cursNo'></th>";
                studentBody += "<td>" + data.lectureList[i].cursNo + "</td>";
                studentBody += "<td>" + data.lectureList[i].subNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].empNm + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursSttDt + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursEndDt + "</td>";
                studentBody += "<td>" + data.lectureList[i].cursSuPri.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","); + "</td>";
              	studentBody += "</tr>";
			}
				pageDivBody += "<input type='hidden' id='hiddenCurPage'>";
              	pageDivBody += "<input type='hidden' name='pageNum' value=" + data.pageVO.lectureListPageCountVO.pageNum +  ">";
              	pageDivBody += "<input type='hidden' name='pageSize' value=" + data.pageVO.lectureListPageCountVO.pageSize + ">";
              	pageDivBody += "<nav aria-label='...'>";
              	pageDivBody += " <ul class='pagination pagination-primary'>";
              	if(data.pageVO.previous == true) {
              	pageDivBody += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='f_pre(" + (data.pageVO.startPage-1) + ")' tabindex='-1'>이전</a></li>";
              	} else {
           		pageDivBody += "<li class='page-item disabled'><a class='page-link' href='javascript:void(0)' tabindex='-1'>이전</a></li>";
              	}
				for(let i = data.pageVO.startPage; i <= data.pageVO.endPage; i++) {
					if(data.pageVO.lectureListPageCountVO.pageNum == thisPage.innerText) {
						pageDivBody += "<li class='page-item'><a class='page-link' href='#' onclick='f_sendPage(" + data.pageVO.lectureListPageCountVO.pageNum + ", " + data.pageVO.lectureListPageCountVO.pageSize + ", this)'>" + i + "</a></li>";
					} else {
						pageDivBody += "<li class='page-item'><a class='page-link' href='#' onclick='f_sendPage(" + data.pageVO.lectureListPageCountVO.pageNum + ", " + data.pageVO.lectureListPageCountVO.pageSize + ", this)'>" + i + "</a></li>";
					}
				}
				if(data.pageVO.next == true) {
					pageDivBody += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='f_next(" + (data.pageVO.endPage+1) + ", this)'>다음</a></li>";
				} else {
					pageDivBody += "<li class='page-item disabled'><a class='page-link' href='javascript:void(0)'>다음</a></li>";
				}
				pageDivBody += "</ul>";
				pageDivBody += "</nav>";
				pageDivBody += "</div>";
               
            document.querySelector("#cursList").innerHTML = studentBody;
            document.querySelector("#pageDiv").innerHTML = pageDivBody;
		},
		error : function(xhr) {
		},
		dataType : "json"
	});
};
</script>