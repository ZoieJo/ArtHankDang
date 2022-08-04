<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sec:authentication var="USER" property="principal.username" scope="request" />

<!-- 페이지 바운더리 출력 -->
<div class="page-header">
	<div class="row">
		<div class="col-sm-12 mx-2 p-4">
			<h3 class="m-4">&emsp;게시판 상세보기</h3>
			<!-- Container-fluid starts-->
			<div class="container-fluid">
				<div class="row px-3">
					<div class="col-sm-12 p-0">
						<div class="card alert alert-primary" role="alert">
							<p class="alert-heading">
								<fmt:formatDate value="${freeboardVO.bdWtDt}"
									pattern="yyyy-MM-dd" />
								&emsp;|&emsp; <i class="icofont icofont-user"></i>${freeboardVO.memNm}
								&emsp;|&emsp; <a type="button" id="like" onclick="f_like()">
									<i class="fa-solid fa-heart"></i><span>${likesCount}Hits</span>
								</a>&emsp;|&emsp; <i class="fa-solid fa-eye"></i>${freeboardVO.bdViews}
							</p>
						</div>
					</div>
					<div class="card">
						<div class="card-body">
							<div class="blog-details">
								<div class="single-blog-content-top">
									<h4>제목 &emsp;|&emsp; ${freeboardVO.bdTL}</h4>
									<tr>
								</div>
								<div class="card-footer">
									<br>
									<h4>${freeboardVO.bdCNT}</h4>
									<br>
<!-- 권한주기 / 학생은 자기가 쓴글만 수정,삭제할 수 있게 -->
									<sec:authorize access="hasRole('STUDENT')">
										<c:set var="memId" value="${freeboardVO.bdWTR}" />
										<c:if test="${USER == freeboardVO.bdWTR}">
											<button id="id_deletebtn" class="btn btn-danger active"
												type="submit" style="margin: 10px; float:right;" onclick="f_deletebtn()">삭제</button>
											<button id="id_updatebtn" class="btn btn-warning"
												type="button" style="margin: 10px; float:right;" onclick="f_updatebtn()">수정</button>
										</c:if>
									</sec:authorize>
<!-- 권한주기 / 교사는 자기가 쓴글만 수정,삭제할 수 있게 -->
									<sec:authorize access="hasRole('TEACHER')">
										<c:set var="memId" value="${freeboardVO.bdWTR}" />
										<c:if test="${USER == freeboardVO.bdWTR}">
											<button id="id_deletebtn" class="btn btn-danger active"
												type="submit" style="margin: 10px; float:right;" onclick="f_deletebtn()">삭제</button>
											<button id="id_updatebtn" class="btn btn-warning"
												type="button" style="margin: 10px; float:right;" onclick="f_updatebtn()">수정</button>
										</c:if>
									</sec:authorize>
<!-- 권한주기 / 교직원은 모든 게시글 수정,삭제할 수 있게 -->
									<sec:authorize access="hasRole('EMPLOYEE')">
										<button id="id_deletebtn" class="btn btn-danger active"
											type="submit" style="margin: 10px; float:right;" onclick="f_deletebtn()">삭제</button>
										<button id="id_updatebtn" class="btn btn-warning"
											type="button" style="margin: 10px; float:right;" onclick="f_updatebtn()">수정</button>
									</sec:authorize>
<!-- 상세보기에서 목록으로 돌아가기 버튼 -->
									<c:if test="${(pageNum != null)&&(pageSize != null)}">
										<button id="id_backbtn" class="btn btn-info active"
											type="button" style="margin: 10px; float:left;"
											onclick="location.href ='${CONTEXT_PATH}/freeboard/main?pageNum=${pageNum}&pageSize=${pageSize}'">목록으로</button>
									</c:if>
									<c:if test="${(pageNum == null)&&(pageSize == null)}">
										<button id="id_backbtn" class="btn btn-info active"
											type="button" style="margin: 10px; float:left"
											onclick="location.href ='${CONTEXT_PATH}/freeboard/main'">목록으로</button>
										<sec:csrfInput />
									</c:if>
								</div>
							</div>
						</div>
					</div>

