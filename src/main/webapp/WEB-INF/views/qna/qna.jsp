<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
   <div class="col-sm-24 col-lg-12">
                <div class="card">
                  <div class="card-header pb-0">
                    <h5>QnA</h5>
                    <c:if test="${user.getMember().getMemCmcd() == '02' }">
                    <button class="btn btn-primary" style="float: right;" type="button" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal">QnA작성</button>
                    </c:if>
                    <span>원하는 QnA 제목을 클릭해주세요.</span>
                    <br>
                    <form action="${pageContext.request.contextPath }/qna" method="get">
                    <div class="col-md-4 mb-3" style="float: right;">
                    <div class="input-group">
                    <input class="form-control" type="text" name="bdTl" placeholder="검색어를 입력하세요.">
                    <button class="btn btn-primary">검색</button>
                  	</div>
                    </div>
                    </form>
                    </div>
                  <div class="card-body">
                    <div class="default-according" id="accordionclose">
                    <!-- foreach start -->
                    <c:forEach var="qna" items="${qnAList }" varStatus="status">
                      <div class="card">
                        <div class="card-header bg-primary" id="heading${status.index }">
                          <h5 class="mb-0">
                            <button class="btn btn-link text-white " data-bs-toggle="collapse" aria-expanded="true" data-bs-target="#collapse${status.index }" aria-controls="collapse${status.index }">${qna.bdTl }</button>
                          </h5>
                        </div>
                        <div class="collapse" id="collapse${status.index }" aria-labelledby="heading${status.index }" data-bs-parent="#accordionclose">
                          <div class="card-body">${qna.bdCnt }</div>
							<c:if test="${user.getMember().getMemCmcd() == '02' }">
                          <div class="mb-3" style="float: right;">
                          <button class="btn btn-warning" data-bs-toggle="modal" data-original-title="test" data-bs-target="#exampleModal${status.index}">수정</button> <!-- 모달창 띄워서 수정하게 ? -->
                          <form action="${pageContext.request.contextPath }/qna/delete" method="post" id="deleteQnAForm" onsubmit="return deleteQnA()">
                          <sec:csrfInput/>
                          <input type="hidden" value="${qna.bdNo }" name="bdNo">
                          <button class="btn btn-danger" type="submit">삭제</button> <!-- 딜리트되게 -->
                          </form>
                          </div>
                          </c:if>
                        </div>
                      </div>
                       <div class="modal fade" id="exampleModal${status.index}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog" role="document">
                      <form action="${pageContext.request.contextPath }/qna/write" method="post">
                      <sec:csrfInput/>
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">QnA 작성</h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                          <div class="mb-3">
                          <label class="form-label">QnA 제목</label>
						  	<input class="form-control" type="text" name="bdTl" value="${qna.bdTl }">
                          </div>
                          <div class="mb-3">
                          <label class="form-label">QnA 내용</label>
						  	<textarea class="form-control" cols="20" rows="20" name="bdCnt" id="exampleFormControlTextarea4">${qna.bdCnt }</textarea>
                          </div>
						  	<input type="hidden"name="bdNo" value="${qna.bdNo }">
						  </div>
                          <div class="modal-footer">
                            <button class="btn btn-primary" type="submit">작성완료</button>
                            <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button>
                          </div>
                        </div>
                          </form>
                      </div>
                    </div>
                      </c:forEach>
                      <!-- foreach end -->
                    </div>
                  </div>
                </div>
              </div>
               <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog" role="document">
                      <form action="${pageContext.request.contextPath }/qna/write" method="post">
                      <sec:csrfInput/>
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">QnA 작성</h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                          <div class="mb-3">
                          <label class="form-label">QnA 제목</label>
						  	<input class="form-control" type="text" name="bdTl">
                          </div>
                          <div class="mb-3">
                          <label class="form-label">QnA 내용</label>
						  	<textarea class="form-control" cols="20" rows="20" name="bdCnt" id="exampleFormControlTextarea4"></textarea>
                          </div>
						  	<input type="hidden"name="bdWtr" value="${user.getMember().getMemId() }">
						  </div>
                          <div class="modal-footer">
                            <button class="btn btn-primary" type="submit">작성완료</button>
                            <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button>
                          </div>
                        </div>
                          </form>
                      </div>
                    </div>
                    
<script>
const deleteQnAForm = document.querySelector("#deleteQnAForm");
const deleteQnA = () => {
	if(confirm("해당 QnA를 삭제하시겠습니까 ?")) {
    return true;
  } else {
	  alert("QnA삭제를 취소하였습니다.");
    return false;
  }
}
</script>