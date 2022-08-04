<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- 스타일 적용 -->
<style>
#lineBox {
	margin-top: 10px;
	/* 	display: inline-block; */
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

.btnDiv {
	display: inline-block;
	width: 80%;
	text-align: left;
	padding-left: 5px;
}

.imgDiv {
	display: inline-block;
	padding-right: 5px;
}

table.table.table-bordered {
    margin-bottom: 20px;
}

/* #midBox i { */
/* 	color: #24695C; */
/* } */

button.btn.btn-light{
	padding: 6px 0px;
	margin: 10px 0px;
	width: 100%;
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

th.col-2.tb_head {
	text-align: center;
	vertical-align: middle;
	padding: 0px;
	border-right: 1px solid #E5E5E5;
}



.alert.alert-secondary.refInfo {
    width: 20%;
}

.memInfo {
	text-align: left;
	padding: 0px 5px;
}

.alert.alert-success.outline.alert-dismissible.ref_info {
    width: 20%;
    padding: 5px;
    display: inline-block;
    margin: 5px;
}

.alert-dismissible .btn-close {
     padding: 10px 6px;
} 

.icon-close:before {
    content: "\e646";
    position: relative;
    left: 25px;
    bottom: 15px;
    cursor: pointer;
}

tbody#tb_body {
    overflow: auto;
}

.emp_id{
	display: inline-block;
}
</style>


<!-- Page Body Start-->
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>결재선 등록</h3>
				<!-- 제목 하단 페이지 경로 -->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${CONTEXT_PATH}/aprl/main">문서관리</a></li>
					<li class="breadcrumb-item">결재선 등록</li>
				</ol>
			</div>
		</div>
	</div>
</div>

<!-- 내용 시작 -->
<div class="container-fluid">
	<div class="row starter-main">
		<!-- 카드 1 시작 -->
		<div class="col-sm-12">
			<div class="card">
				<div class="card-header pb-0">
					<table class="table table-bordered " style="text-align: center;">
						<thead>
							<tr>
								<th class="table-light" style="height: 62px;">
									<button type="button" class="btn btn-primary" onclick="f_register()" style="display:none; float: right;" id="btn_register">등록</button>
									<div id="btn_upde" style="display:none; text-align: right;">
										<button type="button" class="btn btn-warning" onclick="f_update()" id="btn_update">수정</button>
										<button type="button" class="btn btn-danger" onclick="f_delete()" id="btn_delete">삭제</button>
									</div>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>결재선 리스트 &nbsp;&nbsp;&nbsp;
									<select class="custom-select w-75 p-1" id="sel_line">
										<option value="selectOption" selected>선택해주세요</option>
										<option value="mkLine">결재선 만들기</option>
										<c:if test="${aprllnList.size() > 0 }">
											<c:forEach var="aprllnNo" items="${aprllnList}" varStatus="status" >
												<option value="${aprllnNo.usdeaprllnNo}">${aprllnNo.usdeaprllnTl}</option>
											</c:forEach>
										</c:if>
								</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="card-body" style="padding-top: 0px; display:none;" id="id_body">
					<input type="text" id="aprlln_tl" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" placeholder="결재선 이름을 입력하세요." value="" required>
					
					<div id="lineBox">

						<!-- 계층형 트리 -->
						<div class="col-sm-4" id="memList">
							<div class="card">
								<div class="card-header pb-0">
									<h5>직원 리스트</h5>
								</div>
								<div class="card-body">
									<div id="treeBasic" class="jstree jstree-1 jstree-default" role="tree" aria-multiselectable="true" tabindex="0" aria-activedescendant="j1_3" aria-busy="false">
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
								<table class="table table-xl">
									<thead>
										<tr class='lineInfo'>
											<th class="col-2 tb_head"><b>결재</b><br>(본인)</th>
											<td><input class='tp_cd' type='hidden' value="06"/>${memInfo.empNm}(<p class="emp_id">${USERNAME}</p>)</td>
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
		</div>
       	
		<!-- 카드 1 끝 -->
	</div>
