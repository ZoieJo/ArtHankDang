<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ypytjrc59c"></script>

<style>
#img{font-size: 18px; margin-left: 25px;}
span{color: grey;}
</style>

<div class="container-fluid">
	<div class="page-header" style="padding: 20px 0px 20px 0px;">
		<div class="row">
			<div class="col-sm-6">
				<h3>오시는 길</h3>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
					<li class="breadcrumb-item">아트학당소개</li>
					<li class="breadcrumb-item">오시는 길</li>
				</ol>
			</div>
		</div>
	</div>
</div>

<div class="col-xl-12">
    <div class="card" style="height: 800px;">
        <div class="card-header pb-0">
            <span>아트학당의 위치입니다. 주차장은 건물 지하에 있습니다.</span>
        </div>
        <div class="card-body">
			<div id="map" style="width:100%;height:400px;"></div>
			<hr>
		    <div id="img">
		    	<i class="icofont icofont-location-pin">&nbsp;대전광역시 중구 계룡로 846, 3층</i>
		    	<br><br>            
				<i class="icofont icofont-ui-dial-phone">&nbsp;042-222-8202</i>
				<br><br>   
				<i class="icofont icofont-bus-alt-1">&nbsp;서대전네거리역 4번 출구, 오룡역 1번 출구</i>
				<br><br>
				<i class="icofont icofont-bus-alt-2">&nbsp;101번, 103번, 315번, 603번, 614번, 618번</i>
			</div>       
       </div>
    </div>
</div>

<script>
var mapOptions = {
    center: new naver.maps.LatLng(36.325128, 127.4087175),
    zoom: 17
};
var map = new naver.maps.Map('map', mapOptions);

var marker = new naver.maps.Marker({
    position: new naver.maps.LatLng(36.325128, 127.4087175),
    map: map
});
</script>