<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!-- Page Body Start-->
  <!-- 페이지 타이틀 시작 -->
  <div class="container-fluid">
    <div class="page-header">
      <div class="row">
        <div class="col-sm-12">
          <h3>QR 학생증</h3>
          <!-- 제목 하단 페이지 경로 -->
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${CONTEXT_PATH}/">Home</a></li>
            <li class="breadcrumb-item active"><a href="${CONTEXT_PATH}/qrCode">QR 학생증</a></li>
          </ol>
        </div>
      </div>
    </div>
  </div>
  <!-- 페이지 타이틀 끝 -->
  <!-- 내용 시작 -->
  <div class="container-fluid">
    <div class="row starter-main">
      <div class="col-sm-6">
        <div class="card">
          <div class="card-header pb-0">
            <h5>내 QR코드</h5>
          </div>
          <div class="card-body">
            <span>유효시간 : </span><span id="id_time" class="txt-danger">00</span><span>초</span>
            <div id="qrcode" class=""></div>
          </div>
        </div>
      </div>
      <div class="col-sm-6">
        <div class="card">
          <div class="card-header pb-0">
            <h5>학생증</h5>


          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-12 col-lg-4 text-center img-box">
                <img class="img-fluid rounded-circle" alt=""
                  src="https://avatars.dicebear.com/api/micah/${USERNAME}.svg">
              </div>

              <div class="col-12 col-lg-8 my-1 p-2">
                <h6>학번 : ${USERNAME}</h6>
                <h6>이름 : ${member.getStuNm()}</h6>
                <h6>전화번호 : ${member.getStuPhNo()}</h6>
                
              </div>

            </div>
          </div>
        </div>
      </div>
      <!-- 카드 1 끝 -->
    </div>
  </div>
  <!-- Container-fluid Ends-->

  <script src="${CONTEXT_PATH}/js/qrcode.js"></script>
  <script src="${CONTEXT_PATH}/js/ajax.js"></script>
  <script>
    var requestTime = Date.now();
    // var code = '${otp}';
    // var userid = '${USERNAME}';

    var data = {
      // text: ("time=" + requestTime + "&code=" + code + "&userid=" + userid),
      width: 300,
      height: 300,
      colorDark: "#000000",
      colorLight: "#ffffff",
      correctLevel: QRCode.CorrectLevel.M
    }

    var qrcode = new QRCode("qrcode", data);

    function makeCode(p_text) {
      
      qrcode.makeCode(p_text);
      console.log(p_text);
    }

    function calcTime() {
      console.log("calcTime called");
      var time = new Date();
      var sec = 60-parseInt((time-requestTime)/1000);
      document.getElementById("id_time").innerText = sec;

      if (sec==0) {
        getData();
        return;
      }

      setTimeout(calcTime, 1000);
    }

    function getData() {
      var v_json = {
        url:'${CONTEXT_PATH}/qrCode/data',
        method:'get',
        dataType:'json',
        async: true,
        success: function(p_data) {
          requestTime = new Date();
          var text = "time=" + p_data.time + "&code=" + p_data.code + "&userid=" + p_data.userid;
          makeCode(text);
          calcTime();
        }
      };

      f_ajax(v_json);
      //setTimeout(getData, 60000);
    }

    getData();
  </script>