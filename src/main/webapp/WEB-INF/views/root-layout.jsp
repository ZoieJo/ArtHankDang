<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>

<!-- 공통변수 처리 -->
<c:set var="CONTEXT_PATH" value="${pageContext.request.contextPath}" scope="application" />
<c:set var="RESOURCES_PATH" value="${CONTEXT_PATH}/resources" scope="application" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="keywords" content="admin template, viho admin template, dashboard template, flat admin template, responsive admin template, web app">
<meta name="author" content="pixelstrap">
<link rel="icon" href="${RESOURCES_PATH}/logo/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="${RESOURCES_PATH}/logo/favicon.ico" type="image/x-icon">
	
<!-- Google font-->
<!-- <link rel="preconnect" href="https://fonts.gstatic.com"> -->
<!-- <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap" rel="stylesheet"> -->
<!-- <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&amp;display=swap" rel="stylesheet"> -->
<!-- <link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap" rel="stylesheet"> -->

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
<!-- Plugins css Ends-->
<!-- Bootstrap css-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/bootstrap.css">
<!-- App css-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/style.css">
<link id="color" rel="stylesheet" href="${RESOURCES_PATH}/assets/css/color-1.css" media="screen">
<!-- Responsive css-->
<link rel="stylesheet" type="text/css" href="${RESOURCES_PATH}/assets/css/responsive.css">
<!-- 공통 CSS -->
<%-- <link href="${RESOURCES_PATH}/css/style.css" rel="stylesheet" type="text/css"> --%>
<!-- root-layout CSS -->
<script type="text/javascript">
	var CONTEXT_PATH = "${CONTEXT_PATH}";
	var RESOURCES_PATH = "${RESOURCES_PATH}";
</script>
<title><tiles:insertAttribute name="title" /></title>
</head>

<body class="">
	<!-- page-wrapper Start-->
	<div class="page-wrapper" id="pageWrapper">

			<div class="page-body">
			<div class="area">
					<ul class="circles">
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
					</ul>
				</div>
				<tiles:insertAttribute name="body" />
				
			</div>
	</div>

	<!-- latest jquery-->
	<script src="${RESOURCES_PATH}/assets/js/jquery-3.5.1.min.js"></script>
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
	<script src="${RESOURCES_PATH}/assets/js/tree/jstree.min.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/tree/tree.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/form-wizard/jquery.backstretch.min.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/owlcarousel/owl.carousel.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/owlcarousel/owl-custom.js"></script>
	<script src="${RESOURCES_PATH}/assets/js/tooltip-init.js"></script>
	<!-- Plugins JS Ends-->

	<!-- Theme js-->
	<script src="${RESOURCES_PATH}/assets/js/script.js"></script>
</body>
</html>