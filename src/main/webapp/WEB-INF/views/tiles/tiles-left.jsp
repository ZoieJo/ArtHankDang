<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>
	.page-wrapper.compact-wrapper .page-body-wrapper header.main-nav,
	.page-wrapper.compact-wrapper .page-body-wrapper header.main-nav .main-navbar .nav-menu,
	.page-wrapper.compact-wrapper .page-body-wrapper .page-body {
		transition: none;
	}
</style>

<!-- Page Sidebar Start-->
        <header class="main-nav">
          <nav>
            <div class="main-navbar">
              <div id="mainnav">
                <ul class="nav-menu" style="margin-top:15px; width:100%; height: 100%;">
                
                  <li class="back-btn">
                    <div class="mobile-back text-end">
                    	<span>Back</span>
                    	<i class="fa fa-angle-right ps-2" aria-hidden="true"></i>
                    </div>
                  </li>

                <!-- 학원소개 메뉴 -->
				<li class="dropdown">
                  	<a class="nav-link menu-title" href="javascript:void(0)">
                  		<i data-feather="home"></i>
                  		<span>아트학당소개</span>
                  	</a>
                  	<!-- 드롭다운 메뉴 -->
                    <ul class="nav-submenu menu-content">
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/intro/greet">인사말<span class="sub-arrow"></span></a>
                      </li>
                      
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/intro/group">조직도<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
                      </li>
                      
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/intro/map">오시는길<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
                      </li>
                      
                    </ul>
				</li>
				
				<sec:authorize access="!hasAnyRole('TEACHER,STUDENT,EMPLOYEE')">
				<!-- 강의관련 메뉴 -->
				<li class="dropdown">
                  	<a class="nav-link menu-title" href="javascript:void(0)">
                  		<i data-feather="book-open"></i>
                  		<span>강의</span>
                  	</a>
                  	<!-- 드롭다운 메뉴 -->
                    <ul class="nav-submenu menu-content">
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/opensu/sulist">개설강의<span class="sub-arrow"></span></a>
                      </li>
                      
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/opensu/suevaluation">강의후기<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
                      </li>
                    </ul>
				</li>
				
				<!-- 공지사항 -->
				<li class="dropdown">
					<a class="nav-link menu-title" href="${CONTEXT_PATH}/notice/main">
						<i data-feather="info"></i>
						<span>공지사항</span>
					</a>
				</li>
				
				<!-- 상담신청 -->
				<li class="dropdown">
				   	<a class="nav-link menu-title" href="javascript:void(0)">
                  		<i data-feather="book-open"></i>
                  		<span>방문상담신청</span>
                  	</a>
                  	<!-- 드롭다운 메뉴 -->
                    <ul class="nav-submenu menu-content">
                      <li>
                      	<a class="submenu-title"href="${CONTEXT_PATH}/newCslrg/write">방문상담신청<span class="sub-arrow"></span></a>
                      </li>
                      
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/newCslrg/cslrdList">방문상담내역<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
                      </li>
                    </ul>
				</sec:authorize>

