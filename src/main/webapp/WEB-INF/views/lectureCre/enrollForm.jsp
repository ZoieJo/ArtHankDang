<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- 현재 페이지의 스타일 -->
<style>
#cursPnListTr:hover {
	background-color: rgba(36, 105, 92, 0.1);
	cursor: pointer;
}
.nav-item {
	cursor: pointer;
}

table {
	table-layout: fixed;
}
.tdCursPnNm {
	text-align: left;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}
.divItems {
	margin-bottom: 20px;
}
</style>
<!-- 메시지 알림 -->
<script type="text/javascript">
	let msg = "${msg}";
	window.onload = function() {
		if (msg) {
			Swal.fire({
				icon : 'success',
				title : '알림',
				text : msg
			});
		}
	}
</script>

<!-- 몸통 머리 -->
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>강의 등록</h3>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
					<li class="breadcrumb-item">전체 강의 관리</li>
					<li class="breadcrumb-item active">강의 등록</li>
				</ol>
			</div>
		</div>
	</div>
</div>

<!-- 몸통 몸통 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-xl-12 xl-100 col-lg-12 box-col-12">
			<div class="card">
				<div class="card-header pb-0">
				<!-- 검색 -->
				<form id="searchForm" action="${CONTEXT_PATH}/crelecture/employee/search" method="POST">
				  <div class="input-group" style="margin-top:20px;">
					<div class="row">
					    <div class="col">
					      <div class="mb-0">
					        <select class="form-select digits" name="type" id="selectType" style="height: 40px;">
					          <option value='' selected>--구분--</option>
					          <option value='N'>번호</option>
					          <option value='T'>제목</option>
					          <option value='S'>신청상태</option>
					        </select>
					      </div>
					    </div>
					  </div>
					  <input class="form-control" type="text" placeholder="검색어를 입력해주세요." id="keyword" name="keyword">
					  <sec:csrfInput/>
				    <div class="input-group-append">
				      <button onclick="searchBtn()" type="button" class="btn btn-secondary" style="height: 40px;"><i class="fa fa-search"></i></button>
				      <button id="resetSrh" type="reset" class="btn btn-light btn-sm" style="font-family:ngB; font-size:15px; padding: 7.5px 20px 7.5px 20px; height: 40px;">초기화</button>
				    </div>
				  </div>
				</form>						
				</div>
				
				<!-- 헤더 링크 -->
				<div style="padding-top:10px;">
					<ul class="pull-right nav nav-pills nav-primary"
						id="pills-clrtab1" role="tablist">
						<li class="nav-item" style="padding: 5px;"><span
							class="nav-link active" id="pills-clrhome-tab1"
							data-bs-toggle="pill" role="tab" onclick="showList()"
							aria-controls="cursPlanList" aria-selected="true">계획서목록</span></li>
						<li class="nav-item" style="padding: 5px; margin-right: 44px;">
							<span class="nav-link" id="pills-clrprofile-tab1"
							data-bs-toggle="pill" role="tab" onclick="showForm()"
							aria-controls="cursPlanForm" aria-selected="false">강의등록</span>
						</li>
					</ul>
				</div>				
				<div class="card-body" style="padding-top: 0px;">
					<div class="tabbed-card">
						<!-- 카드 바디 -->
						<div id="pills-clrtabContent1" style="display: block;">
							<!-- 등록된 계획서 목록 -->
							<div id="cursPlanList" role="tabpanel"
								aria-labelledby="cursPlanList-tab1" style="display: block;">
								<!-- 테이블 -->
								<div class="card-body" style="padding: 15px 0px 0px 0px;">
									<div class="js-shorting jsgrid" id="sorting-table" style="position: relative; height: 600px; width: 100%;">
										<div class="jsgrid-grid-header">
											<table class="jsgrid-table" style="text-align: center; width: 100%; font-weight: bold; background-color: rgb(36, 105, 92); color: white">
												<tr class="jsgrid-header-row">
													<th class="jsgrid-header-cell" style="width: 15%;">번호</th>
													<th class="jsgrid-header-cell" style="width: 35%;">제목</th>
													<th class="jsgrid-header-cell" style="width: 20%;">신청날짜</th>
													<th class="jsgrid-header-cell" style="width: 15%;">신청상태</th>
													<th class="jsgrid-header-cell" style="width: 15%;">첨부파일</th>
												</tr>
											</table>
											<div class="jsgrid-grid-body"
												style="width: 100%; height: 500px; overflow: auto">
												<table class="jsgrid-table"
													style="height: 100%; width: 100%; text-align: center;">
													<tbody>
														<c:if test="${empty lecPnAllList}">
															<tr class="jsgrid-row">
																<td class="jsgrid-cell" colspan="4">등록된 강의 계획이 존재하지 않습니다.</td>
															</tr>
														</c:if>
														<c:if test="${!empty lecPnAllList}">
															<c:forEach var="item" items="${lecPnAllList}">
																<tr class="jsgrid-row" id="cursPnListTr" onclick="getCurspnDtl('${item.curspnNo}')">
																	<td class="jsgrid-cell" style="width: 15%;">${item.curspnNo}</td>
																	<td class="jsgrid-cell tdCursPnNm" style="width: 35%;">${item.curspnCursNm}</td>
																	<td class="jsgrid-cell" style="width: 20%;">
																	<fmt:formatDate value="${item.curspnRgDt}" pattern="yyyy-MM-dd (hh:mm)" /></td>
																	<c:if test="${item.curspnAprlSt eq '승인완료'}">
																		<td class="jsgrid-cell"
																			style="width: 15%; color: blue; font-weight: bold;">${item.curspnAprlSt}</td>
																		<td class="jsgrid-cell" style="width: 15%;" onclick="stopEvt()"><input
																			type="button" class="btn btn-info btn-sm"  onclick="getPnFile('${item.attchPath}')"
																			value="계획서받기" style="padding: 4px 8px 4px 8px;">
																		</td>
																		<!-- 상태 취소로 변경 -->
																	</c:if>
																	<c:if test="${item.curspnAprlSt ne '승인완료'}">
																		<td class="jsgrid-cell" style="width: 15%;">${item.curspnAprlSt}</td>
																		<td class="jsgrid-cell" style="width: 15%;"><input
																			type="button" class="btn btn-info btn-sm disabled"
																			value="계획서받기" style="padding: 4px 8px 4px 8px;">
																		</td>
																	</c:if>
																</tr>
															</c:forEach>
														</c:if>
													</tbody>
												</table>
											</div>
											<!-- 히든 폼 삭제 / 생성 -->
											<form action="${CONTEXT_PATH}/subject/delete" method="post"
												style="display: none;">
												<input type="text" name="subNo" id="id_subNo">
												<%-- 						           		<sec:csrfInput/> --%>
												<input type="submit" id="delBtn">
											</form>
											<form action="${CONTEXT_PATH}/subject/create" method="post"
												style="display: none;">
												<input type="text" name="subNm" id="id_subNm">
												<input type="submit" id="creBtn">
											</form>
											<!-- 파일 다운로드 -->
											<form id="downloadForm" action="${CONTEXT_PATH}/crelecture/download2" method="post">
												<input type="hidden" value="" name="path" id="path_id">
												<sec:csrfInput/>
											</form>

										</div>
									</div>
								</div>
							</div>

							<!-- 모달 -->
							<div id="curspnModal" class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" 
							aria-labelledby="myLargeModalLabel" style="padding-right:17px; display:none;" aria-modal="false">
							  <div class="modal-dialog modal-lg">
							    <div class="modal-content">
							      <!--모달 머리-->
							      <div class="modal-header">
							        <h4 class="modal-title" id="myLargeModalLabel">강의 계획서 상세페이지</h4>
							        <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <!--모달 몸통-->
							      <div class="modal-body" id="modalBody"></div>
							    </div>
							  </div>
							</div> <!-- 모달 끝 -->	

							<!--강의 등록-->
							<div id="cursPlanForm" role="tabpanel"
								aria-labelledby="cursPlanForm-tab1" style="display: none;">
								<div class="container-fluid" style="padding: 15px 0px 0px 0px;">
									<div class="row">
										<div class="col-sm-12">
											<div class="card">
												<form name="frm" class="form theme-form" action="${CONTEXT_PATH}/crelecture/employee" method="post" enctype="multipart/form-data">
													<div class="card-body">

														<!-- 개설할 강의 계획서 번호 -->
														<div class="row divItems">
															<div class="col">
																<div>
																	<label class="form-label" for="id_curspnNo">강의 계획서 번호</label>
																	<select class="form-select digits" id="id_curspnNo" name="curspnNo" onchange="autoSet(value)">
																		<option value="">-- 번호를 선택해 주세요 --</option>
																		<c:if test="${!empty pnNoList }">
																			<c:forEach var="pnNo" items="${pnNoList}">
																				<option value="${pnNo.curspnNo}">${pnNo.curspnNo}</option>
																			</c:forEach>
																		</c:if>
																		<c:if test="${empty pnNoList}">
																			<c:forEach var="pnNo" items="${pnNoList}">
																				<option value="">선택 가능한 강의 번호가 없습니다.</option>
																			</c:forEach>
																		</c:if>
																	</select>
																</div>
															</div>
														</div>

														<!-- 강의명 -->
														<div class="row divItems">
															<div class="col">
																<div>
																	<label class="form-label" for="id_cursNm">강의명</label>
																	<input class="form-control" id="id_cursNm" name="cursNm" type="text"  autofocus="autofocus" maxlength="33">
																</div>
															</div>
														</div>
														
														<!-- 날짜정보 -->
														<div class="row g-2 divItems">
															<!-- 강의 시작 날짜 -->
															<div class="col md-6 position-relative">
																<div>
																	<label class="form-label" for="id_cursSttDt">강의 시작 날짜</label>
																	<input class="form-control" id="id_cursSttDt"name="cursSttDt" type="date">
																</div>
															</div>
															<!-- 강의 종료 날짜 -->
															<div class="col md-6 position-relative">
																<div>
																	<label class="form-label" for="id_cursEndDt">강의 종료 날짜</label>
																	<input class="form-control" id="id_cursEndDt" name="cursEndDt" type="date" >
																</div>
															</div>
														</div>
														
														<!-- 강의 시작 시 and 분 -->
														<div class="row g-2 divItems">
															<div class="col md-6 position-relative">
																<div>
																	<label class="form-label" for="id_cursSttHh">강의 시작 시간</label>
																	<select class="form-select digits" id="id_cursSttHh" name="cursSttHh">
																		<option value="">--선택--</option>
																		<option value="9">09시</option>
																		<option value="10">10시</option>
																		<option value="11">11시</option>
																		<option value="12">12시</option>
																		<option value="13">13시</option>
																		<option value="14">14시</option>
																		<option value="15">15시</option>
																		<option value="16">16시</option>
																		<option value="17">17시</option>
																		<option value="18">18시</option>
																		<option value="19">19시</option>
																		<option value="20">20시</option>
																	</select>
																</div>
															</div>
															<div class="col md-6 position-relative">
																<div>
																	<label class="form-label" for="id_cursSttMm">&nbsp;&nbsp;</label>
																	<select class="form-select digits" id="id_cursSttMm" name="cursSttMm" >
																		<option value="">--선택--</option>
																		<option value="0">00분</option>
																		<option value="10">10분</option>
																		<option value="20">20분</option>
																		<option value="30">30분</option>
																		<option value="40">40분</option>
																		<option value="50">50분</option>
																	</select>
																</div>
															</div>
														</div>
														<!-- 강의 종료 시 and 분 -->
														<div class="row g-2 divItems">
															<div class="col md-6 position-relative">
																<div>
																	<label class="form-label" for="id_cursEndHh">강의 종료 시간</label>
																	<select class="form-select digits" id="id_cursEndHh" name="cursEndHh" >
																		<option value="">--선택--</option>
																		<option value="9">09시</option>
																		<option value="10">10시</option>
																		<option value="11">11시</option>
																		<option value="12">12시</option>
																		<option value="13">13시</option>
																		<option value="14">14시</option>
																		<option value="15">15시</option>
																		<option value="16">16시</option>
																		<option value="17">17시</option>
																		<option value="18">18시</option>
																		<option value="19">19시</option>
																		<option value="20">20시</option>
																	</select>
																</div>
															</div>
															<div class="col md-6 position-relative">
																<div>
																	<label class="form-label" for="id_cursEndMm">&nbsp;&nbsp;</label>
																	<select class="form-select digits" id="id_cursEndMm" name="cursEndMm" >
																		<option value="">--선택--</option>
																		<option value="0">00분</option>
																		<option value="10">10분</option>
																		<option value="20">20분</option>
																		<option value="30">30분</option>
																		<option value="40">40분</option>
																		<option value="50">50분</option>
																	</select>
																</div>
															</div>
														</div>
														<!-- 요일선택 -->
														<div class="col" style="color:rgb(89, 102, 122); margin-bottom:15px;">
															<div>요일 선택</div>
														    <div class="form-group m-checkbox-inline mb-0">
														        <div class="checkbox checkbox-dark">
														            <input id="inline-1" type="checkbox" value="1" name="cursDay">
														            <label for="inline-1"><span class="digits">월요일</span></label>
														            <input id="inline-2" type="checkbox" value="2"  name="cursDay">
														            <label for="inline-2"><span class="digits">화요일</span></label>
														            <input id="inline-3" type="checkbox" value="3"  name="cursDay">
														            <label for="inline-3"><span class="digits">수요일</span></label>
														            <input id="inline-4" type="checkbox" value="4"  name="cursDay">
														            <label for="inline-4"><span class="digits">목요일</span></label>
														            <input id="inline-5" type="checkbox" value="5"  name="cursDay">
														            <label for="inline-5"><span class="digits">금요일</span></label>
														            <input id="inline-6" type="checkbox" value="6"  name="cursDay">
														            <label for="inline-6"><span class="digits">토요일</span></label>
														            <input id="inline-7" type="checkbox" value="7"  name="cursDay">
														            <label for="inline-7"><span class="digits">일요일</span></label>
														        </div>
														    </div>
														</div>
														<!-- 강의 시수 -->
														<div class="row divItems">
															<div class="col">
																<div>
																	<label class="form-label" for="id_cursNum">강의 시수</label>
																	<input class="form-control" id="id_cursNum" name="cursSuNum" type="number" readonly="readonly" >
																</div>
															</div>
														</div>
														<!-- 시설명 -->
														<div class="row divItems">
															<div class="col">
																<div>
																	<label class="form-label" for="id_faciNm">강의실</label>
																	<input class="form-control" id="id_faciNm" name="faciNm" type="text" readonly="readonly" >
																</div>
															</div>
														</div>
														
														<!-- 강의 가격 -->
														<div class="row divItems">
															<div class="col">
																<div>
																	<label class="form-label" for="id_cursSuPri">강의 가격</label>
																	<input class="form-control" id="id_cursSuPri" name="cursSuPri" type="number" min="0" max="10000000" >
																</div>
															</div>
														</div>
														
														<!-- 썸넬 미리보기 -->
														<div>
															<div class="col">
																<div id="pictureView" style="border:1px solid rgb(89,102,122); width:425px; height:265px;"></div>
															</div>
														</div>
														
														<!-- 강의 썸네일 첨부파일 -->
														<div class="row">
															<div class="col">
																<div>
															        <label class="form-label" for="id_picPath">강의 썸네일 파일</label>
