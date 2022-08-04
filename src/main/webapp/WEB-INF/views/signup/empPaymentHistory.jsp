<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<script src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>
<script src="${CONTEXT_PATH}/assets/js/datatable/datatables/jquery.dataTables.min.js"></script>
<script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.responsive.min.js"></script>
<script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/custom.js"></script>


<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
				<h3>결제 관리</h3>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
					<a href="${CONTEXT_PATH}/">홈</a></li>
					<li class="breadcrumb-item">결제 관리</li>
				</ol>
			</div>
		</div>
	</div>
</div>
<div class="container-fluid">
	<div class="row starter-main">
		<div class="col-sm-12">
			<div class="card">
				<div class="card-header pb-0">
					<h5>학생 결제 내역</h5>
				</div>

				<div class="card-body">
					<table id="id_table" class="dataTable display">
					</table>
				</div>
			</div>
		</div>
		<!-- 카드 1 끝 -->
	</div>
</div>

<script>

	function f_getCourseNm(p_data){
		let result = "";
		for(let i = 0 ; i < p_data.length ; i++){
			result += p_data[i].cursNm;
			if(i != p_data.length -1){
				result += "<br>";
			}
		}
		return result;
	}
	
	function f_getStuNm(p_data){
		return p_data[0].stuId;
	}

	const c_table = document.querySelector("#id_table");
	
	const f_dataTable = function () {
		let xhr = new XMLHttpRequest();
		xhr.open("get","${CONTEXT_PATH}/empSignup/getHistory", true);
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				console.log(xhr.responseText);
				//f_buildTable(p_data);
// 				console.log(p_data);
				let table = $('#id_table').DataTable({
					data: JSON.parse(xhr.responseText),
					columns: [
						{ data: 'ordNo' },
						{ data: 'stuInfo' },
						{ data: 'course' },
						{ data: 'pymDt' },
						{ data: 'pymAmt' },
						{ data: 'pymMtd' },
						{ data: 'pymCmcd' }],
					columnDefs: [{
						title: '주문번호',
						targets: 0,
						className: 'dt-center'
					}, {
						title: '학생ID',
						targets: 1,
						className: 'dt-center',
						render: f_getStuNm
					}, {
						title: '강의명',
						targets: 2,
						className: 'dt-head-center',
						render: f_getCourseNm
					}, {
						title: '결제일',
						targets: 3,
						className: 'dt-center'
					}, {
						title: '결제금액',
						targets: 4,
						className: 'dt-head-center dt-body-right'
					}, {
						title: '결제방식',
						targets: 5,
						className: 'dt-center'
					}, {
						title: '결제상태',
						targets: 6,
						className: 'dt-center'
					}],
					responsive: true,
					language: {
						"decimal": "",
						"emptyTable": "데이터가 없습니다.",
						"info": "	",
						"infoEmpty": "총 0개 데이터 중 0부터 0까지 표시 중",
						"infoFiltered": "(최대 _MAX_개 데이터를 필터링 해 표시함)",
						"infoPostFix": "",
						"thousands": ",",
						"lengthMenu": "한 페이지 당 _MENU_개 데이터 표시",
						"loadingRecords": "로딩 중...",
						"processing": "",
						"search": "검색 :",
						"zeroRecords": "일치하는 데이터가 없습니다.",
						"paginate": {
							"first": "처음",
							"last": "끝",
							"next": "다음",
							"previous": "이전"
						},
						"aria": {
							"sortAscending": ": 오름차순 정렬 활성화",
							"sortDescending": ": 내림차순 정렬 활성화"
						}
					}
				});
			}
		}
		xhr.setRequestHeader("Content-Type", "x-www-form-urlencoded");
		xhr.send();
	}

	f_dataTable();

</script>