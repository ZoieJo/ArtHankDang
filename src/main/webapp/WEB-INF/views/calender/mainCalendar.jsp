<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- fullCalendar -->
<link href="${RESOURCES_PATH}/assets/fullcalendar/lib/main.css" rel='stylesheet'>
<script src="${RESOURCES_PATH}/assets/fullcalendar/lib/main.js"></script>

<style>
#calendar {	height: 85%; margin-top: 5%; margin-bottom: 10%;}
#c1 {color: #16a085;}
#c2 {color: #8e44ad;}
#c3 {color: #dfe4ea;}
#c4 {color: #ee5253;}
#c5 {color: #f1c40f;}
</style>

<!-- 칼라 :  개인일정 - #16a085(초록)  /  공통일정 - #8e44ad(보라)   / 기타일정 - #dfe4ea(회색)    / 공휴일 - #ee5253(빨강)  / 상담일정 - #f1c40f(노랑) -->
<div class="col-sm-12">
	<div class="card">
		<div class="card-header">
			<input type="button"  id="id_day" class="btn btn-pill btn-primary btn-air-primary" value="일정 등록"  onclick="dayInput()">	
			<div align="right">
			<i id="c1" class="fa fa-circle" style="margin-right: 35px">&nbsp;<font style="vertical-align: inherit; color: black;">개인일정</font></i>
			<i id="c2" class="fa fa-circle" style="margin-right: 35px">&nbsp;<font style="vertical-align: inherit; color: black;">학원일정</font></i>
			<i id="c3" class="fa fa-circle" style="margin-right: 35px">&nbsp;<font style="vertical-align: inherit; color: black;">기타일정</font></i>
			<i id="c4" class="fa fa-circle" style="margin-right: 35px">&nbsp;<font style="vertical-align: inherit; color: black;">공휴일</font></i>
			<i id="c5" class="fa fa-circle">&nbsp;<font style="vertical-align: inherit; color: black;">상담일정</font></i>
			</div>
			<div id="calendar" style="max-width: 1500px;">
			</div>			
		</div>
	</div>
</div>


<script type="text/javascript">
const tokenHeader = '${_csrf.headerName}';
const tokenValue = '${_csrf.token}';
const calendarEl = document.getElementById('calendar');
const bColors = ['#16a085','#8e44ad','#dfe4ea','#ee5253', '#f1c40f'];
const tColors = ['white','white','black', 'white', 'black'];
var calendar;



document.addEventListener('DOMContentLoaded', function() {	
	
	
//Ajax 방식  일정 리스트
	let evtDatas =[];
 	let xhr = new XMLHttpRequest();
 	xhr.open("get", "${pageContext.request.contextPath}/schd/callist", true);
 	xhr.onreadystatechange = function(){
 		if(xhr.readyState == 4 && xhr.status ==200){
 			let recDatas=JSON.parse(xhr.responseText);
 			console.log(recDatas);
 			for(var i=0; i<recDatas.length; i++){
 				let evt = {};
 				evt.title = recDatas[i].schdTl;
 				evt.start = recDatas[i].schdSttDt;
  				evt.end = recDatas[i].schdEndDt;
  				evt.id = recDatas[i].schdNo
 				evt.backgroundColor= bColors[parseInt(recDatas[i].schdCmcd.substr(3,2))-1];	 	 				
	 	 		evt.textColor=tColors[parseInt(recDatas[i].schdCmcd.substr(3,2))-1];	
	 	 		evt.borderColor=bColors[parseInt(recDatas[i].schdCmcd.substr(3,2))-1];
				
 			 				
 				evtDatas.push(evt);
 			}
 			
 			
//Calendar 설정 
 			calendar = new FullCalendar.Calendar(calendarEl, {
 			headerToolbar: {
 				left: 'prev,next today',
 				center: 'title',
 				right: 'dayGridMonth'
 				}, 				
 				events:evtDatas,
 				navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
 				nowIndicator: true, // 현재 시간 마크
 				dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
 				locale: 'ko', // 한국어 설정
 				eventClick : function(event){
// 					console.log("넘어오지?");
					console.log(event.event.id);					
 					window.open("${pageContext.request.contextPath}/schd/calendar/update?username=${USERNAME}&schdNo="+event.event.id, "_blank", "width=550, height=415, top=200");
				} 				
 			});
 			calendar.render(); 			
 		} 
 	} 			
 	xhr.setRequestHeader(tokenHeader, tokenValue);
 	xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
 	xhr.send(); 
});



//일정추가 버튼 + 버튼 모달?
function dayInput() {
	window.open("${pageContext.request.contextPath}/schd/calendar/write?username=${USERNAME}", "_blank", "width=550, height=415, top=200");
}
</script>


