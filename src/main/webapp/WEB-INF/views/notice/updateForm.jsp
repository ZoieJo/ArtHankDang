<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script src="${RESOURCES_PATH}/assets/js/editor/ckeditor/ckeditor.js"></script>



<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>&ensp;&ensp;게시판 수정하기</h3>
			</div>
		</div>
	</div>
	
	
	<!-- Container-fluid starts-->
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12">
				<div class="card">
					<div class="card-body">
						<form class="needs-validation" id="not_form" method="POST" action="${CONTEXT_PATH}/notice/update">
							<div class="row">
								<div class="col-sm-1" style="display: flex; align-items: center; justify-content: center;">
								<input type="hidden" value="${noticeVO.bdNo}" name="bdNo">
									<label class="form-label" for="validationCustom01" style="margin-bottom: 0; font-size: 20px;">제목</label> 
								</div>
								<div class="col-sm-10" style="text-align: center;">
									<input class="form-control" id="validationCustom01" name="bdTL" type="text" value="${noticeVO.bdTL}" required>
									<div class="valid-feedback">Looks good!</div>
								</div>
							</div>
							<br>
<!-- 저장, 취소 버튼					 -->
					<textarea id="editor1" name="bdCNT" cols="30" rows="10" required>${noticeVO.bdCNT}</textarea>
							<sec:csrfInput/>
							<hr>
							<div style="float: right;">
							<button class="btn btn-primary active" type="submit" 
							id="id_insertbtn" style="margin: 10px;">수정</button>
							<button id="id_backbtn" class="btn btn-info active" type="button" style="margin: 10px;"
							onclick="location.href ='javascript:history.back()'">취소</button>
							</div>
					</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
		<!-- Container-fluid Ends-->
		
<script type="text/javascript">
	CKEDITOR.replace("editor1",{
	    enterMode : CKEDITOR.ENTER_BR,
	    filebrowserUploadMethod : "form",  // 이 줄 빠트리면 개고생, 전송방식으로 form으로 한다는 의미
	    filebrowserUploadUrl: "<%=request.getContextPath()%>/gUpload?${_csrf.parameterName}=${_csrf.token}"
	});
</script>
		
<script>
	var v_fbForm = document.querySelector("#not_form");

	var v_updatebtn = document.querySelector("#id_insertbtn");	
	
	f_updatebtn = () => {
		event.preventDefault();
		
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
                     '수정이 완료되었습니다.'
                 ).then((result) => {
                	 if(result.isConfirmed){
						v_fbForm.submit();
                	 }
                 });
             }
         });
	};
	
	v_updatebtn.addEventListener("click", f_updatebtn);
	
</script>