<!-- 															        <label class="btn btn-success btn-xs" for="inputFile" style="margin: 0px;">파일선택</label> -->
																	<input class="form-control" id="id_picPath" name="tempPicture" onchange="goPicture()" type="file">
																</div>
															</div>
<!-- 															<div class="col-3 position-relative" style="margin-top:55px; padding: 0px;"> -->
<!-- 																<div> -->
<!-- 															        <label class="form-label" for="dis">&nbsp;&nbsp;</label> -->
<!-- 																	<button type="button" id="dis" class="btn btn-info btn-sm" onclick="goUpload()">사진 업로드</button> -->
<!-- 																</div> -->
<!-- 															</div> -->
														</div>
														<sec:csrfInput/>
														
													<!-- 계획서 작성한 교원 아이디 -->
													<input type="hidden" id="id_tcrId" name="tcrId">
													
													</div> <!-- 폼 몸통 끝 -->
													<div class="card-footer text-end" style="padding: 10px; border:none;">
														<button class="btn btn-primary" type="button" onclick="goEnroll()">완료</button>
														<input class="btn btn-light" type="reset" value="초기화">
													</div> <!-- 폼 발 끝 -->
													
												</form>
											</div>
											
										</div>
									</div>
								</div>
							</div>
							<!-- 등록 -->
						</div>
						<!-- 폼 몸통 -->
					</div>
					<!-- 탭드 카드 -->
				</div>
				<!-- 카드 몸통 -->
			</div>
			<!-- 전체 카드 -->
		</div>
	</div>
