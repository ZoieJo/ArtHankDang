<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- 현재 페이지의 스타일 -->
<style>
#cursPnListTr:hover{
   background-color: rgba(36, 105, 92, 0.1);
   cursor:pointer;
}
input[type=checkbox] {
	zoom: 1.5;
}
.nav-item{
   cursor:pointer;
}
table {
	table-layout: fixed;
}
.cruspnNmTd{
	text-align: left;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}
</style>
<!-- 메시지 알림 -->
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
<!-- 몸통 머리 -->
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>내 강의 계획서 등록</h3>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}/crelecture/teacher/testUpdate">내 강의 관리</a></li>
					<li class="breadcrumb-item active">내 강의 계획서 등록</li>
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
				<form id="searchForm" action="${CONTEXT_PATH}/crelecture/teacher/search" method="POST">
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
				</div> <!-- 머리 끝 -->

				<!-- 카드 링크 -->
				<div style="padding-top:10px;">
					<ul class="pull-right nav nav-pills nav-primary" id="pills-clrtab1" role="tablist">
						<li class="nav-item" style="padding:5px;">
							<span class="nav-link active" id="pills-clrhome-tab1" data-bs-toggle="pill" role="tab" onclick="showList()"
							aria-controls="cursPlanList" aria-selected="true">계획서목록</span>
						</li>
						<li class="nav-item" style="padding:5px; margin-right:44px;">
							<span class="nav-link" id="pills-clrprofile-tab1" data-bs-toggle="pill" role="tab" onclick="showForm()"
							 aria-controls="cursPlanForm" aria-selected="false">계획서등록</span>
						</li>
					</ul>
				</div>	
				<div class="card-body" style="padding-top: 0px;">
					<div class="tabbed-card">
						<!-- 카드 내용 -->
						<div id="pills-clrtabContent1" style="display:block;">
							<!--목록-->
							<div id="cursPlanList" role="tabpanel" aria-labelledby="cursPlanList-tab1" style="display:block;">
						          <!-- 테이블 -->
						          <div class="card-body" style="padding: 15px 0px 0px 0px;">
						            <div class="js-shorting jsgrid" id="sorting-table" style="position:relative; height:600px; width:100%;">
						              <div class="jsgrid-grid-header">
						                <table class="jsgrid-table" style="text-align:center; width:100%; font-weight:bold; background-color:rgb(36, 105, 92); color:white">
						                  <tr class="jsgrid-header-row">
						                    <th class="jsgrid-header-cell" style="width:15%;">번호</th>
						                    <th class="jsgrid-header-cell" style="width:35%;">제목</th>
						                    <th class="jsgrid-header-cell" style="width:20%;">신청날짜</th>
						                    <th class="jsgrid-header-cell" style="width:15%;">신청상태</th>
						                    <th class="jsgrid-header-cell" style="width:15%;">
						                    	<input onclick="cancelBtn()" type="button" class="btn btn-danger btn-sm" 
						                    	style="width:70%; height:auto; text-align:center; font-size:auto; padding: 0px auto;" value="신청취소"></th>
						                  </tr>
						                </table>
						              <div class="jsgrid-grid-body" style="width:100%; height:500px; overflow:auto">
						                <table class="jsgrid-table" style="height:100%; width:100%; text-align:center;">
						                  <tbody>
						                  		<c:if test="${empty lecPnList}">
						                  			<tr class="jsgrid-row">
						                  				<td class="jsgrid-cell" colspan="4">신청한 =강의 계획이 존재하지 않습니다.</td>
						                  			</tr>
						                  		</c:if>
							                  	<c:if test="${!empty lecPnList}">
							                  		<c:forEach var="item" items="${lecPnList}">
								                    <tr class="jsgrid-row" id="cursPnListTr" onclick="getCurspnDtl('${item.curspnNo}')">
								                      <td class="jsgrid-cell" style="width:15%;">${item.curspnNo}</td>
								                      <td class="jsgrid-cell cruspnNmTd" style="width:35%;">${item.curspnCursNm}</td>
								                      <td class="jsgrid-cell" style="width:20%;"><fmt:formatDate value="${item.curspnRgDt}" pattern="yyyy-MM-dd (hh:mm)"/></td>
								                      <c:if test="${item.curspnAprlSt eq '승인대기'}">
									                      <td class="jsgrid-cell" style="width:15%;color:red;">${item.curspnAprlSt}</td>
									                      <td class="jsgrid-cell" style="width:15%;" onclick="stopEvt()"><input type="checkbox" name="pnNo" value="${item.curspnNo}"></td> 
								                      </c:if>
								                      <c:if test="${item.curspnAprlSt ne '승인대기'}">
									                      <td class="jsgrid-cell" style="width:15%;">${item.curspnAprlSt}</td>
									                      <td class="jsgrid-cell" style="width:15%;" onclick="stopEvt()"><input type="checkbox" name="pnNo" disabled="disabled"></td> 
								                      </c:if>
								                    </tr>
								                    </c:forEach>
							                  	</c:if>
											</tbody>
										</table>
						              </div>
						              <!-- 히든 폼 삭제 / 생성 -->
						           	<form action="${CONTEXT_PATH}/subject/delete" method="post" style="display:none;">
						           		<input type="text" name="subNo" id="id_subNo">
