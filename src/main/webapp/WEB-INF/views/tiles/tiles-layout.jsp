<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- 공통변수 처리 -->
<c:set var="CONTEXT_PATH" value="${pageContext.request.contextPath}" scope="application" />
<c:set var="RESOURCES_PATH" value="${CONTEXT_PATH}/resources" scope="application" />
<sec:authentication var="USER" property="principal" scope="request"/> 
<sec:authorize access="isAuthenticated()">
<c:set var="USERNAME" value="${USER.username}" scope="request"/>
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="keywords" content="admin template, viho admin template, dashboard template, flat admin template, responsive admin template, web app">
<meta name="author" content="pixelstrap">
<link rel="icon" href="${RESOURCES_PATH}/logo/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="${RESOURCES_PATH}/logo/favicon.ico" type="image/x-icon">

<!-- Font Awesome-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/fontawesome.css">
<!-- ico-font-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/icofont.css">
<!-- Themify icon-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/themify.css">
<!-- Flag icon-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/flag-icon.css">
<!-- Feather icon-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/feather-icon.css">
<!-- Plugins css start-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/prism.css">
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/tree.css">
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/owlcarousel.css">
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/datatables.css">
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/datatable-extension.css">
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/animate.css">
<!-- Plugins css Ends-->

<!-- Bootstrap CSS-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/bootstrap.css">
<!-- APP CSS-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/style.css">

<sec:authorize access="hasRole('TEACHER')">
	<link id="color" rel="stylesheet" href="${RESOURCES_PATH}/assets/css/color-3.css" media="screen">
</sec:authorize>
<sec:authorize access="hasRole('EMPLOYEE')">
	<link id="color" rel="stylesheet" href="${RESOURCES_PATH}/assets/css/color-6.css" media="screen">	
</sec:authorize>
<sec:authorize access="hasRole('STUDENT')">
	<link id="color" rel="stylesheet" href="${RESOURCES_PATH}/assets/css/color-1.css" media="screen">
</sec:authorize>
<sec:authorize access="isAnonymous()">
	<link id="color" rel="stylesheet" href="${RESOURCES_PATH}/assets/css/color-1.css" media="screen">
</sec:authorize>
<!-- Responsive CSS-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/responsive.css">
<!-- 공통 CSS -->
<link href="${RESOURCES_PATH}/css/style.css" rel="stylesheet" type="text/css">
<!-- sweet alert2 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<!-- jquery timepicker css -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<!-- jquery datepicker css -->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/date-picker.css">
<!-- latest jQuery-->
<script src="${RESOURCES_PATH}/assets/js/jquery-3.5.1.min.js"></script>

<script type="text/javascript">
	var CONTEXT_PATH = "${CONTEXT_PATH}";
	var RESOURCES_PATH = "${RESOURCES_PATH}";
</script>
<title><tiles:insertAttribute name="title" /></title>
<style type="text/css">
.ltr{
	font-family: ngB;
 }
</style>
</head>

<body class="ltr">
	
	<!-- page-wrapper Start-->
	<div class="page-wrapper compact-wrapper" id="pageWrapper">
		<tiles:insertAttribute name="header" />
		
		<div class="page-body-wrapper horizontal-menu">
			<tiles:insertAttribute name="left" />
			<div class="page-body">
				<tiles:insertAttribute name="body" />
			</div>

			<tiles:insertAttribute name="footer" />
		</div>
	</div>
	<!-- fontawesome -->
	<script src="https://kit.fontawesome.com/2c827c8cca.js" crossorigin="anonymous"></script>
	<!-- feather icon js-->
	<script src="${RESOURCES_PATH}/assets/js/icons/feather-icon/feather.min.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/icons/feather-icon/feather-icon.js"></script>
	<!-- Sidebar jquery-->
	<script src="${RESOURCES_PATH}/assets/js/sidebar-menu.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/config.js"></script>
	<!-- Bootstrap js-->
	<script src="${RESOURCES_PATH}/assets/js/bootstrap/popper.min.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/bootstrap/bootstrap.min.js"></script>
	
	
	<!-- Plugins JS start-->
	<script src="${RESOURCES_PATH}/assets/js/prism/prism.min.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/clipboard/clipboard.min.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/custom-card/custom-card.js"></script>
	<!-- js트리 -->
	<script src="${RESOURCES_PATH}/assets/js/tree/jstree.min.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/tree/tree.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/form-wizard/form-wizard-two.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/form-wizard/jquery.backstretch.min.js"></script>
	<!-- owl -->
	<script src="${RESOURCES_PATH}/assets/js/owlcarousel/owl.carousel.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/owlcarousel/owl-custom.js"></script>
	<!-- 알림 -->
    <script src="${RESOURCES_PATH}/assets/js/notify/bootstrap-notify.min.js"></script>
    <script src="${RESOURCES_PATH}/assets/js/notify/notify-script.js"></script>
    
    <script src="${RESOURCES_PATH}/assets/js/icons/icons-notify.js"></script>
    <script src="${RESOURCES_PATH}/assets/js/icons/icon-clipart.js"></script>
    
	<script src="${RESOURCES_PATH}/assets/js/tooltip-init.js"></script>
	
	<!-- 레이팅-->
	<script src="${RESOURCES_PATH}/assets/js/rating/rating-script.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/rating/jquery.barrating.js"></script>
	
	<!-- js 그리드 테이블 -->
	<script src="${RESOURCES_PATH}/assets/js/jsgrid/griddata.js"></script>
<%-- 	<script src="${RESOURCES_PATH}/assets/js/jsgrid/jsgrid.js"></script> --%>
	<script src="${RESOURCES_PATH}/assets/js/jsgrid/jsgrid.min.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/icons/icon-clipart.js"></script>


	
	<!-- Theme js-->
	<script src="${RESOURCES_PATH}/assets/js/script.js"></script>
	
	<!-- sweet alert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>


<script type="text/javascript">
console.log("${USERNAME}");
</script>
</body>
</html>