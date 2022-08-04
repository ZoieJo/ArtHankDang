<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>
#comment{
	font-size: 14px;
}
.accData{
	height: 700px;
	overflow: auto;
}
.starDisp{
	color: #e4ca43;
}
</style>

<div class="container-fluid">
	<div class="page-header" style="padding: 20px 0px;">
		<div class="row">
			<div class="col-sm-6" >
				<h3>강의후기</h3>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${CONTEXT_PATH}">홈</a></li>
					<li class="breadcrumb-item">강의</li>
					<li class="breadcrumb-item">강의후기</li>
				</ol>
			</div>
		</div>
	</div>
</div>

<div class="container-fluid">
     <div class="row">
		
          <div class="col-sm-12 col-sm-12">
               <div class="card">
                    <div class="card-header pb-0">
                         <span id="comment">아트학당의 강의를 들으신 모든 분들의 후기를 보실 수 있습니다.</span>
                    </div>
                    <div class="card-body accData" >
                         <div class="default-according" id="accordion">
						   <c:forEach var="eva"  items="${cursevalist}" varStatus="status">
                              <div class="card"  style="border: 2px solid; color: #39a893;">
                                   <div class="card-header" id="headingOne" >
                                        <h5 class="mb-0">
                                             <button class="btn btn-link collapsed" data-bs-toggle="collapse" data-bs-target="#A_${status.count}"
                                              aria-expanded="false" aria-controls="collapseOne">${eva.cursNm}
                                              </button>
                                               <c:forEach var="counter" begin="1" end="${eva.cursevaScr}" step="1">
            											<span class="starDisp">★</span>
        									  </c:forEach>
                                        </h5>
                                   </div>
                                   <div class="collapse" id="A_${status.count}" aria-labelledby="headingOne" data-bs-parent="#accordion">
                                        <div class="card-body" style="padding-left: 100px; ">
                                        	${eva.cursevaCnt}
                                        </div>
                                   </div>
                              </div>
                         </c:forEach>
                         </div>
                    </div>
               </div>
          </div>

     </div>
</div>
