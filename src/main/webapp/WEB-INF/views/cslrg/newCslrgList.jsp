<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl.carousel.js"></script>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl-custom.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<style>
#j_img1{width: 88%;}
#owl-carousel-14{width: 30%; float: right;  margin-right: -3%;}
div.owl-dots{display: none;}
#btn_su{display: inline-block; float: right; margin-right: 25%; margin-top: -35px;}
#bnt_ca{display: inline-block; float: right;}
#id_test{height: auto;}
.owl-carousel .owl-item img {
    display: block;
    height: 700px;
 }
</style>

<!------------------------------------------------------------- 상담내역 ------------------------------------------------------------->
<c:set var="curPage" value="${pageDTO.cslrgPageCondDTO.pageNum}" />
<c:set var="pageSize" value="${pageDTO.cslrgPageCondDTO.pageSize}" />
<c:set var="keyword" value="${pageDTO.cslrgPageCondDTO.keyword}"/>


<div class="col-sm-12">
	<h3>방문상담목록</h3>
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="${CONTEXT_PATH}" title="아트학당">홈</a></li>
		<li class="breadcrumb-item active">방문상담내역</li>
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
	
	<div class="card" style="width: 70%;">	
		<div class="card-body">
					
<!--글작성 버튼  -->
				<button class="btn btn-success" type="button" style="float: right; margin-bottom: 10px;" id="id_boardwrite"  title="상담신청">
					<i class="fa fa-pencil-square-o" aria-hidden="true" onclick="location.href='${CONTEXT_PATH}/newCslrg/write'"></i>
				</button>

				
			<div id="basic-1_wrapper" class="dataTables_wrapper no-footer">	
			
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
							<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1"   style="width: 12%;">
								<font style="vertical-align: inherit;">학생명</font>
							</th>
							<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1"  style="width: 15%;">
								<font style="vertical-align: inherit;">상담현황</font>
							</th>
						</tr>
					</thead>
	
				 	<tbody>				
					<c:forEach items="${cslrgList}" var="cslrgStr">		
						<tr role="row" class="even">							
							<td id="id_no" onclick="clrgRslt('${cslrgStr.cslrgNo}')" class="sorting_1">${cslrgStr.cslrgNo}</td>
							<td id="id_date" ><fmt:formatDate  value="${cslrgStr.cslrgRsvDt}"  pattern="yyyy-MM-dd"/></td>
							<td id="id_time" >${cslrgStr.cslrgRsvTm}</td>
							<td id="id_cmcd" >${cslrgStr.cslFdCmcd}</td>					
							<td id="id_stuNm" >${cslrgStr.cslrgNm}</td>
							<c:if test="${cslrgStr.cslStCmcd=='신청중'}">	
								<td id="id_stCmcd" style="color: white; background: #d74654;">${cslrgStr.cslStCmcd}</td>
							</c:if>
							<c:if test="${cslrgStr.cslStCmcd=='신청완료'}">	
								<td id="id_stCmcd" style="color: white; background:#e4ca43;">${cslrgStr.cslStCmcd}</td>
							</c:if>
							<c:if test="${cslrgStr.cslStCmcd=='상담완료'}">	
								<td id="id_stCmcd" style="color: white; background:#3db39d;">${cslrgStr.cslStCmcd}</td>
							</c:if>
						</tr>					
					</c:forEach>
					</tbody>		
				</table>
			</div>
		</div>		
	</div>
</div>

<div id="pageDiv">
	<form id="id_pageForm" action="${CONTEXT_PATH}/newCslrg/cslrdList">
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



<!-- 비밀번호 확인 모달창 생성  -->

<div onload="init()" class="modal fade show" id="exampleModalLabel" tabindex="-1" aria-labelledby="myLargeModalLabel" style="display: ; padding-right: 17px;" role="dialog" aria-modal="true" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div id="id_test" class="modal-header">
			
				<form class="theme-form login-form" action="/arthakdang/check" method="post">
	            	<h4>Password Check</h4>	            	
	            	<h6>비밀번호 확인이 필요한 페이지 입니다.</h6>
	                <div class="msgblock">
	                <!-- 로그인 알림메시지 블록 -->
	               	</div>
	                <div class="form-group">
	                   <label>비밀번호</label>
	                   <div class="input-group"><span class="input-group-text"><i class="icon-user"></i></span>
	                   		<input class="form-control" type="password" required="required" placeholder="****" name="password" >
	                   </div>
	                   <h6 style="margin-top: 8px; text-align: right;">방문상담신청시 작성한 비밀번호를 입력해주세요.</h6>
	                </div>
	                <br>
	                 <div class="form-group">
	                   <button id="btn_ca" class="btn btn-secondary btn-block" type="submit" onclick="location.reload()">취소</button>
	                   <button id="btn_su" class="btn btn-primary btn-block" type="submit">확인</button>
	                 </div>
	                 <input type="hidden" name="dir" value="cslrg">
	                 <input type="hidden" name="cslrgNo" id="id_cslrgNo" value="">
	                 <sec:csrfInput/>
	           </form>			
		  </div>
		  </div>
		</div>
	</div>

		



<script type="text/javascript">

//모달창클릭

const clrgRslt = (cslrgStr) => {
	document.querySelector("#id_cslrgNo").value = cslrgStr;
	$("#exampleModalLabel").modal('show');	
	
}


const pageForm = document.querySelector("#id_pageForm");

// 페이지 숫자를 눌렀을 때 실행되는 함수
const f_sendPage = (p_pageNum, p_pageSize) =>{
	event.preventDefault();
	
	console.log("p_pageSize >>>>>>>> " + p_pageNum);
	console.log("p_pageSize >>>>>>>> " + p_pageSize);
	document.querySelector("input[name=pageNum]").value = p_pageNum;
	document.querySelector("input[name=pageSize]").value = p_pageSize;
	document.querySelector("input[name=keyword]").value = '${keyword}';
	pageForm.submit();
}

// 이전 버튼을 클릭하였을 경우 실행되는 함수
const f_prev = () =>{
	document.querySelector("input[name=pageNum]").value = '${pageDTO.startPage - 1}';
	document.querySelector("input[name=pageSize]").value = '${pageSize}';
	document.querySelector("input[name=keyword]").value = '${keyword}';
	pageForm.submit();
}

// 다음 버튼을 클릭하였을 경우 실행되는 함수
const f_next = (p_nextPageNum) => {
	document.querySelector("input[name=pageNum]").value = p_nextPageNum;
	document.querySelector("input[name=pageSize]").value = '${pageSize}';
	document.querySelector("input[name=keyword]").value = '${keyword}';
	pageForm.submit();
}




//사이드바
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
	
	
	const url = new URL(window.location.href);
	const urlParams = url.searchParams;
	
	let error = urlParams.get("error");
	
	if(error) {
		Swal.fire('잘못된 비밀번호 입니다.', '다시 입력해 주세요!', 'error');	
	}
	
</script>
		