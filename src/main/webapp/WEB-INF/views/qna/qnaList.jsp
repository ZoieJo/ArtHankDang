<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
			<br>
				<h3>QnA</h3>
					<ol class="breadcrumb" style="text-align: center;">
                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
                     <li class="breadcrumb-item">커뮤니티</li>
                    <li class="breadcrumb-item active">QNA</li>
                  </ol>
			</div>
			<div class="col-sm-6">
			</div>
		</div>
	</div>
</div>
<div class="col-sm-12">
	<div class="card">
  <div class="container-fluid"  style="text-align: center;">
<br>
  <img src="/arthakdang/resources/image/a.png" alt="배너 내용을 적어주세요." class="img-fluid"/>
            <div class="faq-wrap">
              <div class="row">
                <div class="col-lg-12">
                <br>
                  <div class="header-faq">
                    <br>
                    <div class="col-12">
                    <div class="col-md-4 mb-3" style="float: left;">
                    <button class="btn btn-primary" style="float: left;" type="button" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal">QnA작성</button>
                    <br>
                    <br>
                    </div>
                    <div class="col-md-4 mb-3" style="float: right;">
                    <div class="input-group">
                    <input class="form-control" type="text" name="bdTl" placeholder="검색어를 입력하세요." id="searchBdTl">
                    <button class="btn btn-secondary" type="button" onclick="searchQnA()">검색</button>
                    </div>
                  	</div>
                  </div>
                  </div>
                 </div>
                  <div class="row default-according style-1 faq-accordion" id="accordionoc${status.index }">
                 <div id="searchDiv">
                        <!-- foreach 시작 -->
                    <div class="mb-3">
                       <c:forEach var="qna" items="${qnAList }" varStatus="status">
                      <div class="card">
                        <div class="card-header">
                          <h5 class="mb-0">
                          <c:if test="${qna.bdSuc == 'Y' }">
                            <button class="btn btn-link collapsed" data-bs-toggle="collapse" data-bs-target="#collapseicon${status.index }" aria-expanded="false" aria-controls="collapseicon"><span style="margin: 1px;" class="badge badge-primary">완료</span>${qna.bdTl }</button>
                          </c:if>
                          <c:if test="${qna.bdSuc == 'N' }">
                            <button class="btn btn-link collapsed" data-bs-toggle="collapse" data-bs-target="#collapseicon${status.index }" aria-expanded="false" aria-controls="collapseicon"><span style="margin: 1px;" class="badge badge-warning">미확인</span>${qna.bdTl }</button>
                          </c:if>
                          </h5>
                        </div>
                        <div class="collapse" id="collapseicon${status.index }" aria-labelledby="collapseicon" data-parent="#accordionoc">
                          <div class="card-body">
                            <p>${qna.bdCnt }</p>
                          </div>
                          <c:if test="${user.getMember().getMemCmcd() == '02' }">
                          <div class="col-1" style="float: right;">
                          <button class="btn btn-primary btn-xs" value="${qna.bdNo }" style="float: right;text-align: center;font-size:12px;" type="button" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal1" onclick="updateQnA(this)">수정</button>
                          <form action="${pageContext.request.contextPath }/qna/delete" method="post" onsubmit="return deleteForm(this);">
                          <input type="hidden" value="${qna.bdNo }" name="bdNo">
                          <sec:csrfInput/>
                          <button class="btn btn-danger btn-xs" style="text-align: center;font-size:12px;" type="submit">삭제</button>
                          </form>
                          </div>
                          </c:if>
                        </div>
                      </div>
                      </c:forEach>
                      <!-- foreach end -->
                      </div>
                     </div>
                     </div>
                     </div>
                     </div>
                     </div>
                     </div>
                       </div>
					 <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					 <form action="${pageContext.request.contextPath }/qna/write" method="post" id="writeForm">
					 <sec:csrfInput/>
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">QnA 답변</h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                          <div class="mb-3">
                          <label class="form-label">간단한 질문을 작성해주세요 !</label>
						  	<input class="form-control" type="text" name="bdTl">
                          </div>
						  	<input type="hidden" name="bdWtr" value="${user.getMember().getMemId() }">
						  </div>
                          <div class="modal-footer">
                            <button class="btn btn-primary" type="button" onclick="writeQnA()">작성완료</button>
                            <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button>
                          </div>
                        </div>
                      </div>
                      </form>
                    </div>
                    
					 <div class="modal fade" id="exampleModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                       <form action="${pageContext.request.contextPath }/qna/update" method="post" id="qnAForm">
                       <sec:csrfInput/>
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">QnA 답변</h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                          <div class="mb-3">
                          <label class="form-label">질문</label>
						  	<input class="form-control" type="text" id="bdTl" disabled="disabled">
                          </div>
                          <div class="mb-3">
                          <label class="form-label">질문에 대한 답변을 적어주세요 !</label>
						  	<input class="form-control" type="text" name="bdCnt">
						  	<input type="hidden" id="hiddenBdNo" name="bdNo">
						  </div>
                          </div>
                          <div class="modal-footer">
                            <button class="btn btn-primary" type="button" onclick="submitForm()">작성완료</button>
                            <button class="btn btn-info" type="button" data-bs-dismiss="modal">닫기</button>
                          </div>
                        </div>
                        </div>
						  </form>
                      </div>
                    

