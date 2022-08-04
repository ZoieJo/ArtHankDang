<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl.carousel.js"></script>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl-custom.js"></script>

<style>
#j_img1 {width: 88%;}
#owl-carousel-14{width: 30%; float: right;  margin-right: -3%;}
div.owl-dots {display: none;}
.owl-carousel .owl-item img {
    display: block;
    height: 700px;
 }

</style>



<!------------------------------------------------------------- 상담내역 ------------------------------------------------------------->
<c:set var="tblPath" value="{pageContext.request.contextPath}"></c:set>
<c:set var="curPage" value="${pageDTO.cslrgPageCondDTO.pageNum}" />
<c:set var="pageSize" value="${pageDTO.cslrgPageCondDTO.pageSize}" />
<c:set var="keyword" value="${pageDTO.cslrgPageCondDTO.keyword}"/>

<div class="col-sm-12">
	<h3>나의 상담목록</h3>
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="${CONTEXT_PATH}"
			title="아트학당">홈</a></li>
		<li class="breadcrumb-item active">나의 상담목록</li>
	</ol>

	<div class="owl-carousel owl-theme owl-loaded owl-drag"
		id="owl-carousel-14">
		<div class="owl-stage-outer owl-height">
			<div class="owl-stage" style="transition: all 0.25s ease 0s;">
				<div id="id_owl" class="owl-item">
					<div class="item" style="">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample1.png">
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample2.png">
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample3.png">
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample4.png">
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample5.png">
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample6.png">
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="card" style="width: 70%;">
		<div class="card-header">
			<div class="card-body">
			
<!--글작성 버튼  -->
			<c:if test="${memStu == '01'}">
				<button class="btn btn-success" type="button" style="float: right; margin-bottom: 10px;" id="id_boardwrite"  title="상담신청">
					<i class="fa fa-pencil-square-o" aria-hidden="true" onclick="location.href='${CONTEXT_PATH}/cslrg/write'"></i>
				</button>
			</c:if>	
				
				<div id="basic-1_wrapper" class="dataTables_wrapper no-footer">
					<table class="display dataTable no-footer" id="basic-2" role="grid"
						aria-describedby="basic-1_info" style="text-align: center">
						<thead>
							<tr role="row">
								<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1" style="width: 5%;"><font style="vertical-align: inherit;">NO</font></th>
								<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1" style="width: 20%;"><font style="vertical-align: inherit;">상담일</font></th>
								<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1" style="width: 15%;"><font style="vertical-align: inherit;">상담시간</font></th>
								<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1" style="width: 15%;"><font style="vertical-align: inherit;">상담구분</font></th>
								<th class="sorting_disabled" tabindex="0" aria-controls="basic-1" rowspan="1" colspan="1" style="width: 20%;"><font style="vertical-align: inherit;">상담현황</font></th>
						</thead>

						<tbody>
							<c:forEach items="${cslList}" var="cslrgStr">
								<tr role="row" class="even" onclick="location.href='${CONTEXT_PATH}/cslrg/detail?cslrgNo=${cslrgStr.cslrgNo}'">
									<td class="sorting_1"><font style="vertical-align: inherit;">${cslrgStr.cslrgNo}</font></td>
									<td><font style="vertical-align: inherit;"><fmt:formatDate value="${cslrgStr.cslrgRsvDt}" pattern="yyyy-MM-dd" /></font></td>
									<td><font style="vertical-align: inherit;">${cslrgStr.cslrgRsvTm}</font></td>
									<td><font style="vertical-align: inherit;">${cslrgStr.cslFdCmcd}</font></td>

									<c:if test="${cslrgStr.cslStCmcd=='신청중'}">
										<td id="id_stCmcd" style="color: white; background: #d74654;">${cslrgStr.cslStCmcd}</td>
									</c:if>
									<c:if test="${cslrgStr.cslStCmcd=='신청완료'}">
										<td id="id_stCmcd" style="color: white; background: #e4ca43;">${cslrgStr.cslStCmcd}</td>
									</c:if>
									<c:if test="${cslrgStr.cslStCmcd=='상담완료'}">
										<td id="id_stCmcd" style="color: white; background: #3db39d;">${cslrgStr.cslStCmcd}</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div id="pageDiv">
						<form id="id_pageForm" action="${CONTEXT_PATH}/cslrg/cslList">
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
</div>

<script>

const tokenHeader = '${_csrf.headerName}';
const tokenValue = '${_csrf.token}';

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
</script>