<%-- 						           		<sec:csrfInput/> --%>
						           		<input type="submit" id="delBtn">
						           	</form>
						           	<form action="${CONTEXT_PATH}/subject/create" method="post" style="display:none;">
						           		<input type="text" name="subNm" id="id_subNm">
<%-- 						           		<sec:csrfInput/> --%>
						           		<input type="submit" id="creBtn">
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

							<!--등록-->
							<div id="cursPlanForm" role="tabpanel" aria-labelledby="cursPlanForm-tab1" style="display:none;">
								<div class="container-fluid" style="padding: 15px 0px 0px 0px;">
									<div class="row">
										<div class="col-sm-12">
											<div class="card">
												<form class="form theme-form" action="${CONTEXT_PATH}/crelecture/teacher" method="post" enctype="multipart/form-data">
													<div class="card-body">
														<!-- 교원명 -->
														<div class="row">
															<div class="col">
																<div class="mb-3">
																	<label class="form-label" for="id_tcrId">교원명(아이디)</label>
																	<input class="form-control" id="id_tcrId" type="text"  disabled="disabled" value="${USER.memberDetail.getMemName()}(${myId})">
																	<input class="form-control" name="tcrId" type="hidden" value="${myId}">
																</div>
															</div>
														</div>
														<!-- 강의명 -->
														<div class="row">
															<div class="col">
																<div class="mb-3">
																	<label class="form-label" for="id_curspnCursNm">강의명</label>
																	<input class="form-control" id="id_curspnCursNm" name="curspnCursNm" type="text" required="required" maxlength="33">
																</div>
															</div>
														</div>
														<!-- 강의내용(계획요약 및 목표) -->
														<div class="row">
															<div class="col">
																<div class="mb-3">
																	<label class="form-label" for="id_curspnCnt">강의내용</label>
																	<textarea class="form-control" id="id_curspnCnt" name="curspnCnt" rows="10" 
																	placeholder="강의목표 및 강의요약정보를 입력해 주세요." required="required" maxlength="1000"></textarea>
																</div>
															</div>
														</div>
														<!-- 강의시수 -->
														<div class="row">
															<div class="col">
																<div class="mb-3">
																	<label class="form-label" for="id_curspnCursNum">강의시수</label>
																	<input class="form-control" id="id_curspnCursNum" name="curspnCursNum" type="number"
																		min="0" max="160" required="required">
																</div>
															</div>
														</div>
														<!-- 강의실 가져오기 -->
														<div class="row">
															<div class="col">
																<div class="mb-3">
																	<label class="form-label" for="id_faciNo">강의실</label>
																	<select class="form-select digits" id="id_faciNo" name="faciNo" required="required">
																		<c:forEach var="item" items="${faciInfo}">
																			<option value="${item.faciNo}">${item.faciNm}</option>
																		</c:forEach>
																	</select>
																</div>
															</div>
														</div>
														<!-- 강의계획서 첨부파일 -->
														<div class="row">
														    <div class="col">
														    	<div>
															        <label class="form-label">파일업로드(파일이름:아이디_이름)</label>
															        <input class="form-control" type="file" name="uploadFile" onchange="ckExp()"/>
														    	</div>
														    </div>
														</div>														
													</div>
													<sec:csrfInput/>
													<div class="card-footer text-end" style="padding: 0px 30px 30px 0px; border:none;">
														<input class="btn btn-info" type="button" onclick="goFileDown()" value="계획서양식받기">
														<button class="btn btn-primary" type="submit">완료</button>
														<input class="btn btn-light" type="reset" value="초기화">
													</div>
													<iframe id="ifrm" style="display:none;"></iframe>
												</form>
											</div>

										</div>
									</div>
								</div>
							</div><!-- 등록 -->
						</div> <!-- 폼 몸통 -->
					</div> <!-- 탭드 카드 -->
				</div> <!-- 카드 몸통 -->
			</div> <!-- 전체 카드 -->
		</div>
	</div>
