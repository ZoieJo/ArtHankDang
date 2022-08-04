<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- 알림 메시지 스크립트 -->
<script type="text/javascript">
	let msg = "${msg}";
	window.onload = function(){
	    if(msg){        
	        Swal.fire({
	            icon: 'success',
	            title: '알림',
	            text: msg
	        });
	     }
	}
</script>
<style>
input[type=checkbox] {
	zoom: 1.5;
}	
</style>
<!-- 몸통 내용 시작 -->
<div class="container-fluid">
	<div class="page-header" style="padding-top: 10px;">
		<div class="row">
			<div class="col-sm-6">
				<h3>과목등록</h3>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
					<li class="breadcrumb-item">강의관리</li>
					<li class="breadcrumb-item active">과목등록</li>
				</ol>
			</div>
		</div>
	</div>
</div>
  <!-- 테이블 -->
  <div class="container-fluid">
    <div class="row">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-header pb-0" style="text-align: right;">
          	<!-- 버튼 -->
          	<span>
			<button class="btn btn-primary btn-sm" type="button" id="subCreate">과목생성</button>
<!--           	<button class="btn btn-warning btn-sm" type="button">수정</button> -->
			<button class="btn btn-danger btn-sm" type="button" id="subDelete">과목삭제</button>
			</span>
			<!-- 검색 -->
			  <div class="input-group" style="margin-top:20px;">
				<div class="row">
				    <div class="col">
				      <div class="mb-0">
				        <select class="form-select digits" name='type' id="selectType">
				          <option value='' selected>--구분--</option>
				          <option value='M'>과목명</option>
				          <option value='N'>과목번호</option>
				        </select>
				      </div>
				    </div>
				  </div>
				  <input type="text" class="form-control" placeholder="과목명 또는 과목번호를 입력해주세요." value="" id="keyword">
			    <div class="input-group-append">
			      <button class="btn btn-secondary" type="button" id="searchBtn"><i class="fa fa-search"></i></button>
			      <button id="resetSrh"type="button" class="btn btn-light btn-sm" style="font-family:ngB; font-size:15px; padding: 7.5px 20px 7.5px 20px;">초기화</button>
			    </div>
			  </div> 
          </div>
          <!-- 테이블 -->
          <div class="card-body" style="padding-top:10px;">
            <div class="js-shorting jsgrid" id="sorting-table" style="position:relative; height:600px; width:100%;">
              <div class="jsgrid-grid-header">
                <table class="jsgrid-table" style="text-align:center; width:100%; font-weight:bold; background-color:rgb(36, 105, 92); color:white">
                  <tr class="jsgrid-header-row">
                    <th class="jsgrid-header-cell" style="width:20%;">과목번호</th>
                    <th class="jsgrid-header-cell" style="width:40%;">과목명</th>
                    <th class="jsgrid-header-cell" style="width:30%;">생성일</th>
                    <th class="jsgrid-header-cell" style="width:10%;">삭제</th>
                  </tr>
                </table>
              <div class="jsgrid-grid-body" style="width:100%; height:500px; overflow:auto">
                <table class="jsgrid-table" style="height:100%; width:100%; text-align:center;">
                  <tbody>
                  		<c:if test="${empty sublist}">
                  			<tr class="jsgrid-row">
                  				<td class="jsgrid-cell" colspan="4">등록된 과목이 존재하지 않습니다.</td>
                  			</tr>
                  		</c:if>
	                  	<c:if test="${!empty sublist}">
	                  		<c:forEach var="item" items="${sublist}">
		                    <tr class="jsgrid-row">
		                      <td class="jsgrid-cell" style="width:20%;">${item.subNo}</td>
		                      <td class="jsgrid-cell" style="width:40%;">${item.subNm}</td>
		                      <td class="jsgrid-cell" style="width:30%;"><fmt:formatDate value="${item.subCreDt}" pattern="yyyy-MM-dd (hh:mm)"/></td>
		                      <td class="jsgrid-cell" style="width:10%;"><input type="checkbox" name="subNo" value="${item.subNo}"></td>
		                    </tr>
		                    </c:forEach>
	                  	</c:if>
					</tbody>
				</table>
              </div>
              <!-- 히든 폼 삭제 / 생성 -->
           	<form action="${CONTEXT_PATH}/subject/delete" method="post" style="display:none;">
           		<input type="text" name="subNo" id="id_subNo">
           		<sec:csrfInput/>
           		<input type="submit" id="delBtn">
           	</form>
           	<form action="${CONTEXT_PATH}/subject/create" method="post" style="display:none;">
           		<input type="text" name="subNm" id="id_subNm">
           		<sec:csrfInput/>
           		<input type="submit" id="creBtn">
           	</form>
             
            </div>
          </div>
        </div>
        
      </div>
    </div>
  </div>
</div>
<!-- 몸통 내용 끝 -->
<script type="text/javascript">

	/* 과목 등록 */
	$("#subCreate").click(function () {
   	  console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 등록 @@@@@@@@@@@@@@@@@@@@@@@@");
	  (async () => {
	      const { value: getName } = await Swal.fire({
	          title: '과목생성',
	          text: '생성할 과목의 이름을 입력해주세요.',
	          input: 'text',
	  	      showCancelButton: true,
	  	      confirmButtonText: '생성',
		      cancelButtonText: '취소',
	          inputPlaceholder: '예) JAVA'
	      })
	      // 이후 처리되는 내용.
	      if (getName) {
	    	  console.log(getName);
	    	  $('#id_subNm').val(getName);
	    	  // console.log("입력된 값 input에 넣었나요?" + $('#id_subNm').val());
	    	  $('#creBtn').trigger('click');
	      }
	  })()
	});
	
	/* 삭제 */
	$("#subDelete").click(function () {
   	  console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 삭제 @@@@@@@@@@@@@@@@@@@@@@@@");
	  Swal.fire({
	    title: '삭제',
	    text: "정말 삭제하시겠습니까?",
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonText: '확인',
	    cancelButtonText: '취소',
	    reverseButtons: false
	  }).then((result) => {
	    if (result.isConfirmed) {
	    	let l_list ='';
	    	$("input:checkbox[name=subNo]:checked").each(function(i) {
	    		l_list += $(this).val() + ',';
	    	});
	    	$.trim(l_list);
	    	l_list = l_list.substring(0,l_list.length-1);
    		$('#id_subNo').val(l_list);
	    	// console.log("값이 input에 넣었나요?" + $('#id_subNo').val());
	    	$('#delBtn').trigger('click');
	    	
	    }
	  })
	});	
	
	
	
	
</script>