<!-- 여기서부터는  댓글 달기 : 댓글리스트 아니구 REPLY WRITE-->
					<div class="card comment-box">
						<div class="card-body">
							<h4>댓글</h4>
							<ul>
								<li>
									<div class="comments-box">
										<form class="comment" id="reply_form" action="${CONTEXT_PATH}/reply/write" method="post">
											<%-- <sec:csrfInput/> --%>
											<div class="media align-self-center">
												<img class="align-self-center"
													src="https://avatars.dicebear.com/api/micah/${USERNAME}.svg"
													alt="Generic placeholder image">
												<div class="media-body">
													<div class="input-group text-box">
														<sec:csrfInput />
														<input type="hidden" value="${param.bdNo}" name="bdNo" />
														<input type="hidden" value="${USERNAME}" name="memId">
														<input type="hidden" value="${param.pageNum}" name="pageNum" /> 
														<input type="hidden" value="${param.pageSize}" name="pageSize"> 
														<input class="form-control input-txt-bx" type="text" name="rpyCnt" placeholder="댓글을 작성해주세요." required="required"/>
														<div class="input-group-text">
															<input class="btn btn-primary" type="submit" style="margin: 30px;" value="작성" id="id_replySendButton">
														</div>
													</div>
												</div>
											</div>
										</form>
									</div>
								</li>

<!-- 댓글 리스트 -->
								<c:forEach items="${replyList}" var="replyVO" varStatus="status">
									<li>
										<div class="media align-self-center">
											<img class="align-self-center"
												src="https://avatars.dicebear.com/api/micah/${replyVO.memId}.svg"
												alt="Generic placeholder image">
											<div class="media-body">
												<div class="row">
													<div class="col-md-4">
															<h6 class="mt-0">${replyVO.memNm}<span>(MEMBER)</span></h6>
													</div>
													<div class="col-md-8">
														<ul class="comment-social">
														 <c:set var="memId" value="${replyVO.memId}" />
														   <c:if test="${USER == replyVO.memId}">
															<li>
															<button class="btn btn-warning btn-xs" type="button" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal${replyVO.rpyNo}">
															<i class="fa fa-wrench"></i>수정</button>
															</li>
															<li>
															<button id="id_deletereplybtn" class="btn btn-danger btn-xs" type="button" onclick="f_rpyDeleteBtn('${replyVO.rpyNo}')">
															<i class="fa fa-trash-o"></i>삭제</button>
															</li>
														   </c:if>
														
														   <c:if test="${USER != replyVO.memId}">
															<sec:authorize access="hasRole('EMPLOYEE')">
															<li>
															<button class="btn btn-warning btn-xs" type="button" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal${replyVO.rpyNo}">
															<i class="fa fa-wrench"></i>수정</button>
															</li>
															<li>
															<button id="id_deletereplybtn" class="btn btn-danger btn-xs" type="button" onclick="f_rpyDeleteBtn('${replyVO.rpyNo}')">
															<i class="fa fa-trash-o"></i>삭제</button>
															</li>
															</sec:authorize>
														   </c:if>
															
															<li><i class="icon-calendar"></i>
															<mark><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${replyVO.rpyWtDt}" /></mark></li>
														</ul>
													</div>
												</div>
												<div class="left-box" style="float:left;width:92%;">
												<p><strong>${replyVO.rpyCnt}</strong></p>
												</div>

											</div>
										</div>
									</li>
								
								</c:forEach>
							</ul>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>
