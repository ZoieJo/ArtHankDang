<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl.carousel.js"></script>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl-custom.js"></script>

<style>
#j_img1{width: 88%;}
#owl-carousel-14{width: 30%; float: right;  margin-right: -3%;}
div.owl-dots{display: none;}
.owl-carousel .owl-item img {
    display: block;
    height: 850px;
 }
</style>	
			
<!------------------------------------------------------------- 상담내역 ------------------------------------------------------------->

<c:set var="tblPath" value="{pageContext.request.contextPath}" />							
<c:set var="curPage" value="${pageDTO.cslrgPageCondDTO.pageNum}" />
<c:set var="pageSize" value="${pageDTO.cslrgPageCondDTO.pageSize}" />
<c:set var="keyword" value="${pageDTO.cslrgPageCondDTO.keyword}"/>

<!------------------------------------------------------------- 상담내역 ------------------------------------------------------------->



<div class="col-sm-12">
<h3>상담신청 관리</h3>
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="${CONTEXT_PATH}" data-bs-original-title="아트학당" title="아트학당">홈</a></li>
		<li class="breadcrumb-item active">상담관리</li>	
	</ol>
	<div  class="owl-carousel owl-theme owl-loaded owl-drag" id="owl-carousel-14" >
		<div class="owl-stage-outer owl-height">
			<div class="owl-stage" style="transition: all 0.25s ease 0s;">				
				<div id="id_owl" class="owl-item">
					<div class="item" style="">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample1.png" >
					</div>
				</div>	
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample2.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample3.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample4.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample5.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample6.png" >
					</div>
				</div>
			</div>
		</div>
	</div>	
	<div class="card" style="width: 70%;  height: 870px;">
		<div class="card-body">
		<button id="btn1"  class="btn btn-pill btn-primary" disabled  style="width: 100px; height: 40px; align-items:center; float:right;"  onclick="clickCsl()" >승인</button>
			<div id="basic-1_wrapper" class="dataTables_wrapper no-footer">					
			<br>
				<table class="display dataTable no-footer" id="basic-2" role="grid" aria-describedby="basic-1_info" style="text-align: center">
					<thead>
						<tr role="row">
							<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1"  style="width: 5%;">
								<font style="vertical-align: inherit;">NO</font>
							</th>
							<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1"  style="width: 20%;">
							<font style="vertical-align: inherit;">상담일</font>
							</th>
							<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1"   style="width: 15%;">
							<font style="vertical-align: inherit;">상담시간</font>
							</th>
							<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1"  style="width: 15%;">
							<font style="vertical-align: inherit;">상담구분</font>
							</th>							
							<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1"  style="width: 15%;">
							<font style="vertical-align: inherit;">상담현황</font>
							</th>
							<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1"   style="width: 10%;">
							<font style="vertical-align: inherit;">승인</font>
							</th>							
						</tr>
					</thead>
	
					<tbody>
						<c:forEach items="${allList}" var="cslrgStr">																																			
						<tr role="row" class="even" >									
							<td id="id_no"	 class="sorting_1" onclick="location.href='${CONTEXT_PATH}/cslrg/detail?cslrgNo=${cslrgStr.cslrgNo}'">${cslrgStr.cslrgNo}
								<input id="cslEmpId" type="hidden" name="empId" value="${USERNAME}" >								
								<input id="cslStuId" type="hidden" name="stuId" value="${cslrgStr.stuId}" >
							</td>
							<td id="id_date" onclick="location.href='${CONTEXT_PATH}/cslrg/detail?cslrgNo=${cslrgStr.cslrgNo}'"><fmt:formatDate value="${cslrgStr.cslrgRsvDt}"  pattern="yyyy-MM-dd"/></td>
							<td id="id_time" onclick="location.href='${CONTEXT_PATH}/cslrg/detail?cslrgNo=${cslrgStr.cslrgNo}'"><font style="vertical-align: inherit;">${cslrgStr.cslrgRsvTm}</font></td>
							<td id="id_ti" 	onclick="location.href='${CONTEXT_PATH}/cslrg/detail?cslrgNo=${cslrgStr.cslrgNo}'"><font style="vertical-align: inherit;">${cslrgStr.cslFdCmcd}</font></td>
								<c:if test="${cslrgStr.cslStCmcd=='신청중'}">
									<td id="id_stCmcd" style="color: white; background: #d74654;">${cslrgStr.cslStCmcd}</td>
								</c:if>
								<c:if test="${cslrgStr.cslStCmcd=='신청완료'}">
									<td id="id_stCmcd" style="color: white; background: #e4ca43;;">${cslrgStr.cslStCmcd}</td>
								</c:if>
								<c:if test="${cslrgStr.cslStCmcd=='상담완료'}">
									<td id="id_stCmcd" style="color: white; background: #3db39d;">${cslrgStr.cslStCmcd}</td>
								</c:if>
								<td>							
								<font style="vertical-align: inherit;"><input class="chk1" type="checkbox" style="width: 20px;" height="20px;" onclick="chkBtn(this)" value="${cslrgStr.cslrgNo}" ></font>						
							</td>
						</tr>								
						</c:forEach>
						
					</tbody>					
				</table>			