</div>
<!-- Container-fluid Ends-->

<script>

	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';

	const c_body = document.querySelector("#id_body");
	const c_sel = document.querySelector("#sel_line");
	const c_tbBody = document.querySelector("#tb_body");
	
	// 결재선 이름 input
	const c_aprllnTl = document.querySelector("#aprlln_tl");
	
	// 초기화 버튼
	const c_resetDiv = document.querySelector("#resetDiv");

	// 결재선 삭제 버튼
	const c_tdClose = document.querySelector("#td_close");

	// 결제, 합의, 참조 버튼
	const c_approval = document.querySelector("#btn_approval");
	const c_cooperation = document.querySelector("#btn_cooperation");
	const c_reference = document.querySelector("#btn_reference");
	
	// 참조 목록 div
	const c_referenceMem = document.querySelector("#referenceMem");

	// 등록 버튼
	const c_register = document.querySelector("#btn_register");
	
	// 수정 삭제 div
	const c_upde = document.querySelector("#btn_upde");
	
	
	// select박스를 변경했을때 실행하는 함수
	const f_sel = ()=> {
		let s_value = c_sel.value;

		c_register.style.display="none";
		c_upde.style.display="none";
		
		if(s_value != "selectOption"){
			c_body.style.display="block";
		}else {
			c_body.style.display="none";
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
// 					console.log(JSON.parse(xhr.responseText));

					c_upde.style.display = "block";
					
					let result = JSON.parse(xhr.responseText).usdeaprllndtlList;
					
					
					c_aprllnTl.value = JSON.parse(xhr.responseText).usdeaprllnTl;

					for(let i = 0 ; i < result.length; i++){
// 						console.log(result[i]);
						
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
							code += "<td>" + result[i].empNm + "(<p class='emp_id'>" + result[i].aprlMemId + "</p>)</td>";
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
				c_register.style.display = "block";
		}
	}
	c_sel.addEventListener("change", f_sel);

	// 결재선 리스트를 초기화하는 함수
	function f_reset(){
		c_referenceMem.innerHTML = "";
		c_tbBody.innerHTML = "";
		c_aprllnTl.value = "";
	}
	c_resetDiv.addEventListener("click", f_reset);

	
	// 결제/합의 버튼을 클릭하였을 경우 실행되는 함수
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
		code += "<td>" + info.empNm + "(<p class='emp_id'>" + info.aprlMemId + "</p>)</td>";
		code += "<td class='col-1 td_close'>";
		code += "<i class='icon-close' onclick='f_tbClose(this)'></i>";
		code += "</td>";
		code += "</tr>";

		c_tbBody.innerHTML += code;
	}


	// 결재선에서 참조 버튼을 눌렀을 때 실행되는 함수
	function f_reference(){
		
		let info = getEmpInfo();
		
		// 값이 제대로 반환되는지 확인
// 		console.log(info);
		
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
		code += "<button class='btn-close' type='button' onclick='f_clear(this)'></button>";
		code += "</div>";
		
		c_referenceMem.innerHTML += code;

	}
	
	// 결재 라인을 삭제하는 함수
	function f_tbClose(el){
		el.closest('tr').remove();
	}

	
	// x 버튼 클릭 시 실행되는 이벤트
	function f_clear(el){
		// 클릭한 x버튼의 부모 div를 찾아서 요소를 삭제함
		el.closest('div').remove();
	}
	
	// 결제라인을 등록하는 함수
	function f_register(){

		const ref_emp = document.querySelectorAll('input[class="emp_id"]');
		const aprl_emp = document.querySelectorAll('tr[class="lineInfo"]');
		
		// 결재선 제목 유효성 검증
		if(!c_aprllnTl.checkValidity()){
			c_aprllnTl.reportValidity();
			return;
		}
		
		// 결재 라인 등록 유효성 검증
		if(aprl_emp.length <= 1){
			Swal.fire('결재 라인을 입력하여 주세요', '', 'warning');
			return;
		}
		
		let usdeaprlreflnList = [];
		let usdeaprllnList = [];


		
		// 사용자정의 결재 라인 제목
		const usdeaprllnTl = c_aprllnTl.value;
		
		// 참조자 정보 리스트 저장
		let refNo = 0;
		ref_emp.forEach((el) =>{
			refNo++;
			
			var usdeaprlreflnVO = {};
			usdeaprlreflnVO.refOd = refNo;
			usdeaprlreflnVO.refMemId = el.value;
			
			usdeaprlreflnList.push(usdeaprlreflnVO);
		});

		let aprlNo = 0;
		aprl_emp.forEach((el) =>{
			aprlNo++;

// 			console.log(el);
// 			console.log("결재 라인 empID >>>>>>>>>>> " + el.querySelector("p[class='emp_id']").innerText);
// 			console.log("결재 라인 aprl_tp_cd >>>>>>>>>>> " + el.querySelector("input[class='tp_cd']").value);

			var usdeaprllnVO = {};
			usdeaprllnVO.aprlMemId = el.querySelector("p[class='emp_id']").innerText;
			usdeaprllnVO.aprlOd = aprlNo;
			usdeaprllnVO.aprlTpCd = el.querySelector("input[class='tp_cd']").value;

			usdeaprllnList.push(usdeaprllnVO);
		});
		
		// 사용자 정의 결재 라인 제목
		console.log("사용자정의 결재라인 제목 >>>>>>>>> " + c_aprllnTl.value);

		// 참조 리스트
		console.log(usdeaprlreflnList);

		// 결재라인 리스트
		console.log(usdeaprllnList);
		
		let data = {
				"usdeaprllnTl" : usdeaprllnTl,
				"memId" : '${USERNAME}',
				"usdeaprllndtl" : usdeaprllnList,
				"usdeaprlrefln" : usdeaprlreflnList
		}
		
		console.log(data);

		let xhr = new XMLHttpRequest();
		xhr.open("post","${CONTEXT_PATH}/aprl/mkLine",true);
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){

				console.log("ajax 끝!! >> " + xhr.responseText);
				location.reload();
			}
		}
		xhr.setRequestHeader(tokenHeader, tokenValue);
		xhr.setRequestHeader("Content-Type","application/json;charset=utf-8");
		xhr.send(JSON.stringify(data));

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
		
		let info = {
				"aprlMemId" : c_empId,
				"empNm" : c_empNm
		}
		
		return info;
	}
	
	console.log("${aprllnList}");
	
	// 결재선을 수정하는 함수
	function f_update(){

	}

	// 결재선을 삭제하는 함수
	function f_delete(){
		
		Swal.fire({
		   title: '해당 결재선을 삭제하시겠습니까?',
		   text: '승인을 누르면 결재선이 삭제됩니다.',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   
		   reverseButtons: true, // 버튼 순서 거꾸로
		   
		}).then(result => {
			
			
			
			if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				
				// 선택한 option의 값
				let s_value = c_sel.value;
// 				console.log(s_value);
		
				let xhr = new XMLHttpRequest();
				xhr.open("post", "${CONTEXT_PATH}/aprl/aprllnDelete", true);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						
						if(xhr.responseText == "삭제 성공"){
							Swal.fire('결재선을 성공적으로 삭제하였습니다.', '' , 'success').then(result =>{
								location.reload();
							});
						}else{
							Swal.fire('결재선 삭제를 실패하였습니다.', '' , 'error').then(result =>{
								location.reload();
							});
						}
					}
				}
				xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				xhr.setRequestHeader(tokenHeader, tokenValue);
				xhr.send("usdeaprllnNo="+c_sel.value);
		   }
		});

	}


</script>
