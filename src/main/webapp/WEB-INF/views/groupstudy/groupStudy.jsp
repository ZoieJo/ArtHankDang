<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src="/arthakdang/resources/js/ajax.js"></script>
    <div class="container-fluid">
	<div class="page-header">
		<div class="row">
			<div class="col-sm-6">
			<br>
				<h3>그룹스터디</h3>
					<ol class="breadcrumb" style="text-align: center;">
                    <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">홈</a></li>
                    <li class="breadcrumb-item">커뮤니티</li>
                    <li class="breadcrumb-item active">그룹스터디</li>
                  </ol>
			</div>
			<div class="col-sm-6">
			</div>
		</div>
	</div>
</div>
 <div class="container-fluid">
              <div class="col-sm-12">
                <div class="card">
                  <div class="card-body">
                 <div class="col-md-6 p-0">                    
                      <div class="form-group mb-0 me-0"></div> <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal">그룹스터디 생성</button>
                    </div>
                    <br>
                    <div class="tab-content" id="top-tabContent">
                      <div class="tab-pane fade show active" id="top-home" role="tabpanel" aria-labelledby="top-home-tab">
                        <div class="row">
                        <!-- foreach start -->
                        <c:forEach var="groupStudy" items="${groupStudyList }" varStatus="status">
                          <div class="col-xxl-4 col-lg-6">
                          <!-- button으로 참여하는 버튼 생성 -->
                            <div class="project-box">
	                          	<img class="rounded mx-auto d-block" src="${pageContext.request.contextPath }/resources/image/${groupStudy.inteattchVO.attchStdNm}" style="width: 260px; height: 200px">
                              <div class="media">
                                <div class="media-body">
                                </div>
                              </div>
                              <div class="media mb-0">
                               <p style="color: black">#${groupStudy.gpstyNm }</p> <!-- 그룹스터디 제목 -->
                               </div>
                               <br>
<!--                               <div class="media mb-0"> -->
<%--                                <p style="color: black;">모임장 : ${groupStudy.memId }</p> <!-- 그룹스터디 만든사람 --> --%>
<!--                                </div> -->
                              <div class="project-status mt-4">
                                <div class="media mb-0">
                                  <p>${groupStudy.gpstyJnNum}/7명</p>
                                  <c:choose>
                                  <c:when test="${groupStudy.gpstyJnNum >= 7}">
                                  <div class="media-body text-end"><span style="color: red;">모집완료</span></div> <!-- 모집중 doing 모집완료 done으로 -->
                                  </c:when>
                                  <c:when test="${groupStudy.gpstyJnNum < 7}">
                                  <div class="media-body text-end"><span style="color: green;">모집중</span></div> <!-- 모집중 doing 모집완료 done으로 -->
                                  </c:when>
                                  </c:choose>
                                </div>
                                <div class="progress" style="height: 5px"> <!-- 10명 기준 등록된 사람 나누기로 % 형식 script영역에서 구현 -->
                                  <div class="progress-bar-animated bg-primary progress-bar-striped" role="progressbar" style="width: ${(100*groupStudy.gpstyJnNum)/7}%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <br>
                                <form id="joinGroupStudyForm${status.index}" action="${pageContext.request.contextPath }/groupStudy/joinGroupStudy" method="post" onsubmit="return joinGroupStudy(this)">
                                <sec:csrfInput/>
                                <input type="hidden" name="memId" value="${user.getMember().getMemId()}">
                                <input type="hidden" name="gpstyNo" value="${groupStudy.gpstyNo }">
                                <!-- 이미 가입되어 있다면 disabled -->
                                <c:set var="check" value="false" />
                                <c:set var="check2" value="0"/>
								<c:forEach var="groupStudyMemInfo" items="${groupStudyMemInfoList }" varStatus="status">
                                <c:if test="${not check }">
									<c:choose>
										<c:when test="${groupStudyMemInfo.gpstyNo == groupStudy.gpstyNo }">
											<c:set var="check2" value="1"/>
											<c:set var="check" value="true" />
										</c:when>
										</c:choose>
									</c:if>
								</c:forEach>
							<c:if test="${groupStudy.gpstyJnNum != 7 }">
							<c:if test="${check2 eq '0' }">
								<button class="col-12 btn btn-primary" type="submit" id="joinGroupStudyBtn">가입하기</button>
                             </c:if>
							</c:if>
                               </form>
                               <form action="${pageContext.request.contextPath }/groupStudy/outGroupStudy" method="post" onsubmit="return outGroupStudy(this, ${groupStudy.gpstyJnNum})">
                               <sec:csrfInput/>
                                  <input type="hidden" value="${groupStudy.gpstyNo }" name="gpstyNo">
                                 <input type="hidden" value="${user.getMember().getMemId() }" name="memId">
                                 <input type="hidden" value="${groupStudy.inteattchVO.attchStdNm}" name="gpstyAttchNo">
                                 <c:if test="${check2 eq '1' }">
                                <button class="col-12 btn btn-danger col" type="submit" value="${groupStudy.gpstyJnNum }" id="outGroupStudyBtn">탈퇴하기</button>
                                </c:if>
                               </form>
<!--                                	<br> -->
<!--                                 <button class="btn btn-info" style="width: 420px;" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal1">업/다운로드</button> -->
                              </div>
