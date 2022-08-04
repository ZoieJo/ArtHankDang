<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!-- Page Body Start-->
                <!-- 페이지 타이틀 시작 -->
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="row">
                            <div class="col-sm-12">
                                <h3>출석 상세</h3>
                                <!-- 제목 하단 페이지 경로 -->
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">Home</a></li>
                                    <li class="breadcrumb-item">내 출석 관리</li>
                                    <li class="breadcrumb-item">${curs.cursNm} 출석 상세</li>
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
                                <div class="card-header pb-0 ">
                                    <div class="d-flex justify-content-start">
                                        <h5 class="inline">${curs.cursNm}</h5>
                                        
                                    </div>
                                </div>

                                <div class="card-body">
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
                <!-- edit form modal -->
                <sec:csrfInput />
           
                <script src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>

                <script src="${CONTEXT_PATH}/assets/js/datatable/datatables/jquery.dataTables.min.js"></script>
                <script src="${CONTEXT_PATH}/assets/js/datatable/datatables/datatable.custom.js"></script>
                <!-- <script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.bootstrap4.min.js"></script> -->
                <script
                    src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.responsive.min.js"></script>
                <!-- <script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/responsive.bootstrap4.min.js"></script> -->
                <script
                    src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.buttons.min.js"></script>
              
                <script src="${CONTEXT_PATH}/js/ajax.js"></script>
                <script>


                    const f_padZero = function (p_num) {
                        return p_num.toString().length < 2 ? ('0' + p_num) : p_num;
                    }

                    const f_getTime = function (p_date) {
                        if (p_date == null) {
                            return '-';
                        }
                        let date = new Date(p_date);
                        var timeArr = [f_padZero(date.getHours()), f_padZero(date.getMinutes()), f_padZero(date.getSeconds())];
                        return timeArr.join(':');
                    }

                    const f_renderAtdStatus = function (p_value) {
                        if (p_value == 'ATD00') { // 결석
                            return "<h5 class='mb-0'><span class='badge rounded-pill badge-danger'>결석</span></h5>"
                        }
                        if (p_value == 'ATD01') { // 출석
                            return "<h5 class='mb-0'><span class='badge rounded-pill badge-primary'>출석</span></h5>"
                        }
                        if (p_value == 'ATD02') { // 지각
                            return "<h5 class='mb-0'><span class='badge rounded-pill badge-warning text-dark'>지각</span></h5>"
                        }
                        if (p_value == 'ATD03') { // 조퇴
                            return "<h5 class='mb-0'><span class='badge rounded-pill badge-info'>조퇴</span></h5>"
                        }
                        if (p_value == 'ATD04') { // 병결
                            return "<h5 class='mb-0'><span class='badge rounded-pill badge-light text-dark'>병결</span></h5>"
                        }
                        if (p_value == 'ATD06') { // 지각+조퇴
                            return "<h5 class='mb-0'><span class='badge rounded-pill badge-secondary'>지각+조퇴</span></h5>"
                        }

                        return "";

                    }


                    const f_getData = function () {
                        v_data = {
                            url: "${CONTEXT_PATH}/atdManagement/detail/data?cursNo=${curs.cursNo}&stuId=${USERNAME}",
                            method: "get",
                            dataType: "json",
                            async: true,
                            success: function (p_data) {
                                //f_buildTable(p_data);
                                let table = $('#id_table').DataTable({
                                    data: p_data,
                                    columns: [
                                        { data: 'atdDt' },
                                        { data: 'atdInTm' },
                                        { data: 'atdOutTm' },
                                        { data: 'atdCmcd' }],
                                    columnDefs: [{
                                        title: '출석일',
                                        targets: 0,
                                        className: 'dt-center'
                                    }, {
                                        title: '입실 시각',
                                        targets: 1,
                                        className: 'dt-center',
                                        render: f_getTime
                                    }, {
                                        title: '퇴실 시각',
                                        targets: 2,
                                        className: 'dt-center',
                                        render: f_getTime
                                    }, {
                                        title: '출석 상태',
                                        targets: 3,
                                        className: 'dt-center',
                                        render: f_renderAtdStatus
                                    }],
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
                            }
                        };
                        f_ajax(v_data);
                    }



                    
                    f_getData();

                </script>