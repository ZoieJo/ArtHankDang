<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<style>
body {
  min-height: 100%;
  font-family: ngB;
}
#tbodyRcv tr:hover{
   background-color: rgba(36, 105, 92, 0.1);
   cursor:pointer;
}
#tbodySnt tr:hover{
   background-color: rgba(36, 105, 92, 0.1);
   cursor:pointer;
}
input[type=checkbox] {
	zoom: 1.5;
}
table {
	table-layout: fixed;
}
.cell-cntTl{
	text-align: left;
	white-space:nowrap;
	text-overflow:ellipsis;
	overflow:hidden;
}
.list-inline-item a{
	padding: 20px 10px 10px 10px;
	font-weight: bold;
	cursor: pointer;
}
.jsgrid-pager-page{
	color: rgb(44, 50, 63);
}
</style>

<!-- 내용 머리 -->
<script type="text/javascript">
    let msg = "${msg}";
	let goRcvBox = "${goRcvBox}";

	window.onload = function(){
	    if(msg){        
	        Swal.fire({
	            icon: 'success',
	            title: '알림',
	            text: msg
	        });
	     }
	    
		if(goRcvBox){
			f_rcvNteBox(1,5);
		}
	}
</script>
<div class="container-fluid">
   <div class="page-header" style="padding: 20px;">
      <div class="row">
         <div class="col-sm-12">
            <h3>업무 쪽지</h3>
			<!-- 제목 하단 페이지 경로 -->
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
				<li class="breadcrumb-item"><a href="javascript:void(0)">업무쪽지</a></li>
			</ol>            
         </div>
      </div>
   </div>
</div>

