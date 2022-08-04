<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Page Body Start-->
<!-- 페이지 타이틀 시작 -->
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-12">
				<h3>페이지 제목을 써주세요</h3>
				<!-- 제목 하단 페이지 경로 -->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">Home</a></li>
					<li class="breadcrumb-item">Starter Kit</li>
					<li class="breadcrumb-item">Color Version</li>
					<li class="breadcrumb-item active">Layout Light</li>
				</ol>
			</div>
		</div>
	</div>
</div>
<!-- 페이지 타이틀 끝 -->
<!-- 내용 시작 -->
<div class="container-fluid">
	<div class="row starter-main">
		<div class="col-sm-12">
			<div class="card">
				<div class="card-header pb-0">
					<h5>카드모양 소제목</h5>

				</div>

				<div class="card-body">
					<p>Getting start with your project custom requirements using a
						ready template which is quite difficult and time taking process,
						viho Admin provides useful features to kick start your project
						development with no efforts !</p>
						<div class="d-flex flex-row-reverse">
							<ul class="list-group list-group-horizontal">
								<li><button class="py-0 px-1 m-1 btn btn-outline-light" id="id_addBtn" onclick="f_addQtn()"><i class="m-0 fa-solid fa-plus"></i></button></li>
								<li><button class="py-0 px-1 m-1 btn btn-outline-light" id="id_delBtn" onclick="f_delQtn()"><i class="m-0 fa-solid fa-minus"></i></button></li>
							</ul>

						</div>
						<div class="col-sm-12 border" id="id_testEditorBlock">
							<div class="p-2" id="id_qtnForm">

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
	const c_qtnForm = document.querySelector("#id_qtnForm");

	const c_addBtn = document.querySelector("#id_addBtn");
	const c_delBtn = document.querySelector("#id_delBtn");
	const c_getLength = function () {
		
		return document.querySelectorAll("#qtn").length;
	}
	
	const c_qtnTxt = function() { 
		
		let length = c_getLength();
		let txt = "문제 : <input type='text' name='nm_qtn" + length + "' id='id_qtn"
		+ length + "'><br>"
		+ "유형 : <select name='nm_qtnType' id='id_qtnType' onchange='f_changeType(this, "
		+ length + ")'>"
		+ "<option value='1'>O, X</option>"
		+ "<option value='2'>선다형</option>"
		+ "<option value='3'>단답형</option>"
		+ "<option value='4'>서술형</option></select><br>"
		+ "<div id='id_qtnBox" + length + "'></div>";
		
		return txt;
	
	}
	
	let clickedQtn = "";
	
	const f_init = function() {
		c_qtnForm.innerHTML = "";
		f_addQtn();
	};

	const f_changeType = function(p_qtn, num) {
		
		let val = p_qtn.value;
		let qtnBox = document.querySelector("#id_qtnBox"+num);
		
		if(val==1) { // o, x
			qtnBox.innerHTML = "<input type='radio' name='nm_oxQtn"+ num +"' id='id_form"+ num +"' value='0'>&nbsp;O<br>"
								+ "<input type='radio' name='nm_oxQtn"+ num +"' id='id_form"+ num +"' value='1'>&nbsp;X";
		}

		if(val==2) { // 선다형
			qtnBox.innerHTML = "<input type='checkbox' name='nm_checkQtn' id='id_form" + num 
								+ "' value='1'>&nbsp;<input type='text' name='nm_checkQtnValue" + num + "'><br>";
		}

		if(val==3) { // 단답형
			qtnBox.innerHTML = "답안 : <input type='text' name='nm_txtQtn' id='id_form"+ num +"'>";
		}

		if(val==4) { // 서술형
			qtnBox.innerHTML = "답안 : <textarea name='nm_longQtn' id='id_form"+ num +"'></textarea>";
		}

	};

	const f_addQtn = function() {
		let div = document.createElement("div");
		div.setAttribute("id", "qtn");
		div.setAttribute("class", "col-sm-12 m-2 border")
		div.innerHTML = c_qtnTxt();
		c_qtnForm.appendChild(div);

	};
	
	const f_createForm = function() {

	};
	
	f_init();
	
</script>