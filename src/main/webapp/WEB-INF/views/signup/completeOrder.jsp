<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
h2 {
	color: #24695c;
	text-align: center;
	vertical-align: middle;
	font-weight: bold;
	margin-top: 30px;
}

table.table.table-bordered {
    width: 50%;
    margin: auto;
}

#btnBox {
margin-top: 20px;
text-align: center;
}

#btnBox .btn {
	width: 10%;
	padding: 6px 15px;
	margin: 0px 10px;
}
</style>
<!-- Page Body Start-->
<!-- 내용 시작 -->
<div class="container-fluid">
	<div class="row starter-main">
		<div class="col-sm-12">
			<div class="card">

				<div class="card-header pb-0">
					<h2>수강료가 정상적으로 납부되었습니다.</h2>
				</div>
				<div class="card-body">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<th class="col-3">주문번호</th>
								<td colspan="3" style="text-align: left;">${paymentVO.pymNo}</td>
							</tr>
							<tr>
								<th class="col-3">주문일</th>
								<td colspan="3">
									<fmt:formatDate value="${paymentVO.pymDt}" pattern="yyyy-MM-dd"/>
								</td>
							</tr>
							<tr>
								<th class="col-3">강의명</th>
								<td colspan="3">
									<c:forEach var="course" items="${paymentVO.course}" varStatus="status">
										${course.cursNm}
										<c:if test="${not status.last}"><br></c:if>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<th class="col-3">결제수단</th>
								<td colspan="3">${paymentVO.pymMtd}</td>
							</tr>
							<tr>
								<th class="col-3">총 결제액</th>
								<td colspan="3">￦<fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVO.pymAmt}"/></td>
							</tr>
						</tbody>
					</table>
					<div id="btnBox">
						<button class="btn btn-info" type="button" onclick="location.href='${CONTEXT_PATH}/stdSignup/paymentHistory'">결제내역보기</button>
						<button class="btn btn-primary" type="button" onclick="location.href='${CONTEXT_PATH}/'">메인화면으로</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 카드 1 끝 -->
	</div>
</div>

<!-- Container-fluid Ends -->