<!-- 내용 몸통-->
<div class="container-fluid">
	<div class="row">
      <div class="col call-chat-sidebar" style="height: auto;">
      	<div class="card">
			<div class="card-body chat-body">
			
				<div class="chat-box">
                  <!-- 쪽지 사이드 보내는 사람 목록 -->
                  <div class="chat-left-aside">
                     <!-- 내 사진? 넣기 -->
                     <div class="media">
                        <div class="media-body">
                           <div class="about">
                              <!-- 여기에 로그인 한 사람 -->
                              <div class="name f-w-600">나</div>
                              <div class="status">${myId}</div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <hr>
                    <!-- 직원 목록 뿌리기 -->
                    <div class="people-list" id="people-list">
                    	<div style="font-size: 15px;color: rgb(70, 70, 70);font-weight: bold;">교직원 주소록</div>
                    </div>
				</div>
                <!-- Chat left side Ends-->
                
				<!-- 트리구조 -->
				<div id="treecheckbox" class="jstree jstree-2 jstree-default jstree-checkbox-selection" role="tree" aria-multiselectable="true" tabindex="0" aria-activedescendant="j2_4" aria-busy="false" aria-selected="false">
					<ul class="jstree-container-ul jstree-children" role="group">
						<li role="treeitem" aria-selected="true" aria-level="1" aria-labelledby="allEmp_anchor" aria-expanded="true" id="allEmp" class="jstree-node jstree-open">
							 <i class="jstree-icon jstree-ocl" role="presentation"></i>
						     <a class="jstree-anchor " href="#" tabindex="-1" id="allEmp_anchor">
						          <i class="jstree-icon jstree-checkbox" role="presentation"></i>
						          <i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>직원
						     </a>
						     <!-- 직원 트리 구조 -->
						     <ul role="group" class="jstree-children" style="">
						          <!-- 관리 부서 -->
						          <li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="management_anchor" aria-expanded="true" 
						          id="management" class="jstree-node jstree-open jstree-last">
						               <i class="jstree-icon jstree-ocl" role="presentation"></i>
						               <a class="jstree-anchor " href="#" tabindex="-1" id="management_anchor">
							               <i class="jstree-icon jstree-checkbox" role="presentation"></i>
							               <i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>관리 부서
						               </a>
						               <ul role="group" class="jstree-children">
			               	                <c:forEach var="item" items="${emplist }">
	                							<c:if test="${item.empDepNm  eq 'MAN'}">
								                    <li role="treeitem" data-jstree="{&quot;type&quot;:&quot;file&quot;}" aria-selected="false" aria-level="3" aria-labelledby="${item.empEmail }" id="${item.empId }"
								                     class="jstree-node jstree-leaf">
								                         <i class="jstree-icon jstree-ocl" role="presentation"></i>
								                         <a  class="jstree-anchor" href="#" tabindex="-1" id="${item.empEmail}" title="${item.empId}" >
									                         <i class="jstree-icon jstree-checkbox" role="presentation"></i>
									                         <i class="icofont icofont-user" role="presentation"></i>${item.empNm}
									                     </a>
									                </li>
									           </c:if>
								           </c:forEach>
						               </ul>
						          </li>
							          
						          <!-- 경영 부서 -->
						          <li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="business_anchor" aria-expanded="true" 
						          id="busniess" class="jstree-node jstree-open jstree-last">
						               <i class="jstree-icon jstree-ocl" role="presentation"></i>
						               <a class="jstree-anchor " href="#" tabindex="-1" id="business_anchor">
							               <i class="jstree-icon jstree-checkbox" role="presentation"></i>
							               <i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>경영 부서
						               </a>
						               
						               <ul role="group" class="jstree-children">
                							<c:forEach var="item" items="${emplist }">
	            							   	<c:if test="${item.empDepNm  eq 'BUS'}">
								                    <li role="treeitem" data-jstree="{&quot;type&quot;:&quot;file&quot;}" aria-selected="false" aria-level="3" aria-labelledby="${item.empEmail}" id="${item.empId }" 
								                    class="jstree-node jstree-leaf">
								                         <i class="jstree-icon jstree-ocl" role="presentation"></i>
								                         <a class="jstree-anchor " href="#" tabindex="-1" id="${item.empEmail}" title="${item.empId}" >
								                         	<i class="jstree-icon jstree-checkbox" role="presentation"></i>
								                         	<i class="jstree-icon jstree-themeicon icofont icofont-file-alt font-dark jstree-themeicon-custom" role="presentation"></i>${item.empNm}
								                         </a>
								                    </li>
								               </c:if>
							               </c:forEach>
						               </ul>
						          </li>
						          
						          <!-- 교육 부서 -->
						          <li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="education_anchor" aria-expanded="true" id="education" class="jstree-node  jstree-open jstree-last">
						               <i class="jstree-icon jstree-ocl" role="presentation"></i>
						               <a class="jstree-anchor " href="#" tabindex="-1" id="education_anchor">
							               <i class="jstree-icon jstree-checkbox" role="presentation"></i>
							               <i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>교육 부서
						               </a>

						               <ul role="group" class="jstree-children">
										<c:forEach var="item" items="${emplist }">
							               <c:if test="${item.empDepNm  eq 'EDU'}">
							                   <li role="treeitem" data-jstree="{&quot;type&quot;:&quot;file&quot;}" aria-selected="false" aria-level="3" aria-labelledby="${item.empEmail }" id="${item.empId }"
							                    class="jstree-node jstree-leaf">
							                        <i class="jstree-icon jstree-ocl" role="presentation"></i>
							                        <a class="jstree-anchor " href="#" tabindex="-1" id="${item.empEmail}" title="${item.empId}" >
							                        	<i class="jstree-icon jstree-checkbox" role="presentation"></i>
							                        	<i class="jstree-icon jstree-themeicon icofont icofont-file-alt font-dark jstree-themeicon-custom" role="presentation"></i>${item.empNm }
							                        </a>
							                   </li>
							               </c:if>
						               	</c:forEach>
						               </ul>
						          </li>
						     </ul> <!-- 직원 트리구조 끝 -->
						</li>
					</ul>
				</div> <!-- 트리구조 완전 끝 -->
			</div>
		</div>
	</div>


      <div class="col call-chat-body">
         <div class="card">
            <div class="card-body m-1">
               <div class="row chat-box">
                  <!-- 쪽지 -->
                  <div class="col chat-right-aside">
                     <!-- 쪽지 start-->
                     <div class="chat">
                        <!-- 쪽지 머리 start-->
                        <div class="media chat-header clearfix">
                           <div class="media-body">
                              <ul class="list-inline float-start float-sm-end chat-menu-icons">
                                 <li class="list-inline-item"><a id="st_nte" onclick="f_sntNteBox(1, 5)">보낸쪽지<i class="fa fa-mail-forward"></i></a></li>
                                 <li class="list-inline-item"><a id="rc_nte" onclick="f_rcvNteBox(1, 5)">받은쪽지<i class="fa fa-mail-reply"></i></a></li>
                                 <li class="list-inline-item"><a id="wt_nte" style="color:red">쪽지작성<i class="fa fa-pencil"></i></a></li>
                              </ul>
                           </div>
                        </div>
                        <!-- 쪽지 머리 end-->

                        <!-- 보낸 쪽지 함 -->
                        <div class="card" id="nteSt_disp" style="display:none;" >
                           <!-- 카드 머리 -->
                           <div class="card-header pb-0">
                              <h5>보낸 쪽지함</h5>
                           </div>
                           <!-- 카드 몸통 -->
                           <div class="card-body" style="text-align: center;">
                              <div id="batchDelete" class="jsgrid" style="position: relative; height: auto; width: 100%; margin: 0;">
                              <div class="jsgrid-grid-header">
                                 <table class="jsgrid-table"  style="width:100%; background-color: rgb(30,90,90); color: white;">
                                    <tr class="jsgrid-header-row">
                                       <th class="jsgrid-header-cell" style="width:10%;">No</th>
                                       <th class="jsgrid-header-cell" style="width:20%;">받는이ID</th>
                                       <th class="jsgrid-header-cell" style="width:40%;">제목</th>
                                       <th class="jsgrid-header-cell" style="width:20%;">보낸날짜</th>
                                       <th class="jsgrid-header-cell jsgrid-align-center" style="width: 10%;"><button id="sntAllDel" type="button" class="btn btn-danger btn-xs btn-delete mb-0">삭제</button></th>
                                    </tr>
                                 </table>
                              </div>
                              
                              <div class="jsgrid-grid-body">
                                 <table class="jsgrid-table"  style="width:100%">
                                    <tbody id="tbodySnt"></tbody>
                                 </table>
                              </div>
                              
                              <!-- 보낸 쪽지 페이징 -->
                              <div class="jsgrid-pager-container" style="width:100%">
                                 <div class="jsgrid-pager" id="sntPaging">
                                 </div>
                              </div>
                              
                              </div> <!-- batchDelete end -->
                           </div> <!--카드 몸통 end -->
                        </div>
                        
                        <!-- 보낸 쪽지 상세 보기 모달 -->
                        <div class="modal fade" id="modalSntNteDtl" tabindex="-1" aria-labelledby="modalSntNteDtl" style="display: none;" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered" role="document">
							   <div class="modal-content">
							    <!-- 모달 머리 -->
							      <div class="modal-header">
							         <h5 class="modal-title">보낸 쪽지 상세히...</h5>
							         <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="close" data-bs-original-title="" title=""></button>
							      </div>
							      <!-- 모달 몸통 -->
							      <div class="modal-body" id="modal-snt-dtl">
							      </div>
							      <!-- 모달 발 -->
							      <div class="modal-footer">
							        <button class="btn btn-danger" type="button" id="sntDtlDel">삭제</button>
							        <button class="btn btn-info" type="button" data-bs-dismiss="modal">닫기</button>
							      </div>
							    </div>
							  </div>
						</div>
                        
                        <!-- 받은 쪽지 함 -->
                        <div class="card" id="nteRc_disp" style="display:none;" >
                           <!-- 카드 머리 -->
                           <div class="card-header pb-0">
                              <h5>받은 쪽지함</h5>
                           </div>
                           <!-- 카드 몸통 -->
                           <div class="card-body" style="text-align: center;">
                              <div id="batchDelete" class="jsgrid" style="position: relative; height: auto; width:100%; margin: 0;">
	                              <div class="jsgrid-grid-header jsgrid-header-scrollbar">
	                                 <table class="jsgrid-table"  style="width:100%; background-color: rgb(30,90,90); color: white;">
	                                    <tr class="jsgrid-header-row">
	                                       <th class="jsgrid-header-cell" style="width: 10%;">No</th>
	                                       <th class="jsgrid-header-cell" style="width: 20%;">보낸이ID</th>
	                                       <th class="jsgrid-header-cell" style="width: 30%;">제목</th>
	                                       <th class="jsgrid-header-cell" style="width: 20%;">받은날짜</th>
	                                       <th class="jsgrid-header-cell" style="width: 10%;">확인</th>
	                                       <th class="jsgrid-header-cell jsgrid-align-center" style="width:10%;"><button id="rcvAllDel" type="button" class="btn btn-danger btn-xs btn-delete mb-0">삭제</button></th>
	                                    </tr>
	                                 </table>
	                              </div>
	                              
	                              <div class="jsgrid-grid-body">
	                                 <table class="jsgrid-table" style="width:100%">
	                                    <tbody id="tbodyRcv"></tbody>
	                                 </table>
	                              </div>
	                              
	                              <!-- 받은 쪽지 페이징 -->
	                              <div class="jsgrid-pager-container" style="width:100%; color: black;">
	                                 <div class="jsgrid-pager" id="rcvPaging"></div>
	                              </div>
	                              
                              </div> <!-- batchDelete end -->
                           </div> <!--카드 몸통 end -->
                        </div>
                        
                        <!-- 받은 쪽지 상세 보기 모달 -->
						<div class="modal fade" id="modalRcvNteDtl" tabindex="-1" aria-labelledby="modalRcvNteDtl" style="display: none;" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="modal-content">
									<!-- 모달 머리 -->
									<div class="modal-header">
									  <h5 class="modal-title">받은 쪽지 상세 페이지</h5>
									  <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="close" data-bs-original-title="" title=""></button>
									</div>
									<!-- 모달 몸통 -->
									<div class="modal-body" id="modal-rcv-dtl"></div>
									<!-- 모달 발 -->
									<div class="modal-footer">
									  <button class="btn btn-primary" type="button" id="rcvDtlDel">삭제</button>
									  <button class="btn btn-secondary" type="button" data-bs-dismiss="modal" id="rcvCls">닫기</button>
									</div>
								</div>
							</div>
						</div>
                        
                        
                        <!-- 쪽지 작성 폼 -->
                        <div id="nteWt_disp" style="display:block;">
                           <form action="${CONTEXT_PATH}/note/send" method="post">
                              <div class="col">
                                 <div class="m-1">
                                    <label class="form-label" for="nteRcDisp">받는 사람</label>
                                    <input class="form-control" id="nteRcDisp" type="text" value="" disabled="disabled" required="required">
                                 </div>
                                    <input id="nteRc" name="nteRc" type="hidden" required>
                              </div>
                              <div class="col">
                                 <div class="m-1">
                                    <input class="form-control" id="nteSd" name="nteSd" type="hidden" value="${myId}">
                                 </div>
                              </div>
                              <div class="col">
                                 <div class="m-1">
                                    <label class="form-label" for="nteTl">쪽지 제목</label>
                                    <input class="form-control" id="nteTl" name="nteTl" type="text" autofocus required>
                                 </div>
                              </div>
                              <div class="row">
                                 <div class="col">
                                    <div>
                                       <label class="form-label" for="nteCnt">쪽지 내용</label>
                                       <textarea class="form-control" id="nteCnt" name="nteCnt" rows="10" placeholder="내용을 입력해 주세요." style="resize: none;" required></textarea>
                                    </div>
                                 </div>
                              </div> <br>
                              <security:csrfInput/>
                              <p>
	                              <input type="reset" style="float: right; display: inline;" class="btn btn-info btn-sm" value="초기화">
	                              <input type="submit" style="float: right; display: inline; margin-right: 10px;" class="btn btn-primary btn-sm" id="nteSendBtn" value="전송">
                              </p>
                           </form>
                        </div>

                     </div>
                  </div>
                  <!-- 오른쪽 사이드바 끝 -->

               </div>
            </div>
         </div>
      </div>

   </div>
