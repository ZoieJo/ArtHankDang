<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!-- 스타일 -->
<style>
input[type=checkbox] {
	zoom: 1.5;
}
table{
	table-layout: fixed;
}
table th{
	background-color: rgb(30,90,90);
	color: white;
}
.jsgrid-row:hover{
	cursor:pointer;
	background-color: rgba(36, 105, 92, 0.1);
}
#pagingDiv{
	font-family: ngB;
	font-size: 16px;
}
</style>
<!-- 메시지 알림 뜨기 -->
<script type="text/javascript">
    let msg = "${msg}";
	window.onload = function(){
	    if(msg){        
	        Swal.fire({
	            icon: 'success',
	            title: '알림',
	            text: msg
	        });
	     }
	}
</script>
<!-- 스크립트 -->
<script type="text/javascript">
	/* 이벤트 전달 막는 함수 */
	function stopPro(){
		event.stopPropagation();
	}
	
	/* 상세히 보기 */
	function msgDtl(p){
		console.log(p);
    	console.log("@@@@@@@@@@@@@@@@@@@@@@@@ 메시지(MMS) 상세 보기 @@@@@@@@@@@@@@@@@@@@@@@@@@");
		let url = "${CONTEXT_PATH}/msg/employee/detail?msgNo=" + p;
		let xhr = new XMLHttpRequest();
		
		xhr.open("get", url, true);
		xhr.onreadystatechange = function(){
		  if (xhr.readyState == 4 && xhr.status == 200) {
			 console.log(xhr.responseText);
			 let data = JSON.parse(xhr.responseText);
		     
			 let ModalBody = document.querySelector("#modal_detail"); // 모달 몸통
		     let l_code = "";
		     
		     l_code += "<div>";
		     
		     let gubun = '단체';
		     if(data.msgCmcd == 'MSG01') {gubun = '개인'}
		     l_code += "<p><strong>구분</strong><br>" + gubun + "</p>";
		     
		     l_code += "<p><strong>내용</strong><br>" + data.msgCnt + "</p>";
		     console.log(data.msgCnt);
		     
		     l_code += "<p><strong>받는이</strong><br>" + data.msgRc + "</p>";
		     
// 		     if(data.msgSd == '${myId}'){
// 			     l_code += "<p><strong>보낸이</strong><br>나</p>";
// 		     } else{
// 			     l_code += "<p><strong>보낸이</strong><br>" + data.empNm + "</p>";
// 		     }
		     
		     l_code += "<p><strong>보낸날짜</strong><br>" + data.msgSntDt + "</p>";
		     
		     let pp = data.msgNo;
		     // 개별 삭제
		     $('#sntDtlDel').val(pp);
		     
		     ModalBody.innerHTML = l_code;
		     $('#modalMsgDtl').modal('show'); // 모달 열기
		  }
		}
		xhr.send();		
	}
</script>

<div class="container-fluid">
	<div class="page-header" style="padding: 20px;">
		<div class="row">
			<div class="col-sm-12">
				<h3>메시지(MMS)내역</h3>
				<!-- 제목 하단 페이지 경로 -->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
					<li class="breadcrumb-item"><a href="#">학원관리</a></li>
					<li class="breadcrumb-item"><a href="#">메시지(MMS)내역</a></li>
				</ol>
			</div>
		</div>
	</div>