<script>
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');

const updateQnA = (bdNo) => {
	var hiddenBdNo = document.querySelector("#hiddenBdNo").value;
	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
		},
		url : "${pageContext.request.contextPath}/qna/qnaInfo",
		type : "post",
		data : JSON.stringify({"bdNo" : bdNo.value}),
		contentType : "application/json",
		success : function(data) {
			document.querySelector("#bdTl").value = data.bdTl;
			document.querySelector("#hiddenBdNo").value = data.bdNo;
		},
		error : function(error) {
			
		},
		dataType : "json"
	});
};

const qnAForm = document.querySelector("#qnAForm");
const qnASubmitBtn = document.querySelector("#qnASubmitBtn");
const submitForm = () => {
	Swal.fire({
        title: "QnA 답변 등록",
       	text : "선택하신 QnA의 답변을 등록하시겠습니까 ?",
        icon: "info",		
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: '확인',
        denyButtonText: '취소',
     }).then(function(result){
        if (result.isConfirmed) {
//         	Swal.fire(
//       	          '등록완료',
//       	          '등록이 완료되었습니다.',
//       	          'success'
//       	        )
        	qnAForm.submit();
        } else if (result.isDenied) {
        	return;
        }
     });
// 	if(confirm("답변을 달겠습니까 ?")) {
// 		qnAForm.submit();
// 	} else {
// 		return;
// 	}
};

const writeForm = document.querySelector("#writeForm");
const writeQnA = () => {
	Swal.fire({
        title: "QnA 등록",
       	text : "QnA를 등록하시겠습니까 ?",
        icon: "info",		
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: '확인',
        denyButtonText: '취소',
     }).then(function(result){
        if (result.isConfirmed) {
        	writeForm.submit();
        } else if (result.isDenied) {
        	return;
        }
     });
}
const deleteForm = (thisForm) => {
	event.preventDefault();
	Swal.fire({
        title: "QnA 삭제",
       	text : "선택한 QnA를 삭제하시겠습니까 ?",
        icon: "info",		
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: '확인',
        denyButtonText: '취소',
     }).then(function(result){
        if (result.isConfirmed) {
        	thisForm.submit();
        	return true;
        } else if (result.isDenied) {
        	return false;
        }
     });
// 	if(confirm("선택한 QnA를 삭제하시겠습니까 ?")) {
// 		return true;
// 	} else {
// 		return false;
// 	}
};

const searchQnA = () => {
var searchBdTl = document.querySelector("#searchBdTl");
	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
		},
		url : "${pageContext.request.contextPath}/qna/searchQnA",
		type : "post",
		data : JSON.stringify({"bdTl" : searchBdTl.value}),
		contentType : "application/json",
		success : function(data) {
			
			console.log(data);
			let searchText = "";
			document.querySelector("#searchDiv").innerHTML = "";
			for(let i  = 0; i < data.length; i++) {
				searchText += "<div class='card'>"; 
				searchText +=  "<div class='card-header'>";
				searchText += "<h5 class='mb-0'>";
				if(data[i].bdSuc == "Y") {
				searchText +=   "<button class='btn btn-link collapsed' data-bs-toggle='collapse' data-bs-target='#collapseicon" + i + "' aria-expanded='false' aria-controls='collapseicon'><span style='margin: 1px;' class='badge badge-primary'>완료</span>" + data[i].bdTl + "</button>";
				} else {
				searchText +=   "<button class='btn btn-link collapsed' data-bs-toggle='collapse' data-bs-target='#collapseicon" + i + "' aria-expanded='false' aria-controls='collapseicon'><span style='margin: 1px;' class='badge badge-warning'>미확인</span>" + data[i].bdTl + "</button>";
				}
				searchText += "</h5>";
				searchText += "</div>";
				searchText += "<div class='collapse' id='collapseicon" + i + "' aria-labelledby='collapseicon' data-parent='#accordionoc'>";
				searchText += "<div class='card-body'>";
				searchText += "<p>" + data[i].bdCnt + "</p>"; 
				searchText += "</div>";
				if(${user.getMember().getMemCmcd() == "02"}) { 
				searchText += "<div class='col-1' style='float: right;'>";
				searchText += "<button class='btn btn-primary btn-xs' value='" + data[i].bdNo + "' style='float: right;' type='button' data-bs-toggle='modal' data-original-title='test' data-bs-target='#exampleModal1' onclick='updateQnA(this)'>수정</button>";
				searchText += "<form action='${pageContext.request.contextPath }/qna/delete' method='post' onsubmit='return deleteForm();'>";
				searchText += "<input type='hidden' value='" + data[i].bdNo + "' name='bdNo'>";
				searchText += '<sec:csrfInput/>';
				searchText += "<button class='btn btn-danger btn-xs' type='submit'>삭제</button>";
				searchText += "</form>";
				searchText += "</div>";
				}
				searchText += "</div>";
				searchText += "</div>"; 
			} 
			
			$(document.querySelector("#searchDiv")).append(searchText);
		},
		error : function(error) {
			 
		},
		dataType : "json"
	});
};

</script>