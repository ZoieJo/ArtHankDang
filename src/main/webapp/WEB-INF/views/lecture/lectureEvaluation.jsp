<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" type="text/css" href="/arthakdang/resources/assets/css/rating.css">
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
			<br>
				<h3>강의평가</h3>
					<ol class="breadcrumb" style="text-align: center;">
                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">홈</a></li>
                    <li class="breadcrumb-item">강의</li>
                    <li class="breadcrumb-item">강의평가</li>
                  </ol>
			</div>
			<div class="col-sm-6">
			</div>
		</div>
	</div>
</div>
 <div class="col-sm-12">
   <div class="card">
     <div class="table-responsive">
       <table class="table table-sm" style="text-align: center;">
         <thead>
           <tr>
             <th scope="col">강의명</th>
             <th scope="col">강사명</th>
             <th scope="col">개강날짜</th>
             <th scope="col">종강날짜</th>
             <th scope="col">수강료</th>
             <th scope="col">수강인원</th>
             <th scope="col">평가</th>
<!--              <th scope="col">삭제</th> -->
           </tr>
         </thead>
         <tbody>
         <c:forEach var="myLecture" items="${myLectureList }" varStatus="status">
         <c:if test="${myLecture.cursevaWidWn == null}">
           <tr>
             <th scope="row">${myLecture.cursNm }</th>
             <td>${myLecture.empNm }</td>
             <td><fmt:formatDate value="${myLecture.cursSttDt }" pattern="yyyy-MM-dd" /></td>
             <td><fmt:formatDate value="${myLecture.cursEndDt }" pattern="yyyy-MM-dd"/></td>
             <td>${myLecture.cursSuPri }</td>
             <td>${myLecture.cursSuNum }</td>
             <c:if test="${myLecture.evalChk == 1 }">
				  <td><button class="btn btn-info btn-xs" disabled="disabled">완료</button></td>           
             </c:if>
             <c:if test="${myLecture.evalChk == 0 }">
             <td><button class="btn btn-primary btn-xs" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal" onclick="lectureEval(this)" value="${myLecture.cursNo }">선택</button></td>
             </c:if>
           </tr>
           </c:if>
           </c:forEach>
         </tbody>
       </table>
     </div>
   </div>
 </div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">강의평가</h5>
        <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="${pageContext.request.contextPath }/lecture/evaluationSend" method="post" id="lectureEvaluationForm">
      <sec:csrfInput/>
      <div class="modal-body">
      <div id="headDiv">
      </div>
      <h6>별점</h6>
      	<div class="rating-container">
         <select id="u-rating-fontawesome" name="cursevaScr" >
           <option value="1">1</option>
           <option value="2">2</option>
           <option value="3">3</option>
           <option value="4">4</option>
           <option value="5">5</option>
         </select>
       </div>
       <br>
       <br>
       	<h6>수강 후기</h6>
       <div class="input-group">
       	<input class="form-control" type="text" name="cursevaCnt">
       </div>
      </div>
      <div class="modal-footer">
      	<input type="hidden" value="${user.getMember().getMemId() }" name="stuId">
      	<input type="hidden" name="cursNo" id="hiddenCursNo">
        <button class="btn btn-primary" type="button" onclick="sendLectureEvaluationForm()">제출</button>
        <button class="btn btn-info" type="button" data-bs-dismiss="modal">닫기</button>
      </div>
      </form>
    </div>
  </div>
</div>

<script src="/arthakdang/resources/assets/js/rating/jquery.barrating.js"></script>
<script src="/arthakdang/resources/assets/js/rating/rating-script.js"></script>
<script src="/arthakdang/resources/assets/js/tooltip-init.js"></script>
<script>
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');
const lectureEval = (lecture) => {
	var cursNo = lecture.value;
	$.ajax({
		beforeSend : function(xhr){
	           xhr.setRequestHeader(header, token);
  		},
		url : "${pageContext.request.contextPath}/lecture/evaluation/modal",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify({"cursNo" : cursNo}),
		success : function(data) {
			let tbody = "";
			lectureBody = "";
			console.log(data);
			tbody += "<h6>강의명</h6>";
            tbody += "<h6>" + data.cursNm + "</h6>";
            tbody += "<br>";
            tbody += "<br>";
          	document.querySelector("#headDiv").innerHTML = tbody;
          	document.querySelector("#hiddenCursNo").value = data.cursNo;
		},
		error : function (error) {
		},
		dataType : "json"
	});
}

const sendLectureEvaluationForm = () => {
	lectureEvaluationForm = document.querySelector("#lectureEvaluationForm");
// 	if(confirm("평가는 한번만 남길 수 있습니다. 제출하시겠습니까 ?")) {
// 		lectureEvaluationForm.submit();
// 	} else {
// 		return;
// 	}
	Swal.fire({
	      title: '평가를 완료하시겠습니까 ?',
	      text: "평가는 한번만 남길 수 있습니다. 제출하시겠습니까 ?",
	      icon: 'warning',
	      showCancelButton: true,
	      confirmButtonColor: '#3085d6',
	      cancelButtonColor: '#d33',
	      confirmButtonText: '확인',
	      cancelButtonText: '취소',
	      reverseButtons: false, // 버튼 순서 거꾸로
	      
	    }).then((result) => {
	      if (result.isConfirmed) {
// 	        Swal.fire(
// 	          '제출완료',
// 	          '제출 완료되었습니다.',
// 	          'success'
// 	        )
	        lectureEvaluationForm.submit();
	      }
	    })
}

const deleteEvaluation = (evaluation) => {
	event.preventDefault();
	console.log(evaluation.elements['evalChk']);
	Swal.fire({
	      title: '평가를 삭제하시겠습니까 ?',
	      text: "평가가 삭제되면 다시는 볼 수 없습니다. 삭제하시겠습니까 ?",
	      icon: 'warning',
	      showCancelButton: true,
	      confirmButtonColor: '#3085d6',
	      cancelButtonColor: '#d33',
	      confirmButtonText: '확인',
	      cancelButtonText: '취소',
	      reverseButtons: false, // 버튼 순서 거꾸로
	      
	    }).then((result) => {
	      if (result.isConfirmed) {
	    	  if(evaluation.elements['evalChk'].value == "0") {
	    		  Swal.fire(
    	 	          '삭제 불가',
    	 	          '평가를 완료해야 삭제할 수 있습니다.',
    	 	          'warning'
   	 	          )
   	 	          return;
	    	  } else {
	        evaluation.submit();
	    	  }
	      }
	    })
}
</script>