<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
h3 {
	font-family: ngB;
}
</style>

<div class="container-fluid">
	<div class="page-header" style="padding: 20px 0px 20px 0px;">
		<div class="row">
			<div class="col-sm-6">
				<h3>조직도</h3>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
					<li class="breadcrumb-item">아트학당소개</li>
					<li class="breadcrumb-item">조직도</li>
				</ol>
			</div>
		</div>
	</div>
</div>

<!-- 조직도 시작 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-sm-12">
			<div class="card">
				<!-- 조직도 그리기 -->
				<div id="orgChartContainer">
					<div id="orgChart" class="text-center container-fluid">
							<br><br><br>
						<img class="img-fluid"
							src="../resources/image/tree.jpg"
							alt="Grapefruit slice atop a pile of other slices">
							<br><br><br>
							
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 조직도 끝 -->