<!-- 학생 -->
<sec:authorize access="isAuthenticated()" >
 				<sec:authorize access="hasRole('STUDENT')" >
                <!-- 마이페이지 -->
				<li class="dropdown">
                  	<a class="nav-link menu-title" href="${CONTEXT_PATH}/mypage/main" >
                  		<i data-feather="user"></i>
                  		<span>마이페이지</span>
                  	</a>
				</li>
				
				<!-- 일정관리 -->
				<li class="dropdown">
                  	<a class="nav-link menu-title" href="${CONTEXT_PATH}/schd/calendar">
                  		<i data-feather="calendar"></i>
                  		<span>내 일정 관리</span>
                  	</a>
				</li>
						
			    <!-- QR학생증 -->
				<li class="dropdown">
                  	<a class="nav-link menu-title" href="${CONTEXT_PATH}/qrCode" >
                  		<i data-feather="grid"></i>
                  		<span>QR학생증</span>
                  	</a>
				</li>
				
				<!-- 출석 -->
				<li class="dropdown">
                  	<a class="nav-link menu-title" href="${CONTEXT_PATH}/attendance/main">
                  		<i data-feather="clipboard"></i>
                  		<span>출석조회</span>
                  	</a>
				</li>
				
				<!-- 강의 -->
				<li class="dropdown">
                  	<a class="nav-link menu-title" href="javascript:void(0)">
                  		<i data-feather="feather"></i>
                  		<span>강의</span>
                  	</a>
                  	<!-- 드롭다운 메뉴 -->
                    <ul class="nav-submenu menu-content">
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH }/grade/main">내성적조회<span class="sub-arrow"></span></a>
                      </li>
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH }/lecture/studentLecture">내강의조회<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
                      </li>
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/lecture/evaluation">강의평가<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
                      </li>
                    </ul>
				</li>
				
				<!-- 상담신청 -->
				<li class="dropdown">
                  	<a class="nav-link menu-title" href="javascript:void(0)">
                  		<i data-feather="clock"></i>
                  		<span>상담</span>
                  	</a>
                  	<!-- 드롭다운 메뉴 -->
                    <ul class="nav-submenu menu-content">
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/cslrg/write">상담신청<span class="sub-arrow"></span></a>
                      </li>
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/cslrg/cslList">내 상담내역<span class="sub-arrow"></span></a>
                      </li>
                    </ul>
				</li>
				
				<!-- 수강 메뉴 -->
				<li class="dropdown">
                  	<a class="nav-link menu-title" href="javascript:void(0)">
                  		<i data-feather="shopping-bag"></i>
                  		<span>수강신청</span>
                  	</a>
                  	<!-- 드롭다운 메뉴 -->
                    <ul class="nav-submenu menu-content">
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/stdSignup/curslist">강의목록<span class="sub-arrow"></span></a>
                      </li>
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/stdSignup/cartlist">장바구니<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
                      </li>
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/stdSignup/paymentHistory">결제내역<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
                      </li>
                    </ul>
				</li>


				<!-- 커뮤니티 메뉴 -->
				<li class="dropdown">
                  	<a class="nav-link menu-title" href="javascript:void(0)">
                  		<i data-feather="globe"></i>
                  		<span>커뮤니티</span>
                  	</a>
                  	<!-- 드롭다운 메뉴 -->
                    <ul class="nav-submenu menu-content">
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/freeboard/main">자유게시판<span class="sub-arrow"></span></a>
                      </li>
                      
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/qna">Q&amp;A<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
                      </li>
                      
                      <li>
                      	<a class="submenu-title" href="${CONTEXT_PATH}/groupStudy/main">그룹스터디게시판<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
                      </li>
                      
                    </ul>
				</li>
				
				<!-- 공지사항 -->
				<li class="dropdown">
					<a class="nav-link menu-title" href="${CONTEXT_PATH}/notice/main">
						<i data-feather="info"></i>
						<span>공지사항</span>
					</a>
				</li>
				
				<!-- 시설대여 -->
				<li class="dropdown">
					<a class="nav-link menu-title" href="${CONTEXT_PATH}/fac/main">
						<i data-feather="archive"></i>
						<span>시설대여</span>
					</a>
				</li>                  
                  </sec:authorize>

