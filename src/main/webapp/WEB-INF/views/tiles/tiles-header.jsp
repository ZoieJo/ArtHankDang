<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>


     <!-- Page Header Start-->
      <div class="page-main-header" id="headerDisp">
        <div class="main-header-right row m-0">
        
        <!-- 아트학당 로고 넣을 곳(헤더 맨 왼쪽 빈 공간) -->
          <div class="main-header-left">
            <div class="logo-wrapper"><a href="${CONTEXT_PATH}/"><img class="img-fluid" src="${RESOURCES_PATH}/logo/favicon-32x32.png" alt="">아트학당</a></div>
            
            <div class="dark-logo-wrapper"><a href="${CONTEXT_PATH}/"><img class="img-fluid" src="${RESOURCES_PATH}/assets/images/logo/icon-logo.png" alt=""></a></div>
            
            <div class="toggle-sidebar"><i class="status_toggle middle" data-feather="align-center" id="sidebar-toggle"></i></div>
            
          </div>
          
          <!-- 헤더 맨 오른쪽 로고 모여 있는 곳임당~~-->
          <div class="nav-right col pull-right right-menu p-0">
            <ul class="nav-menus">

              <!-- 로그인 버튼 -->
              <li class="onhover-dropdown p-0">
                <button class="btn btn-primary-light" type="button">
	                <a href="${CONTEXT_PATH}/login">
	                <i data-feather="log-in"></i>Log in</a>
                </button>
              </li>
              
              
            </ul>
          </div>
          
          <div class="d-lg-none mobile-toggle pull-right w-auto"><i data-feather="more-horizontal"></i></div>
        </div>
      </div>
      <!-- Page Header Ends ============================================================================= -->