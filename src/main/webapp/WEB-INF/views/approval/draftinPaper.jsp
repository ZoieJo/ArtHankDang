<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<script src="${RESOURCES_PATH}/assets/js/editor/ckeditor/ckeditor.js"></script>

<style>
#j_form1{
	width: 28%; 
	float: left; 
}

.tb_draft th{
	background-color: #ecf0f1;
	border-width: 1px;
	border-color: black;
	font-size: 18px;
} 

.tb_draft td {
	border-width: 1px;
	border-color: black;
	font-size: 18px;
}
#j_th1{
	width: 28px;
}

#j_form2{
	width: 40%;
	float: right;
}

#j_tr1{
	height: 60px;
}

td.j_td {
    width: 100px;
}

#midBox {
	margin: 30px 5%;
	width: 10%;
	text-align: center;
	float: left;
	vertical-align: middle;
/* 	border: 1px solid black; */
 	padding: 20px 0px; 
	overflow: hidden;
}


#memList {
	width: 30%;
	float: left;
 	overflow: auto; 
}

#selMem {
	width: 50%;
	float: left;
}

#resetDiv {
	padding: 5px 10px;
	background-color: #F2F2F2;
	cursor: pointer;
}

#setLine {
	height: 400px;
	margin-top: 10px;
	margin-bottom: 30px;
	border: 1px solid #E5E5E5;
	overflow: auto;
}

#referenceMem {
	height: 150px;
	margin: 10px 0px;
	border: 1px solid #E5E5E5;
	padding: 10px;
}

button.btn.btn-light{
	padding: 6px 0px;
	margin: 10px 0px;
	width: 100%;
}

table.table.table-bordered {
    margin-bottom: 20px;
}

th.col-2.tb_head {
	text-align: center;
	vertical-align: middle;
	padding: 0px;
	border-right: 1px solid #E5E5E5;
}

tbody#tb_body {
    overflow: auto;
}

#basic-1_wrapper{
	width: 80%;
	margin: 10px auto 20px;
}

.lineInfo {
	vertical-align: middle;
}

.btnDiv {
	display: inline-block;
	width: 75%;
	text-align: left;
	padding-left: 5px;
}

.imgDiv {
	display: inline-block;
	padding-right: 5px;
}

.alert.alert-success.outline.alert-dismissible.ref_info {
    width: 30%;
    padding: 5px;
    display: inline-block;
    margin: 5px;
}


.alert-dismissible .btn-close {
     padding: 10px 6px;
} 

button.btn-close.btn_close {
    position: absolute;
    top: 0px;
    right: 5px;
}

#id_draft {
	width: 100%;
}

#id_draft th {
	text-align: center;
}

#id_draft td {
	padding: 2px;
}

#id_draft td input {
    border-width: 0px;
    width: 100%;
}

#aprldocCnt{
	width: 100%;
	height: 500px;
	border-width: 0px;
}

#treecheckbox {
	border: 1px solid #E5E5E5;
	padding: 20px;
}

#id_refDocNo{
	padding: 20px;
	margin-top: 10px;
	border: 1px solid #e5e5e5;
	background-color: #E5E5E5;
	width: 100%;
	height: 150px;
}

</style>