</div>
<!-- 바디 시작 -->
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header pb-0">
                    <!-- 검색 -->
				  	<form id="msgfrm" action="${CONTEXT_PATH}/msg/employee/list" method="post">
						<div class="input-group">
							<div class="row">
							    <div class="col">
							      <div class="mb-0">
							        <select class="form-select digits" name="type" id="selectType" style="height: 40px;">
							          <option value='' selected>--구분--</option>
							          <option value='R'>받는이</option>
							          <option value='C'>내용</option>
							        </select>
							      </div>
							    </div>
							</div>
							<input type="text" class="form-control" name="keyword"
							placeholder="메시지(MMS) 내용 혹은 받는이를 입력해 주세요." value="" id="keyword">
							<div class="input-group-append">
								<button class="btn btn-secondary" type="button" id="searchBtn" style="height: 40px;"><i class="fa fa-search"></i></button>
								<button id="resetSrh"type="button" class="btn btn-light btn-sm" style="height:40px; font-family:ngB; font-size:15px; padding: 7.5px 20px 7.5px 20px;">초기화</button>
							</div>
							<input type="hidden" name="myId" value="${myId}">
							<sec:csrfInput/>
						</div>
					</form>
				  
				</div>                   
                
                <div class="card-body">
                    <div id="batchDelete" class="jsgrid" style="position:relative; height:auto; width:100%;">
	                	<!-- 데이터 헤더 -->
                        <div class="jsgrid-grid-header jsgrid-header-scrollbar">
                            <table class="jsgrid-table" style="height:auto; width:100%;">
                                <tr class="jsgrid-header-row" style="text-align:center;">
                                    <th class="jsgrid-header-cell" style="width:10%;">NO</th>
                                    <th class="jsgrid-header-cell" style="width:10%;">구분</th>
                                    <th class="jsgrid-header-cell" style="width:35%;">내용</th>
                                    <th class="jsgrid-header-cell" style="width:15%;">보낸날짜</th>
                                    <th class="jsgrid-header-cell" style="width:15%;">받는이</th>
                                    <th class="jsgrid-header-cell" style="width:15%;">
                                    <button type="button" class="btn btn-danger btn-sm btn-delete mb-0" id="delAll">삭제</button></th>
                                </tr>
                            </table>
                        </div>
                        
						<c:set var="p" value="${paging}"/>
                        <!-- 데이터 내용 -->
                        <div class="jsgrid-grid-body" id="listCtr">
                            <table class="jsgrid-table" style="height:auto; width:100%;">
                                <tbody>
                                <c:if test="${empty msgList}">
                                	<tr class="jsgrid-row">
                                		<td class="jsgrid-cell"  style="text-align:center;cursor:default;" colspan="6"> ** 찾으시는 검색어의 메시지가 존재하지 않습니다 **</td>
                                	</tr>
                                </c:if>
                                <c:if test="${!empty msgList}">
                                <c:forEach var="msg" items="${msgList}" varStatus="status" >
                                    <tr class="jsgrid-row" onclick="msgDtl(${msg.msgNo})">
                                        <td class="jsgrid-cell" style="width:10%; text-align:center;">${status.count}</td>
                                        
										<c:if test="${msg.msgCmcd eq 'MSG01'}">
	                                        <td class="jsgrid-cell" style="width:10%; text-align:center;">개인</td>
										</c:if>
										<c:if test="${msg.msgCmcd eq 'MSG02'}">
	                                        <td class="jsgrid-cell" style="width:10%; text-align:center;">단체</td>
										</c:if>

                                        <td class="jsgrid-cell" style="width:35%; text-align:left; white-space:nowrap; text-overflow:ellipsis; overflow:hidden;">${msg.msgCnt}</td>

                                        <td class="jsgrid-cell" style="width:15%; text-align:center;"><fmt:formatDate value="${msg.msgSntDt}" pattern="yyyy-MM-dd"/></td>

                                        <td class="jsgrid-cell" style="width:15%; text-align:center; white-space:nowrap; text-overflow:ellipsis; overflow:hidden;">${msg.msgRc}</td>

                                        <td class="jsgrid-cell" style="width:15%; text-align:center;" onclick="stopPro()"><input type="checkbox" name="msgDele" value="${msg.msgNo}">
                                        </td>
                                    </tr>
								</c:forEach>                                    
                                </c:if>
                                </tbody>
                            </table>
                        </div>
						<form action="${CONTEXT_PATH}/msg/employee/allDelete" method="post" style="display: none;">
							<input type="hidden" value="" name="msgNo" id="msgDelWn" >
							<sec:csrfInput/>
							<input type="submit" id="allDelSend">
						</form>
                        
                        <!-- 데이터 상세보기 모달 -->
                        <div class="modal fade" id="modalMsgDtl" tabindex="-1" aria-labelledby="modalSntNteDtl" style="display: none;" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered" role="document">
							   <div class="modal-content">
							   
							    <!-- 모달 머리 -->
							     <div class="modal-header">
							         <h5 class="modal-title">보낸 메시지(MMS) 상세히...</h5>
							         <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="close"></button>
							     </div>
							     
							      <!-- 모달 몸통 -->
							     <div class="modal-body" id="modal_detail"></div>
							     
							      <!-- 모달 발 -->
							     <div class="modal-footer">
							        <form action="${CONTEXT_PATH}/msg/employee/delete" method="POST" style="display: none;">
							        	<input type="hidden" id="sntDtlDel" value="" name="msgNo">
							        	<sec:csrfInput/>
							        	<button id="formSubmit">전송</button>
							        </form>
							        <button class="btn btn-danger" type="button" id="msgDel">삭제</button>
							        <button class="btn btn-info" type="button" data-bs-dismiss="modal">닫기</button>
							     </div>
							     
							   </div>
							 </div>
						</div>                        
                        
                        
                        <!-- 페이징 -->
                        <div class="jsgrid-pager-container" style="text-align: center;" id="pagingCtr">
                            <div class="jsgrid-pager" id="pagingDiv">
                            	<!-- 처음 -->
                                <c:if test="${p.nowPage eq 1}">
	  		                       	<span class="jsgrid-pager-nav-button disabled">처음</span>  
                            	</c:if>
                                <c:if test="${p.nowPage ne 1}">
  		                       	<span class="jsgrid-pager-nav-button"><a href="${CONTEXT_PATH}/msg/employee/list?nowPage=1&keyword=${p.keyword}&type=${p.type}">처음</a></span>
  		                       	</c:if>
  		                       	
                            	<!-- 이전 -->
                                <c:if test="${p.nowPage ne 1}">
	                            	<span class="jsgrid-pager-nav-button jsgrid-pager-nav-inactive-button">
	                            		<a href="${CONTEXT_PATH}/msg/employee/list?nowPage=${p.nowPage - 1}&keyword=${p.keyword}&type=${p.type}">이전</a>
	                            	</span>
                                </c:if>
                                
                            	<!-- 페이지 숫자 -->
	                            <c:forEach begin="${p.startPage}" end="${p.endPage}" var="num" step="1">
	                                <c:if test="${num eq p.nowPage}">
		                                <span class="jsgrid-pager-page" style="background-color:rgb(36, 105, 92); color:white">${num}</span>
	                                </c:if>
	                                <c:if test="${num ne p.nowPage}">
	                                	<span class="jsgrid-pager-page" style="cursor:pointer">
	                                		<a href="${CONTEXT_PATH}/msg/employee/list?nowPage=${num}&keyword=${p.keyword}&type=${p.type}">${num}</a>
	                                	</span>
	                                </c:if>
                            	</c:forEach>
                                
                            	<!-- 다음 -->
                                <c:if test="${p.nowPage ne p.endPage}">
                                	<span class="jsgrid-pager-nav-button" style="cursor:pointer">
                                		<a href="${CONTEXT_PATH}/msg/employee/list?nowPage=${p.nowPage + 1}&keyword=${p.keyword}&type=${p.type}">다음</a>
                                	</span>
                                </c:if>
                                
                            	<!-- 끝 -->
                                <c:if test="${p.nowPage eq p.lastPage}">
	  		                       	<span class="jsgrid-pager-nav-button disabled">끝</span>  
                            	</c:if>                                
                                <c:if test="${p.nowPage ne p.lastPage}">
                           		<span class="jsgrid-pager-nav-button"><a href="${CONTEXT_PATH}/msg/employee/list?nowPage=${p.lastPage}&keyword=${p.keyword}&type=${p.type}">끝</a></span>
								</c:if>
                            </div>
                        </div>
                        
                    </div>
                </div>
                <!-- card-body 끝 -->
            </div>
        </div>
    </div>
