<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <fmt:formatDate value="${curs.cursSttDt}" pattern="yyyy-MM-dd" var="startDt" />
                <fmt:formatDate value="${curs.cursEndDt}" pattern="yyyy-MM-dd" var="endDt" />
                <fmt:parseNumber var="term" value="${(curs.cursEndDt.time - curs.cursSttDt.time)/86400000}"
                    integerOnly="true" />

                <!-- Page Body Start-->
                <!-- 페이지 타이틀 시작 -->
                <div class="container-fluid">
                    <div class="page-header">
                        <div class="row">
                            <div class="col-sm-12">
                                <h3></h3>
                                <!-- 제목 하단 페이지 경로 -->
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">홈</a></li>
                                    <li class="breadcrumb-item">내 성적 조회</li>
                                    <li class="breadcrumb-item active">${curs.cursNm}</li>
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
                                    <h5>성적 조회</h5>
                                </div>

                                <div class="card-body">
                                    <h3>${curs.cursNm}</h3><br>

                                    <div id="id_chartDiv" class="container-fluid">
                                        <canvas id="id_chart">

                                        </canvas>
                                    </div>
                                    <br>
                                    <div id="id_cursInfoDiv" class="container-fluid">

                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col">과목</th>
                                                    <td id="id_cursSubNm">${curs.subNm}</td>
                                                    <th scope="col">강의실</th>
                                                    <td id="id_cursFaciNm">${curs.faciNm}</td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th scope="col">담당 강사</th>
                                                    <td id="id_cursTcrNm">임지수</td>
                                                    <th scope="col">강의 기간</th>
                                                    <td id="id_cursPeriod">${startDt}~${endDt} (${term}일)</td>

                                                </tr>
                                                <tr>
                                                    <th scope="col">평균</th>
                                                    <td id="id_avg">${avg*100/100}</td>
                                                    <th scope="col">내 점수</th>
                                                    <td id="id_grdScr">${grd.grdScr}</td>
                                                </tr>
                                                <tr>
                                                    <th scope="col">수강생 수</th>
                                                    <td id="id_cursSuNum">${curs.cursSuNum}명</td>
                                                    <th scope="row">석차</th>
                                                    <td id="id_grdRank">${grd.grdRank}등</td>
                                                </tr>
                                                <tr>
                                                    <th class="col">강사 코멘트</th>
                                                    <td class="" rowspan="3">${grd.grdCmt}</td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                    <br>
                                </div>
                            </div>
                        </div>
                        <!-- 카드 1 끝 -->
                    </div>
                </div>
                <!-- Container-fluid Ends-->
                <script src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
                <script>

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

                    const ctx = document.querySelector('#id_chart').getContext('2d');
                    const myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: ['내 점수', '평균'],
                            datasets: [{
                                label: '점수',
                                data: ['${grd.grdScr}', '${avg}'],
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
                            plugin: {
                                legend: {
                                    display: false
                                }
                            }
                        }

                    });

                    const f_renderNum = function (p_num) {
                        return Math.round(p_num * 100) / 100;
                    }

                </script>