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
                                <h3>학생 출석 상세</h3>
                                <!-- 제목 하단 페이지 경로 -->
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">Home</a></li>
                                    <li class="breadcrumb-item">강의 관리</li>
                                    <li class="breadcrumb-item">강의 출결 내역</li>
                                    <li class="breadcrumb-item active">학생 출석 상세</li>
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
                                    <div class="d-flex justify-content-between">
                                        <h5 class="inline">${name} 수강생</h5>
                                        <button id="id_insertBtn" class="btn btn-primary btn-sm mx-3"
                                            onclick="f_showInsertModal()">출석 추가</button>
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
                <div class="modal fade" id="id_formModal" tabindex="-1" aria-labelledby="formModalLabel"
                    style="display: none;" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">출결 내역 수정하기</h5>
                                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"
                                    data-bs-original-title="" title=""></button>
                            </div>
                            <div class="modal-body">
                                <form id="id_editForm">
                                    <div class="mb-3">
                                        <label class="col-form-label">날짜 : </label>
                                        <input id="datePicker" name="atdDt"
                                            class="form-control datepicker-here form-control digits" type="text"
                                            value="">
                                    </div>
                                    <div class="mb-3">
                                        <label class="col-form-label">입실 시간 : </label>
                                        <input name="atdInTm"
                                            class="form-control timepicker timepicker-with-dropdown text-center"
                                            type="text" value="">
                                    </div>
                                    <div class="mb-3">
                                        <label class="col-form-label">퇴실 시간 : </label>
                                        <input name="atdOutTm"
                                            class="form-control timepicker timepicker-with-dropdown text-center"
                                            type="text" value="">
                                    </div>
                                    <div class="mb-3">
                                        <label class="col-form-label">출석 상태 : </label>
                                        <select name="atdCmcd">
                                            <option value="ATD00">결석</option>
                                            <option value="ATD01">출석</option>
                                            <option value="ATD02">지각</option>
                                            <option value="ATD03">조퇴</option>
                                            <option value="ATD04">병결</option>
                                            <option value="ATD06">지각+조퇴</option>
                                        </select>
                                    </div>
                                    <sec:csrfInput />
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button id="id_submitBtn" class="btn btn-primary" type="button"
                                    data-bs-original-title="" title="">확인</button>
                                <button class="btn btn-info" type="button" data-bs-dismiss="modal"
                                    data-bs-original-title="" title="">취소</button>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>

                <script src="${CONTEXT_PATH}/assets/js/datatable/datatables/jquery.dataTables.min.js"></script>
                <script src="${CONTEXT_PATH}/assets/js/datatable/datatables/datatable.custom.js"></script>
                <!-- <script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.bootstrap4.min.js"></script> -->
                <script
                    src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.responsive.min.js"></script>
                <!-- <script src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/responsive.bootstrap4.min.js"></script> -->
                <script
                    src="${CONTEXT_PATH}/assets/js/datatable/datatable-extension/dataTables.buttons.min.js"></script>
                <script src="http://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
                <script src="${CONTEXT_PATH}/assets/js/datepicker/date-picker/datepicker.js"></script>
                <script src="${CONTEXT_PATH}/assets/js/datepicker/date-picker/datepicker.en.js"></script>
                <script src="${CONTEXT_PATH}/assets/js/datepicker/date-picker/datepicker.custom.js"></script>

                <script src="${CONTEXT_PATH}/js/ajax.js"></script>
                <script>

                    const c_modalDiv = document.querySelector("#id_modalDiv");

                    const f_validateTime = function (p_inTime, p_outTime) {
                        //console.log(new Date(p_outTime));
                        let dtString = "1970-01-01T";
                        return new Date(dtString+p_outTime)>new Date(dtString+p_inTime);
                    }

                    const f_showInsertModal = function () {
                        $('#id_formModal').modal('show');
                        $("#id_submitBtn").one("click", f_submitInsertForm);
                    }

                    const f_submitInsertForm = function () {
                        let inTime = document.querySelector("#id_formModal input[name=atdInTm]").value;
                        let outTime = document.querySelector("#id_formModal input[name=atdOutTm]").value;
                        let checkinDate = document.querySelector("#id_formModal input[name=atdDt]").value;
                        let v_data = {
                            stuId: '${stuId}',
                            cursNo: '${cursNo}',
                            atdDt: checkinDate,
                            atdInTm: new Date(checkinDate + 'T' + inTime),
                            atdOutTm: new Date(checkinDate + 'T' + outTime),
                            atdCmcd: document.querySelector("#id_formModal select[name=atdCmcd]").value
                        };

                        let v_json = {
                            url: "${CONTEXT_PATH}/atdManagement/detail/insert",
                            method: "post",
                            data: JSON.stringify(v_data),
                            contentType: "application/json; charset=utf-8",
                            async: true,
                            csrf: true,
                            success: function (p_data) {
                                alert(p_data);
                                $('#id_formModal').modal('hide');
                                f_getData();
                            }
                        }

                        f_ajax(v_json);
                    }

                    const f_initModal = function () {
                        document.querySelector("#id_formModal input[name=atdDt]").value = "";
                        document.querySelector("#id_formModal input[name=atdDt]").disabled = "";
                        document.querySelector("#id_formModal input[name=atdInTm]").value = "";
                        document.querySelector("#id_formModal input[name=atdOutTm]").value = "";
                        document.querySelector("#id_formModal select[name=atdCmcd]").value = "";
                        $("#id_submitBtn").off("click");
                    }
                    $('#id_formModal').on('hidden.bs.modal', f_initModal);


                    const f_submitEditForm = function (p_data) {
                        let inTime = document.querySelector("#id_formModal input[name=atdInTm]").value;
                        let outTime = document.querySelector("#id_formModal input[name=atdOutTm]").value;
                        console.log(inTime, outTime);
                        let v_data = {
                            stuId: p_data['stuId'],
                            cursNo: p_data['cursNo'],
                            atdDt: p_data['atdDt'],
                            atdInTm: new Date(p_data['atdDt'] + 'T' + inTime),
                            atdOutTm: new Date(p_data['atdDt'] + 'T' + outTime),
                            atdCmcd: document.querySelector("#id_formModal select[name=atdCmcd]").value
                        };
                        console.log(v_data);
                        let v_json = {
                            url: "${CONTEXT_PATH}/atdManagement/detail/update",
                            method: "post",
                            data: JSON.stringify(v_data),
                            contentType: "application/json; charset=utf-8",
                            async: true,
                            csrf: true,
                            success: function (p_data) {
                                alert(p_data);
                                $('#id_formModal').modal('hide');

                            }
                        }

                        f_ajax(v_json);

                    }

                    const f_deleteAlert = function (p_atdDt) {
                        Swal.fire({
                            title: "출석 삭제하기",
                            text: "정말 삭제하시겠습니까?",
                            icon: "question",
                            showCancelButton: true,
                            confirmButtonText: '확인',
                            cancelButtonText: '취소',
                        }).then((result) => {
                            if (result.isConfirmed) {
                                f_submitDelete(p_atdDt);
                                
                            }
                            if (result.dismiss === Swal.DismissReason.cancel) {
                                Swal.fire(
                                    '', '취소되었습니다.', 'info'
                                )
                            }

                        })
                    }

                    const f_submitDelete = function (p_atdDt) {
                        let v_data = {
                            stuId: '${stuId}',
                            cursNo: '${cursNo}',
                            atdDt: p_atdDt
                        }
                        let v_json = {
                            url: "${CONTEXT_PATH}/atdManagement/detail/delete",
                            method: "post",
                            data: JSON.stringify(v_data),
                            contentType: "application/json; charset=utf-8",
                            async: true,
                            csrf: true,
                            success: function (p_data) {
                                Swal.fire(
                                    '', '삭제되었습니다.', 'success'
                                )
                                console.log(p_data);
                            }

                        };
                        f_ajax(v_json)
                    }

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
                            url: "${CONTEXT_PATH}/atdManagement/detail/data?cursNo=${courseVO.cursNo}&stuId=${studentVO.stuId}",
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
                                        { data: 'atdCmcd' },
                                        { data: null }],
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
                                    }, {
                                        title: '비고',
                                        targets: -1,
                                        data: null,
                                        className: 'dt-center',
                                        defaultContent: "<h5 class='mb-0'><a href='#'><span id='id_editBtn' class='badge badge-warning'"
                                            + ">수정</span><a>&nbsp;"
                                            + "<a href='#'><span id='id_deleteBtn' class='badge badge-danger'>삭제</span></a></h5>"
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

                                $('#id_table tbody').on('click', '#id_editBtn', function () {
                                    let data = table.row($(this).parents('tr')).data();
                                    console.log(data);
                                    $('#id_formModal').modal('show');

                                    document.querySelector("#id_formModal input[name=atdDt]").value = data['atdDt'];
                                    document.querySelector("#id_formModal input[name=atdDt]").disabled = true;
                                    document.querySelector("#id_formModal input[name=atdInTm]").value = f_getTime(data['atdInTm']);
                                    document.querySelector("#id_formModal input[name=atdOutTm]").value = f_getTime(data['atdOutTm']);
                                    document.querySelector("#id_formModal select[name=atdCmcd]").value = data['atdCmcd'];
                                    //alert(data['atdDt'] + "일의 출석 결과는" + data['atdCmcd']);

                                    $("#id_submitBtn").one("click", f_submitEditForm.bind(data, data));
                                });

                                $('#id_table tbody').on('click', '#id_deleteBtn', function () {
                                    let data = table.row($(this).parents('tr')).data();
                                    f_deleteAlert(data['atdDt']);
                                });
                            }
                        };
                        f_ajax(v_data);
                    }


                    $('.timepicker').timepicker({
                        timeFormat: 'HH:mm:ss',
                        interval: 30,
                        minTime: '6',
                        maxTime: '22:00:00',
                        defaultTime: '11',
                        startTime: '06:00',
                        dynamic: false,
                        dropdown: true,
                        scrollbar: true
                    });

                    $('#datePicker').datepicker({
                        dateFormat: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
                        //startDate: '-10d',	//달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
                        //endDate: '+10d',	//달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
                        autoclose: true,	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
                        calendarWeeks: false, //캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
                        clearBtn: false, //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
                        //datesDisabled : ['2019-06-24','2019-06-26'],//선택 불가능한 일 설정 하는 배열 위에 있는 format 과 형식이 같아야함.
                        //daysOfWeekDisabled : [0,6],	//선택 불가능한 요일 설정 0 : 일요일 ~ 6 : 토요일
                        //daysOfWeekHighlighted : [3], //강조 되어야 하는 요일 설정
                        disableTouchKeyboard: false,	//모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
                        immediateUpdates: false,	//사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false 
                        multidate: false, //여러 날짜 선택할 수 있게 하는 옵션 기본값 :false 
                        multidateSeparator: ",", //여러 날짜를 선택했을 때 사이에 나타나는 글짜 2019-05-01,2019-06-01
                        templates: {
                            leftArrow: '&laquo;',
                            rightArrow: '&raquo;'
                        }, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징 
                        showWeekDays: true,// 위에 요일 보여주는 옵션 기본값 : true
                        title: "날짜 선택",	//캘린더 상단에 보여주는 타이틀
                        todayHighlight: true,	//오늘 날짜에 하이라이팅 기능 기본값 :false 
                        toggleActive: true,	//이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
                        weekStart: 0,//달력 시작 요일 선택하는 것 기본값은 0인 일요일 
                        language: "en"	//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.

                    });//datepicker end

                    console.log(f_validateTime("11:00:00", "09:00:00"));

                    f_initModal();
                    f_getData();

                </script>