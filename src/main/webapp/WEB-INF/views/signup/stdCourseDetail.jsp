<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.table th {
	text-align: center;
	background-color: #f8f9fa;
}

#closeBtn {
	text-align: center;
	margin-top : 10px; 
}

button.btn.btn-info {

}
</style>

<section>
	<div class="container-fluid p-0">
		<div class="row">
			<div class="col-12">
				<div class="login-card">
					<div class="card-body">
						<div class="col-sm-12">
							<div class="card">
								<div class="card-header pb-0">
									<h5>강의 상세보기</h5>
								</div>
								<div class="card-body">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<th class="col-3">강의명</th>
												<td colspan="3" style="text-align: left;">${cursInfo[0].cursNm}</td>
											</tr>
											<tr>
												<th class="col-3">교원명</th>
												<td colspan="3">${cursInfo[0].empNm}</td>
											</tr>
											<tr>
												<th class="col-3">강의실</th>
												<td>${cursInfo[0].faciNm}호</td>
												<th class="col-3">수강인원</th>
												<td>${cursInfo[0].cursSuNum}</td>
											</tr>
											<tr>
												<th class="col-3">시작일</th>
												<td><fmt:formatDate value="${cursInfo[0].cursSttDt}" pattern="yyyy-MM-dd"/></td>
												<th class="col-3">종료일</th>
												<td><fmt:formatDate value="${cursInfo[0].cursEndDt}" pattern="yyyy-MM-dd"/></td>
											</tr>
											<tr>
												<th class="col-3">강의시간</th>
												<td colspan="3">
													<c:forEach var="info" items="${cursInfo}" varStatus="status">
														${info.cursDay} (${String.format("%02d",info.cursSttHh)}:${String.format("%02d",info.cursSttMm)} ~ ${String.format("%02d",info.cursEndHh)}:${String.format("%02d",info.cursEndMm)})
														<c:if test="${!status.last}"><br></c:if>
													</c:forEach>
												</td>
											</tr>
											<tr>
												<th class="col-3">강의내용</th>
												<td colspan="3"> ${cursInfo[0].curspnCnt} </td>
											</tr>
											<tr>
												<th class="col-3">수강료</th>
												<td colspan="3">
												<fmt:formatNumber type="number" maxFractionDigits="3" value="${cursInfo[0].cursSuPri}"/></td>
											</tr>
										</tbody>
									</table>
									<div id="closeBtn">
										<button class="btn btn-primary" type="button" onclick="window.open('','_self').close();">닫기</button>
									</div>
								</div>
							</div>
						</div>

					</div>
					<!-- 카드 끝 -->
				</div>
			</div>
		</div>
	</div>
</section>
	
<script>
</script>