<!-- 교원(선생님) -->
<sec:authorize access="hasRole('TEACHER')">
 					<!-- 마이페이지 -->
					<li class="dropdown">
	                  	<a class="nav-link menu-title" href="${CONTEXT_PATH}/mypage/main" >
	                  		<i data-feather="user"></i>
	                  		<span>마이페이지</span>
	                  	</a>
					</li>
					<!-- 일정관리 -->
					<li class="dropdown">
                  		<a class="nav-link menu-title" href="${CONTEXT_PATH}/schd/calendar">
                  			<i data-feather="calendar"></i>
                  			<span>일정관리</span>
                  		</a>
					</li>
					
					<!-- 상담 -->
					<li class="dropdown">
	                  	<a class="nav-link menu-title" href="${CONTEXT_PATH}/cslrcd/cslrcdSub">
	                  		<i data-feather="clock"></i>
	                  		<span>상담</span>
	                  	</a>
	                  	<!-- 드롭다운 메뉴 -->
	                    <ul class="nav-submenu menu-content">
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/cslrcd/cslrcdSub">상담조회<span class="sub-arrow"></span></a>
	                      </li>
                        </ul>	                      
					</li>
	
					<!-- 내학생관리 -->
					<li class="dropdown">
	                  	<a class="nav-link menu-title" href="javascript:void(0)">
	                  		<i data-feather="users"></i>
	                  		<span>내학생관리</span>
	                  	</a>
	                  	<!-- 드롭다운 메뉴 -->
	                    <ul class="nav-submenu menu-content">
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/student/list">정보관리<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/atdManagement/main">출결관리<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/msg/teacher/page">메시지(MMS)발송<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/msg/teacher/list">메시지(MMS)내역<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                    </ul>
					</li>
	
					<!-- 강의 관리 -->
					<li class="dropdown">
						<a class="nav-link menu-title" href="#">
							<i data-feather="book-open"></i>
							<span>내강의관리</span>
						</a>
						
	                  	<!-- 드롭다운 메뉴 -->
	                    <ul class="nav-submenu menu-content">
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/lecture/mylecture">내 강의 조회<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/crelecture/teacher">내 강의 계획서 등록<span class="sub-arrow"></span></a>
	                      </li>
	                    </ul>
					</li>

					<!-- 성적관리 -->
					<li class="dropdown">
						<a class="nav-link menu-title" href="${CONTEXT_PATH}/grdManagement/main">
							<i data-feather="list"></i>
							<span>성적관리</span>
						</a>
	                  	<!-- 드롭다운 메뉴 -->
					</li>
					
					<!-- 커뮤니티 게시판 관리 -->
					<li class="dropdown">
	                  	<a class="nav-link menu-title" href="javascript:void(0)">
	                  		<i data-feather="clipboard"></i>
	                  		<span>게시판 관리</span>
	                  	</a>
	                  	<!-- 드롭다운 메뉴 -->
	                    <ul class="nav-submenu menu-content">
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/notice/main">공지사항게시판<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/freeboard/main">자유게시판<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/qna">Q&amp;A<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                    </ul>
					</li>
					
					<!-- 시설대여 -->
					<li class="dropdown">
						<a class="nav-link menu-title" href="${CONTEXT_PATH}/fac/main">
							<i data-feather="archive"></i>
							<span>시설대여</span>
						</a>
					</li> 
                  
                  	<!-- 문서관리 -->
					<li class="dropdown">
						<a class="nav-link menu-title" href="javascript:void(0)">
							<i data-feather="file-text"></i>
							<span>결재문서관리</span>
						</a>
						
	                  	<!-- 드롭다운 메뉴 -->
	                     <ul class="nav-submenu menu-content">
	                      <li>
	                      	<a class="submenu-title" href="javascript:void(0)">기안문 작성<span class="sub-arrow"></span></a>
	                      	 <ul class="nav-submenu menu-content">
	                      		<li>
	                      			<a class="submenu-title" href="${CONTEXT_PATH }/aprl/draftinPaper">&emsp;기안문 작성<span class="sub-arrow"></span></a>
	                      		</li>
	                      		<li>
	                      			<a class="submenu-title" href="${CONTEXT_PATH }/aprl/holidayPaper">&emsp;휴가 신청<span class="sub-arrow"></span></a>
	                      		</li>
	                      	 </ul>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH }/aprl/tmpbox">임시보관함<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH }/aprl/sendbox">보낸결재함<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH }/aprl/receivebox">받은결재함<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH }/aprl/line">결재선등록<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                      
	                    </ul>
					</li>                  
                  </sec:authorize>
<!-- 직원 -->                  
<sec:authorize access="hasRole('EMPLOYEE')">
 					<!-- 마이페이지 -->
					<li class="dropdown">
	                  	<a class="nav-link menu-title" href="${CONTEXT_PATH}/mypage/main">
	                  		<i data-feather="user"></i>
	                  		<span>마이페이지</span>
	                  	</a>
					</li>
					
					<!-- 일정관리 -->
					<li class="dropdown">
	                  	<a class="nav-link menu-title" href="${CONTEXT_PATH}/schd/calendar">
	                  		<i data-feather="calendar"></i>
	                  		<span>일정관리</span>
	                  	</a>
					</li>
					
					<!-- 상담 -->
					<li class="dropdown">
	                  	<a class="nav-link menu-title" href="javascript:void(0)">
	                  		<i data-feather="clock"></i>
	                  		<span>상담</span>
	                  	</a>
	                  	<!-- 드롭다운 메뉴 -->
	                    <ul class="nav-submenu menu-content">
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/cslrcd/cslrcdList">상담신청관리<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/cslrcd/cslrcdSub">상담결과관리<span class="sub-arrow"></span></a>
	                      </li>
	                    </ul>
					</li>
	
					<!-- 회원 관리 -->
					<li class="dropdown">
	                  	<a class="nav-link menu-title" href="javascript:void(0)">
	                  		<i data-feather="users"></i>
	                  		<span>회원관리</span>
	                  	</a>
	                  	<!-- 드롭다운 메뉴 -->
	                    <ul class="nav-submenu menu-content">
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/student/join">학생추가<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/student/list">학생정보관리<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/employee/join">교직원추가<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/employee/list">교원 및 직원 정보관리<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/msg/employee/page">메시지(MMS)발송<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/msg/employee/list">메시지(MMS)내역<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>	                      
	                    </ul>
					</li>
					
					<!-- 성적관리 -->
					<li class="dropdown">
						<a class="nav-link menu-title" href="javascript:void(0)">
							<i data-feather="feather"></i>
							<span>성적조회</span>
						</a>
					</li>
	
					<!-- 강의 관리 -->
					<li class="dropdown">
						<a class="nav-link menu-title" href="#">
							<i data-feather="book-open"></i>
							<span>전체강의관리</span>
						</a>
						
	                  	<!-- 드롭다운 메뉴 -->
	                    <ul class="nav-submenu menu-content">
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/lecture/management">전체 강의 조회<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/crelecture/employee">강의 등록<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/subject/list">과목 등록<span class="sub-arrow"></span></a>
	                      </li>
