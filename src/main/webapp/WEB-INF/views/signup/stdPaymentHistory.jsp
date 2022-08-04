<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>
<script src="${CONTEXT_PATH}/assets/js/datatable/datatables/jquery.dataTables.min.js"></script>
<script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.responsive.min.js"></script>
<script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/custom.js"></script>


<style>
.table {
	vertical-align: middle;
}
</style>

 <div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>결제 내역</h3>
				<!-- 제목 하단 페이지 경로 -->
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<a href="${CONTEXT_PATH}">홈</a>
					</li>
					<li class="breadcrumb-item">수강신청</li>
					<li class="breadcrumb-item">결제 내역</li>
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
				<div class="card-header pb-0"></div>
				<div class="card-body" style="padding-top: 0px;">
					<table id="id_table" class="dataTable display">
					</table>
					
				</div>
				
				
				
				
			</div>
		</div>
		<!-- 카드 1 끝 -->
	</div>


</div>

<script>

	const tokenHeader = '${_csrf.headerName}';
	const tokenValue = '${_csrf.token}';

	const f_dataTable = function() {
		let xhr = new XMLHttpRequest();
		xhr.open("post", "${CONTEXT_PATH}/stdSignup/paymentHistory", true);
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				console.log(JSON.parse(xhr.responseText));
				//f_buildTable(p_data);
				//				console.log(p_data);
				let table = $('#id_table').DataTable({
					data : JSON.parse(xhr.responseText),
					columns : [ {
						data : 'ordNo'
					}, {
						data : 'course'
					}, {
						data : 'pymDt'
					}, {
						data : 'pymMtd'
					}, {
						data : 'pymAmt'
					} ],
					columnDefs : [ {
						title : '주문번호',
						targets : 0,
						className : 'dt-center'
					}, {
						title : '결제내역',
						targets : 1,
						className : 'dt-head-center',
						render : f_getCursNm
					}, {
						title : '결제일시',
						targets : 2,
						className : 'dt-center'
					}, {
						title : '결제방식',
						targets : 3,
						className : 'dt-center'
					}, {
						title : '결제금액',
						targets : 4,
						className : 'dt-head-center dt-body-right'
					} ],
					responsive : true,
					language : {
						"decimal" : "",
						"emptyTable" : "데이터가 없습니다.",
						"info" : "	",
						"infoEmpty" : "총 0개 데이터 중 0부터 0까지 표시 중",
						"infoFiltered" : "(최대 _MAX_개 데이터를 필터링 해 표시함)",
						"infoPostFix" : "",
						"thousands" : ",",
						"lengthMenu" : "한 페이지 당 _MENU_개 데이터 표시",
						"loadingRecords" : "로딩 중...",
						"processing" : "",
						"search" : "검색 :",
						"zeroRecords" : "일치하는 데이터가 없습니다.",
						"paginate" : {
							"first" : "처음",
							"last" : "끝",
							"next" : "다음",
							"previous" : "이전"
						},
						"aria" : {
							"sortAscending" : ": 오름차순 정렬 활성화",
							"sortDescending" : ": 내림차순 정렬 활성화"
						}
					}
				});
			}
		}
		xhr.setRequestHeader(tokenHeader, tokenValue);
		xhr.setRequestHeader("Content-Type", "x-www-form-urlencoded");
		xhr.send();
	}
	
	function f_getCursNm(p_data){
		let result = "";
		for(let i = 0 ; i < p_data.length ; i++){
			result += p_data[i].cursNm;
			if(i != p_data.length -1){
				result += "<br>";
			}
		}
		return result;
	}

	f_dataTable();
</script>
    