<!-- 상세보기에서 수정 버튼이 있어야할 모달창 -->
<c:forEach items="${replyList}" var="replyVO" varStatus="status">
			<div class="modal fade" id="exampleModal${replyVO.rpyNo }" tabindex="-1" aria-labelledby="exampleModalLabel" style="display: none;" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">댓글 상세보기</h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close" data-bs-original-title="" title=""></button>
                          </div>
                          <div class="modal-body">
							<div class="row">
							<div class="form-group has-success has-feedback ">
								<label class="control-label " for="inputSuccess4">작성자아이디</label> 
								<input type="text" class="form-control" id="inputSuccess4" aria-describedby="inputSuccess4Status" value="${replyVO.memNm}" readonly="readonly">
								<label class="control-label " for="inputSuccess4">작성일</label> 
								<input type="hidden" value="${pageNum}" name="pageNum" /> 
								<input type="hidden" value="${pageSize}" name="pageSize"> 
								<input type="text" class="form-control" id="inputSuccess4" aria-describedby="inputSuccess4Status" value="<fmt:formatDate value="${replyVO.rpyWtDt}" pattern="yyyy-MM-dd"></fmt:formatDate>" readonly="readonly">
								<label class="control-label " for="inputSuccess4">내용</label> 
							<textarea class="form-control col-sm-5" rows="5" id="id_${replyVO.rpyNo }" >${replyVO.rpyCnt}</textarea>
							<br>
							</div>
							</div>
                          </div>
<!-- 모달창 푸터 수정 닫기 버튼 -->
                          <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-bs-original-title="" title="" onclick="f_replyupdatebtn('${replyVO.rpyNo}')">수정</button>
                            <button class="btn btn-primary" type="button" data-bs-dismiss="modal" data-bs-original-title="" title="">닫기</button>
                          </div>
                        </div>
                      </div>
                    </div>			
</c:forEach>
<!-- Container-fluid Ends-->


<script>

	// 댓글 상세보기 모달 창
	const c_modals = document.querySelectorAll("#modal");
	const c_modalWindows = document.querySelectorAll("#modal > .modal-window");
	
	function f_rpyViewHide(p_index){
		c_modals[p_index].style.display="none";		
	}
	
	function f_allModalHide(){
		for(let hiyahoModal of c_modals){
			hiyahoModal.style.display="none";
		}
	}
	
    function f_rpyDetailView(p_index){
		f_allModalHide();
		c_modals[p_index].style.display="flex";
		c_modalWindows[p_index].style.top = document.documentElement.scrollTop - 400 + "px";  // 대략 항상 중간
		
	}

// 	------------------------------------------------------------------------------------------------------

// 	게시글 수정 버튼
	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';
	
	var v_fbForm = document.querySelector("#fb_form");
	var bdno = "${freeboardVO.bdNo}";
	var userName = "${USERNAME}";
	
	var v_updatebtn = document.querySelector("#id_updatebtn");	

	
	f_updatebtn = () => {
		location.href="${CONTEXT_PATH}/freeboard/update?bdNo=${freeboardVO.bdNo}&pageNum=${pageNum}&pageSize=${pageSize}";
	}
	
	if(v_updatebtn != null){
 		v_updatebtn.addEventListener("click", f_updatebtn);		
	}

// 	------------------------------------------------------------------------------------------------------

// 댓글 수정 버튼
// 	const c_replyupdatebtn = document.querySelector("#id_replyupdatebtn");
	
