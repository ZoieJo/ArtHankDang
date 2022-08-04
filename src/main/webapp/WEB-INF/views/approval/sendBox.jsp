<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
</style>
<!-- Page Body Start-->
<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>보낸 결재함</h3>
				<!-- 제목 하단 페이지 경로 -->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${CONTEXT_PATH}/aprl/main">문서관리</a></li>
					<li class="breadcrumb-item">보낸 결재함</li>
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
								<th class="col-2">문서명</th>
								<th class="col-1">상태</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="aprldocVO" items="${aprldocList}" varStatus="status">
								<tr onclick="location.href='${CONTEXT_PATH}/aprl/draftinPaper?aprldocNo=${tmpVO.aprldocNo}'">
									<td>${aprldocVO + 1}</td>
									<td>${aprldocVO.aprldocNo}</td>
									<td><fmt:formatDate value="${aprldocVO.aprldocDfDt}" pattern="yyyy-MM-dd"/></td>
									<td>${aprldocVO.aprldocTl}</td>
									<td>
										<c:if test="${aprldocVO.docStCd.equals('02')}">
											결재진행중
										</c:if>
										<c:if test="${aprldocVO.docStCd.equals('03')}">
											결재완료
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div>
						<nav aria-label="...">	
							<ul class="pagination justify-content-center  pagination-primary">
								<li class="page-item disabled"><a class="page-link" href="javascript:void(0)" tabindex="-1">이전</a></li>
								<li class="page-item active"><a class="page-link" href="javascript:void(0)">1<span class="sr-only">(current)</span></a></li>
								<li class="page-item disabled"><a class="page-link" href="javascript:void(0)">다음</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
		<!-- 카드 1 끝 -->
	</div>
</div>
<!-- Container-fluid Ends-->