<!--                       <div class="modal fade" id="exampleModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true"> -->
<!--                       <div class="modal-dialog" role="document"> -->
<!--                         <div class="modal-content"> -->
<!--                           <div class="modal-header"> -->
<!--                             <h4 class="modal-title" id="exampleModalLabel">그룹스터디 자료</h4> -->
<!--                           </div> -->
<%--                            <form action="${pageContext.request.contextPath }/groupStudy/uploadFile" method="post" enctype="multipart/form-data"> --%>
<%--                            <sec:csrfInput/> --%>
<!--                            <div class="modal-body"> -->
<!--                            <div class="mb-3"> -->
<!--                            <label>자료 업로드</label> -->
<%--                            	  <input type="hidden" name="inteattchNo" value="${groupStudy.gpstyNo }">	 --%>
<%--                            	  <input type="hidden" name="rgMemId" value="${user.getMember().getMemId() }">	 --%>
<!--                        		  <input class="form-control" type="file" name="multiFile" multiple="multiple"> -->
<!--                            </div> -->
<!--                            <br> -->
<!--                            <br> -->
<!--                            <div class="mb-3"> -->
<!--                             <label>자료 다운로드</label> -->
<!--                             foreach로 리스트 뽑고 다운로드 -->
<%--                             <c:forEach var="uploadFile" items="${uploadFileList }" varStatus="status"> --%>
<!--                            	 <div class="mb-3"> -->
<%-- 								<p>${uploadFile.attchRgDt }</p> --%>
<!--                            	 </div> -->
                           	 
<%--                             </c:forEach> --%>
<!--                           </div> -->
<!--                            </div> -->
<!--                            <div class="modal-footer"> -->
<!--                             <button type="submit" class="btn btn-primary">전송</button> -->
<!--                             <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button> -->
<!--                           </div> -->
<!--                           </form> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                     </div> -->
                            </div>
                          </div>
                          
                          </c:forEach>
                          <!-- foreach end -->
                         </div>
                       </div>           
                     </div>
                   </div>
                 </div>
               </div>
             </div>
           </div>
                    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h4 class="modal-title" id="exampleModalLabel">Create Group Study</h4>
                          </div>
                          <form id="createGroupStudyForm" action="${pageContext.request.contextPath }/groupStudy/createGroupStudy" method="post" enctype="multipart/form-data">
                          <sec:csrfInput/>
                          <input type="hidden" name="memId" value="${memId}">
                          <div class="modal-body">
 							<div class="mb-3">
                            <label>그룹스터디 이름</label>
                            <input class="form-control" type="text" placeholder="SPRING 그룹스터디" name="gpstyNm" id="groupName">
                          </div>
                          <div class="mb-3">
                            <label>그룹스터디 과목</label>
                            <select id="subjectChoice" class="form-select" aria-label="Default select example" name="gpstyHtNm">
							  <option selected value="0">과목을 선택해주세요 ! (해시태그 형식 #SPRING)</option>
							  <c:forEach var="subject" items="${subjectList }" varStatus="status">
							  <option value="${subject.subNm }">${subject.subNm }</option>
							  </c:forEach>
							</select>
                          </div>
                          <div class="mb-3">
                            <label>그룹스터디 메인 이미지</label>
                            <input class="form-control" type="file" name="uploadFile">
                          </div>
                          </div>
                          </form>
                           <div class="modal-footer">
                            <button class="btn btn-primary" type="button" id="createGroupStudyBtn">생성</button>
                            <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button>
                          </div>
                        </div>
                      </div>
                    </div>
<script>
const createGroupStudyForm = document.querySelector("#createGroupStudyForm");
const createGroupStudyBtn = document.querySelector("#createGroupStudyBtn");
const createGroupStudy = () => {
	if(document.querySelector("#groupName").value == "") {
//     alert("그룹스터디 이름을 입력해주세요 !");
    Swal.fire({
	      title: '생성 실패 !',
	      text: '그룹스터디 이름을 입력해주세요 !',
	      icon: 'warning',
  });
		event.preventDefault();
  } else if(document.querySelector("#subjectChoice").value == 0) {
// 		alert("과목을 선택해주세요 !");
		Swal.fire({
		      title: '생성 실패 !',
		      text: '과목을 선택해주세요 !',
		      icon: 'warning',
	  });
		event.preventDefault();
	} else {
		createGroupStudyForm.submit();
	}
}
createGroupStudyBtn.addEventListener("click", createGroupStudy);


const joinGroupStudy = (submitForm) => {
	event.preventDefault();
	Swal.fire({
        title: "그룹스터디 가입",
       	text : "선택한 그룹스터디를 가입하시겠습니까 ?",
        icon: "info",		
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: '확인',
        denyButtonText: '취소',
     }).then(function(result){
        if (result.isConfirmed) {
        	submitForm.submit();
        	return true;
        } else if (result.isDenied) {
        	return false;
        }
     });
//   if(confirm("선택하신 스터디그룹을 가입하시겠습니까 ?")) {
//     return true;
//   } else {
//     alert("가입을 취소했습니다.");
//     event.preventDefault();
//     return false;
//   }
}
// joinGroupStudyBtn.addEventListener("submit", joinGroupStudy);


const outGroupStudy = (submitForm, num) => {
	console.log(num);
	event.preventDefault();
	Swal.fire({
        title: "그룹스터디 탈퇴",
       	text : "선택한 그룹스터디를 탈퇴하시겠습니까 ?",
        icon: "info",		
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: '확인',
        denyButtonText: '취소',
     }).then(function(result){
        if (result.isConfirmed) {
        	if(num == 1) {
        		Swal.fire({
      		      title: '탈퇴 실패 !',
      		      text: '최소 2명 이상 존재해야 합니다!',
      		      icon: 'warning',
      	  });
        		return;
        	} else {
        	submitForm.submit();
        	}
        	return true;
        } else if (result.isDenied) {
        	return false;
        }
     });
}
</script>