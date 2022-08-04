<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
body{
	width:100%;
	height:100vh;
}
#cursModal {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
#modalBody li{
	margin: 10px;
	font-size: 18px;
}
</style>

<!-- 머리 -->
<div class="container-fluid">
	<div class="page-header" style="padding: 20px 0px;">
		<div class="row">
			<div class="col-sm-6">
				<h3>개설강의</h3>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
					<li class="breadcrumb-item">강의</li>
					<li class="breadcrumb-item active">개설강의</li>
				</ol>
			</div>
		</div>
	</div>
</div>
<!-- 몸통 시작 -->
<div class="container-fluid blog-page">
	<div class="row">

	<!-- 모달 -->
	<div id="cursModal" class="modal fade" style="display:none; padding-right:17px;" aria-modal="true" role="dialog">
	    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <div class="product-box row">
	                    <div class="product-img col-lg-6">
	                    	<img class="img-fluid" id="id_disp"  style="text-align:center; width:400px; height:370px;" src="" alt="">
	                    </div>
	                    <div class="product-details col-lg-6 text-start">
	                    	<a href="#" data-bs-original-title="" title="" style="border-bottom: 1px solid grey;">
	                            <h5>강의정보 상세보기</h5>
	                        </a>
	                        <div class="product-view" id="modalBody"></div>
	                    </div>
	                </div>
	                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close" data-bs-original-title="" title=""></button>
	            </div>
	        </div>
	    </div>
	</div>
	
		<!-- 개설된 강의 생성 -->
		<c:forEach var="item" items="${leclist}">
		<div class="col-sm-6 col-xl-3 box-col-6 des-xl-50" onclick="goDetail('${item.cursNo}')">
			<div class="card">
				<div class="blog-box blog-grid">
					<!-- 썸네일 -->
					<div class="blog-wrraper" style="cursor:pointer;">
						<img class="img-fluid top-radius-blog" src="${CONTEXT_PATH}${item.attchPath}" alt="강의썸네일" style="height:170px;">
					</div>
					
					<!-- 강의 제목 및 간단한 설명 -->
					<div class="blog-details-second" style="cursor:pointer; height: 300px; overflow: hidden;">
						<h6 class="blog-bottom-details" style="margin-top:10px;">[${item.subNm}] ${item.cursNm}</h6>
						<p>${item.curspnCnt}</p>
					</div>
				</div>
			</div>
		</div>
		</c:forEach>
		
	</div>
</div>
<!-- 몸통 끝 -->

<script type="text/javascript">

function goDetail(p_no){
	
	const url = '${CONTEXT_PATH}/opensu/sulist';
	
	let xhr = new XMLHttpRequest();
	xhr.open("post", url, true)
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			// console.log(xhr.responseText);
			let data = JSON.parse(xhr.responseText);
			console.log(data);

			
			let code = '';
			code += `<ul style="margin: 20px 0px 20px 0px;"><li>`;
			code += '<h6>['+ data[0].subNm + '] ' + data[0].cursNm + '</h6>';
			code += `</li><li>강사 : `;
			code += data[0].empNm + `</li><li>인원 : `;
			code += data[0].cursSuNum + ` 명</li><li>시작날짜 : `;
			code += data[0].cursSttDt + `</li><li>종료날짜 : `;
			code += data[0].cursEndDt + `</li><li>수업요일 : `;
			let day = '';
			for(let i=0; i < data.length; i++){
				switch (data[i].cursDay) {
				  case '1':
				    day += "월";
				    break;
				  case '2':
				    day += "화";
				    break;
				  case '3':
				     day += "수";
				    break;
				  case '4':
				    day += "목";
				    break;
				  case '5':
				    day += "금";
				    break;
				  case '6':
				    day += "토";
				    break;
				  case '7':
				    day += "일";
				    break;
				}
				if(i!=data.length-1){
					day += ", ";
				}
				if(i==data.length-1){document.querySelector("#id_disp").src = "${CONTEXT_PATH}" + data[i].attchPath;}
			}
			console.log(day);
			code +=  day + `</li><li>시간 : `;
			if(data[0].cursSttMm == '0' ){data[0].cursSttMm = '00';}
			if(data[0].cursEndMm == '0' ){data[0].cursEndMm = '00';}
			code += data[0].cursSttHh + ':' + data[0].cursSttMm + ' ~ ' + data[0].cursEndHh +':' + data[0].cursEndMm + '</li></ul>';			
			
			document.querySelector('#modalBody').innerHTML = code;
			$('#cursModal').modal('show');
		}
	}
	xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.send("cursNo="+p_no);
	
	
}

</script>