</div>
<!-- 파일 다운로드 -->
<form id="downloadForm" action="${CONTEXT_PATH}/crelecture/download2" method="post">
	<input type="hidden" value="" name="path" id="path_id">
	<sec:csrfInput/>
</form>

<script type="text/javascript">
	
	/* 계획서 다운로드 버튼 클릭 */
	function pnFile(p_filePath){
		let df = document.querySelector("#downloadForm");
		let pa = document.querySelector("#path_id");
		pa.value = p_filePath;
		df.submit();	
	}
	
	/* 검색 버튼 누를 때, 검사 */
	function searchBtn(){
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
		location.href = "${CONTEXT_PATH}/crelecture/teacher";
	});

	/* 확장자 확인 로직 */
	function ckExp(){
		 let l_file = $('input[name=uploadFile]')[0];
		 let fileName= l_file.files[0].name;
		 let fileFormat = fileName.substr(fileName.lastIndexOf(".")+1).toUpperCase();
		 if(!(fileFormat=="DOCX" || fileFormat=="DOC")){
			 Swal.fire({
					icon : 'warning',
					title : '경고',
					text : '계획서 파일은 워드형식만 올릴 수 있습니다.'
				});
			 l_file.value="";      
   			return;
		 }		
	}

	/* 이벤트 막기 */
	function stopEvt(){
		event.stopPropagation();
	}
	
	/* 양식 다운 받기 */
	function goFileDown(){
		//location.href = "${CONTEXT_PATH}/crelecture/download";
		$("#ifrm").attr("src","${CONTEXT_PATH}/crelecture/download");
	}
	
	/* 리스트 보여주기 */
	function showList(){
		document.getElementById("cursPlanForm").style.display = 'none';
		document.getElementById("cursPlanList").style.display = "block";
	}
	
	/* 폼 보여주기 */
	function showForm(){
		document.getElementById("cursPlanForm").style.display = "block";
		document.getElementById("cursPlanList").style.display = "none";
	}
	
	/* 계획서 상세정보 가져오기 */
	function getCurspnDtl(p_curspnNo){
		let url = '${CONTEXT_PATH}/crelecture/teacher/dtl?curspnNo=' + p_curspnNo ; // AJAX get-URL
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
					<form class="form theme-form" name="modiForm" action="${CONTEXT_PATH}/crelecture/teacher/update" method="post"> <!-- enctype="multipart/form-data" -->
					  <div class="card-body">
					    <div class="row">
					      <div class="col">
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnNo1">계획서 번호</label>
					          <div class="col-sm-9"><input class="form-control" id="id_curspnNo1" name="curspnNo" type="text" value="`; code += data.curspnNo + `" readonly></div>
					        </div>
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnCursNm1">강의명</label>
					          <div class="col-sm-9"><input class="form-control" id="id_curspnCursNm1" name="curspnCursNm" type="text" value="`; code += data.curspnCursNm + `" readonly></div>
					        </div>
					        <div class="row">
					          <label class="col-sm-3 col-form-label" for="id_curspnCnt1">내용</label>
					          <div class="col-sm-9"><textarea class="form-control" id="id_curspnCnt1" name="curspnCnt" rows="10" cols="5" readonly>`;
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
					          <label class="col-sm-3 col-form-label" for="id_faciNm1">강의실</label>
					          <div class="col-sm-9"><input class="form-control" id="id_faciNm1" name="faciNm" type="text" value="`; code += data.faciNm + `" readonly></div>
					        </div>        
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnCursNum1">강의시수</label>
					          <div class="col-sm-9"><input class="form-control digits" id="id_curspnCursNum1" name="curspnCursNum" type="number" value="`; code += data.curspnCursNum + `" readonly></div>
					        </div>
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnRgDt1">등록날짜</label>
					          <div class="col-sm-9"><input class="form-control digits" id="id_curspnRgDt1" name="curspnRgDt" type="text" value="`; code += data.curspnRgDt + `" readonly></div>
					        </div>
					        <div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnAprlSt1">승인상태</label>
					          <div class="col-sm-9"><input class="form-control" id="id_curspnAprlSt1" name="curspnAprlSt" type="text" value="`; code += data.curspnAprlSt + `" readonly></div>
					        </div>`;
					        // 승인자와 날짜 보여주기 -> 승인완료시
					        if(data.empId && data.curspnAprlDt ){
					        	code += `<div class="mb-3 row"><label class="col-sm-3 col-form-label" for="id_empId1">승인자</label>
					          			<div class="col-sm-9"><input class="form-control" id="id_empId1" name="empId" type="text" value="`; 
								code += data.empId + `" readonly></div></div>`;
				        		code += `<div class="mb-3 row"><label class="col-sm-3 col-form-label" for="id_curspnAprlDt1">승인날짜</label>
					          			<div class="col-sm-9"><input class="form-control digits" id="id_curspnAprlDt1" name="curspnAprlDt" type="text" value="`;
					         	code += data.curspnAprlDt + `" readonly></div></div>`;
					        }
					        code += `<div class="mb-3 row">
					          <label class="col-sm-3 col-form-label" for="id_curspnFile1">계획서</label>
					          <div class="col-sm-9"><input class="form-control digits fbtn btn-secondary btn-sm" type="button" 
					          id="id_curspnFile1" value="계획서다운받기" onclick="pnFile('`; code += data.attchPath + `')" />
					          <input class="form-control digits" id="id_attchPath1" name="attchPath" type="file" style="display:none;" disabled/></div>
					        </div>
					      </div>
					    </div>
					  </div>
					  <div class="card-footer text-end" style="padding:0; border:none;">
					    <div class="col-sm-9 offset-sm-3">`;
					    // 승인대기 >> 수정가능, 승인중, 승인완료, 취소, 반려 >> 수정불가
					    if(data.curspnAprlSt=='승인대기'){
					    	code += `<button class="btn btn-warning" type="button" onclick="updateBtn()">수정</button>
							      <button class="btn btn-primary" type="button" onclick="goEnroll()" style="display:none;" id="doneBtn">완료</button>
							      <input class="btn btn-light" type="reset" style="display:none;" id="resetBtn" value="원래대로">`;
					    }
					      code += `<button class="btn btn-info" type="button" onclick="modalClose()">닫기</button>
					    	  <sec:csrfInput/>
					    </div>
					  </div>
					</form>`;				
				
				document.querySelector('#modalBody').innerHTML = code;
				$('#curspnModal').modal('show');

			}
		}
		xhr.send();
	}
	
	/* 전송 유효성 검색후 데이터 변경 */
	function goEnroll(){
// 		console.log($('input[id="id_curspnCursNm1"]').val());
// 		console.log($('textarea#id_curspnCnt1').val());
// 		console.log($('input[id="id_curspnCursNum1"]').val());
		
		  if(!$('input[id="id_curspnCursNm1"]').val()){ // 강의명
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의명 입력은 필수 입니다."
			});
			return;
		  }
		  
		  if(!$('textarea#id_curspnCnt1').val()){ // 강의내용
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 내용 입력은 필수입니다."
			});
			return;
		  }
		  if(!$('input[id="id_curspnCursNum1"]').val()){ // 강의시수
		   Swal.fire({
				icon : 'warning',
				title : '경고',
				text : "강의 시수 입력은 필수입니다."
			});
			return;
		  }
		  
		  Swal.fire({
			  icon : 'info',
			  title: '확인메시지',
		      text: '변경된 내용을 반영하시겠습니까?',
			  showCancelButton: true,
			  confirmButtonText: '확인',
			  cancelButtonText: '취소',
		  }).then((result) => {
			  if (result.isConfirmed) {
			  // 전송
			  let form = $('form[name="modiForm"]');
			  form.submit();
			  }
		  })
	  }	
	
	/* 모달 닫기 */
	function modalClose(){
		$('#curspnModal').modal('hide');
	}
	
	/* 모달 수정 버튼 클릭시 */
	function updateBtn(){
		document.querySelector('#doneBtn').style.display = "inline-block";
		document.querySelector('#resetBtn').style.display = "inline-block";
		$('input').prop('readonly', false);
		$('textarea').prop('readonly', false);
		$('#id_curspnFile1').prop('disabled', true); // 파일 다운 금지
		$('#id_curspnFile1').css('display', 'none'); // 파일 다운 버튼 지우기
		$('#id_curspnFile1').css('display', 'none'); // 파일 다운 버튼 지우기
		$('#id_attchPath1').css('display', 'block'); // 파일 입력 태그 생성
		$('#id_empId1').prop('readonly', true);
		$('#id_faciNm1').prop('readonly', true);
		$('#id_curspnAprlDt1').prop('readonly', true);
		$('#id_curspnNo1').prop('readonly', true);
		$('#id_curspnAprlSt1').prop('readonly', true);
		$('#id_curspnRgDt1').prop('readonly', true);
	}
	
	/* 신청 취소 버튼 클릭(일괄처리) */
	function cancelBtn(){
		// 체크박스 값 가져오기
		let chk_Val = [];
	 	$("input:checkbox[name=pnNo]:checked").each(function(i) {
	 		chk_Val.push($(this).val());
	 	});
	 	// console.log(chk_Val);
	 	
	 	// 보내 줄 번호가 들어 있는 배열
	    let data = {
			"curspnNoList" : chk_Val
		};
	 	
	 	// 알림 및 데이터 처리
		Swal.fire({
			   title: '취소알림',
			   text: '강의 계획서 제출을 취소하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   reverseButtons: false, // 버튼 순서 거꾸로
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // confirm
			    	// 전송ajax
			        let xhr = new XMLHttpRequest();
			        xhr.open("post", "${CONTEXT_PATH}/crelecture/teacher/delete", true);
					xhr.onreadystatechange = function(){
						if (xhr.readyState == 4 && xhr.status == 200) {
							location.href = '${CONTEXT_PATH}/crelecture/teacher'; // 새로고침...
					        Swal.fire({ // 알림...
					            icon: 'success',
					            title: '알림',
					            text: xhr.responseText
					        });
						}
					}
					xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
					xhr.setRequestHeader("Content-Type", "application/json;chartset=utf-8");
					xhr.send(JSON.stringify(data));
					
			   }// end if
			});
	}

	
</script>