<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
			<br>
				<h3>자유게시판</h3>
				<ol class="breadcrumb" style="text-align: center;">
                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">홈</a></li>
<!--                     <li class="breadcrumb-item"><a href="#">게시판 관리</a></li> -->
                    <li class="breadcrumb-item"><a href="#">자유게시판</a></li>
                  </ol>
			</div>
		</div>
	</div>
</div>
<!-- Container-fluid starts-->

<!-- 페이지 바운더리 출력 -->
<c:set var="curPage" value="${pageDTO.pageCondDTO.pageNum}" />
<c:set var="pageSize" value="${pageDTO.pageCondDTO.pageSize}" />
<c:set var="contextPath"
	value="${pageContext.request.contextPath}/freeboard" />
<form id="id_pageForm" action="${contextPath}/main">
	<input type="hidden" name="pageNum" value=""> <input
		type="hidden" name="pageSize" value="">
</form>
	<div class="col-sm-12">
		<div class="card">
			<div class="card-header">
			<div class="basic-6_wrapper" class="dataTables_wrapper"
				style="margin: 0 auto;">
				<div class="container-fluid">
						<img src="../image/freeboarddd.PNG" alt="배너 내용을 적어주세요." class="img-fluid" style="width: 100%;"/>
				</div>
			</div>
			<div class="basic-6_wrapper" class="dataTables_wrapper"
					style="margin: 1% auto;">
<%-- 					<span>이 공간에서는 이용자분들이라면 <code>로그인</code>후 자유롭게 이용하실 수 있습니다. --%>
<!-- 						비방, 욕설, 특정 대상을 비하하는 언행은 삼가해주시기 바랍니다. -->
<!-- 					</span> -->
				</div>
				<div class="table-responsive">
					<button class="btn btn-success" type="button"
						style="float: right; margin: 20px;" id="id_boardwrite">
						<i class="fa fa-pencil-square-o"></i>
					</button>
					<table class="table table-hover">
						<thead>
							<tr style="text-align: center;background-color:rgb(30,90,90);margin:5px;">
								<th  scope="col" style="color:white;">No</th>
								<th  scope="col" style="color:white;">제목</th>
								<th  scope="col" style="color:white;">작성자</th>
								<th  scope="col" style="color:white;">작성일</th>
								<th  scope="col" style="color:white;">조회수</th>
								<th  scope="col" style="color:white;">좋아요</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach items="${list}" var="freeboardVO" varStatus="status">
								<tr style="text-align:center;cursor:pointer;"
									onclick="location.href='${CONTEXT_PATH}/freeboard/detail?bdNo=${freeboardVO.bdNo}&pageNum=${curPage}&pageSize=${pageSize}'">
<%-- 									<th scope="row">${status.index + 1}</th> --%>
<%-- 									<th scope="row">${freeboardVO.bdNo.substring(3)}</th> --%>
									<th scope="row">${freeboardVO.bdNo.substring(3).replaceAll("^0+", "")}</th>
									<td style="text-align: left;">${freeboardVO.bdTL}</td>
									<td>${freeboardVO.memNm}</td>
									<td><fmt:formatDate value="${freeboardVO.bdWtDt}"
											pattern="yyyy-MM-dd"></fmt:formatDate></td>
									<td>${freeboardVO.bdViews}</td>
									<td>${freeboardVO.bdLikes}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<br>
					<nav style="text-align: center;" >
					    <ul class="pagination pagination-primary" style="justify-content:center;">
						 <!-- 이전 -->
						<c:if test="${pageDTO.isPrevious() == true}">
						    <li class="page-item"><a class="page-link" onclick="f_previouse()" tabindex="-1" style="cursor:pointer;">이전</a></li>
						</c:if>
						<c:if test="${pageDTO.isPrevious() == false}">
						    <li class="page-item disabled"><a class="page-link"  tabindex="-1" style="cursor:pointer;">이전</a></li>
						</c:if>	
					
						<!-- 숫자 -->		    
						<c:forEach var="pageNum" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
						<c:if test="${pageNum == curPage}">
					    <li class="page-item active"><a class="page-link"onclick="f_sendPage('${pageNum}','${pageSize}')" style="cursor:pointer;">${pageNum}</a></li>
					    </c:if>
					    <c:if test="${pageNum != curPage}">
					    <li class="page-item"><a class="page-link" onclick="f_sendPage('${pageNum}','${pageSize}')" style="cursor:pointer;">${pageNum}<span class="sr-only">(current)</span></a></li>
					    </c:if>
						</c:forEach>
					    
					    <!-- 다음 -->
					    <c:if test="${pageDTO.isNext() == true}">
					    <li class="page-item"><a class="page-link" onclick="f_next('${pageDTO.endPage+1}')" style="cursor:pointer;">다음</a></li>
					    </c:if>
					    <c:if test="${pageDTO.isNext() == false}">
					    <li class="page-item"><a class="page-link" tabindex="-1" style="cursor:pointer;">다음</a></li>
					    </c:if>
					    </ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
<!-- Container-fluid Ends-->
<script>

		const c_modal = document.querySelector("#id_boardwrite");

        c_modal.onclick = ()=>{
           location.href="${CONTEXT_PATH}/freeboard/write";    // 다시 안보이깅, 자리도 안차지
        }

        if("${errmsg}") {
        	alert("${errmsg}");
        }
        
        
        const pageForm = document.querySelector("#id_pageForm");
        
        const f_sendPage = (p_pageNum,p_pageSize)=>{
       	 event.preventDefault(); // a 태그의 link기능 막아버리깅
       	 document.querySelector("input[name=pageNum]").value = p_pageNum;
       	 document.querySelector("input[name=pageSize]").value =  p_pageSize;
       	 pageForm.submit();  // form 전송
        }
        
        const f_previouse = ()=>{
   	 	  document.querySelector("input[name=pageNum]").value = '${pageDTO.startPage -1}';
   	      document.querySelector("input[name=pageSize]").value = '${pageSize}';
   	      pageForm.submit();  // form 전송
   		}
        
        const f_next = (p_nextPageNum) => {
   	      document.querySelector("input[name=pageNum]").value = p_nextPageNum;
   	      document.querySelector("input[name=pageSize]").value = '${pageSize}';
   	      pageForm.submit();  // form 전송
    	}
        
</script>