<!-- 내용 시작 -->
<div class="container-fluid">
	<div class="row starter-main">
		<div class="col-sm-12">
			<div class="card">
				<div class="card-header">
						<div id="basic-1_wrapper" class="dataTables_wrapper no-footer">
							<form>
								<table id="j_form1" border="2" class="tb_draft">
									<tr align="center">
										<th>문서번호</th>
										<td id="id_aprldocNo"></td>
									</tr>
									<tr align="center">
										<th>부    서</th>
										<td>${userInfo.empCmcd}</td>
									</tr>
									<tr align="center">
										<th>기 안 일</th>
										<td id="id_aprldocDfDt"></td>
									</tr>
									<tr align="center">
										<th>기 안 자</th>
										<td>${userInfo.empNm}</td>
									</tr>
									<tr align="center">
										<th>결재내용</th>
										<td>기안문 </td>
									</tr>				
								</table>
								<table id="j_form2" border="2" class="tb_draft">
								 	<tr align="center" height="20px" id="id_position" >					
										<th id="j_th1" rowspan="3">결재</th>
										<td class="j_td">사원</td>						
										<td class="j_td">대리</td>						
										<td class="j_td">과장</td>						
										<td class="j_td">부장</td>						
									</tr>
									
									<tr id="id_sign" align="center" height="60px">
										<td class="td_line" title="결재자 서명 or 승인"></td>						
										<td class="td_line" title="결재자 서명 or 승인"></td>						
										<td class="td_line" title="결재자 서명 or 승인"></td>						
										<td class="td_line" title="결재자 서명 or 승인"></td>						
								 	</tr>
								 	
								 	
								 	<tr id="id_draftDate" align="center" height="20px">
										<td title="결재일"></td>
										<td title="결재일"></td>
										<td title="결재일"></td>
										<td title="결재일"></td>
								 	</tr>				
								</table>
							</form>				
					</div>
					
					<!-- 참조문서 모달 -->
					<div class="modal fade bd-example-modal-lg" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" style="display: none;" aria-hidden="true">
                      <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">참조문서</h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close" data-bs-original-title="" title=""></button>
                          </div>
                          <div class="modal-body">
								<div id="treecheckbox" class="jstree jstree-2 jstree-default jstree-checkbox-selection" role="tree aria-multiselectable="true" tabindex="0" aria-activedescendant="j2_7" aria-busy="false" aria-selected="false">
									<ul class="jstree-container-ul jstree-children" role="group">
										<li role="treeitem" aria-selected="false" aria-level="1" aria-labelledby="j2_1_anchor" aria-expanded="true"
											id="j2_1" class="jstree-node  jstree-open"><i class="jstree-icon jstree-ocl" role="presentation"></i><a
												class="jstree-anchor" href="#" tabindex="-1" id="j2_1_anchor"><i class="jstree-icon jstree-checkbox"
													role="presentation"></i><i
													class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom"
													role="presentation"></i> 참조문서
											</a>
											<ul role="group" class="jstree-children">
												<li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="j2_14_anchor" aria-expanded="true" id="j2_14" class="jstree-node  jstree-open jstree-last">
													<i class="jstree-icon jstree-ocl" role="presentation"></i>
													<a class="jstree-anchor" href="#" tabindex="-1" id="j2_14_anchor">
															<i class="jstree-icon jstree-checkbox" role="presentation"></i>
															<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i> 강의 계획
													</a>
													<ul role="group" class="jstree-children">
														<c:forEach items="${curspnList}" varStatus="status" var="curspn">
															<li role="treeitem" data-jstree="{&quot;type&quot;:&quot;file&quot;}" aria-selected="false" aria-level="3" aria-labelledby="${curspn.curspnNo}_anchor" id="${curspn.curspnNo}" class="jstree-node  jstree-leaf">
																<i class="jstree-icon jstree-ocl" role="presentation"></i>
																	<a class="jstree-anchor" href="#" tabindex="-1" id="${curspn.curspnNo}_anchor">
																		<i class="jstree-icon jstree-checkbox" role="presentation"></i>
																		<i class="jstree-icon jstree-themeicon icofont icofont-file-alt font-dark jstree-themeicon-custom" role="presentation"></i>${curspn.curspnCursNm}
																	</a>
															</li>
														</c:forEach>
													</ul>
												</li>
											</ul>
										</li>
									</ul>
								</div>
								
								<div id="id_refDocNo">
									
								</div>

						  </div>
                          <div class="modal-footer">
                            <button class="btn btn-primary" type="button" data-bs-dismiss="modal" data-bs-original-title="" title="">취소</button>
								<button class="btn btn-secondary" type="button" data-bs-original-title="" title="" id="btn_addRefDoc">등록</button>
                          </div>
                        </div>
                      </div>
                    </div>
					
		
					<!-- 결재선 모달 -->
					<div class="modal fade bd-example-modal-lg" id="exampleModal" tabindex="-1" aria-labelledby="myLargeModalLabel" style="display: none;" aria-hidden="true">
						<div class="modal-dialog modal-lg">
						  <div class="modal-content">
							<div class="modal-header">
							  <h4 class="modal-title" id="myLargeModalLabel">결재선 등록</h4>
							  <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close" data-bs-original-title="" title=""></button>
							</div>
							<div class="modal-body">
								<!-- 결재선 선택 select -->
								<table class="table table-bordered " style="text-align: center;">
									<tbody>
										<tr>
											<td>결재선 리스트 &nbsp;&nbsp;&nbsp;
												<select class="custom-select w-75 p-1" id="sel_line">
													<option value="selectOption" selected>선택해주세요</option>
													<option value="mkLine">결재선 등록</option>
													<c:if test="${aprllnList.size() > 0 }">
														<c:forEach var="aprllnNo" items="${aprllnList}" varStatus="status">
															<option value="${aprllnNo.usdeaprllnNo}">${aprllnNo.usdeaprllnTl}</option>
														</c:forEach>
													</c:if>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
		
								<div id="aprl" style="display: none;">
		
									<div id="lineBox">
										<!-- 계층형 트리 -->
										<div class="col-sm-4" id="memList">
											<div class="card">
												<div class="card-header pb-0">
													<h5>직원 리스트</h5>
												</div>
												<div class="card-body">
													<div id="treeBasic" class="jstree jstree-1 jstree-default" role="tree" aria-multiselectable="true"
														tabindex="0" aria-activedescendant="j1_3" aria-busy="false">
														<ul class="jstree-container-ul jstree-children" role="group">
															<li role="treeitem" aria-selected="false" aria-level="1" aria-labelledby="j1_1_anchor" aria-expanded="true" id="j1_1" class="jstree-node  jstree-open">
																<i class="jstree-icon jstree-ocl" role="presentation"></i>
																<a class="jstree-anchor" href="#" tabindex="-1" id="j1_1_anchor">
																	<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>직원
																</a>
																<ul role="group" class="jstree-children">
																	<!-- 관리 부서 -->
																	<li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="management" aria-expanded="true" id="id_man" class="jstree-node  jstree-open jstree-last">
																		<i class="jstree-icon jstree-ocl" role="presentation"></i>
																		<a class="jstree-anchor" href="#" tabindex="-1" id="management">
																			<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>관리 부서
																		</a>
																		<ul role="group" class="jstree-children">
																			<c:forEach var="empVO" items="${empList}">
																				<c:if test="${empVO.empDepNm == 'MAN'}">
																					<li role="treeitem" data-jstree="{&quot;type&quot;:&quot;file&quot;}" aria-selected="false" aria-level="3" aria-labelledby="id_${empVO.empId}" id="${empVO.empId}" class="jstree-node  jstree-leaf">
																						<i class="jstree-icon jstree-ocl" role="presentation"></i>
																						<a class="jstree-anchor" href="#" tabindex="-1" id="id_${empVO.empId}">
																							<i class="jstree-icon jstree-themeicon icofont icofont-file-alt font-dark jstree-themeicon-custom" role="presentation"></i>${empVO.empNm}
																						</a>
																					</li>
																				</c:if>
																			</c:forEach>
																		</ul>
																	</li>
																	<!-- 관리 부서 끝 -->
								
																	<!-- 경영 부서 -->
																	<li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="business" aria-expanded="true" id="id_bus" class="jstree-node  jstree-open jstree-last">
																		<i class="jstree-icon jstree-ocl" role="presentation"></i>
																		<a class="jstree-anchor" href="#" tabindex="-1" id="business">
																			<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>경영 부서
																		</a>
																		<ul role="group" class="jstree-children">
																			<c:forEach var="empVO" items="${empList}">
																				<c:if test="${empVO.empDepNm == 'BUS'}">
																					<li role="treeitem" data-jstree="{&quot;type&quot;:&quot;file&quot;}" aria-selected="false" aria-level="3" aria-labelledby="id_${empVO.empId}" id="${empVO.empId}" class="jstree-node  jstree-leaf">
																						<i class="jstree-icon jstree-ocl" role="presentation"></i>
																						<a class="jstree-anchor" href="#" tabindex="-1" id="id_${empVO.empId}">
																							<i class="jstree-icon jstree-themeicon icofont icofont-file-alt font-dark jstree-themeicon-custom" role="presentation"></i>${empVO.empNm}
																						</a>
																					</li>
																				</c:if>
																			</c:forEach>
																		</ul>
																	</li>
																	<!-- 경영 부서 끝 -->
								
																	<!-- 교육 부서 -->
																	<li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="education" aria-expanded="true" id="id_edu" class="jstree-node  jstree-open jstree-last">
																		<i class="jstree-icon jstree-ocl" role="presentation"></i>
																		<a class="jstree-anchor" href="#" tabindex="-1" id="education">
																			<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>교육 부서
																		</a>
																		<ul role="group" class="jstree-children">
																			<c:forEach var="empVO" items="${empList}">
																				<c:if test="${empVO.empDepNm == 'EDU'}">
																					<li role="treeitem" data-jstree="{&quot;type&quot;:&quot;file&quot;}" aria-selected="false" aria-level="3" aria-labelledby="id_${empVO.empId}" id="${empVO.empId}" class="jstree-node  jstree-leaf">
																						<i class="jstree-icon jstree-ocl" role="presentation"></i>
																						<a class="jstree-anchor" href="#" tabindex="-1" id="id_${empVO.empId}">
																							<i class="jstree-icon jstree-themeicon icofont icofont-file-alt font-dark jstree-themeicon-custom" role="presentation"></i>${empVO.empNm}
																						</a>
																					</li>
																				</c:if>
																			</c:forEach>
																		</ul>
																	</li>
																	<!-- 교육 부서 끝 -->
								
																</ul>
															</li>
														</ul>
													</div>
												</div>
											</div>
										</div>
										<!-- 계층형 트리 끝 -->
								
								
								
										<!-- 그냥 화살표 -->
										<div id="midBox">
											<button class="btn btn-light" type="button" id="btn_approval" onclick="addLine('06')">
												<div class="btnDiv">
													결&ensp;제<br>
												</div>
												<div class="imgDiv">
													<i class="fa fa-angle-right"></i>
												</div>
											</button>
								
											<button class="btn btn-light" type="button" id="btn_cooperation" onclick="addLine('04')">
												<div class="btnDiv">
													합&ensp;의
												</div>
												<div class="imgDiv">
													<i class="fa fa-angle-right"></i>
												</div>
											</button>
								
											<button class="btn btn-light" type="button" id="btn_reference">
												<div class="btnDiv">
													참&ensp;조
												</div>
												<div class="imgDiv">
													<i class="fa fa-angle-right"></i>
												</div>
											</button>
								
										</div>
								
										<!-- 결재선 등록할 교직원 -->
										<div id="selMem">
											<div id="resetDiv">
												<i class="icofont icofont-ui-reply"></i>&nbsp;<b>초기화</b>
											</div>
								
											<div id="setLine">
												<table class="table table-xl" >
													<thead>
														<tr class='lineInfo'>
															<th class="col-2 tb_head"><b>결재</b><br>(본인)</th>
															<td><input class='tp_cd' type='hidden' value="06" />${userInfo.empNm}(<p class="emp_id" style="display: inline-block;">
																	${USERNAME}</p>)</td>
															<td class="col-1 td_close"></td>
														</tr>
													</thead>
													<tbody id="tb_body">
								
													</tbody>
												</table>
											</div>
								
											<h6>참조</h6>
											<div id="referenceMem">
								
											</div>
								
										</div>
									</div>
		
								</div>
								
								
		
		
							</div>
							<div class="modal-footer">
								<button class="btn btn-primary" type="button" data-bs-dismiss="modal" data-bs-original-title="" title="">취소</button>
								<button class="btn btn-secondary" type="button" data-bs-original-title="" title="" id="btn_register">등록</button>
							  </div>
						  </div>
						</div>
					</div>


					<h1 align="center">예&nbsp;술&nbsp;학&nbsp;당</h1>
					<br>
					<div style="width: 80%; text-align: right; margin: auto;">
						<input type="button" class="btn btn-success" value="결재선등록"
							title="결재선을 선택해주세요." id="btn_aprlln">
					</div>
					<br> <br>
					<form style="width: 80%; margin: auto;">
						<table id="id_draft" class="tb_draft">
							<!-- 제목 -->
							<tr>
								<th style="width: 20%;">제목</th>
								<td>
									<input type="text" id="aprldocTl" value="" required>
								</td>
							</tr>
							<!-- 참조문서 -->
							<tr>
								<th>참조문서</th>
								<td>
									<button type="button" id="btn_ref" class="btn btn-outline-info btn-sm" title="참조문서를 선택하세요.">참조문서</button>
									<input type="text" id="id_refDoc" style="width: 80%;" value ="" readonly/>
								</td>
							</tr>
							<!-- 수신부서 -->
							<tr>
								<th>수신부서</th>
								<td></td>
							</tr>
							<!-- 내용 -->
							<tr>
								<th colspan="2">내용</th>
							</tr>
							<tr>
								<td colspan="2" style="padding: 10px;">
									<textarea id="aprldocCnt" required></textarea>
								</td>
							</tr>
							<!-- 첨부파일 -->
							<tr>
								<th colspan="2">첨부파일</th>
							</tr>
							<tr>
								<td colspan="2">
									<input type="file" value="첨부파일" title="붙임파일 및 첨부자료" multiple>
								</td>
							</tr>
						</table>

						<br>
						<div style="text-align: right;">
							<input type="button" class="btn btn-warning" value="임시저장"
								style="position: relative;" id="btn_temp"> <input
								type="button" class="btn btn-primary" value="결재"
								style="position: relative;" id="btn_draft"> <input
								type="button" class="btn btn-info" value="취소"
								style="position: relative;" id="btn_cancle">
						</div>
					</form>
				</div>							
			</div>
		</div>
	</div>