<div id="pageDiv">
	<form id="id_pageForm" action="${CONTEXT_PATH}/cslrcd/cslrcdList">
		<input type="hidden" name="pageNum" value="">
		<input type="hidden" name="pageSize" value="">
		<input type="hidden" name="keyword" value="">
	</form>

	<nav aria-label="...">
		<ul class="pagination justify-content-center pagination-primary">

			<!-- 이전 버튼 -->
		<c:if test="${pageDTO.isPrevious() == true}">
			<li class="page-item"><a class="page-link" onclick="f_prev()" >이전</a></li>
		</c:if>
		<c:if test="${pageDTO.isPrevious() == false}">
		<!-- disable -->
			<li class="page-item disabled"><a class="page-link" onclick="f_prev()" >이전</a></li>
		</c:if>
		<!-- 페이지 넘버 버튼 -->
		<c:forEach var="pageNum" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
			<c:if test="${pageNum == curPage }">
				<li class="page-item active"><a class="page-link" onclick="f_sendPage('${pageNum}','${pageSize}')">${pageNum}<span class="sr-only">(current)</span></a></li>
			</c:if>
			<c:if test="${pageNum != curPage }">
				<li class="page-item"><a class="page-link" onclick="f_sendPage('${pageNum}','${pageSize}')">${pageNum}</a></li>
			</c:if>
		</c:forEach>
		<!-- 다음 버튼 -->
		<c:if test="${pageDTO.isNext() == true}">
			<li class="page-item"><a class="page-link" onclick="f_next('${pageDTO.endPage+1}')">다음</a></li>
		</c:if>
		<c:if test="${pageDTO.isNext() == false}">
		<!-- disable -->
			<li class="page-item disabled"><a class="page-link" onclick="f_next('${pageDTO.endPage+1}')">다음</a></li>
		</c:if>
        </ul>
    </nav>
</div>
			</div>
		</div>                                                                                            
	</div>
</div>




<script>


const pageForm = document.querySelector("#id_pageForm");

//페이지 숫자를 눌렀을 때 실행되는 함수
const f_sendPage = (p_pageNum, p_pageSize) =>{
	event.preventDefault();
	
	console.log("p_pageSize >>>>>>>> " + p_pageNum);
	console.log("p_pageSize >>>>>>>> " + p_pageSize);
	document.querySelector("input[name=pageNum]").value = p_pageNum;
	document.querySelector("input[name=pageSize]").value = p_pageSize;
	document.querySelector("input[name=keyword]").value = '${keyword}';
	pageForm.submit();
}

//이전 버튼을 클릭하였을 경우 실행되는 함수
const f_prev = () =>{
	document.querySelector("input[name=pageNum]").value = '${pageDTO.startPage - 1}';
	document.querySelector("input[name=pageSize]").value = '${pageSize}';
	document.querySelector("input[name=keyword]").value = '${keyword}';
	pageForm.submit();
}

