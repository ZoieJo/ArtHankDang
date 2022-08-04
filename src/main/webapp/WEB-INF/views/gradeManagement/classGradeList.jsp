<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <fmt:formatDate value="${cursTerm.cursSttDt}" pattern="yyyy-MM-dd" var="startDt" />
                <fmt:formatDate value="${cursTerm.cursEndDt}" pattern="yyyy-MM-dd" var="endDt" />

                <fmt:parseNumber var="term" value="${(cursTerm.cursEndDt.time - cursTerm.cursSttDt.time)/86400000}"
                    integerOnly="true" />

                <!-- Page Body Start-->
                <!-- 페이지 타이틀 시작 -->
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="row">
                            <div class="col-sm-12">
                                <h3>강의별 성적 관리</h3>
                                <!-- 제목 하단 페이지 경로 -->
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">Home</a></li>
                                    <li class="breadcrumb-item">강의 관리</li>
                                    <li class="breadcrumb-item active">수강생 성적 관리</li>
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
                                    <h5>학생 성적 목록</h5>
                                </div>

                                <div class="card-body">

                                    <div id="id_cursInfoDiv" class="container-fluid">
                                        <h3>${curs.cursNm}</h3><br>
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col">담당 강사</th>
                                                    <td id="id_cursTcrNm">임지수</td>
                                                    <th scope="col"></th>
                                                    <td id="id_cursStuNum"></td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th scope="col">강의 기간</th>
                                                    <td id="id_cursPeriod">${startDt}~${endDt} (${term}일)</td>
                                                    <th scope="col">수강생 수</th>
                                                    <td id="id_cursStuNum">${curs.cursSuNum}명</td>
                                                </tr>
                                                <tr>
                                                    <th scope="col">평균</th>
                                                    <td id="id_avg">평균 성적 점수</td>
                                                    <th scope="row">표준편차</th>
                                                    <td id="id_stDiviation">표준편차</td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                    <br>
                                    <div id="id_chartDiv" class="container-fluid">
                                        <canvas id="id_chart">

                                        </canvas>
                                    </div>
                                    <br>
                                    <table id="id_table" class="dataTable display">

                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- 카드 1 끝 -->
                    </div>
                </div>
                <!-- Container-fluid Ends-->
                <!-- Modal Start -->
                <div class="modal fade" id="id_formModal" tabindex="-1" aria-labelledby="formModalLabel"
                    style="display: none;" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">성적 입력</h5>
                                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"
                                    data-bs-original-title="" title=""></button>
                            </div>
                            <div class="modal-body">
                                <form id="id_editForm">
                                    <div class="mb-3 form-insert">
                                        <label class="col-form-label">학생 선택</label>&nbsp;
                                        <select name="stuId" onchange="f_setStuId(this.value)">
                                            <option hidden="" disabled="disabled" selected="selected" value="">---
                                            </option>
                                            <c:forEach var="vo" items="${stuList}">
                                                <option value="${vo.stuId}">${vo.stuNm}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="mb-3 form-detail">
                                        <label class="col-form-label">학생</label>&nbsp;
                                        <input name="stuNm" class="form-control" type="text" value="" readonly="true">
                                        <input name="stuId" class="form-control" type="hidden" value="" readonly="true">
                                    </div>

                                    <div class="mb-3">
                                        <label class="col-form-label">점수</label>
                                        <input name="grdScr" class="form-control" type="text" value="">
                                    </div>
                                    <div class="mb-3">
                                        <label class="col-form-label">교원 코멘트</label>
                                        <input name="grdCmt" class="form-control" type="text" value="">
                                    </div>

                                    <sec:csrfInput />
                                </form>
                            </div>
                            <div class="modal-footer">
                                <div class="form-insert">
                                    <button id="id_submitBtn" class="btn btn-primary" type="button"
                                        data-bs-original-title="" title="">확인</button>
                                    <button class="btn btn-info" type="button" data-bs-dismiss="modal"
                                        data-bs-original-title="" title="">취소</button>
                                </div>
                                <div class="form-detail">
                                    <button id="id_editSubmitBtn" class="btn btn-primary" type="button"
                                        data-bs-original-title="" title="">확인</button>
                                    <button id="id_editBtn" class="btn btn-warning" type="button"
                                        data-bs-original-title="" title="">수정</button>
                                    <button id="id_deleteBtn" class="btn btn-danger" type="button" title=""
                                        onclick="f_deleteConfirm()">삭제</button>
                                    <button class="btn btn-info" type="button" data-bs-dismiss="modal"
                                        data-bs-original-title="" title="">뒤로가기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>
                <script src="${CONTEXT_PATH}/assets/js/datatable/datatables/jquery.dataTables.min.js"></script>
                <!-- <script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.bootstrap4.min.js"></script> -->
                <script
                    src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.responsive.min.js"></script>
                <!-- <script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/responsive.bootstrap4.min.js"></script> -->
                <script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/custom.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
                <script
                    src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.buttons.min.js"></script>
                <script
                    src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/buttons.bootstrap4.min.js"></script>
                <script src="${CONTEXT_PATH}/js/ajax.js"></script>
                <script>

                    const c_inputGrdScr = document.querySelector("#id_formModal input[name=grdScr]");
                    const c_inputGrdCmt = document.querySelector("#id_formModal input[name=grdCmt]");
                    const c_inputStuNm = document.querySelector("#id_formModal input[name=stuNm]");
                    const c_inputStuId = document.querySelector("#id_formModal input[name=stuId]");

                    const colorArr = [
                        'rgba(255, 99, 132, 0.4)',
                        'rgba(50, 155, 255, 0.4)',
                        'rgba(255, 216, 76, 0.4)',
                        'rgba(75, 200, 190, 0.4)',
                        'rgba(153, 102, 255, 0.4)',
                        'rgba(255, 159, 50, 0.4)',
                        'rgba(90, 210, 30, 0.4)',
                        'rgba(95, 110, 255, 0.4)',
                        'rgba(245, 97, 30, 0.4)',
                        'rgba(215, 95, 255, 0.4)',
                        'rgba(10, 200, 255, 0.4)',
                        'rgba(0, 140, 60, 0.4)',
                        'rgba(255, 200, 235, 0.4)',
                        'rgba(200, 30, 100, 0.4)',
                        'rgba(10, 110, 255, 0.4)',
                        'rgba(180, 200, 255, 0.4)',
                        'rgba(0, 110, 130, 0.4)',
                        'rgba(255, 250, 205, 0.4)',
                        'rgba(120, 80, 30, 0.4)',
                        'rgba(200, 180, 255, 0.4)'
                    ];

                    function addData(chart, label, data) {
                        chart.data.labels.push(label);
                        chart.data.datasets.forEach((dataset) => {
                            dataset.data.push(data);
                        });
                        chart.update();
                    };

                    function removeData(chart) {
                        chart.data.labels.pop();
                        chart.data.datasets.forEach((dataset) => {
                            dataset.data.pop();
                        });
                        chart.update();
                    };


                    const ctx = document.querySelector('#id_chart').getContext('2d');
                    const myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: [],
                            datasets: [{
                                label: '',
                                data: [],
                                backgroundColor: colorArr,
                                borderColor: colorArr,
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            },
                            legend: {
                                display: false
                            },
                            tooltips: {
                                callbacks: {
                                    label: function (tooltipItem) {
                                        return tooltipItem.yLabel;
                                    }
                                }
                            }
                        }

                    });


                    // 데이터테이블의 내용이 바뀔 때 마다 차트를 새로고침하는 메서드 
                    const f_renderChart = function () {
                        let v_data = {};
                        // QuerySelector로 반환한 NodeList에 .map 함수를 쓰기 위해 Spread Operators를 사용하여 배열로 변환함
                        // 선택한 셀의 텍스트를 배열로 추출 
                        let stuNames = [...document.querySelectorAll('#id_table td.data-name')].map(x => x.innerText);
                        let stuScores = [...document.querySelectorAll('#id_table td.data-score')].map(x => x.innerText);

                        myChart.data.labels = stuNames;
                        myChart.data.datasets[0].data = stuScores;
                        //console.log(myChart);
                        myChart.update();

                    };

                    const f_resetModal = function () {
                        c_inputGrdScr.value = "";
                        c_inputGrdCmt.value = "";
                    }

                    const f_renderNum = function (p_num) {
                        return Math.round(p_num * 100) / 100;
                    }

                    // 표준편차를 구하는 계산
                    const f_getStandardDeviation = function (p_data) {

                        /*
                        for (let i = 0; i < p_data.length; i++) {
                            arr.push(Number(p_data[i]['grdScr']));
                            console.log(p_data[i]['grdScr']);
                        }
                        // 아래와 의미가 같음
                        */
                        // array의 map을 이용한 배열 변환
                        let arr = p_data.map(x => Number(x['grdScr']));
                        console.log(arr);

                        // 0 처리
                        if (!arr || arr.length === 0) { return 0; }

                        let n = arr.length
                        let mean = arr.reduce((a, b) => a + b) / n // 평균 구하기(리듀서 함수)
                        let sd = Math.sqrt(arr.map(x => Math.pow(x - mean, 2)).reduce((a, b) => a + b) / n);

                        document.querySelector("#id_avg").innerText = f_renderNum(mean);
                        document.querySelector("#id_stDiviation").innerText = f_renderNum(sd);
                        return sd;
                    };

                    const f_getData = function () {
                        v_json = {
                            url: "${CONTEXT_PATH}/grdManagement/list/data?cursNo=${cursNo}",
                            method: "get",
                            dataType: "json",
                            async: true,
                            success: function (p_data) {

                                if ($.fn.dataTable.isDataTable('#id_table')) {
                                    let table = $('#id_table').DataTable();
                                    table.clear();
                                    table.rows.add(p_data).draw();
                                } else {
                                    f_dataTable(p_data);
                                }

                                let t = f_getStandardDeviation(p_data);
                                console.log(t);
                                f_renderChart();
                                f_setSelectBox();

                            }
                        }

                        f_ajax(v_json);
                    };

                    const f_dataTable = function (p_data) {
                        let table = $('#id_table').DataTable({
                            dom: "lfrtBp",
                            data: p_data,
                            columns: [
                                { data: "stuId" },
                                { data: "stuNm" },
                                { data: "grdScr" },
                                { data: "grdRank" },
                                { data: null },
                                { data: null }],
                            columnDefs: [{
                                title: '학생 ID',
                                targets: 0,
                                className: 'dt-head-center'
                            }, {
                                title: '학생 이름',
                                targets: 1,
                                className: 'dt-center data-name'
                            }, {
                                title: '원점수',
                                targets: 2,
                                className: 'dt-center data-score'
                            }, {
                                title: '석차',
                                targets: 3,
                                className: 'dt-center'
                            }, {
                                title: '백분위',
                                targets: 4,
                                data: null,
                                render: function (data, type, row) { return 100 - (parseInt(data["grdRank"] / data["grdTotal"] * 100)) },
                                className: 'dt-center'
                            }, {
                                title: '상세',
                                targets: -1,
                                data: null,
                                className: 'dt-center',
                                defaultContent: "<a href='#'><span class='badge badge-primary' id='id_detailBtn'>상세조회</span></a>"
                            }],
                            buttons: [{
                                text: '성적 입력',
                                action: function () {
                                    $('.form-detail').hide();
                                    $('.form-insert').show();
                                    $('.modal-title').text('성적 입력');
                                    f_toggleModalEditable(true);
                                    $('#id_formModal').modal('show');
                                    $("#id_submitBtn").one("click", f_submitGrd.bind(document, "insert"));
                                },
                                className: 'btn btn-primary',

                            }, {
                                text: 'xlsx 내보내기',
                                action: f_exportXLSX,
                                className: 'btn btn-secondary',
                                attr: { id: 'sheetjsexport' }
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

                            $('.modal-title').text('성적 수정');
                            f_toggleModalEditable(false);
                            $('.form-insert').hide();
                            $('.form-detail').show();
                            $('#id_formModal').modal('show');

                            c_inputGrdScr.value = data['grdScr'];
                            c_inputGrdCmt.value = data['grdCmt'];
                            c_inputStuNm.value = data['stuNm'];
                            c_inputStuId.value = data['stuId'];

                            //alert(data['atdDt'] + "일의 출석 결과는" + data['atdCmcd']);

                            $("#id_editBtn").one("click", f_initEdit);
                        });

                    };

                    const f_deleteConfirm = function () {
                        Swal.fire({
                            title: "성적 삭제하기",
                            text: "정말 삭제하시겠습니까?",
                            icon: "question",
                            showCancelButton: true,
                            confirmButtonText: '확인',
                            cancelButtonText: '취소',
                        }).then((result) => {
                            if (result.isConfirmed) {
                                f_submitGrd("delete");
                                $("select[name=stuId]").append("<option value='" + c_inputStuId.value + "'>" + c_inputStuNm.value + "</option>");
                            }
                            if (result.dismiss === Swal.DismissReason.cancel) {
                                Swal.fire(
                                    '', '취소되었습니다.', 'info'
                                )
                            }

                        });
                    }

                    const f_forgeInputData = function () {
                        return {
                            grdScr: c_inputGrdScr.value,
                            grdCmt: c_inputGrdCmt.value,
                            stuId: c_inputStuId.value,
                            cursNo: '${cursNo}'
                        };
                    };

                    const f_submitGrd = function (p_query) {
                        let v_data = f_forgeInputData();
                        console.log(v_data);
                        let v_json = {
                            url: "${CONTEXT_PATH}/grdManagement/detail/" + p_query,
                            method: "post",
                            data: JSON.stringify(v_data),
                            contentType: "application/json; charset=utf-8",
                            async: true,
                            csrf: true,
                            success: function (p_data) {
                                Swal.fire(
                                    '', p_data, 'info'
                                )
                                $('#id_formModal').modal('hide');
                                f_getData();
                            }
                        }
                        f_ajax(v_json);
                    };


                    const f_initEdit = function () {
                        f_toggleModalEditable(true);
                        $("#id_editSubmitBtn").one("click", f_submitGrd.bind(document, "update"));
                    };

                    const f_toggleModalEditable = function (p_bool) {
                        c_inputGrdScr.readOnly = !p_bool;
                        c_inputGrdCmt.readOnly = !p_bool;

                        if (p_bool) {
                            $("#id_editSubmitBtn").show();
                            $("#id_editBtn").hide();
                        }
                        if (!p_bool) {
                            $("#id_editSubmitBtn").hide();
                            $("#id_editBtn").show();
                        }


                    };

                    const f_setSelectBox = function () {
                        v_json = {
                            url: "${CONTEXT_PATH}/grdManagement/detail/stuList?cursNo=${cursNo}",
                            method: "get",
                            async: true,
                            dataType: "json",
                            success: function (p_data) {

                                $("select[name=stuId]").find("option").remove();
                                $("select[name=stuId]").append("<option hidden='' disabled='disabled' selected='selected' value=''>---</option>");

                                for (let i = 0; i < p_data.length; i++) {
                                    $("select[name=stuId]").append("<option value='" + p_data[i].stuId + "'>" + p_data[i].stuNm + "</option>");
                                }
                            }
                        }

                        f_ajax(v_json)
                    };

                    const f_setStuId = function (p_val) {
                        c_inputStuId.value = p_val
                    };

                    const f_exportXLSX = function () {
                        let table = document.querySelector("#id_table");
                        /* Create worksheet from HTML DOM TABLE */
                        var wb = XLSX.utils.table_to_book(table);
                        /* Export to file (start a download) */
                        XLSX.writeFile(wb, "${cursNo}+강의+전체+수강생+성적.xlsx");
                    };

                    f_getData();
                    $('#id_formModal').on('hidden.bs.modal', f_resetModal);

                </script>