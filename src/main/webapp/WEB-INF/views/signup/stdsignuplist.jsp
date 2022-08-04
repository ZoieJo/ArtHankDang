<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
</style>
<!-- Page Body Start-->
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>수강 신청 목록</h3>
				<!-- 제목 하단 페이지 경로 -->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${CONTEXT_PATH}/stdSignup/main">수강신청</a></li>
					<li class="breadcrumb-item">수강 신청 목록</li>
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
				</div>
				<div class="card-body" style="padding-top: 0px;">
					<table class="table" style="text-align: center;">
						<thead>
							<tr class="table-light">
								<th class="col-1">No</th>
								<th class="col-4">강의명</th>
								<th class="col-1">강사</th>
								<th class="col-1">시작일</th>
								<th class="col-1">종료일</th>
								<th class="col-1">강의시간</th>
								<th class="col-1">수강료</th>
								<th class="col-1">수강인원</th>
								<th class="col-1">수강신청</th>
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