//다음 버튼을 클릭하였을 경우 실행되는 함수
const f_next = (p_nextPageNum) => {
	document.querySelector("input[name=pageNum]").value = p_nextPageNum;
	document.querySelector("input[name=pageSize]").value = '${pageSize}';
	document.querySelector("input[name=keyword]").value = '${keyword}';
	pageForm.submit();
}



//토큰 설정
const tokenHeader = '${_csrf.headerName}';
const tokenValue = '${_csrf.token}';

//수정데이터 받아오기
const cdSts = document.querySelectorAll("#id_stCmcd");
const st = document.querySelectorAll("#id_ti");
const emps = document.querySelectorAll("#cslEmpId");

//체크박스 선택시, 승인버튼 생성
const chkBoxs = document.querySelectorAll(".chk1");
const target = document.querySelector("#btn1");

//값 가져오기!!
let no = document.querySelectorAll("#id_no");	
let date = document.querySelectorAll("#id_date");
let time = document.querySelectorAll("#id_time");
let ti = document.querySelectorAll("#id_ti");
let cnt = document.querySelectorAll("#id_cnt"); 
let stu = document.querySelectorAll("#cslStuId");

for(let i=0; i<cdSts.length; i++){
	if(cdSts[i].innerText=="신청완료"){
		chkBoxs[i].disabled = true;
		
	}if(cdSts[i].innerText=="상담완료"){
		chkBoxs[i].disabled = true;
	}
}

//체크박스 check시 버튼 활성화
let checkedCnt = 0;

var chkBtn =(p_this)=> {
	if(p_this.checked){
		checkedCnt++;
	}else{
		checkedCnt--;
	}
		
	if(checkedCnt>0){
		target.disabled = false;
		return;
	}
	target.disabled = true;	
}

//승인버튼 활성화시, 상담현황 업데이트 발생
const clickCsl = () => {
	
	var arrCslrgVO = [];
	
	for(var i=0; i<chkBoxs.length; i++){
		if(chkBoxs[i].checked){
			var cslrVO = {};
			cslrVO.cslrgNo = chkBoxs[i].value;
			cslrVO.cslFdCmcd = ti[i].innerText;
			cslrVO.cslStCmcd = cdSts[i].innerText;
			cslrVO.empId = emps[i].value;
			cslrVO.cslrgTl = ti[i].innerText;
			cslrVO.cslrgRsvDt = date[i].innerHTML;
			cslrVO.cslrgSttDt = date[i].innerHTML;
			cslrVO.stuId = stu[i].value;
			arrCslrgVO.push(cslrVO);				
		}		
	}

	console.log(arrCslrgVO);

	if(!arrCslrgVO.length){
		Swal.fire('체크해주시기 바랍니다.');
		return;
	}
	
	Swal.fire({
		title: '상담배정	',
		text: '상담을 배정하시겠습니까?',
		icon: 'warning',
		
		showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		confirmButtonText: '승인', // confirm 버튼 텍스트 지정
		cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		
		reverseButtons: false, //버튼 순서 거꾸로
		   
		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			   let xhr = new XMLHttpRequest();
		   	   xhr.open("post","${pageContext.request.contextPath}/cslrcd/updateCslrcd", true);		  
			   xhr.onreadystatechange = function(){
				   if(xhr.readyState == 4 && xhr.status==200){
				   Swal.fire('상담배정이 일정에 추가되었습니다.').then(result => {
					   
				   location.replace(location.href); //페이지 다시 로딩, DB값을 다시 읽어오기 위해성
                   });
				}
			}
			xhr.setRequestHeader(tokenHeader, tokenValue);
			xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
			xhr.send(JSON.stringify(arrCslrgVO));
		   }
		});
	}




// 배너설정
	$(".owl-carousel").owlCarousel({
		items : 1,
		center : true,
		loop : true,
		dots : true,
		autoplay : true,
		autoplayTimeout : 3000,
		autoplayHoverPause : true,
		rewind : false,
		mouseDrag : true,
		touchDrag : true,
		nav : false
	});
	$(window).on('load scroll resize', function() {
		setTimeout(function() {
			var w = $('.starter-main .owl-carousel.owl-loaded').css('width');
			$('.starter-main .owl-carousel .owl-item .item').css('width', w);
		}, 300);
	});


</script>




 