</div>
<!-- Container-fluid Ends-->
<script>
	/* 버튼을 클릭하면 실시간 전체 알림가는 코드 */
// 	$('#nteSendBtn').on('click', function(){
// 		let rcv = $('#nteRc').val(); // 보내는 사람 아이디 가져오기
// 		let rcvlist = rcv.split(','); // 보내는 사람인 경우 split으로 잘라서 for문 돌릴예정
// 		if(rcvlist.length > 1){
// 			// alert("자네, 여러명에게 보내는 군!");
// 			// alert(rcvlist.length);
// 			rcvlist.forEach(function(ID){
// 				// alert(ID); // 아이디
// 				let mmm = ID + "," + "님 쪽지가 도착했습니다.";
// 				sendMessage(mmm); // 전체 메시지 보내기
// 			});
// 		} else{
// 			// alert('에헴!! 한 사람 분량이군');
// 			let nnn = rcv + ',' + "님 쪽지가 도착했습니다.";
// 			sendMessage(nnn);
// 		}
// 	});

	// 넘겨줄 아이디
	let l_myId = '${myId}';
	// 뿌려줄 코드
	let code;
	// 보낸 쪽지
	let l_stNte = document.querySelector("#st_nte");
	let l_nteStDisp = document.querySelector("#nteSt_disp");
	
	// 받은 쪽지
	let l_rcNte = document.querySelector("#rc_nte");
	let l_nteRcDisp = document.querySelector("#nteRc_disp");
	
	// 쪽지 폼
	let l_wtNte = document.querySelector("#wt_nte");
	let l_nteWtDisp = document.querySelector("#nteWt_disp");
	
	// 토큰
	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';
	
	// 일괄 삭제 버튼
	const c_sntAllDel = document.querySelector("#sntAllDel");
	const c_rcvAllDel = document.querySelector("#rcvAllDel");
	
	// 개별 삭제 버튼(모달)
    let l_sntDtlDel = document.querySelector("#sntDtlDel");
    let l_rcvDtlDel = document.querySelector("#rcvDtlDel");
    
    // 이벤트 전달 막는 함수
    function stopPro(){
    	event.stopPropagation();
    	
    }
    
    // 페이징 뿌려주는 곳
    let l_sntPaging = document.querySelector("#sntPaging"); // 보낸 쪽지
    let l_rcvPaging = document.querySelector("#rcvPaging"); // 받은 쪽지
	let pageCode = ''; // 페이지 만드는 변수
	let p1 = "1";
	let p2 = "5";
	
	// tbody선택
	let l_tbodySnt = document.querySelector("#tbodySnt"); // 보낸쪽지
    let l_tbodyRcv = document.querySelector("#tbodyRcv"); // 받는쪽지
    
	// 트리뷰 -> 쪽지 보낼이 선택하기
    let list = ''; // 진짜 아이디 뿌려주는 곳
    let list2 = ''; // 누구 아이디인지 이름 보여주는 곳
    
