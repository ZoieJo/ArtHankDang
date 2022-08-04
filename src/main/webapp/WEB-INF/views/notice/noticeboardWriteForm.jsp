<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${RESOURCES_PATH}/assets/js/editor/ckeditor/ckeditor.js"></script>

<style>
#id_p {
    margin-top: 6px;
}
</style>

<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>&ensp;&ensp;공지사항 새글 쓰기</h3>
			</div>
		</div>
	</div>
	
	
	<!-- Container-fluid starts-->
	<div class="container-fluid">

				<div class="card">
					<div class="card-body">
						<form class="needs-validation" id="fb_form" action="${CONTEXT_PATH}/notice/write" method="post">
							<div class="row">
								<div class="col-sm-1" style="text-align: center;">
									<h5 id="id_p" class="form-label" for="validationCustom01">제목</h5> 
								</div>
								<div class="col-sm-11">
									<input  class="form-control" id="validationCustom01" name="bdTL" type="text" value="" placeholder="제목을 입력해주세요." required>
									<div class="valid-feedback">Looks good!</div>
								</div>
							</div>
					
					
					<div class="col-sm-8 row g-3">
						<div class="col-md-6" style="margin: 20px;">
						<div class="col-md-3">
<!-- 							<label class="form-label" for="validationCustom04">분야</label> -->
<!-- 							<select class="form-select" id="validationCustom04" > -->
<!-- 								<option selected="" disabled="" value="">Choose...</option> -->
<!-- 								<option>출석</option> -->
<!-- 								<option>시험</option> -->
<!-- 								<option>성적</option> -->
<!-- 								<option>기타</option> -->
<!-- 							</select> -->
<!-- 							<div class="invalid-feedback">Please select a valid state.</div> -->
						</div>
					</div>
				</div>
					<textarea id="editor1" name="bdCNT" cols="30" rows="10" required=>
					</textarea>
							<sec:csrfInput/>
							<div style="float: right;">
							<button class="btn btn-primary active" type="submit" style="margin: 10px;" 
							id="id_insertbtn">저장</button>
							<button id="id_backbtn" class="btn btn-info active" type="button" style="margin: 10px;" 
							onclick="location.href ='javascript:history.back()'">취소</button>
							</div>		
					</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Container-fluid Ends-->
		
		
<script>
	var v_fbForm = document.querySelector("#fb_form");
	var v_insertbtn = document.querySelector("#id_insertbtn");	
	var v_editor1 = document.querySelector("#editor1");
	
	CKEDITOR.replace("editor1",{
    	enterMode : CKEDITOR.ENTER_BR,
    	filebrowserUploadMethod : "form",  // 이 줄 빠트리면 개고생, 전송방식으로 form으로 한다는 의미
    	filebrowserUploadUrl:"<%=request.getContextPath()%>/gUpload?${_csrf.parameterName}=${_csrf.token}"			
	})

	
	v_fbForm.onsubmit = function(){
		event.preventDefault();
		
		var v_content = CKEDITOR.instances.editor1.getData();
		v_content=v_content.replaceAll("&nbsp;","");

		if(v_content.trim().length < 10){
			Swal.fire(
					  '경고!',         	   // Alert 제목
					  '10자 이상 입력하세요.',  // lert 내용
					  'warning',          // Alert 타입
					)
				return;
		}
		 Swal.fire({
             title: '저장하시겠습니까?',
             icon: 'warning',
             showCancelButton: true,
             confirmButtonColor: '#3085d6',
             cancelButtonColor: '#d33',
             confirmButtonText: '확인',
             cancelButtonText: '취소'
         }).then((result) => {
             if (result.isConfirmed) {
                 Swal.fire(
                     '글쓰기가 완료되었습니다.'
                 ).then((result) => {
                	 if(result.isConfirmed){
						v_fbForm.submit();
                	 }
                 }
                 )
             }
         });
	}
		
</script>

























