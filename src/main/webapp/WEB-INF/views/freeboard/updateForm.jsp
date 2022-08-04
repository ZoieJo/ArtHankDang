<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script src="${RESOURCES_PATH}/assets/js/editor/ckeditor/ckeditor.js"></script>

<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>&ensp;&ensp;게시판 수정하기</h3>
			</div>
			<div class="col-sm-6">


				<!-- Bookmark Start-->
				<div class="bookmark">
					<ul>
						<li><a href="javascript:void(0)" data-container="body"
							data-bs-toggle="popover" data-placement="top" title=""
							data-original-title="Tables"><i data-feather="inbox"></i></a></li>
						<li><a href="javascript:void(0)" data-container="body"
							data-bs-toggle="popover" data-placement="top" title=""
							data-original-title="Chat"><i data-feather="message-square"></i></a></li>
						<li><a href="javascript:void(0)" data-container="body"
							data-bs-toggle="popover" data-placement="top" title=""
							data-original-title="Icons"><i data-feather="command"></i></a></li>
						<li><a href="javascript:void(0)" data-container="body"
							data-bs-toggle="popover" data-placement="top" title=""
							data-original-title="Learning"><i data-feather="layers"></i></a></li>
						<li><a href="javascript:void(0)"><i
								class="bookmark-search" data-feather="star"></i></a>
							<form class="form-inline search-form">
								<div class="form-group form-control-search">
									<input type="text" placeholder="Search..">
								</div>
							</form></li>
					</ul>
				</div>
				<!-- Bookmark Ends-->


			</div>
		</div>
	</div>


	<!-- Container-fluid starts-->
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-12">
				<div class="card">
					<div class="card-body">
						<form class="needs-validation" id="fb_form" method="POST" action="${CONTEXT_PATH}/freeboard/update">
							<div class="row">
								<div class="col-sm-1" style="display: flex; align-items: center; justify-content: center;">
									<label class="form-label" for="validationCustom01" style="margin-bottom: 0; font-size: 20px;">제목</label>
								</div>
								<div class="col-sm-10">
									<input
										class="form-control" id="validationCustom01" name="bdTL"
										type="text" value="${freeboardVO.bdTL}"
										placeholder="제목을 입력해주세요." required>
										<input type="hidden" value="${pageNum}" name="pageNum">
										<input type="hidden" value="${pageSize}" name="pageSize">										
									<div class="valid-feedback">Looks good!</div>
								</div>
							</div>
							<br>
							
							<textarea id="editor1" name="bdCNT" cols="30" rows="10" required>${freeboardVO.bdCNT}</textarea>
							<sec:csrfInput />
							<hr>
							<div style="text-align: right;">
								<input type="hidden" value="${freeboardVO.bdNo}" name="bdNo">
								<button class="btn btn-primary active" type="submit" id="id_updatebtn" style="margin: 10px;">수정</button>
								<button id="id_backbtn" class="btn btn-info active" type="button" style="margin: 10px;" onclick="location.href ='javascript:history.back()'">취소</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Container-fluid Ends-->
		
		
<script>
	var v_fbForm = document.querySelector("#fb_form");

	var v_updatebtn = document.querySelector("#id_updatebtn");	

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
	}
	
	v_updatebtn.addEventListener("click", f_updatebtn);
	
	
	CKEDITOR.replace("editor1",{
    enterMode : CKEDITOR.ENTER_BR,
    filebrowserUploadMethod : "form",  // 이 줄 빠트리면 개고생, 전송방식으로 form으로 한다는 의미
    filebrowserUploadUrl: "<%=request.getContextPath()%>/ckUpload"
	})
</script>