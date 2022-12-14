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

<!-- ?????? ?????? -->
<div class="container-fluid">
	<div class="row starter-main">
		<div class="col-sm-12">
			<div class="card">
				<div class="card-header">
						<div id="basic-1_wrapper" class="dataTables_wrapper no-footer">
							<form>
								<table id="j_form1" border="2" class="tb_draft">
									<tr align="center">
										<th>????????????</th>
										<td id="id_aprldocNo"></td>
									</tr>
									<tr align="center">
										<th>???    ???</th>
										<td>${userInfo.empCmcd}</td>
									</tr>
									<tr align="center">
										<th>??? ??? ???</th>
										<td id="id_aprldocDfDt"></td>
									</tr>
									<tr align="center">
										<th>??? ??? ???</th>
										<td>${userInfo.empNm}</td>
									</tr>
									<tr align="center">
										<th>????????????</th>
										<td>????????? </td>
									</tr>				
								</table>
								<table id="j_form2" border="2" class="tb_draft">
								 	<tr align="center" height="20px" id="id_position" >					
										<th id="j_th1" rowspan="3">??????</th>
										<td class="j_td">??????</td>						
										<td class="j_td">??????</td>						
										<td class="j_td">??????</td>						
										<td class="j_td">??????</td>						
									</tr>
									
									<tr id="id_sign" align="center" height="60px">
										<td class="td_line" title="????????? ?????? or ??????"></td>						
										<td class="td_line" title="????????? ?????? or ??????"></td>						
										<td class="td_line" title="????????? ?????? or ??????"></td>						
										<td class="td_line" title="????????? ?????? or ??????"></td>						
								 	</tr>
								 	
								 	
								 	<tr id="id_draftDate" align="center" height="20px">
										<td title="?????????"></td>
										<td title="?????????"></td>
										<td title="?????????"></td>
										<td title="?????????"></td>
								 	</tr>				
								</table>
							</form>				
					</div>
					
					<!-- ???????????? ?????? -->
					<div class="modal fade bd-example-modal-lg" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" style="display: none;" aria-hidden="true">
                      <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">????????????</h5>
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
													role="presentation"></i> ????????????
											</a>
											<ul role="group" class="jstree-children">
												<li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="j2_14_anchor" aria-expanded="true" id="j2_14" class="jstree-node  jstree-open jstree-last">
													<i class="jstree-icon jstree-ocl" role="presentation"></i>
													<a class="jstree-anchor" href="#" tabindex="-1" id="j2_14_anchor">
															<i class="jstree-icon jstree-checkbox" role="presentation"></i>
															<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i> ?????? ??????
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
                            <button class="btn btn-primary" type="button" data-bs-dismiss="modal" data-bs-original-title="" title="">??????</button>
								<button class="btn btn-secondary" type="button" data-bs-original-title="" title="" id="btn_addRefDoc">??????</button>
                          </div>
                        </div>
                      </div>
                    </div>
					
		
					<!-- ????????? ?????? -->
					<div class="modal fade bd-example-modal-lg" id="exampleModal" tabindex="-1" aria-labelledby="myLargeModalLabel" style="display: none;" aria-hidden="true">
						<div class="modal-dialog modal-lg">
						  <div class="modal-content">
							<div class="modal-header">
							  <h4 class="modal-title" id="myLargeModalLabel">????????? ??????</h4>
							  <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close" data-bs-original-title="" title=""></button>
							</div>
							<div class="modal-body">
								<!-- ????????? ?????? select -->
								<table class="table table-bordered " style="text-align: center;">
									<tbody>
										<tr>
											<td>????????? ????????? &nbsp;&nbsp;&nbsp;
												<select class="custom-select w-75 p-1" id="sel_line">
													<option value="selectOption" selected>??????????????????</option>
													<option value="mkLine">????????? ??????</option>
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
										<!-- ????????? ?????? -->
										<div class="col-sm-4" id="memList">
											<div class="card">
												<div class="card-header pb-0">
													<h5>?????? ?????????</h5>
												</div>
												<div class="card-body">
													<div id="treeBasic" class="jstree jstree-1 jstree-default" role="tree" aria-multiselectable="true"
														tabindex="0" aria-activedescendant="j1_3" aria-busy="false">
														<ul class="jstree-container-ul jstree-children" role="group">
															<li role="treeitem" aria-selected="false" aria-level="1" aria-labelledby="j1_1_anchor" aria-expanded="true" id="j1_1" class="jstree-node  jstree-open">
																<i class="jstree-icon jstree-ocl" role="presentation"></i>
																<a class="jstree-anchor" href="#" tabindex="-1" id="j1_1_anchor">
																	<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>??????
																</a>
																<ul role="group" class="jstree-children">
																	<!-- ?????? ?????? -->
																	<li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="management" aria-expanded="true" id="id_man" class="jstree-node  jstree-open jstree-last">
																		<i class="jstree-icon jstree-ocl" role="presentation"></i>
																		<a class="jstree-anchor" href="#" tabindex="-1" id="management">
																			<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>?????? ??????
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
																	<!-- ?????? ?????? ??? -->
								
																	<!-- ?????? ?????? -->
																	<li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="business" aria-expanded="true" id="id_bus" class="jstree-node  jstree-open jstree-last">
																		<i class="jstree-icon jstree-ocl" role="presentation"></i>
																		<a class="jstree-anchor" href="#" tabindex="-1" id="business">
																			<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>?????? ??????
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
																	<!-- ?????? ?????? ??? -->
								
																	<!-- ?????? ?????? -->
																	<li role="treeitem" data-jstree="{&quot;opened&quot;:true}" aria-selected="false" aria-level="2" aria-labelledby="education" aria-expanded="true" id="id_edu" class="jstree-node  jstree-open jstree-last">
																		<i class="jstree-icon jstree-ocl" role="presentation"></i>
																		<a class="jstree-anchor" href="#" tabindex="-1" id="education">
																			<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom" role="presentation"></i>?????? ??????
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
																	<!-- ?????? ?????? ??? -->
								
																</ul>
															</li>
														</ul>
													</div>
												</div>
											</div>
										</div>
										<!-- ????????? ?????? ??? -->
								
								
								
										<!-- ?????? ????????? -->
										<div id="midBox">
											<button class="btn btn-light" type="button" id="btn_approval" onclick="addLine('06')">
												<div class="btnDiv">
													???&ensp;???<br>
												</div>
												<div class="imgDiv">
													<i class="fa fa-angle-right"></i>
												</div>
											</button>
								
											<button class="btn btn-light" type="button" id="btn_cooperation" onclick="addLine('04')">
												<div class="btnDiv">
													???&ensp;???
												</div>
												<div class="imgDiv">
													<i class="fa fa-angle-right"></i>
												</div>
											</button>
								
											<button class="btn btn-light" type="button" id="btn_reference">
												<div class="btnDiv">
													???&ensp;???
												</div>
												<div class="imgDiv">
													<i class="fa fa-angle-right"></i>
												</div>
											</button>
								
										</div>
								
										<!-- ????????? ????????? ????????? -->
										<div id="selMem">
											<div id="resetDiv">
												<i class="icofont icofont-ui-reply"></i>&nbsp;<b>?????????</b>
											</div>
								
											<div id="setLine">
												<table class="table table-xl" >
													<thead>
														<tr class='lineInfo'>
															<th class="col-2 tb_head"><b>??????</b><br>(??????)</th>
															<td><input class='tp_cd' type='hidden' value="06" />${userInfo.empNm}(<p class="emp_id" style="display: inline-block;">
																	${USERNAME}</p>)</td>
															<td class="col-1 td_close"></td>
														</tr>
													</thead>
													<tbody id="tb_body">
								
													</tbody>
												</table>
											</div>
								
											<h6>??????</h6>
											<div id="referenceMem">
								
											</div>
								
										</div>
									</div>
		
								</div>
								
								
		
		
							</div>
							<div class="modal-footer">
								<button class="btn btn-primary" type="button" data-bs-dismiss="modal" data-bs-original-title="" title="">??????</button>
								<button class="btn btn-secondary" type="button" data-bs-original-title="" title="" id="btn_register">??????</button>
							  </div>
						  </div>
						</div>
					</div>


					<h1 align="center">???&nbsp;???&nbsp;???&nbsp;???</h1>
					<br>
					<div style="width: 80%; text-align: right; margin: auto;">
						<input type="button" class="btn btn-success" value="???????????????"
							title="???????????? ??????????????????." id="btn_aprlln">
					</div>
					<br> <br>
					<form style="width: 80%; margin: auto;">
						<table id="id_draft" class="tb_draft">
							<!-- ?????? -->
							<tr>
								<th style="width: 20%;">??????</th>
								<td>
									<input type="text" id="aprldocTl" value="" required>
								</td>
							</tr>
							<!-- ???????????? -->
							<tr>
								<th>????????????</th>
								<td>
									<button type="button" id="btn_ref" class="btn btn-outline-info btn-sm" title="??????????????? ???????????????.">????????????</button>
									<input type="text" id="id_refDoc" style="width: 80%;" value ="" readonly/>
								</td>
							</tr>
							<!-- ???????????? -->
							<tr>
								<th>????????????</th>
								<td></td>
							</tr>
							<!-- ?????? -->
							<tr>
								<th colspan="2">??????</th>
							</tr>
							<tr>
								<td colspan="2" style="padding: 10px;">
									<textarea id="aprldocCnt" required></textarea>
								</td>
							</tr>
							<!-- ???????????? -->
							<tr>
								<th colspan="2">????????????</th>
							</tr>
							<tr>
								<td colspan="2">
									<input type="file" value="????????????" title="???????????? ??? ????????????" multiple>
								</td>
							</tr>
						</table>

						<br>
						<div style="text-align: right;">
							<input type="button" class="btn btn-warning" value="????????????"
								style="position: relative;" id="btn_temp"> <input
								type="button" class="btn btn-primary" value="??????"
								style="position: relative;" id="btn_draft"> <input
								type="button" class="btn btn-info" value="??????"
								style="position: relative;" id="btn_cancle">
						</div>
					</form>
				</div>							
			</div>
		</div>
	</div>
