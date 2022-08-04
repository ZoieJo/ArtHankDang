<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<link href="${RESOURCES_PATH}/css/root-style.css" rel="stylesheet" type="text/css">
 <section>
    <div class="container-fluid p-0">
      <div class="row">
        <div class="col-12">
          <div class="login-card">

            <div class="card-body">
            
                  <form class="theme-form login-form" action="${CONTEXT_PATH}/check" method="post">
                    <h4>Password Check</h4>
                    <h6>비밀번호 확인이 필요한 페이지 입니다.</h6>
                    <div class="msgblock">
                      <!-- 로그인 알림메시지 블록 -->
                    </div>
                    <div class="form-group">
                      <label>아이디</label>
                      <div class="input-group"><span class="input-group-text"><i class="icon-user"></i></span>
                        <input class="form-control" type="password" required="required" placeholder="********" name="password">
                      </div>
                    </div>
               
                    <div class="form-group">
                      <button class="btn btn-primary btn-block" type="submit">로그인</button>
                    </div>

                    <c:if test="${cslrgNo!=null}">
                    
                    <input type="hidden" value="${cslrgNo}" name="cslrgNo">
                    </c:if>
                    <input type="hidden" value="${dir}" name="dir">
                   <sec:csrfInput/>
                  </form>

              
            </div>


          </div>
        </div>
      </div>
    </div>
  </section>

  <script>
    // 로그인 알림메시지 스크립트
    let errorMsg = function () {

      let msg = document.querySelector(".msgblock")
      console.log(msg);

      msg.innerHTML = "<i data-feather='alert-triangle'></i> ${msg}";
      msg.style.color = "#FFFFFF";
      msg.setAttribute("class", "alert alert-danger");
    };

    if ('${msg}') {
      errorMsg();
    }
  </script>