<!-- 	                      <li> -->
<!-- 	                      	<a class="submenu-title" href="javascript:void(0)">전체 시험 조회<span class="sub-arrow"></span></a> -->
<!-- 	                      </li> -->
<!-- 	                      <li> -->
<!-- 	                      	<a class="submenu-title" href="javascript:void(0)">강의 영상 조회<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a> -->
<!-- 	                      </li> -->
	                    </ul>
					</li>

					<!-- 수납관리 -->	
					<li class="dropdown">
						<a class="nav-link menu-title" href="${CONTEXT_PATH }/empSignup/paymentHistory">
							<i data-feather="dollar-sign"></i>
							<span>결제관리</span>
						</a>
					</li> 
					
                  	<!-- 문서관리 -->
					<li class="dropdown">
						<a class="nav-link menu-title" href="javascript:void(0)">
							<i data-feather="file-text"></i>
							<span>결재문서관리</span>
						</a>
						
	                  	<!-- 드롭다운 메뉴 -->
	                    <ul class="nav-submenu menu-content">
	                      <li>
	                      	<a class="submenu-title" href="javascript:void(0)">기안문 작성<span class="sub-arrow"></span></a>
	                      	 <ul class="nav-submenu menu-content">
	                      		<li>
	                      			<a class="submenu-title" href="${CONTEXT_PATH }/aprl/draftinPaper">&emsp;기안문 작성<span class="sub-arrow"></span></a>
	                      		</li>
	                      		<li>
	                      			<a class="submenu-title" href="${CONTEXT_PATH }/aprl/holidayPaper">&emsp;휴가 신청<span class="sub-arrow"></span></a>
	                      		</li>
	                      	 </ul>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH }/aprl/tmpbox">임시보관함<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH }/aprl/sendbox">보낸결재함<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH }/aprl/receivebox">받은결재함<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH }/aprl/line">결재선등록<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                      
	                    </ul>
					</li>
					              					
					<!-- 학원관리 -->
					<li class="dropdown">
	                  	<a class="nav-link menu-title" href="${CONTEXT_PATH}/fac/main">
	                  		<i data-feather="archive"></i>
	                  		<span>시설대여관리</span>
	                  	</a>
	                  	<!-- 드롭다운 메뉴 -->
<!-- 	                    <ul class="nav-submenu menu-content"> -->
<!-- 	                      <li> -->
<%-- 	                      	<a class="submenu-title" href="${CONTEXT_PATH}/fac/main">시설대여관리<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a> --%>
<!-- 	                      </li> -->

<!-- 	                    </ul> -->
					</li>
	
					<!-- 커뮤니티 게시판 관리 -->
					<li class="dropdown">
	                  	<a class="nav-link menu-title" href="javascript:void(0)">
	                  		<i data-feather="clipboard"></i>
	                  		<span>게시판 관리</span>
	                  	</a>
	                  	<!-- 드롭다운 메뉴 -->
	                    <ul class="nav-submenu menu-content">
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/notice/main">공지사항게시판<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/freeboard/main">자유게시판<span class="sub-arrow"></span></a>
	                      </li>
	                      <li>
	                      	<a class="submenu-title" href="${CONTEXT_PATH}/qna">Q&amp;A<span class="sub-arrow"><i class="fa fa-chevron-right"></i></span></a>
	                      </li>
	                    </ul>
					</li>
                  </sec:authorize>                  
                  
</sec:authorize>
                </ul>
              </div>
            </div>
          </nav>
        </header>
<!-- Page Sidebar Ends-->
