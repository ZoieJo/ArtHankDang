<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 스타일 적용 -->
<style>
.subinfo {
	background-color: #F7F5F2;
	width: 20%;
	height: 200px;
	margin: 10px 2.5%;
	float: left;
	padding: 10px;
	overflow: auto;
}

.subinfo h6 {
	text-align: center;
}

.subinfo h6:hover {
	text-decoration: underline;
	cursor: pointer;
}

.subinfo hr {
	margin: 10px 0px;
}

.tb-subinfo {
	width: 100%;
	text-align: center;
}

.tb-subinfo td {
}

.tb-subinfo button{
	padding: 6px 10px;
}

.card .card-header h5 {
	float: left;
}

.more {
	float: right;
}

.btnBox {
	text-align: center;
}

</style>

<!-- Body 시작 -->
<!-- Page Body Start-->
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>수강신청</h3>
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
					<h5>강의 목록</h5>
				</div>
				
				<div class="card-body">
				
					<div class="subinfo">
						<h6>취업에 날개를 달아주는 javascript</h6>
						<hr>
						<table class="tb-subinfo">
							<tr>
								<td>강&nbsp;&nbsp;사&nbsp;&nbsp;명</td>
								<td>272</td>
							</tr>
							<tr>
								<td>강의기간</td>
								<td>272</td>
							</tr>
							<tr>
								<td colspan="2" style="text-align:right">
								</td>
							</tr>
						</table>
							<button type="button" class="btn btn-warning">장바구니</button>
							<button type="button" class="btn btn-primary">수강신청</button>
						
					</div>
					<div class="subinfo">
						<table class="table table-borderless" style="text-align: center;">
							<thead>
								<tr>
									<th colspan="2"><h6>취업에 날개를 달아주는 javascript</h6></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th class="col-4">강사</th>
									<td></td>
								</tr>
								<tr>
									<th>강의시간</th>
									<td></td>
								</tr>
							</tbody>
						</table>
						<div class="btnBox">
							<button type="button" class="btn btn-warning">장바구니</button>
							
							<button type="button" class="btn btn-primary">수강신청</button>
						</div>
					</div>
					<div class="subinfo">안녕</div>
					<div class="subinfo">안녕</div>
				</div>
			</div>
		</div>
		<!-- 카드 1 끝 -->
		<!-- 카드 2 시작 -->
		<div class="col-sm-12">
			<div class="card">
				<div class="card-header pb-0">
					<h5>장바구니 목록</h5>
					<div class="more">
						<a href="${CONTEXT_PATH}/stdSignup/cartlist">더보기 &gt;</a>
					</div>
				</div>
				<div class="card-body">
					<table class="table" style="text-align: center;">
						<thead>
							<tr class="table-light">
								<th class="col-1">No</th>
								<th class="col-2">강의명</th>
								<th class="col-1">강사</th>
								<th class="col-1">시작일</th>
								<th class="col-1">수강료</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- 카드 2 끝 -->
		<!-- 카드 3 시작 -->
		<div class="col-sm-12">
			<div class="card">
				<div class="card-header pb-0">
					<h5>수강 신청 목록</h5>
					<div class="more">
						<a href="${CONTEXT_PATH}/stdSignup/curslist">더보기 &gt;</a>
					</div>
				</div>
				<div class="card-body">
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
								<th class="col-1">수강취소</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- 카드 3 끝 -->
	</div>
</div>
<!-- Container-fluid Ends-->