// ==================================================================================================================
	
	/* 트리뷰 아이디 선택하기 */
	$(function(){
		$('#treecheckbox').on('changed.jstree', function(e,data){
			// 값 초기화
			$('#nteRc').val('');
			$('#nteRcDisp').val('');
			list = '';
			list2 = '';
			
		    var nodes = $("#treecheckbox").jstree(true).get_selected("full", true);
		    
		    for(node of nodes){
		    	console.log(node);
		        if(!node.children.length){
		            list += node.id + ',';
		            list2 += node.text.trim() + ',';
		        }
		    }
		    $.trim(list);
		    $.trim(list2);
		    
			const c_list = list.substring(0, list.length -1);
			const c_list2 = list2.substring(0, list2.length -1);
			
            console.log("hidden 으로 숨길 자료 list = "+ c_list);
            console.log("disp에서 보여줄 자료 list2 = "+ c_list2);
			
			$('#nteRc').val(c_list);
			$('#nteRcDisp').val(c_list2);
			
		});
	}); // 즉각실행 함수 끝

	
    /* 보낸 쪽지함 */
    function f_sntNteBox(now, num){
	   	console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@ 보낸 쪽지 함 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
	   	l_stNte.style.color = "red";
	   	l_rcNte.style.color = "rgb(36, 105, 92)";
	   	l_wtNte.style.color = "rgb(36, 105, 92)";
		l_nteWtDisp.style.display = "none";
		l_nteStDisp.style.display = "block";
		l_nteRcDisp.style.display = "none";
	      
		let pData = {
			"l_myId" : l_myId,
			"nowPage" : now,           // 디폴트 값
			"cntPerPage" : num         // 디폴트 값
		}
		
		let xhr = new XMLHttpRequest();
		xhr.open("post", "${CONTEXT_PATH}/note/stNte", true);
		xhr.onreadystatechange = function(){
			if (xhr.readyState == 4 && xhr.status == 200) {
				// console.log(xhr.responseText);
				let map = JSON.parse(xhr.responseText);
			   	let list = map.noteList;
			   	let page = map.paging;
				
				/* 보낸 쪽지 리스트*/
			   	// console.log(list);
			   	code = "";
			   	if(list.length == 0){
			   		code = "<tr><td class='jsgrid-cell' colspan='5'>** 보낸 쪽지가 없습니다 **</td></tr>";
			   	}
			   	else {
				   	for(let i=0; i<list.length; i++){
				    	code += '<tr class="jsgrid-row" " onclick="sntDtl('+ list[i].nteNo +')">';
				      	code += '<td class="jsgrid-cell" style="width: 10%;border-right: 1px dashed grey;">'+ (i+1) +'</td>';
	 			      	code += '<td class="jsgrid-cell" style="width: 20%;border-right: 1px dashed grey;">' + list[i].nteRc + '</td>';
				      	code += '<td class="jsgrid-cell cell-cntTl" style="width: 40%;border-right: 1px dashed grey;">' + list[i].nteTl + '</td>';
				      	let date = new Date(list[i].nteSntDt);
				      	code += '<td class="jsgrid-cell" style="width: 20%;border-right: 1px dashed grey;">' + date.getFullYear() +"/"+ (date.getMonth()+1) + "/" +  date.getDate() + '</td>';
				      	code += '<td class="jsgrid-cell" style="width: 10%;" onclick="stopPro()"><input type="checkbox" name="sntNteNo" value="'+ list[i].nteNo +'"></td>';
				      	code += '</tr>';
				   	}
			   	}
			   	l_tbodySnt.innerHTML = code;
			   	
			   	/* 보낸 쪽지 페이징 */
			   	// console.log(page);
			   	// console.log(page.cntPerPage);
			   	pageCode = '';
			   	
			   	// 이전 페이지
			   	if(page.startPage > 1){
			   		pageCode += '<span class="jsgrid-pager-nav-button" onclick="f_sntNteBox(' + (page.startPage - 1) + ',' + page.cntPerPage+')" style="cursor:pointer">이전</span>';
			   	}
			   	for(let i = page.startPage; i<= page.endPage; i++){
			   		if(i == page.nowPage){
			   			pageCode += '<span class="jsgrid-pager-page" style="color:green;font-weight:bold;">'+i+'</span>';
			   		} else{
			   			pageCode += '<span class="jsgrid-pager-page" onclick="f_sntNteBox('+i+','+ page.cntPerPage +')" style="cursor:pointer">'+i+'</span>';
			   		}
			   	}
			   	if(page.endPage != page.lastPage){
			   		pageCode += '<span class="jsgrid-pager-nav-button" onclick="f_sntNteBox('+(page.endPage+1)+','+ page.cntPerPage +')" style="cursor:pointer">다음</span>';
			   	}
			   	l_sntPaging.innerHTML = pageCode;
			   	
			} // end if
		} // end function
		xhr.setRequestHeader(tokenHeader, tokenValue);
		xhr.setRequestHeader("Content-Type", "application/json;chartset=utf-8");
		xhr.send(JSON.stringify(pData));
	}

		
    /* 보낸 쪽지 일괄 삭제 */
    c_sntAllDel.onclick = function(){
    	// 선택된 체크박스 값 foreach로 가져오기 
    	let chk_Val = [];
    	$("input:checkbox[name=sntNteNo]:checked").each(function(i) {
    		// 배열에 번호 담아주기
    		chk_Val.push($(this).val());
    	});
    	console.log(chk_Val); // 배열 찍어보기
    	
    	// 보내 줄 번호가 들어 있는 배열
        let data = {
			"nteNoList" : chk_Val
  		};
    	
    	// 전송ajax
        let xhr = new XMLHttpRequest();
        xhr.open("post", "${CONTEXT_PATH}/note/sntAllDel", true);
		xhr.onreadystatechange = function(){
			if (xhr.readyState == 4 && xhr.status == 200) {
				f_sntNteBox();
		        Swal.fire({ // 변경 내용 알림
		            icon: 'success',
		            title: '알림',
		            text: xhr.responseText
		        });	
				
			}
		}
		xhr.setRequestHeader(tokenHeader, tokenValue);
		xhr.setRequestHeader("Content-Type", "application/json;chartset=utf-8");
		xhr.send(JSON.stringify(data));
        
    }
    
    /* 보낸 쪽지 상세 보여주기 */
    function sntDtl(param) {
        console.log("@@@@@@@@@@@@@@@@@@ 보낸 쪽지 상세 열기 @@@@@@@@@@@@@@@@")
        let url = "${CONTEXT_PATH}/note/sntNteDtl?nteNo=" + param;
        let xhr = new XMLHttpRequest();
        xhr.open("get", url, true);
        xhr.onreadystatechange = function(){
          if (xhr.readyState == 4 && xhr.status == 200) {
        	  let data = JSON.parse(xhr.responseText);
			  let ModalBody = document.querySelector("#modal-snt-dtl"); // 모달 몸통
			  let l_code ="";
              l_code += "<div>";
 			  l_code += "<p><strong>받는이 ID(이름)</strong><br>" + data.nteRc +"(" + data.empNm  +")</p>";
 			  l_code += "<p><strong>제목</strong><br>" + data.nteTl + "</p>";
 			  l_code += "<p><strong>내용</strong><br>" + data.nteCnt + "</p>";
 		 	  let date = new Date(data.nteSntDt);
 			  l_code += "<p><strong>보낸날짜</strong><br>" + date.getFullYear() +"/"+ (date.getMonth()+1) + "/" +  date.getDate() + "</p>";
 			  l_code += "</div>";
 			
              l_sntDtlDel.title = data.nteNo;
              ModalBody.innerHTML = l_code;
             
         	 $('#modalSntNteDtl').modal('show'); // 모달 열기
          }
        }
        xhr.send();
	}
    
    /* 보낸 쪽지 상세 보기 삭제 */
    l_sntDtlDel.onclick = function(){
    	console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 받은 쪽지 삭제 @@@@@@@@@@@@@@@@@@@@@@@@");
		let param = l_sntDtlDel.title;
		let url = "${CONTEXT_PATH}/note/sntNteDtlDel?nteNo=" + param;
		let xhr = new XMLHttpRequest();
		
		xhr.open("get", url, true);
		xhr.onreadystatechange = function(){
		    if (xhr.readyState == 4 && xhr.status == 200) {
				$('#modalSntNteDtl').modal('hide'); // 모달 닫기
				f_sntNteBox(); // 보낸 메일함 새로고침
		        Swal.fire({ // 변경 내용 알림
		            icon: 'success',
		            title: '알림',
		            text: xhr.responseText
		        });					
		    }
		} 
		xhr.send();
    }
    
    
    /* 받은 쪽지함 */
    function f_rcvNteBox(now, num){
	   	console.log("@@@@@@@@@@@@@@@@@@@@@@@ 받은 쪽지 함 @@@@@@@@@@@@@@@@@@@@@");
	   	l_stNte.style.color = "rgb(36, 105, 92)";
	   	l_rcNte.style.color = "red";
	   	l_wtNte.style.color = "rgb(36, 105, 92)";
        l_nteWtDisp.style.display = "none";
        l_nteStDisp.style.display = "none";
        l_nteRcDisp.style.display = "block";
       
		let pData = {
   			"l_myId" : l_myId,
   			"nowPage" : now,           // 디폴트 값
   			"cntPerPage" : num         // 디폴트 값
   		}
   		
   		let xhr = new XMLHttpRequest();
   		xhr.open("post", "${CONTEXT_PATH}/note/rvNte", true);
   		xhr.onreadystatechange = function(){
   			if (xhr.readyState == 4 && xhr.status == 200) {
   				// console.log(xhr.responseText);
   				let map = JSON.parse(xhr.responseText);
                let list = map.noteList;
			   	let page = map.paging;
   				
   				/* 받은 쪽지 리스트 뿌리기*/
   				console.log(list);
                code = "";
                if(list.length == 0){
    		   		code = "<tr><td class='jsgrid-cell' colspan='6'>** 받은 쪽지가 없습니다 **</td></tr>";
    		   		}
 	   		  	else {
 	   	           for(let i=0; i<list.length; i++){
 	   	              code += '<tr class="jsgrid-row" onclick="rcvDtl('+ list[i].nteNo +', '+ page.nowPage +', '+ page.cntPerPage +')">';
 	   	              code += '<td class="jsgrid-cell" style="width: 10%;border-right: 1px dashed grey;">'+ (i+1) +'</td>';
 	   	              code += '<td class="jsgrid-cell" style="width: 20%;border-right: 1px dashed grey;">' + list[i].nteSd + '</td>';
 	   	              code += '<td class="jsgrid-cell cell-cntTl" style="width: 30%;border-right: 1px dashed grey;">' + list[i].nteTl + '</td>';
 	   	              let date = new Date(list[i].nteRcvDt);
 	   	              code += '<td class="jsgrid-cell jsgrid-align-center" style="width: 20%;border-right: 1px dashed grey;">' + date.getFullYear() +"/"+ (date.getMonth()+1) + "/" +  date.getDate() + '</td>';
 	   	              let red = '안읽음';
 	   	              if(list[i].nteRed==='Y'){red='읽음';}
 	   	              code += '<td class="jsgrid-cell" style="width: 10%;border-right: 1px dashed grey;">' + red + '</td>';
 	   	              code += '<td class="jsgrid-cell" style="width: 10%;" onclick="stopPro()"><input type="checkbox" name="rcvNteNo" value="'+ list[i].nteNo +'"></td>';
 	   	              console.log("@@@@@@list에 있는 nteNO")
 	   	              code += '</tr>';
 	   	           }
 	   		   	}
 	           	l_tbodyRcv.innerHTML = code;
   			   	
 	            /* 받은 쪽지 페이징 뿌리기 */
			   	console.log(page);
			   	// console.log(page.cntPerPage);
			   	pageCode = '';
			   	if(page.startPage != 1){
			   		pageCode += '<span class="jsgrid-pager-nav-button" onclick="f_rcvNteBox(' + (page.startPage - 1) + ',' + page.cntPerPage+')" style="cursor:pointer">이전</span>';
			   	}
			   	for(let i = page.startPage; i<= page.endPage; i++){
			   		if(i == page.nowPage){
			   			pageCode += '<span class="jsgrid-pager-page" style="color:green; font-weight:bold;">'+i+'</span>';
			   		}
			   		else{
			   			pageCode += '<span class="jsgrid-pager-page" onclick="f_rcvNteBox('+i+','+page.cntPerPage+')" style="cursor:pointer">'+i+'</span>';
			   		}
			   	}
			   	if(page.endPage != page.lastPage){
			   		pageCode += '<span class="jsgrid-pager-nav-button" onclick="f_rcvNteBox('+(page.endPage+1)+','+ page.cntPerPage +')" style="cursor:pointer">다음</span>';
			   	}
			   	
			   	l_rcvPaging.innerHTML = pageCode;
   			   	
   			} // end if
   		} // end function
   		xhr.setRequestHeader(tokenHeader, tokenValue);
   		xhr.setRequestHeader("Content-Type", "application/json;chartset=utf-8");
   		xhr.send(JSON.stringify(pData));
       
    }

    /* 받은 쪽지 일괄 삭제 */
    c_rcvAllDel.onclick = function(){
    	let chk_Val = [];
    	$("input:checkbox[name=rcvNteNo]:checked").each(function(i) {
    		chk_Val.push($(this).val());
    	});
    	
        let data = {
			"nteRcvList" : chk_Val
  		};
    	
    	// 전송ajax
        let xhr = new XMLHttpRequest();
        xhr.open("post", "${CONTEXT_PATH}/note/rcvAllDel", true);
		xhr.onreadystatechange = function(){
			if (xhr.readyState == 4 && xhr.status == 200) {
				f_rcvNteBox();
		        Swal.fire({ // 변경 내용 알림
		            icon: 'success',
		            title: '알림',
		            text: xhr.responseText
		        });					
			}
		}
		xhr.setRequestHeader(tokenHeader, tokenValue);
		xhr.setRequestHeader("Content-Type", "application/json;chartset=utf-8");
		xhr.send(JSON.stringify(data));
    	
    }    	
    

    /* 받은 쪽지 상세히 보기 */
    function rcvDtl(param, now, num) {
    	console.log("@@@@@@@@@@@@@@@@@@@@@@@@ 받은 쪽지 상세 보기 @@@@@@@@@@@@@@@@@@@@@@@@@@");
		let url = "${CONTEXT_PATH}/note/rcvNteDtl?nteNo=" + param;
		let xhr = new XMLHttpRequest();
		
		xhr.open("get", url, true);
		xhr.onreadystatechange = function(){
		  if (xhr.readyState == 4 && xhr.status == 200) {
		     let data = JSON.parse(xhr.responseText);
			  console.log(data);
		     let ModalBody = document.querySelector("#modal-rcv-dtl"); // 모달 몸통
		     let l_code = "";
		     l_code += "<div>";
		     l_code += "<p><strong>받는이 ID(이름)</strong><br>" + data.nteSd +"(" + data.empNm  +")</p>";
		     l_code += "<p><strong>제목</strong><br>" + data.nteTl + "</p>";
		     l_code += "<p><strong>내용</strong><br>" + data.nteCnt + "</p>";
		     let date = new Date(data.nteRcvDt);
		     l_code += "<p><strong>받은날짜</strong><br>" + date.getFullYear() +"/"+ (date.getMonth()+1) + "/" +  date.getDate() + "</p>";
		     l_code += "</div>";
		     
		     l_rcvDtlDel.title = data.nteNo;
		     ModalBody.innerHTML = l_code;
		     
		     $('#modalRcvNteDtl').modal('show'); // 모달 열기
		     f_rcvNteBox(now, num); // 받은 쪽지함 새로고침 -> 읽음 표시 때문에
		  }
		}
		xhr.send();
    }
    
    /* 받은 쪽지 상세 보기 삭제 */
    l_rcvDtlDel.onclick = function(){
    	console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 받은 쪽지 삭제 @@@@@@@@@@@@@@@@@@@@@@@@");
		let param = l_rcvDtlDel.title;
		let url = "${CONTEXT_PATH}/note/rcvNteDtlDel?nteNo=" + param;
		let xhr = new XMLHttpRequest();
		
		xhr.open("get", url, true);
		xhr.onreadystatechange = function(){
		    if (xhr.readyState == 4 && xhr.status == 200) {
				$('#modalRcvNteDtl').modal('hide'); // 모달 닫기
				f_rcvNteBox(); // 리스트 새로고침 	
		        Swal.fire({ // 변경 내용 알림
		            icon: 'success',
		            title: '알림',
		            text: xhr.responseText
		        });		    	
		    }
		}
		xhr.send();
    }
    
    /* 쪽지폼 */
    l_wtNte.onclick = function(){
	   	l_stNte.style.color = "rgb(36, 105, 92)";
	   	l_rcNte.style.color = "rgb(36, 105, 92)";
	   	l_wtNte.style.color = "red";
    	l_nteWtDisp.style.display = "block";
		l_nteStDisp.style.display = "none";
		l_nteRcDisp.style.display = "none";
    }
    
 </script>