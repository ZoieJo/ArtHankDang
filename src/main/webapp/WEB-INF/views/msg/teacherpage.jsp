<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!-- 현재 페이지의 바디 내의 css -->
<style>
.container-fluid {
	min-height: 100%;
	font-family: ngB;
}
form label{
	font-size: 17px;
}
#exampleFormControlTextarea4 {
 	resize: none; 
	font-size: 17px;
}
</style>

<!-- 내용 머리 -->
<script type="text/javascript">
    let msg = "${msg}";
	window.onload = function(){
	    if(msg){        
	        Swal.fire({
	            icon: 'success',
	            title: '성공',
	            text: msg
	        });
	    }
	}
</script>

<div class="container-fluid">
	<div class="page-header" style="padding: 20px;">
		<div class="row">
			<div class="col-sm-12">
				<h3>메시지(MMS)</h3>
				<!-- 제목 하단 페이지 경로 -->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
					<li class="breadcrumb-item"><a href="#">학원관리</a></li>
					<li class="breadcrumb-item"><a href="#">메시지(MMS)전송</a></li>
				</ol>
			</div>
		</div>
	</div>
</div>

<!-- 내용 몸통-->
<div class="container-fluid">
	<div class="row">
		<div class="col call-chat-sidebar">
			<div class="card">
				<div class="card-body chat-body" style="height:auto; word-break:break-all; overflow: auto;">

					<div class="chat-box">
						<!-- 쪽지 사이드 보내는 사람 목록 -->
						<div class="chat-left-aside">
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
							<div
								style="font-size: 15px; color: rgb(70, 70, 70); font-weight: bold;">수강 학생 주소록</div>
						</div>
					</div>
					<!-- Chat left side Ends-->

					<!-- 트리구조 -->
					<div id="treecheckbox"
						class="jstree jstree-2 jstree-default jstree-checkbox-selection"
						role="tree" aria-multiselectable="true" tabindex="0"
						aria-activedescendant="j2_4" aria-busy="false"
						aria-selected="false">
						<ul class="jstree-container-ul jstree-children" role="group">
							<li role="treeitem" aria-selected="true" aria-level="1"
								aria-labelledby="allStu_anchor" aria-expanded="true" id="allStu"
								class="jstree-node jstree-open"><i
								class="jstree-icon jstree-ocl" role="presentation"></i>
								<a class="jstree-anchor " href="#" tabindex="-1" id="allStu_anchor">
									<i class="jstree-icon jstree-checkbox" role="presentation"></i>
									<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom"
									role="presentation"></i>학생
								</a>
								
								<!-- 강의 수강 학생 트리 구조 -->
								<ul role="group" class="jstree-children">
								
									<c:if test="${empty stuList}">
										<li role="treeitem" data-jstree="{&quot;opened&quot;:true}"
											aria-selected="false" aria-level="2"
											aria-labelledby="noCurs_anchor" aria-expanded="true"
											id="noCurs" class="jstree-node jstree-open jstree-last">
											<i class="jstree-icon jstree-ocl" role="presentation"></i>
											<a class="jstree-anchor " href="#" tabindex="-1" id="noCurs_anchor">
												<i class="jstree-icon jstree-checkbox" role="presentation"></i>
												<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom"
												role="presentation"></i>강의없음
											</a>
										</li>
									</c:if>
									<c:if test="${!empty stuList}">
										<c:forEach var="student" items="${stuList}"> <!-- 강의 개수 만큼 돌기 -->
											<!-- 강의 -->
											<li role="treeitem" data-jstree="{&quot;opened&quot;:true}"
												aria-selected="false" aria-level="2"
												aria-labelledby="${student.cursNo}_anchor" aria-expanded="true"
												id="${student.cursNo}" class="jstree-node jstree-open jstree-last">
												<i class="jstree-icon jstree-ocl" role="presentation"></i>
												<a class="jstree-anchor " href="#" tabindex="-1" id="${student.cursNo}_anchor" style="display:inline-block; width: 50px;">
													<i class="jstree-icon jstree-checkbox" role="presentation"></i>
													<i class="jstree-icon jstree-themeicon icofont icofont-folder font-theme jstree-themeicon-custom"
													role="presentation"></i>
													${student.cursNm}
												</a> <!-- 강의 이름 넣어주기 -->
												
												<!-- 해당 강의에 대한 학생 -->
												<ul role="group" class="jstree-children">
													<c:forEach var="stuinfo" items="${student.stuVO}" varStatus="status">
														<li role="treeitem"
															data-jstree="{&quot;type&quot;:&quot;file&quot;}"
															aria-selected="false" aria-level="3"
															aria-labelledby="${stuinfo.stuPhNo}_${status.count}"
															class="jstree-node jstree-leaf">
															<i class="jstree-icon jstree-ocl" role="presentation"></i>
															<a class="jstree-anchor" href="#" tabindex="-1" id="${stuinfo.stuPhNo}_${status.count}">
																<i class="jstree-icon jstree-checkbox" role="presentation"></i>
																<i class="icofont icofont-user" role="presentation"></i>${stuinfo.stuNm}
															</a>
														</li>
													</c:forEach>
												</ul>
											</li>
											
										</c:forEach> <!-- 강의개수만큼 돌아요 -->
									</c:if>


								</ul> <!-- 학생 트리구조 내부 끝 -->
							</li>
						</ul>
					</div>
					<!-- 트리구조 완전 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
				</div>
			</div>
		</div>

		<div class="col call-chat-body">
			<div class="card">
				<!-- msg 작성 폼 -->
					<form class="form theme-form" id="msgForm">
					<div class="card-body">
						<div class="row">
							<div class="col">
								<div class="mb-3">
									<label class="form-label" for="exampleFormControlInput1">받는이(전화번호)</label>
									<textarea class="form-control" id="exampleFormControlInput1" name="msgRcNm" rows="1" readonly="readonly" style="overflow:hidden"></textarea>
									<input id="msgRc" name="msgPhNm" type="hidden" value="" required="required">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<div>
									<label class="form-label" for="exampleFormControlTextarea4">내용</label>
									<textarea class="form-control" id="exampleFormControlTextarea4" name="msgCnt" rows="15" 
									placeholder="메시지(MMS)로 전송할 내용을 입력해주세요." required="required"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="card-footer text-end" style="padding: 0px 30px 30px 0px; border:none;">
						<button class="btn btn-primary" type="button" id="msgSend">전송</button>
						<button class="btn btn-info" type="reset" id="msgReset">리셋</button>
					</div>
				</form>
			</div>
		</div>
		<!-- 오른쪽 사이드바 끝 -->
	</div>
