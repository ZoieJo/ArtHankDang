<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#div_wrap{
	margin: 0;
	padding: 0;
}
#disp_err{
	position: absolute;
	top: 100px;
	left: 100px;
	font-family: ngEB;
 	background-color: white;
	padding: 50px;
	text-align: center;
	margin: 0 auto;
	
}
#errorImg{
	width: 500px;
	height: auto;
	margin: 10px;
}
#errorBtn {
	margin-top:10px;
	color: black;
}
#errorBtn:hover {
	color: white;
}
</style>

<div id="div_wrap">
	<div id="disp_err">
		<h2>${exception}</h2>
			<img data-mdb-animation-start="onHover"  data-mdb-animation-reset="true" data-mdb-toggle="animation" data-mdb-animation="fade-out-left"
			 id="errorImg" src="${RESOURCES_PATH }/image/제리.png" alt="에러발생">
		<a id="errorBtn" class="btn btn-warning btn-lg" href="${CONTEXT_PATH}/">홈페이지 처음으로...</a>
	</div>
</div>