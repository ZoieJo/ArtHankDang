<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
</style>
<!-- Page Body Start-->
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>받은 결재함</h3>
				<!-- 제목 하단 페이지 경로 -->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${CONTEXT_PATH}/aprl/main">문서관리</a></li>
					<li class="breadcrumb-item">받은 결재함</li>
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
					<div style="background-color:lightgray;">
						<div style="float: left;">
							<select class="form-select form-select-lg mb-3"
								style="width: 150px;">
								<option selected>검색조건</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
						</div>
						<div style="float: right; margin-top: 10px;">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-clock" style="float: left;">
						<circle cx="12" cy="12" r="10"></circle>
						<polyline points="12 6 12 12 16 14"></polyline>
						</svg>
							<p style="float: right;">&nbsp;&nbsp;전자결재 상태표</p>
						</div>
					</div>
				</div>
				<div class="card-body" style="padding-top: 0px;">
					<table class="table" style="text-align: center;">
						<thead>
							<tr class="table-light">
								<th class="col-1">번호</th>
								<th class="col-1">문서번호</th>
								<th class="col-1">기안일자</th>
								<th class="col-1">문서종류</th>
								<th class="col-2">문서명</th>
								<th class="col-1">상태</th>
								<th class="col-2">의견</th>
								<th class="col-2">수정/삭제</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div>페이징</div>
				</div>
			</div>
		</div>
		<!-- 카드 1 끝 -->
	</div>
</div>
<!-- Container-fluid Ends-->