</div>

<script>

	console.log('로그인한 회원의 정보 >>>>>>>>>>>> ${userInfo}');

	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';

	const c_sel = document.querySelector("#sel_line");

	const c_temp = document.querySelector("#btn_temp");			// 임시저장 버튼
	const c_draft = document.querySelector("#btn_draft");		// 결재 버튼
	const c_cancle = document.querySelector("#btn_cancle");		// 취소 버튼
	const c_aprllnBtn = document.querySelector("#btn_aprlln");	// 결재선 등록 버튼
	const c_reference = document.querySelector("#btn_reference");	// 결재선 모달 참조 버튼
	const c_register = document.querySelector("#btn_register");	// 결재선 모달 등록 버튼	
	const c_resetDiv = document.querySelector("#resetDiv");		// 초기화 버튼
	const c_ref = document.querySelector("#btn_ref");

	const c_tbBody = document.querySelector("#tb_body");		// 결재라인 테이블 tbody
	const c_referenceMem = document.querySelector("#referenceMem");	// 참조자 div

	const c_position = document.querySelector("#id_position");		// 결재칸(직급)
	const c_sign = document.querySelector("#id_sign");				// 결재칸(사인)
	const c_draftDate = document.querySelector("#id_draftDate");	// 결재칸(날짜)

	const c_aprldocTl = document.querySelector("#aprldocTl");		// 결재문서 제목 input
	const c_aprldocCnt = document.querySelector("#aprldocCnt");		// 결재문서 내용 textarea
	const c_refDoc = document.querySelector("#id_refDoc");			// 결재문서 참조문서 input

	const c_aprl = document.querySelector("#aprl");		// 결재선 등록 폼
	
	const c_aprldocNo = document.querySelector("#id_aprldocNo");	// 결재문서 정보(결재문서 번호)
	const c_aprldocDfDt = document.querySelector("#id_aprldocDfDt");	// 결재문서 정보(기안일자)
	
	const c_refDocNo = document.querySelector("#id_refDocNo");	// 참조문서 번호를 담는 div

	window.onload = function(){
		if('${aprldocInfo}' != null){
			c_aprldocNo.innerHTML = '${aprldocInfo.aprldocNo}';
			c_aprldocTl.value = '${aprldocInfo.aprldocTl}';
			vo_aprldocCnt = '${aprldocInfo.aprldocCnt}';
			c_aprldocCnt.value = vo_aprldocCnt.replaceAll("<br>", "\r\n");
			c_refDoc.value = '${aprldocInfo.refDoc}';
		}
		
		$('#treecheckbox').on('changed.jstree', function(e,data){
			
			c_refDocNo.innerText = "";
			
			// 값 초기화
			list = '';
			list2 = '';
			
		    var nodes = $("#treecheckbox").jstree(true).get_selected("full", true);
		    
		    for(node of nodes){
		        if(!node.children.length){
		            list += node.id + ',';
		            list2 += node.text.trim() + ',';
		        }
		    }
		    $.trim(list);
		    $.trim(list2);
		    
			const c_list = list.substring(0, list.length -1);
			const c_list2 = list2.substring(0, list2.length -1);
			
            // console.log("hidden 으로 숨길 자료 list = "+ c_list);
            // console.log("disp에서 보여줄 자료 list2 = "+ c_list2);
			
			c_refDocNo.innerText = c_list;
            
            
		});
	}


	c_ref.addEventListener("click", function(){
		$("#exampleModal2").modal('show');
	});

	c_aprllnBtn.addEventListener("click", function(){
		$("#exampleModal").modal('show');
	});

	// select박스를 변경했을때 실행하는 함수
	const f_sel = ()=> {
		let s_value = c_sel.value;
		
		if(s_value != "selectOption"){
			c_aprl.style.display="block";
		}else {
			c_aprl.style.display="none";
		}
		
		f_reset();
		
		if(s_value != "mkLine"){

			let data = {
				"usdeaprllnNo" : s_value,
				"memId" : '${USERNAME}'
			}
			

			let xhr = new XMLHttpRequest();
			xhr.open("post","${CONTEXT_PATH}/aprl/aprllnInfo", true);
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					// console.log(xhr.responseText);
					// console.log(JSON.parse(xhr.responseText));

					let result = JSON.parse(xhr.responseText).usdeaprllndtlList;
					
					for(let i = 0 ; i < result.length; i++){
						// console.log(result[i]);
						
						let code = "";
						
						if(result[i].aprlTpCd == '05'){
							addReference(result[i]);
						}else {
							let tp_cd_vu = "";

							if(result[i].aprlTpCd == '06'){
								tp_cd_vu = "결재";
							}else if(result[i].aprlTpCd == '04'){
								tp_cd_vu = "합의";
							}

							code += "<tr class='lineInfo'>";
							code += "<th class='col-2 tb_head'><b><input class='tp_cd' type='hidden' value='" + result[i].aprlTpCd + "'>" + tp_cd_vu + "</b></th>";
							code += "<td><p class='emp_name' style='display:inline-block;'>" + result[i].empNm + "</p>(<p class='emp_id' style='display:inline-block;'>" + result[i].aprlMemId + "</p>)<input type='hidden' class='emp_position' value='"+ result[i].employeeInfo[0].empPosiNm +"'/></td>";
							code += "<td class='col-1 td_close'>";
							code += "<i class='icon-close' onclick='f_tbClose(this)'></i>";
							code += "</td>";
							code += "</tr>";
							c_tbBody.innerHTML += code;
						}
						
					}
				}
			}
			xhr.setRequestHeader(tokenHeader, tokenValue);
			xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
			xhr.send(JSON.stringify(data));
		} else if(s_value == 'mkLine'){
			c_aprl.style.display = "block";
		}
	}
	c_sel.addEventListener("change", f_sel);

	// 임시저장 버튼을 클릭하였을 경우 실행되는 함수
	function f_tempSave(){

		event.preventDefault();
		
		if(!c_aprldocTl.checkValidity()){
			c_aprldocTl.reportValidity();
			return;
		}

		if(!c_aprldocCnt.checkValidity()){
			c_aprldocCnt.reportValidity();
			return;
		}


		Swal.fire({
		   title: '결재문서를 임시저장하시겠습니까?',
		   text: '임시저장시 첨부파일,결재선은 저장되지 않습니다.',
		   icon: 'question',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   
		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면

				let aprldocVO = {};
		   		aprldocVO.aprldocNo = c_aprldocNo.innerText;
				aprldocVO.aprldocTl = c_aprldocTl.value;
				aprldocVO.aprldocCnt = c_aprldocCnt.value.replace(/(\n|\r\n)/g, "<br>");
				aprldocVO.refDoc = c_refDoc.value;
				aprldocVO.memId = '${USERNAME}';


				console.log(aprldocVO);
			   
				let xhr = new XMLHttpRequest();
				xhr.open("post","${CONTEXT_PATH}/aprl/saveAprldocTemp",true);
				xhr.onreadystatechange = function(){
					console.log(xhr.responseText);
					if(xhr.responseText == "success"){
						Swal.fire({
							icon: 'success',
							title: '임시저장을 성공하였습니다.',
							text: '임시보관함으로 이동합니다.'
						}).then(result => {
							location.href = '${CONTEXT_PATH}/aprl/tmpbox';
						});
					}else{
						Swal.fire({
							icon: 'error',
							title: '임시저장을 실패하였습니다'
						});
					}
				}
				xhr.setRequestHeader(tokenHeader, tokenValue);
				xhr.setRequestHeader("Content-Type","application/json; charset=utf-8");
				xhr.send(JSON.stringify(aprldocVO));

		   }else{
			   return;
		   }
		});


	}
	c_temp.addEventListener("click", f_tempSave);


	// 취소 버튼을 클릭하였을 경우 실행되는 함수
	function f_cancle(){

		event.preventDefault();

		Swal.fire({
		   title: '결재문서를 취소하시겠습니까?',
		   text: '취소하면 보낸결재함으로 이동합니다.',
		   icon: 'question',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정sds
		   
		   
		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			   location.href = "${CONTEXT_PATH}/aprl/sendbox";
		   }else{
			   return;
		   }
		});
	}
	c_cancle.addEventListener("click", f_cancle);

	// 결재 버튼을 클릭하였을 경우 실행되는 함수
	function f_draft(){
		
		event.preventDefault();
		
		if(!c_aprldocTl.checkValidity()){
			c_aprldocTl.reportValidity();
			return;
		}

		if(!c_aprldocCnt.checkValidity()){
			c_aprldocCnt.reportValidity();
			return;
		}

		if(document.querySelectorAll("td[class='td_line']")[0].innerHTML == ''){
			Swal.fire({
				title: '결재선을 등록하여주세요.',
		   		text: '',
		   		icon: 'warning'
			});
			return;
		}

		
		Swal.fire({
		   title: '결재문서를 제출하시겠습니까?',
		   text: '',
		   icon: 'question',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   
		   
		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면

			let aprldocVO = {};
		   	aprldocVO.aprldocNo = c_aprldocNo.innerText;
			aprldocVO.aprldocTl = c_aprldocTl.value;
			aprldocVO.aprldocCnt = c_aprldocCnt.value.replace(/(\n|\r\n)/g, "<br>");
			aprldocVO.refDoc = c_refDoc.value;
			aprldocVO.memId = '${USERNAME}';

			let aprlln = document.querySelectorAll("td[class='td_line']");
// 			console.log(aprlln);
			let aprllnList = [];
			aprlln.forEach((el,index)=>{
				console.log(el);
				let aprllnVO = {};
				aprllnVO.aprldocNo = c_aprldocNo.innerText;
				aprllnVO.aprlOd = index + 1;
				aprllnVO.memId = el.querySelector("p[class='emp_id']").innerText;
				aprllnVO.aprlTpCd = el.querySelector("p[class='aprl_tp']").innerText;
				if(index == 0){
					aprllnVO.aprlStCd = '01';
				}else if(index == 1){
					aprllnVO.aprlStCd = '03';
				}else{
					aprllnVO.aprlStCd = '04';
				}
				aprllnList.push(aprllnVO);

			});

			aprldocVO.aprllnList = aprllnList;

			console.log(aprldocVO);


			let xhr = new XMLHttpRequest();
			xhr.open("post","${CONTEXT_PATH}/aprl/sendAprldoc",true);
			xhr.onreadystatechange = function(){
				console.log(xhr.responseText);
				if(xhr.responseText == "success"){
					Swal.fire({
						icon: 'success',
						title: '결재를 성공적으로 보냈습니다.',
						text: '보낸 보관함으로 이동합니다.'
					}).then(result => {
						location.href = '${CONTEXT_PATH}/aprl/sendbox';
					});
				}else{
					Swal.fire({
						icon: 'error',
						title: '결재를 제출하는데 실패하였습니다.'
					});
				}
			}
			xhr.setRequestHeader(tokenHeader, tokenValue);
			xhr.setRequestHeader("Content-Type","application/json; charset=utf-8");
			xhr.send(JSON.stringify(aprldocVO));
			   
		   }else{
			   return;
		   }
		});
	}
	c_draft.addEventListener("click", f_draft);

	function addLine(aprl_tp_cd){
		
		let info = getEmpInfo();
		
		let tp_cd_vu = "";

		if(aprl_tp_cd == '06'){
			tp_cd_vu = "결재";
		}else if(aprl_tp_cd == '04'){
			tp_cd_vu = "합의";
		}

		let code = "";
		code += "<tr class='lineInfo'>";
		code += "<th class='col-2 tb_head'><b><input class='tp_cd' type='hidden' value='" + aprl_tp_cd + "'>" + tp_cd_vu + "</b></th>";
		code += "<td><p class='emp_name' style='display:inline-block;'>" + info.empNm + "</p>(<p class='emp_id' style='display:inline-block;'>" + info.aprlMemId + "</p>)<input class='emp_position' type='hidden' value='"+ info.empPosi +"'/></td>";
		code += "<td class='col-1 td_close'>";
		code += "<i class='icon-close' onclick='f_tbClose(this)'></i>";
		code += "</td>";
		code += "</tr>";

		c_tbBody.innerHTML += code;
	}

	// 선택한 직원의 정보(아이디, 이름)을 리턴하는 함수
	function getEmpInfo(){
		empId = '';
		empNm = '';

		var nodes = $("#treeBasic").jstree(true).get_selected("full", true);

		for (node of nodes) {
			if (!node.children.length) {
				empId += node.id + ',';
				empNm += node.text.trim() + ',';
			}
		}

		$.trim(empId);
		$.trim(empNm);

		const c_empId = empId.substring(0, empId.length - 1);	// 아이디
		const c_empNm = empNm.substring(0, empNm.length - 1);	// 이름

		let c_empPosi = "";
		
		let xhr = new XMLHttpRequest();
		let url = "${CONTEXT_PATH}/aprl/getPosition?empId="+c_empId;
		xhr.open("get",url,false);
		xhr.onreadystatechange = function(){
			c_empPosi = xhr.responseText;
		}
		xhr.send();
		
		let info = {
				"aprlMemId" : c_empId,
				"empNm" : c_empNm,
				"empPosi" : c_empPosi
		}
		
		// console.log(info);
		
		return info;
	}

	// 결재선 리스트를 초기화하는 함수
	function f_reset(){
		c_referenceMem.innerHTML = "";
		c_tbBody.innerHTML = "";
	}

	c_resetDiv.addEventListener("click", f_reset);

		// 결재 라인을 삭제하는 함수
	function f_tbClose(el){
		el.closest('tr').remove();
	}

		// 결재선에서 참조 버튼을 눌렀을 때 실행되는 함수
		function f_reference(){
		
		let info = getEmpInfo();
		
		addReference(info);
		
	}
	c_reference.addEventListener("click", f_reference);
	
	// 참조자를 div에 삽입하는 함수
	function addReference(info){

		let code = "";
		code += "<div class='alert alert-success outline alert-dismissible ref_info'>";
		code += "<div class='refMemInfo'>";
		code += "<input class='emp_id' type='hidden' value='" + info.aprlMemId + "'>";
		code += "<input class='aprl_tp_cd' type='hidden' value='05'>";
		code += "<p>" + info.empNm + "</p>";
		code += "</div>";
		code += "<button class='btn-close btn_close' type='button' onclick='f_clear(this)'></button>";
		code += "</div>";

		c_referenceMem.innerHTML += code;

	}

	// x 버튼 클릭 시 실행되는 이벤트
	function f_clear(el){
		// 클릭한 x버튼의 부모 div를 찾아서 요소를 삭제함
		el.closest('div').remove();
	}

	// 결재선을 선택하여 기안문에 넣어주기 위한 함수
	function f_lineRegister(){

		// 결재선 등록시 초기화
		if(c_position.childElementCount > 1){
			let child = document.querySelectorAll("td[class='j_td']");
			for(let i = 0 ; i < child.length ; i++){
				c_position.removeChild(child[i]);
			}
		}
		c_sign.innerHTML = "";
		c_draftDate.innerHTML = "";
		
		const aprl_emp = document.querySelectorAll('tr[class="lineInfo"]');
		
		// console.log("결제선 수 >>>>>>>>>> " + aprl_emp.length); 
		
		// 결재 라인 등록 유효성 검증
		if(aprl_emp.length <= 1){
			Swal.fire('결재 라인을 입력하여 주세요', '', 'warning');
			return;
		}

		aprl_emp.forEach((el, index) => {

			if(index != 0){

				// console.log(el.querySelector("p[class='emp_name']").innerText);

				let l_empAprlTpCd = el.querySelector("input[class='tp_cd']");
				let l_empId = el.querySelector("p[class='emp_id']").innerText;
				let l_empPosi = el.querySelector("input[class='emp_position']").value;
				let l_empName = el.querySelector("p[class='emp_name']").innerText;

				c_position.innerHTML += "<td class='j_td'>" + l_empPosi + "</td>";
				c_sign.innerHTML += "<td  class='td_line' title='결재자 서명 or 승인'><p class='aprl_tp' style='display:none;'>" + l_empAprlTpCd.value + "</p>" + "<p class='emp_id' style='display:none;'>"+ l_empId + "</p>" + l_empName + "</td>";
				c_draftDate.innerHTML += "<td title='결제일'></td>";
				
			}else{
				c_position.innerHTML += "<td class='j_td'>${userInfo.empPosiNm}</td>";
				c_sign.innerHTML += "<td  class='td_line' title='결재자 서명 or 승인'><p class='aprl_tp' style='display:none;'>01</p>" + "<p class='emp_id' style='display:none;'>${userInfo.empId}</p>${userInfo.empNm}</td>";
				c_draftDate.innerHTML += "<td title='결재일'></td>";
			}

		});

		c_sel.getElementsByTagName('option')[0].selected = 'selected';
		f_reset();
		$("#exampleModal").modal('hide');


	}
	c_register.addEventListener("click", f_lineRegister);
	
	function f_addRefDoc(){
		
		c_refDoc.value = c_refDocNo.innerText;
		
	}
	
	document.querySelector("#btn_addRefDoc").addEventListener("click", function(){
		c_refDoc.value = c_refDocNo.innerText;
		$("#exampleModal2").modal('hide');
	});
	
</script>