</div>

<script type="text/javascript">
	/* 검색 버튼 누를 때, 검사 */
	function searchBtn(){
		alert('버튼누를 때 작동한다구여');
		// 검색 타입 + 키워드 가져오기
		let tp = $('#selectType').val();
		let kw = $('#keyword').val();
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
		// 전송
		document.querySelector('#searchForm').submit();
	}
	
	/* 초기화 버튼 */
	$('#resetSrh').on("click", function(){
		location.href = "${CONTEXT_PATH}/crelecture/employee";
	});	

	/* 썸네일 만들기 */
	function goPicture(){
		 let picture = $('input[name=tempPicture]')[0];
		 let fileName= picture.files[0].name;
		 let fileFormat = fileName.substr(fileName.lastIndexOf(".")+1).toUpperCase();
		 if(!(fileFormat=="JPG" || fileFormat=="JPEG"|| fileFormat=="PNG")){
			 Swal.fire({
					icon : 'warning',
					title : '경고',
					text : '이미지는 jpg/jpeg/png 형식만 가능합니다.'
				});
	   		picture.value="";      
   			return;
		 } 
		   
	      var reader = new FileReader();
	       reader.onload = function (e) {
	           $('div#pictureView')
	              .css({'background-image':'url('+e.target.result+')',
	                 'background-position':'center',
	                 'background-size':'cover',
	                 'background-repeat':'no-repeat'
	                 });
	        }
	      reader.readAsDataURL(picture.files[0]);
	}
	
	/* 이벤트 막기 */
	function stopEvt(){
		event.stopPropagation();
	}

	/* 리스트 보여주기 */
	function showList() {
		document.getElementById("cursPlanForm").style.display = 'none';
		document.getElementById("cursPlanList").style.display = "block";
	}

	/* 폼 보여주기 */
	function showForm() {
		document.getElementById("cursPlanForm").style.display = "block";
		document.getElementById("cursPlanList").style.display = "none";
	}

	/* 값 자동으로 세팅 해주는 함수 */
	function autoSet(p_no) {
// 		console.log(p_no);
		let url = '${CONTEXT_PATH}/crelecture/employee/pndtl?no=' + p_no;
		let xhr = new XMLHttpRequest();
		xhr.open('get', url, true);
		xhr.onreadystatechange = function(){
			if (xhr.readyState == 4 && xhr.status == 200) {
 				console.log("xhr.responseText : " + xhr.responseText);
				let data = JSON.parse(xhr.responseText);
				document.querySelector('#id_cursNm').value = data.curspnCursNm ; // 강의명
				document.querySelector('#id_faciNm').value = data.faciNm; // 시설명
				document.querySelector('#id_cursNum').value = data.curspnCursNum; // 시수
				document.querySelector('#id_tcrId').value = data.tcrId; // 교원
			}
		}
		xhr.send();
	}
	
	/* 계획서 다운 받기 */
	function getPnFile(p_path){
		let df = document.querySelector("#downloadForm");
		let pa = document.querySelector("#path_id");
		pa.value = p_path;
		df.submit();
	}

	/* 계획서 상세정보 가져오기 */
	function getCurspnDtl(p_curspnNo){
		let url = '${CONTEXT_PATH}/crelecture/employee/dtl?curspnNo=' + p_curspnNo ; // AJAX get-URL
		// alert(p_curspnNo);
		let xhr = new XMLHttpRequest();
		xhr.open('GET', url, true);
		xhr.onreadystatechange = function(){
			if (xhr.readyState == 4 && xhr.status == 200) {
// 				console.log(xhr.responseText);
				let data = JSON.parse(xhr.responseText);
				console.log(data);
				
				let code = '';
				code += `
					<form class="form theme-form">
					  <div class="card-body">
					    <div class="row">
					      <div class="col">
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnNo">계획서 번호</label>
					          <div class="col-sm-9"><input class="form-control" id="id_curspnNo" type="text" value="`; code += data.curspnNo + `" readonly></div>
					        </div>
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnCursNm">강의명</label>
					          <div class="col-sm-9"><input class="form-control" id="id_curspnCursNm" type="text" value="`; code += data.curspnCursNm + `" readonly></div>
					        </div>
					        <div class="row">
					          <label class="col-sm-3 col-form-label" for="id_curspnCnt">내용</label>
					          <div class="col-sm-9"><textarea class="form-control" id="id_curspnCnt" rows="5" cols="5" readonly>`; 
					          let cnt = '';
					          if(data.curspnCnt.includes("<br>")){
					        	  cnt = data.curspnCnt.replace(/<br>/gi,'\n');
					          } else {
					        	  cnt = data.curspnCnt;
					          }
					          console.log(cnt);
					          code += cnt + `</textarea></div>
					        </div>
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="">강의실</label>
					          <div class="col-sm-9"><input class="form-control" type="text" value="`; code += data.faciNm + `" readonly></div>
					        </div>        
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnCursNum">강의시수</label>
					          <div class="col-sm-9"><input class="form-control digits" id="id_curspnCursNum" type="number" value="`; code += data.curspnCursNum + `" readonly></div>
					        </div>
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnRgDt">등록날짜</label>
					          <div class="col-sm-9"><input class="form-control digits" id="id_curspnRgDt" type="text" value="`; code += data.curspnRgDt + `" readonly></div>
					        </div>
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_tcrId">작성자(아이디)</label>
					          <div class="col-sm-9"><input class="form-control" id="id_tcrId" type="text" value="`; code += data.empNm + '('+ data.tcrId +')' + `" readonly></div>
					        </div>
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnAprlSt">승인상태</label>
					          <div class="col-sm-9"><input class="form-control" id="id_curspnAprlSt" type="text" value="`; code += data.curspnAprlSt + `" readonly></div>
					        </div>`;
					        if(data.curspnAprlDt!=null){
					          code += `<div class="mb-3 row"><label class="col-sm-3 col-form-label" for="id_curspnAprlDt">승인날짜</label><div class="col-sm-9"><input class="form-control digits" id="id_curspnAprlDt" type="text" value="`;
					          code += data.curspnAprlDt + `" readonly></div></div>`;
					        }
					       code += `</div></div></div>
					  <div class="card-footer text-end" style="padding:0; border:none;">
					    <div class="col-sm-9 offset-sm-3">
					    	<input class="btn btn-light" type="reset" style="display:none;" id="resetBtn" value="초기화">
					     	<button class="btn btn-info" type="button" onclick="modalClose()">닫기</button>
					    </div></div></form>`;
				
				document.querySelector('#modalBody').innerHTML = code;
				$('#curspnModal').modal('show');

			}
		}
		xhr.send();
	}
	
	/* 모달 닫기 */
	function modalClose(){
		$('#curspnModal').modal('hide');
	}	

	/* 전송 유효성 검색 */
	function goEnroll(){
		  if(!$("select[name=curspnNo]").val()){ // 강의 번호
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 계획서 번호 선택은 필수입니다."
			});
			return;
		  }
		  if(!$('input[name="cursNm"]').val()){ // 강의명
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의명은 필수입니다."
			});
			return;
		  }
		  if(!$('input[name="cursSttDt"]').val()){ // 강의 시작 날짜
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 시작 날짜 선택은 필수입니다."
			});
			return;
		  }
		  if(!$('input[name="cursEndDt"]').val()){ // 강의 종료 날짜
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 종료 날짜 선택은 필수 입니다."
			});
			return;
		  }
		  if(!$('select[name="cursSttHh"]').val()){ // 강의 시작 시간
		   console.log("시작시간");
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 시작 시간 선택은 필수입니다."
			});
			return;
		  }
		  if(!$('select[name="cursSttMm"]').val()){ // 강의 시작 시간
		   console.log("시작 분");
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 시작 시간 선택은 필수입니다."
			});
			return;
		  }
		  if(!$('select[name="cursEndHh"]').val()){ // 강의 종료 분
		   console.log("종료 시 성공");
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 종료 시간 선택은 필수입니다."
			});
			return;
		  }
		  if(!$('select[name="cursEndMm"]').val()){ // 강의 종료 분
		   console.log("종료 분 성공");
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 종료 시간 선택은 필수입니다."
			});
			return;
		  }
		  if(!$('input:checkbox[name=cursDay]').val()){ // 강의 요일
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 요일 선택은 필수 입니다."
			});
			return;
		  }
		  if(!$('input[name="cursSuPri"]').val()){ // 강의 가격
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 가격 입력은 필수 입니다."
			});
			return;
		  }
		  let uploadCheck = $('input[name="checkUpload"]').val(); // 강의 썸네일 
		  if(uploadCheck=="0"){
			Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 썸네일 사진 업로드는 필수 입니다."
			});
			return;
		  }
		  
		  // 전송
		  let form = $('form[name="frm"]');
		  form.submit();
	  }

</script>	
	