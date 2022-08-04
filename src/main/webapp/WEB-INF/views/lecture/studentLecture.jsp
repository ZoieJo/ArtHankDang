<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
				<h3>내강의관리</h3>
					<ol class="breadcrumb" style="text-align: center;">
                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">홈</a></li>
                    <li class="breadcrumb-item">강의</li>
                    <li class="breadcrumb-item">내강의관리</li>
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
                    <button class="btn btn-secondary" onclick="searchMyLecture()">검색</button>
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
                        </tr>
                      </thead>
                      <tbody id="myCursList">
                      <!-- foreach start -->
                      <c:forEach var="lecture" items="${studentLectureList }" varStatus="status">
                        <tr>
                          <th scope="row"><input class="checkbox_animated" type="checkbox" onclick="lectureInfo(this)" value="${lecture.cursNo }" id="cursNo" name="cursNo"></th>
                          <td>${lecture.cursNo }</td>
                          <td>${lecture.subNm }</td>
                          <td>${lecture.cursNm }</td>
                          <td>${lecture.empNm }</td>
                          <td><fmt:formatDate value="${lecture.cursSttDt}" type="date" pattern="yyyy-MM-dd" /></td>
                          <td><fmt:formatDate value="${lecture.cursEndDt}" type="date" pattern="yyyy-MM-dd" /></td>
                        </tr>
                        </c:forEach>
                        <!-- foreach end -->
                      </tbody>
                    </table>
                  </div>
                  <div class="card-body">
                    <nav aria-label="...">
                      <ul class="pagination pagination-primary">
                        <li class="page-item disabled"><a class="page-link" href="javascript:void(0)" tabindex="-1">이전</a></li>
                        <li class="page-item active"><a class="page-link" href="javascript:void(0)">1 <span class="sr-only">(current)</span></a></li>
                        <li class="page-item"><a class="page-link" href="javascript:void(0)">2</a></li>
                        <li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li>
                        <li class="page-item"><a class="page-link" href="javascript:void(0)">다음</a></li>
                      </ul>
                    </nav>
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
                    <input type="hidden" id="cursNoList" name="cursNo">
<!--                     <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target=".bd-example-modal-lg" id="studentList" onclick="lectureStudentList()">수강중인 수강생</button> -->
                    <button class="btn btn-info" onclick="refreshSearch()">초기화</button>
                    </div>
                  </div>
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
		url : "${pageContext.request.contextPath}/lecture/studentLecture/Info",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNo" : p_ckBox.value}),
		success : function(data) {
			console.log(data);
			console.log(data.subNm);
			document.querySelector("#lec_subNm").value = data.subNm;
			document.querySelector("#lec_cursNm").value = data.cursNm;
			document.querySelector("#lec_empNm").value = data.empNm;
			document.querySelector("#lec_sttDt").value = data.cursSttDt;
			document.querySelector("#lec_endDt").value = data.cursEndDt;
		},
		error : function(error) {
			console.log(error);
		},
		dateType : 'json'
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
	document.querySelector("#lec_sttDt").value = "";
	document.querySelector("#lec_endDt").value = "";
	document.querySelector("#myCursList").innerHTML =
	`<c:forEach var="lecture" items="${studentLectureList }" varStatus="status">
                        <tr>
                          <th scope="row"><input class="checkbox_animated" type="checkbox" onclick="lectureInfo(this)" value="${lecture.cursNo }" id="cursNo" name="cursNo"></th>
                          <td>${lecture.cursNo }</td>
                          <td>${lecture.subNm }</td>
                          <td>${lecture.cursNm }</td>
                          <td>${lecture.empNm }</td>
                          <td><fmt:formatDate value="${lecture.cursSttDt}" type="date" pattern="yyyy-MM-dd" /></td>
                          <td><fmt:formatDate value="${lecture.cursEndDt}" type="date" pattern="yyyy-MM-dd" /></td>
                        </tr>
                        </c:forEach>`;
}; 

const searchMyLecture = () => {
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
		url : "${pageContext.request.contextPath}/lecture/studentLecture/searchLecture",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNm" : document.querySelector("#searchCursNm").value}),
		success : function(data) {
			console.log(document.querySelector("#searchCursNm").value);
			console.log(data);
			document.querySelector("#myCursList").innerHTML = "";
			let body = "";
			for(let i = 0; i < data.length; i++) {
				body += "<tr>"
				body +=	"<th scope='row'><input class='checkbox_animated' type='checkbox' onclick='lectureInfo(this)' value='" + data[i].cursNo + "' id='cursNo' name='cursNo'></th>";
				body += "<td>" + data[i].cursNo + "</td>";
				body += "<td>" + data[i].subNm + "</td>";
				body += "<td>" + data[i].cursNm + "</td>";
                body += "<td>" + data[i].empNm + "</td>";
                body += "<td>" + data[i].cursSttDt + "</td>";
                body += "<td>" + data[i].cursEndDt + "</td>";
                body += "</tr>";
			}
			document.querySelector("#myCursList").innerHTML = body;
		},
		error : function(xhr) {
			console.log(xhr);
		},
		dataType : "json"
	});
}
</script>