<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- <sec:authentication var="USER" property="principal.username" scope="request" /> --%>

<div class="page-header">
	<div class="row">
		<div class="col-sm-12 mx-2 p-4">
			<h3 class="m-4">&emsp;공지사항 상세보기</h3>
			<!-- Container-fluid starts-->
			<div class="container-fluid">
				<div class="row px-3">
					<div class="col-sm-12 p-0">
						<div class="card alert alert-primary" role="alert">
							<p class="alert-heading"> 
								 &emsp;
								 <i class="icofont icofont-user"></i>${noticeVO.bdWTR} 
								 &emsp;|&emsp;
								<fmt:formatDate value="${noticeVO.bdWtDt}" pattern="yyyy-MM-dd" />
							</p>
						</div>
					</div>
					<div class="card">
						<div class="card-body">
							<div class="blog-details">
								<div class="single-blog-content-top">
									<h4>제목 &emsp;|&emsp; ${noticeVO.bdTL}</h4>
									<tr>
								</div>
								<div class="card-footer">
									<br>
									<h4>${noticeVO.bdCNT}</h4>
									<br>
<!-- 권한주기 / 학생은 자기가 쓴글만 수정,삭제할 수 있게 -->
									<sec:authorize access="hasRole('STUDENT')">
										<c:set var="memId" value="${noticeVO.bdWTR}" />
										<c:if test="${USERNAME == noticeVO.bdWTR}">
											<button id="id_deletebtn" class="btn btn-danger active"
												type="submit" style="margin: 10px; float:right" onclick="f_deletebtn()">삭제</button>
											<button id="id_updatebtn" class="btn btn-warning"
												type="button" style="margin: 10px; float:right" onclick="f_updatebtn()">수정</button>
										</c:if>
									</sec:authorize>
<!-- 권한주기 / 교사는 자기가 쓴글만 수정,삭제할 수 있게 -->
									<sec:authorize access="hasRole('TEACHER')">
										<c:set var="memId" value="${noticeVO.bdWTR}" />
										<c:if test="${USERNAME == noticeVO.bdWTR}">
											<button id="id_deletebtn" class="btn btn-danger active"
												type="submit" style="margin: 10px; float:right" onclick="f_deletebtn()">삭제</button>
											<button id="id_updatebtn" class="btn btn-warning"
												type="button" style="margin: 10px; float:right" onclick="f_updatebtn()">수정</button>
										</c:if>
									</sec:authorize>
<!-- 권한주기 / 교직원은 모든 게시글 수정,삭제할 수 있게 -->
									<sec:authorize access="hasRole('EMPLOYEE')">
										<button id="id_deletebtn" class="btn btn-danger active"
											type="submit" style="margin: 10px; float:right;" onclick="f_deletebtn()">삭제</button>
										<button id="id_updatebtn" class="btn btn-warning"
											type="button" style="margin: 10px; float:right" onclick="f_updatebtn()">수정</button>
									</sec:authorize>
<!-- 상세보기에서 목록으로 돌아가기 버튼 -->
									<c:if test="${(pageNum != null)&&(pageSize != null)}">
										<button id="id_backbtn" class="btn btn-info active"
											type="button" style="margin: 10px; float:left;"
											onclick="location.href ='${CONTEXT_PATH}/notice/main?pageNum=${pageNum}&pageSize=${pageSize}'">목록으로</button>
									</c:if>
									<c:if test="${(pageNum == null)&&(pageSize == null)}">
										<button id="id_backbtn" class="btn btn-info active"
											type="button" style="margin: 10px; float:left;"
											onclick="location.href ='${CONTEXT_PATH}/notice/main'">목록으로</button>
										<sec:csrfInput />
									</c:if>
								</div>
							</div>
						</div>
					</div>

</div></div></div></div></div>
<!-- Container-fluid Ends-->



<script>
	

// 	------------------------------------------------------------------------------------------------------

// 	게시글 수정 버튼
	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';
	
	var v_fbForm = document.querySelector("#fb_form");
	var bdno = "${noticeVO.bdNo}";
	var userName = "${USERNAME}";
	
	var v_updatebtn = document.querySelector("#id_updatebtn");	

	
	f_updatebtn = () => {
		location.href="${CONTEXT_PATH}/notice/update?bdNo=${noticeVO.bdNo}";
	}
	
	if(v_updatebtn != null){
 		v_updatebtn.addEventListener("click", f_updatebtn);		
	}

	
// 	-------------------------------------------------------------------------------------------------------
// 	게시글 삭제 버튼
	var v_deletebtn = document.querySelector("#id_deletebtn");	

	f_deletebtn = () => {
        let xhr = new XMLHttpRequest();
        xhr.open("post","${CONTEXT_PATH}/notice/delete",true);
        xhr.onreadystatechange = function(){
            if(xhr.readyState == 4 && xhr.status == 200){
            	let result = xhr.responseText;
            	if(result == "NG"){
            		alert("작성자가 아닌 사용자는 삭제할 수 없습니다.");
            		return; // 종료
            	}
            	Swal.fire({
                    icon: 'success',
                    title: '게시글이 삭제되었습니다.'
                }).then((result) => {
                    if (result.isConfirmed) {
                    	location.href="${CONTEXT_PATH}/notice/main";       
                    }
                });
            }
        }
        xhr.setRequestHeader(tokenHeader, tokenValue);
        xhr.setRequestHeader('Content-type','application/json');
        let myJsonData = {
        		bdNo : bdno,
				memId : userName
        };
        console.log(myJsonData);
        xhr.send(JSON.stringify(myJsonData));
	
	}
	
	if("${msg}") {
		alert("${msg}");
	}

</script>