// 	if(c_replyupdatebtn != null){
// 		c_replyupdatebtn.addEventListener("click", f_replyupdatebtn);
// 	}
	
	function f_replyupdatebtn(rpyno){
		
        let xhr = new XMLHttpRequest();
        xhr.open("post","${CONTEXT_PATH}/reply/update",true);
        xhr.onreadystatechange = function(){
            if(xhr.readyState == 4 && xhr.status == 200){
        		console.log((xhr.responseText));    	
        		
        		const Toast = Swal.mixin({
                     toast: true,
                     position: 'center-center',
                     showConfirmButton: false,
                     timer: 2000,
                     timerProgressBar: true,
                     didOpen: (toast) => {
                         toast.addEventListener('mouseenter', Swal.stopTimer),
                         toast.addEventListener('mouseleave', Swal.resumeTimer)
                     }
                 })

                 Toast.fire({
                     icon: 'warning',
                     title: '댓글이 수정되는 중입니다.'
                 }).then((result) =>{
                	 if(result.dismiss === Toast.DismissReason.timer){
        				location.replace(location.href);
                	 }
                 });
        		
            };

        }
        xhr.setRequestHeader(tokenHeader, tokenValue);
        xhr.setRequestHeader('Content-type','application/json;charset=utf-8')
        let myJsonData = {
				"rpyNo" : rpyno,
				"rpyCnt" : document.querySelector("#id_" + rpyno).value
        };
        
        console.log(myJsonData);
        xhr.send(JSON.stringify(myJsonData));
		
	}

// 	-------------------------------------------------------------------------------------------------------	
// 	게시글 좋아요 버튼
	const c_like = document.querySelector("#like");
	
	function f_like(){	
		console.log("좋아요!");
		let mySpan;
		if(event.target.tagName == "A"){
			mySpan = event.target.children[1];
		}else {
			mySpan = event.target.parentElement.children[1];
		}
		console.log("체킁킁",mySpan.innerHTML);
		
        let xhr = new XMLHttpRequest();
        xhr.open("post","${CONTEXT_PATH}/freeboard/detail",true);
        xhr.onreadystatechange = function(){
            if(xhr.readyState == 4 && xhr.status == 200){
            	console.log("hj",JSON.parse(xhr.responseText)); // 항상 이걸로 넘어온 값 눈으로 확인
            	console.log(mySpan);
            	mySpan.innerHTML = JSON.parse(xhr.responseText) + "Hits";
            }
        }
        xhr.setRequestHeader(tokenHeader, tokenValue);
        xhr.setRequestHeader('Content-type','application/json;charset=utf-8')
        let myJsonData = {
				bdNo : bdno,
				memId : userName
        };
        xhr.send(JSON.stringify(myJsonData));
    }
	
// 	-------------------------------------------------------------------------------------------------------
// 	게시글 삭제 버튼
	var v_deletebtn = document.querySelector("#id_deletebtn");	

	f_deletebtn = () => {
        let xhr = new XMLHttpRequest();
        xhr.open("post","${CONTEXT_PATH}/freeboard/delete",true);
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
		                location.href="${CONTEXT_PATH}/freeboard/main";        
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

// 	-------------------------------------------------------------------------------------------------------
// 댓글 삭제 버튼
	const c_deletereplybtn = document.querySelector("id_deletereplybtn");
	
	f_rpyDeleteBtn = (rpyno) => {
		  let xhr = new XMLHttpRequest();
	        xhr.open("post","${CONTEXT_PATH}/reply/delete",true);
	        xhr.onreadystatechange = function(){
	            if(xhr.readyState == 4 && xhr.status == 200){
	            	let result = xhr.responseText;
	        		const Toast = Swal.mixin({
	                     toast: true,
	                     position: 'center-center',
	                     showConfirmButton: false,
	                     timer: 1500,
	                     timerProgressBar: true,
	                     didOpen: (toast) => {
	                         toast.addEventListener('mouseenter', Swal.stopTimer),
	                         toast.addEventListener('mouseleave', Swal.resumeTimer)
	                     }
	                 })

	                 Toast.fire({
	                     icon: 'success',
	                     title: '댓글이 삭제되었습니다.'
	                 }).then((result) =>{
	                	 if(result.dismiss === Toast.DismissReason.timer){
	         				location.replace(location.href);
	                 	 }
	                 });
	            }
	        }
	        xhr.setRequestHeader(tokenHeader, tokenValue);
	        xhr.setRequestHeader('Content-type','application/json');
	        let myJsonData = {
	        		"rpyNo" : rpyno
	        };
	        console.log(myJsonData);
	        xhr.send(JSON.stringify(myJsonData));
		
	}






</script>