</div>
<!-- 스크립트 -->
<script type="text/javascript">
	/* 초기화 버튼 */
	$('#resetSrh').on("click", function(){
		location.href = "${CONTEXT_PATH}/msg/employee/list";
	});
	
	/* 개별 삭제 버튼 */
	$('#msgDel').on("click", function(){
		console.log("@@@@@@@@@@@@@@@@@@@@@@@@ 메시지(MMS) 개별 삭제 @@@@@@@@@@@@@@@@@@@@@@@@@@");
		$('#formSubmit').trigger("click");
	});
	
	/* 일괄삭제 */
	$("#delAll").click(function () {
		Swal.fire({
		  title: '삭제확인',
		  text: '해당 메시지(MMS) 내역을 삭제하시겠습니까?',
		  icon: 'question',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '확인',
		  cancelButtonText: '취소',
		  reverseButtons: false, // 버튼 순서 거꾸로
		  
		}).then((result) => {
		  if (result.isConfirmed) {
			let chk_Val = '';
			$("input:checkbox[name=msgDele]:checked").each(function(i){
				// console.log($(this).val());
				chk_Val += $(this).val() + ",";
			});
			$.trim(chk_Val);
			let msgNoList = chk_Val.substring(0, chk_Val.length - 1);
			// console.log(msgNoList);
			
			$("#msgDelWn").val(msgNoList);
			console.log("숨겨진 폼태그 value로 넣음 "+ $("#msgDelWn").val());
			// 전송
			$('#allDelSend').trigger("click");

		  }
		})
	});
	
	
	/* 검색 */
	const c_searchBtn = document.querySelector("#searchBtn");
	const c_keyword = document.querySelector("#keyword");
	const c_selectType = document.querySelector("#selectType");
	const c_listCtr = document.querySelector("#listCtr"); // 리스트 몸통
	const c_pagingCtr = document.querySelector("#pagingCtr"); // 페이징 몸통
	
	
	c_searchBtn.onclick = function(){
		// 검색 타입 + 키워드 가져오기
		let tp = c_selectType.value;
		let kw = c_keyword.value;
		console.log(tp); // 타입
		console.log(kw); // 키워드
		
		if(!tp){
			Swal.fire(
			  "알림",
			  "검색 타입을 선택해 주세요.",
			  "warning"
			);
			return;
		}
		if(!kw){
			Swal.fire(
			  '알림',
			  '검색 키워드를 입력해 주세요.',
			  'warning'
			);
			return;
		}
		
		document.querySelector('#msgfrm').submit();
	} // end 검색
	
</script>