</div>

<script>

	console.log('???????????? ????????? ?????? >>>>>>>>>>>> ${userInfo}');

	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';

	const c_sel = document.querySelector("#sel_line");

	const c_temp = document.querySelector("#btn_temp");			// ???????????? ??????
	const c_draft = document.querySelector("#btn_draft");		// ?????? ??????
	const c_cancle = document.querySelector("#btn_cancle");		// ?????? ??????
	const c_aprllnBtn = document.querySelector("#btn_aprlln");	// ????????? ?????? ??????
	const c_reference = document.querySelector("#btn_reference");	// ????????? ?????? ?????? ??????
	const c_register = document.querySelector("#btn_register");	// ????????? ?????? ?????? ??????	
	const c_resetDiv = document.querySelector("#resetDiv");		// ????????? ??????
	const c_ref = document.querySelector("#btn_ref");

	const c_tbBody = document.querySelector("#tb_body");		// ???????????? ????????? tbody
	const c_referenceMem = document.querySelector("#referenceMem");	// ????????? div

	const c_position = document.querySelector("#id_position");		// ?????????(??????)
	const c_sign = document.querySelector("#id_sign");				// ?????????(??????)
	const c_draftDate = document.querySelector("#id_draftDate");	// ?????????(??????)

	const c_aprldocTl = document.querySelector("#aprldocTl");		// ???????????? ?????? input
	const c_aprldocCnt = document.querySelector("#aprldocCnt");		// ???????????? ?????? textarea
	const c_refDoc = document.querySelector("#id_refDoc");			// ???????????? ???????????? input

	const c_aprl = document.querySelector("#aprl");		// ????????? ?????? ???
	
	const c_aprldocNo = document.querySelector("#id_aprldocNo");	// ???????????? ??????(???????????? ??????)
	const c_aprldocDfDt = document.querySelector("#id_aprldocDfDt");	// ???????????? ??????(????????????)
	
	const c_refDocNo = document.querySelector("#id_refDocNo");	// ???????????? ????????? ?????? div

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
			
			// ??? ?????????
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
			
            // console.log("hidden ?????? ?????? ?????? list = "+ c_list);
            // console.log("disp?????? ????????? ?????? list2 = "+ c_list2);
			
			c_refDocNo.innerText = c_list;
            
            
		});
	}


	c_ref.addEventListener("click", function(){
		$("#exampleModal2").modal('show');
	});

	c_aprllnBtn.addEventListener("click", function(){
		$("#exampleModal").modal('show');
	});

	// select????????? ??????????????? ???????????? ??????
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
								tp_cd_vu = "??????";
							}else if(result[i].aprlTpCd == '04'){
								tp_cd_vu = "??????";
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

	// ???????????? ????????? ??????????????? ?????? ???????????? ??????
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
		   title: '??????????????? ???????????????????????????????',
		   text: '??????????????? ????????????,???????????? ???????????? ????????????.',
		   icon: 'question',
		   
		   showCancelButton: true, // cancel?????? ?????????. ????????? ?????? ??????
		   confirmButtonColor: '#3085d6', // confrim ?????? ?????? ??????
		   cancelButtonColor: '#d33', // cancel ?????? ?????? ??????
		   confirmButtonText: '??????', // confirm ?????? ????????? ??????
		   cancelButtonText: '??????', // cancel ?????? ????????? ??????
		   
		}).then(result => {
		   // ?????? Promise????????? ?????????,
		   if (result.isConfirmed) { // ?????? ??????????????? confirm ????????? ????????????

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
							title: '??????????????? ?????????????????????.',
							text: '????????????????????? ???????????????.'
						}).then(result => {
							location.href = '${CONTEXT_PATH}/aprl/tmpbox';
						});
					}else{
						Swal.fire({
							icon: 'error',
							title: '??????????????? ?????????????????????'
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


	// ?????? ????????? ??????????????? ?????? ???????????? ??????
	function f_cancle(){

		event.preventDefault();

		Swal.fire({
		   title: '??????????????? ?????????????????????????',
		   text: '???????????? ????????????????????? ???????????????.',
		   icon: 'question',
		   
		   showCancelButton: true, // cancel?????? ?????????. ????????? ?????? ??????
		   confirmButtonColor: '#3085d6', // confrim ?????? ?????? ??????
		   cancelButtonColor: '#d33', // cancel ?????? ?????? ??????
		   confirmButtonText: '??????', // confirm ?????? ????????? ??????
		   cancelButtonText: '??????', // cancel ?????? ????????? ??????sds
		   
		   
		}).then(result => {
		   // ?????? Promise????????? ?????????,
		   if (result.isConfirmed) { // ?????? ??????????????? confirm ????????? ????????????
			   location.href = "${CONTEXT_PATH}/aprl/sendbox";
		   }else{
			   return;
		   }
		});
	}
	c_cancle.addEventListener("click", f_cancle);

	// ?????? ????????? ??????????????? ?????? ???????????? ??????
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
				title: '???????????? ?????????????????????.',
		   		text: '',
		   		icon: 'warning'
			});
			return;
		}

		
		Swal.fire({
		   title: '??????????????? ?????????????????????????',
		   text: '',
		   icon: 'question',
		   
		   showCancelButton: true, // cancel?????? ?????????. ????????? ?????? ??????
		   confirmButtonColor: '#3085d6', // confrim ?????? ?????? ??????
		   cancelButtonColor: '#d33', // cancel ?????? ?????? ??????
		   confirmButtonText: '??????', // confirm ?????? ????????? ??????
		   cancelButtonText: '??????', // cancel ?????? ????????? ??????
		   
		   
		}).then(result => {
		   // ?????? Promise????????? ?????????,
		   if (result.isConfirmed) { // ?????? ??????????????? confirm ????????? ????????????

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
						title: '????????? ??????????????? ???????????????.',
						text: '?????? ??????????????? ???????????????.'
					}).then(result => {
						location.href = '${CONTEXT_PATH}/aprl/sendbox';
					});
				}else{
					Swal.fire({
						icon: 'error',
						title: '????????? ??????????????? ?????????????????????.'
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
			tp_cd_vu = "??????";
		}else if(aprl_tp_cd == '04'){
			tp_cd_vu = "??????";
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

	// ????????? ????????? ??????(?????????, ??????)??? ???????????? ??????
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

		const c_empId = empId.substring(0, empId.length - 1);	// ?????????
		const c_empNm = empNm.substring(0, empNm.length - 1);	// ??????

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

	// ????????? ???????????? ??????????????? ??????
	function f_reset(){
		c_referenceMem.innerHTML = "";
		c_tbBody.innerHTML = "";
	}

	c_resetDiv.addEventListener("click", f_reset);

		// ?????? ????????? ???????????? ??????
	function f_tbClose(el){
		el.closest('tr').remove();
	}

		// ??????????????? ?????? ????????? ????????? ??? ???????????? ??????
		function f_reference(){
		
		let info = getEmpInfo();
		
		addReference(info);
		
	}
	c_reference.addEventListener("click", f_reference);
	
	// ???????????? div??? ???????????? ??????
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

	// x ?????? ?????? ??? ???????????? ?????????
	function f_clear(el){
		// ????????? x????????? ?????? div??? ????????? ????????? ?????????
		el.closest('div').remove();
	}

	// ???????????? ???????????? ???????????? ???????????? ?????? ??????
	function f_lineRegister(){

		// ????????? ????????? ?????????
		if(c_position.childElementCount > 1){
			let child = document.querySelectorAll("td[class='j_td']");
			for(let i = 0 ; i < child.length ; i++){
				c_position.removeChild(child[i]);
			}
		}
		c_sign.innerHTML = "";
		c_draftDate.innerHTML = "";
		
		const aprl_emp = document.querySelectorAll('tr[class="lineInfo"]');
		
		// console.log("????????? ??? >>>>>>>>>> " + aprl_emp.length); 
		
		// ?????? ?????? ?????? ????????? ??????
		if(aprl_emp.length <= 1){
			Swal.fire('?????? ????????? ???????????? ?????????', '', 'warning');
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
				c_sign.innerHTML += "<td  class='td_line' title='????????? ?????? or ??????'><p class='aprl_tp' style='display:none;'>" + l_empAprlTpCd.value + "</p>" + "<p class='emp_id' style='display:none;'>"+ l_empId + "</p>" + l_empName + "</td>";
				c_draftDate.innerHTML += "<td title='?????????'></td>";
				
			}else{
				c_position.innerHTML += "<td class='j_td'>${userInfo.empPosiNm}</td>";
				c_sign.innerHTML += "<td  class='td_line' title='????????? ?????? or ??????'><p class='aprl_tp' style='display:none;'>01</p>" + "<p class='emp_id' style='display:none;'>${userInfo.empId}</p>${userInfo.empNm}</td>";
				c_draftDate.innerHTML += "<td title='?????????'></td>";
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
