<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!-- Page Body Start-->
            <!-- 페이지 타이틀 시작 -->
            <div class="container-fluid">
                <div class="page-header">
                    <div class="row">
                        <div class="col-sm-12">
                            <h3>내 출석 조회</h3>
                            <!-- 제목 하단 페이지 경로 -->
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">Home</a></li>
                                <li class="breadcrumb-item">내 출석 조회</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 페이지 타이틀 끝 -->
            <!-- 내용 시작 -->
            <div class="container-fluid">
                <div class="row starter-main">
                    <c:if test="${cursList==null}">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header pb-0">
                                    <h4>현재 수강 중인 강의가 없습니다.</h4>
                                </div>

                                <div class="card-body">
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${cursList!=null}">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header pb-0">
                                    <h5>진행 중인 강의</h5>
                                </div>

                                <div class="card-body">
                                    <table class="table table-hover" style="text-align: center;">
                                        <thead>
                                            <tr class="table-light">
                                                <th class="col-1">No</th>
                                                <th class="col-1">과목</th>
                                                <th class="col-3">강의명</th>
                                                <th class="col-1">수강정원</th>
                                                <th class="col-1">강의실</th>
                                                <th class="col-2">시작일</th>
                                                <th class="col-2">종료일</th>
                                            </tr>
                                        </thead>
 

                                        <tbody>
                                            <c:forEach var="curs" items="${cursList}" varStatus="status">
                                                <tr onclick="location.href='${CONTEXT_PATH}/attendance/detail?cursNo=${curs.cursNo}'">
                                                    <fmt:formatDate value="${curs.cursEndDt}" pattern="yyyy-MM-dd" var="endDt"/>
                                                    <fmt:formatDate value="${curs.cursSttDt}" pattern="yyyy-MM-dd" var="startDt"/>
                                                    <c:set value="<%=new java.util.Date()%>" var="now"/>
                                                    <c:set target="${now}" property="time" value="${now.time + (86400000 * 10)}" />
                                                        <td>${status.index+1}</td>
                                                        <td>${curs.subNm}</td>
                                                        <td>${curs.cursNm}</td>
                                                        <td>${curs.cursSuNum}명</td>
                                                        <td>${curs.faciNm}</td>
                                                        <td>${startDt}</td>
                                                        <td>${endDt}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <c:if test="${endedCursList!=null}">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-header pb-0">
                                        <h5>지난 강의</h5>
                                    </div>

                                    <div class="card-body">
                                        <table class="table table-hover" style="text-align: center;">
                                            <thead>
                                                <tr class="table-light">
                                                    <th class="col-1">No</th>
                                                    <th class="col-1">과목</th>
                                                    <th class="col-3">강의명</th>
                                                    <th class="col-1">수강정원</th>
                                                    <th class="col-1">강의실</th>
                                                    <th class="col-2">시작일</th>
                                                    <th class="col-2">종료일</th>
                                                </tr>
                                            </thead>
    
    
                                            <tbody>
                                                <c:forEach var="curs" items="${endedCursList}" varStatus="status">
                                                    <tr onclick="location.href='${CONTEXT_PATH}/attendance/detail?cursNo=${curs.cursNo}'">
                                                        <fmt:formatDate value="${curs.cursEndDt}" pattern="yyyy-MM-dd" var="endDt"/>
                                                        <fmt:formatDate value="${curs.cursSttDt}" pattern="yyyy-MM-dd" var="startDt"/>
                                                            <td>${status.index+1}</td>
                                                            <td>${curs.subNm}</td>
                                                            <td>${curs.cursNm}</td>
                                                            <td>${curs.cursSuNum}명</td>
                                                            <td>${curs.faciNm}</td>
                                                            <td>${startDt}</td>
                                                            <td>${endDt}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:if>
                    <!-- 카드 1 끝 -->
                </div>
            </div>
            <!-- Container-fluid Ends-->