</div>
<!-- Container-fluid Ends-->
<script>
	// 넘겨줄 아이디
	let l_myId = '${myId}';
	
	// 뿌려줄 코드
	let code;
	
	// 토큰 - ajax
	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';
	
	// 쪽지 작성
    let list = '';
    let list2 = '';
    
// ==================================================================================================================
	
	/* 트리뷰 아이디 선택하기 */
	$(function(){
		$('#treecheckbox').on('changed.jstree', function(e,data){
			// 값 초기화
			$('#msgRc').val('');
			$('#exampleFormControlInput1').val('');
			list = '';
			list2 = '';
			
		    var nodes = $("#treecheckbox").jstree(true).get_selected("full", true); 
		   //leaf만 찾기(자식 없으면 leaf)
		    for(node of nodes){
				console.log(node);
		        if(!node.children.length){
		            list += node.a_attr.id.split('_')[0].trim() + ',';
		            list2 += node.text.trim() + '('+ node.a_attr.id.split('_')[0].trim() +'), ';
		        }
		    }
			$.trim(list);
			$.trim(list2);
			const c_list = list.substring(0, list.length - 1);
            console.log("노드의 아이디를 가져옴 : ",c_list);
			const c_list2 = list2.substring(0, list2.length - 2);
            console.log("노드의 아이디를 가녀옴", c_list2);
			
			$('#msgRc').val(c_list);
			$('#exampleFormControlInput1').val(c_list2);
			
		});
	}); // 즉각실행 함수 끝
	
	
	// 메시지 전송 ajax
	$("#msgSend").on("click", function () {
		$.ajax({
			url : '${CONTEXT_PATH}/msg/teacher/page',
			headers: {
				'${_csrf.headerName}': '${_csrf.token}'
			},
			contentType: 'application/json',
			type : 'POST',
			data : JSON.stringify({
				msgRcNm : $('#exampleFormControlInput1').val(),
				msgPhNm : $('#msgRc').val(),
				msgCnt : $('#exampleFormControlTextarea4').val()
			}),
			success : function(data){
				Swal.fire({
				  icon: 'success',
				  title: '완료',
				  text: data,
				});
				$('#msgReset').trigger('click');
				$("#treecheckbox").jstree().deselect_all(true);
			},
			error : function(request,status,error){
				console.log("error!",error);
				console.log("status!",status);
			}
		});
	});
	
 </script>