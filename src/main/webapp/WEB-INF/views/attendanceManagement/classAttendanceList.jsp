<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
			<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
				<fmt:formatDate value="${cursTerm.cursSttDt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="startDt" />
				<fmt:formatDate value="${cursTerm.cursEndDt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="endDt" />

				<!-- Page Body Start-->
				<!-- 페이지 타이틀 시작 -->
				<div class="container-fluid">
					<div class="page-header">
						<div class="row">
							<div class="col-sm-12">
								<h3>강의 출결 내역</h3>
								<!-- 제목 하단 페이지 경로 -->
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">Home</a></li>
									<li class="breadcrumb-item">강의 관리</li>
									<li class="breadcrumb-item active">강의 출결 내역</li>
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
									<h5>출석 내역 목록</h5>

								</div>

								<div class="card-body">
									<div id="id_chartDiv" class="container-fluid">
                                        <canvas id="id_chart">

                                        </canvas>
                                    </div>

									<table id="id_table" class="dataTable display">

									</table>
									<button id="sheetjsexport"><b>XLSX 내보내기</b></button>
								</div>
							</div>
						</div>
						<!-- 카드 1 끝 -->
					</div>
				</div>
				<!-- Container-fluid Ends-->
				<script src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>
                <script src="${CONTEXT_PATH}/assets/js/datatable/datatables/jquery.dataTables.min.js"></script>
                <!-- <script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.bootstrap4.min.js"></script> -->
                <script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.responsive.min.js"></script>
                <!-- <script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/responsive.bootstrap4.min.js"></script> -->
				<script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/custom.js"></script>
                <script src="${CONTEXT_PATH}/js/ajax.js"></script>
				<script>
					let cursSttDt = new Date('${startDt}');
					let cursEndDt = new Date('${endDt}');
					console.log("서버에서 보낸 값 : " + '${startDt}');
					console.log("스크립트에서 생성한 날짜 객체 : " + cursSttDt);

					const atdTable = document.querySelector("#id_table");

					document.querySelector("#sheetjsexport").addEventListener('click', function () {
						/* Create worksheet from HTML DOM TABLE */
						var wb = XLSX.utils.table_to_book(atdTable);
						/* Export to file (start a download) */
						XLSX.writeFile(wb, "${cursNo}+강의+전체+수강생+출석.xlsx");
					});

					const f_renderNum = function(p_num) {
						return Math.round(p_num*100)/100;
					}

					const f_getDaysArray = function (startDt, endDt) {
						let arr = [];
						for (let dt = new Date(startDt); dt <= new Date(endDt); dt.setDate(dt
							.getDate() + 1)) {
							// 새 객체를 만들어 넣어주지 않으면 계속해서 참조로 값을 가져오게 된다.
							arr.push(new Date(dt));
						}
						return arr;
					};


					const f_getTodaysData = function () {
						let v_data = {
							url: "",
							method: "get",
							dataType: "json",
							async: true,
							success: function(p_data) {
								console.log(p_data);
							}
						}
					}

					const f_getData = function () {
						let v_data = {
							url: "${CONTEXT_PATH}/atdManagement/list/data?cursNo=${cursNo}",
							method: "get",
							dataType: "json",
							async: true,
							success: function (p_data) {
								//f_buildTable(p_data);
								console.log(p_data);
								let table = $('#id_table').DataTable({
									data: p_data,
									columns: [
										{ data: 'stuId' },
										{ data: 'checkinDay' },
										{ data: 'absentDay' },
										{ data: 'lateDay' },
										{ data: 'earlyDepartDay' },
										{ data: 'illnessDay' },
										{ data: 'lateAndEarlyDepartDay' },
										{ data: 'totalTakenTime' },
										{ data: null }],
									columnDefs: [{
										title: '학생 ID',
										targets: 0,
										className: 'dt-head-center'
									}, {
										title: '출석',
										targets: 1,
										className: 'dt-center'
									}, {
										title: '결석',
										targets: 2,
										className: 'dt-center'
									}, {
										title: '지각',
										targets: 3,
										className: 'dt-center'
									}, {
										title: '조퇴',
										targets: 4,
										className: 'dt-center'
									}, {
										title: '병결',
										targets: 5,
										className: 'dt-center'
									}, {
										title: '지각+조퇴',
										targets: 6,
										className: 'dt-center'
									}, {
										title: '총 이수 시간',
										targets: 7,
										className: 'dt-center',
										render: f_renderNum
									}, {
										title: '상세',
										targets: -1,
										data: null,
										className: 'dt-center',
										defaultContent: "<a href='#'><span class='badge badge-primary' id='id_detailBtn'>상세조회</span></a>"
									}],
									responsive: true,
									language: {
										"decimal": "",
										"emptyTable": "데이터가 없습니다.",
										"info": "총 _TOTAL_개 데이터 중 _START_부터 _END_까지 표시 중",
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

								$('#id_table tbody').on('click', '#id_detailBtn', function () {
									let data = table.row($(this).parents('tr')).data();
									console.log(data);
									location.href = '${CONTEXT_PATH}/atdManagement/detail?stuId=' + data['stuId'] + '&cursNo=${cursNo}';

								});
							}
						};
						f_ajax(v_data);
					}

					f_getData();
				</script>