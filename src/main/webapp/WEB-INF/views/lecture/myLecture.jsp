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
				<h3>교원강의관리</h3>
					<ol class="breadcrumb" style="text-align: center;">
                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">홈</a></li>
                    <li class="breadcrumb-item">강의</li>
                    <li class="breadcrumb-item">교원강의관리</li>
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
                          <th scope="col">수강인원</th>
                          <th scope="col">평가점수</th>
                          <th scope="col">평가내용</th>
                        </tr>
                      </thead>
                      <tbody id="myCursList">
                      <!-- foreach start -->
                      <c:forEach var="lecture" items="${myLectureList }" varStatus="status">
                        <tr>
                          <th scope="row"><input class="checkbox_animated" type="checkbox" onclick="myLectureInfo(this)" value="${lecture.cursNo }" id="cursNo" name="cursNo"></th>
                          <td>${lecture.cursNo }</td>
                          <td>${lecture.subNm }</td>
                          <td>${lecture.cursNm }</td>
                          <td>${lecture.empNm }</td>
                          <td><fmt:formatDate value="${lecture.cursSttDt}" type="date" pattern="yyyy-MM-dd" /></td>
                          <td><fmt:formatDate value="${lecture.cursEndDt}" type="date" pattern="yyyy-MM-dd" /></td>
                          <td>${lecture.cursStuCnt }/25명</td>
                          <td>${lecture.cursevaScrAvg }/5점</td>
                          <c:if test="${lecture.cursevaScrAvg == 0 }">
                          <td><button class="btn btn-info btn-xs" disabled="disabled" id="LectureReviewBtn" onclick="myLectureReview(this)" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal" value="${lecture.cursNo }">평가내용</button></td>
                         </c:if>
                         <c:if test="${lecture.cursevaScrAvg != 0 }">
                          <td><button class="btn btn-primary btn-xs" id="LectureReviewBtn" onclick="myLectureReview(this)" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal" value="${lecture.cursNo }">평가내용</button></td>
                          </c:if>
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
                    <h5>내 강의 상세정보</h5>
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
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#studentModal" id="studentList" onclick="lectureStudentList()">수강중인 수강생</button>
                    <button class="btn btn-info" onclick="refreshSearch()">초기화</button>
                    </div>
                  </div>
                    <div class="modal fade bd-example-modal-lg" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                      <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="myLargeModalLabel">평가리스트</h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                          	<div class="table-responsive">
			                    <table class="table">
			                      <thead>
			                        <tr>
			                          <th scope="col">No</th>
			                          <th scope="col">평가점수</th>
			                          <th scope="col">평가내용</th>
			                          <th scope="col">평가일</th>
			                        </tr>
			                      </thead>
			                      <tbody id="reviewTbody">
			                      </tbody>
			                      </table>
	                          </div>
                          </div>
                          <div class="modal-footer">
                            <button class="btn btn-info" type="button" data-bs-dismiss="modal">닫기</button>
                          </div>
                        </div>
                      </div>
                    </div>
                     <div class="modal fade bd-example-modal-lg" id="studentModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
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
<script>
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');

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
		url : "${pageContext.request.contextPath}/lecture/mylecture/search",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNm" : document.querySelector("#searchCursNm").value}),
		success : function(data) {
			console.log(data);
			document.querySelector("#myCursList").innerHTML = "";
			let body = "";
			for(let i = 0; i < data.length; i++) {
				body += "<tr>"
				body +=	"<th scope='row'><input class='checkbox_animated' type='checkbox' onclick='myLectureInfo(this)' value='" + data[i].cursNo + "' id='cursNo' name='cursNo'></th>";
				body += "<td>" + data[i].cursNo + "</td>";
				body += "<td>" + data[i].subNm + "</td>";
				body += "<td>" + data[i].cursNm + "</td>";
                body += "<td>" + data[i].empNm + "</td>";
                body += "<td>" + data[i].cursSttDt + "</td>";
                body += "<td>" + data[i].cursEndDt + "</td>";
                body += "<td>" + data[i].cursStuCnt+ "/25명</td>";
                body += "<td>" + data[i].cursevaScrAvg + "/5점</td>";
                body += "<td><button class='btn btn-primary btn-xs' id='LectureReviewBtn' onclick='myLectureReview(this)' data-bs-toggle='modal' data-original-title='test' data-bs-target='#exampleModal' value=" + data[i].cursNo + ">평가내용</button></td>";
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

const myLectureReview = (cursBtn) => {
	cursNo = cursBtn.value;
	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
     	},
		url : "${pageContext.request.contextPath}/lecture/mylecture/review",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNo" : cursNo}),
		success : function(data) {
			console.log(data);
			document.querySelector("#reviewTbody").innerHTML = "";
			let body = "";
			for(let i = 0; i < data.length; i++) {
				body += "<tr>";
				body += "<th scope='row'>" + (i+1) + "</th>";
				body += "<td>" + data[i].cursevaScr + "/5점</td>";
				body += "<td>" + data[i].cursevaCnt + "</td>";
				body += "<td>" + data[i].cursevaDt + "</td>";
				body += "</tr>";
				
			}
			document.querySelector("#reviewTbody").innerHTML = body;
		},
		error : function(xhr) {
			console.log(xhr);
		},
		dataType : "json"
	});
}
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
	document.querySelector("#myCursList").innerHTML =
	`<c:forEach var="lecture" items="${myLectureList }" varStatus="status">
      <tr>
        <th scope="row"><input class="checkbox_animated" type="checkbox" onclick="myLectureInfo(this)" value="${lecture.cursNo }" id="cursNo" name="cursNo"></th>
        <td>${lecture.cursNo }</td>
        <td>${lecture.subNm }</td>
        <td>${lecture.cursNm }</td>
        <td>${lecture.empNm }</td>
        <td><fmt:formatDate value="${lecture.cursSttDt}" type="date" pattern="yyyy-MM-dd" /></td>
        <td><fmt:formatDate value="${lecture.cursEndDt}" type="date" pattern="yyyy-MM-dd" /></td>
        <td>${lecture.cursStuCnt }/25명</td>
        <td>${lecture.cursevaScrAvg }/5점</td>
        <td><button class="btn btn-primary btn-xs" id="LectureReviewBtn" onclick="myLectureReview(this)" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal" value="${lecture.cursNo }">평가내용</button></td>
      </tr>
      </c:forEach>`;
};

const myLectureInfo = (p_ckBox) => {
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
		url : "${pageContext.request.contextPath}/lecture/mylecture/info",
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

const lectureStudentList = () => {
	let cursNo = document.querySelector("#cursNoList").value;
	console.log("cursNo > ", cursNo);
	
	document.querySelector("#searchText").value = "";
		
	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
     	},
		url : "${pageContext.request.contextPath}/lecture/mylecture/studentList",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNo" : cursNo}),
		success : function(data) {
			console.log(data);
			let studentBody = "";
			for(let i = 0; i < data.length; i++) {
				studentBody += "<tr>";
				studentBody += "<th scope='row'>" + (i+1) + "</th>";
				studentBody += "<td>" + data[i].stuNm + "</td>"
				studentBody += "<td>" + data[i].stuPhNo + "</td>"
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
		url : "${pageContext.request.contextPath}/lecture/mylecture/searchMyStudent",
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
</script>