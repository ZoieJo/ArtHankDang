<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
#j_form1{width: 20%; float: left; margin-left: 190px;}
th{
background-color: #ecf0f1;
border-width: 1px;
border-color: black;
font-size: 18px;
} 

td {
border-width: 1px;
border-color: black;
font-size: 18px;
}
#j_th1{width: 28px;}

#j_form2{width: 20%; float: right; margin-right: 190px;}
#j_tr1{height: 60px;} 

</style>


<div class="col-sm-12">
	<%-- 
	<h3>기안문</h3>
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="${CONTEXT_PATH}" data-bs-original-title="아트학당" title="아트학당">홈</a></li>
		<li class="breadcrumb-item"><a href="#" data-bs-original-title="기안문작성" title="기안문작성">기안문작성</a></li>
		<li class="breadcrumb-item"><a href="#" data-bs-original-title="기안문" title="기안문">기안문</a></li>	
	</ol>
	 --%>
	<div class="card">
		<div class="card-header">
			<div class="card-body">
				<div id="basic-1_wrapper" class="dataTables_wrapper no-footer">
					<form>
						<table id="j_form2" border="2" style="width: 500px;">
						 	<tr align="center" height="30px" >					
								<th id="j_th1" rowspan="3">결재</th>						
								<td>직원</td>
								<td>팀장</td>
								<td>과장</td>
								<td>부장</td>
								
						 	</tr>
						 	
							<tr align="center" height="60px">
								<td title="결재자 서명 or승인"></td>
								<td title="결재자 서명 or승인"></td>
								<td title="결재자 서명 or승인"></td>
								<td title="결재자 서명 or승인"></td>						
						 	</tr>
						 	
						 	
						 	<tr align="center" height="30px">					
								<td title="결재일"></td>
								<td title="결재일"></td>
								<td title="결재일"></td>
								<td title="결재일"></td>
						 	</tr>				
						</table>
					</form>				
				</div>
				<br>
			</div>
				<h1 align="center">휴&nbsp;가&nbsp;신&nbsp;청&nbsp;서</h1>
				<br>
				<input type="button" class="btn btn-success" value="결재선등록" title="결재선을 선택해주세요." style="float: right; margin-right: 230px;">
				<br><br>
			<form>
				<table border="2" style="width: 70%; margin: auto;">
					<tr>
						<th  style="width: 20%; text-align: center; height: 50px;">소     &nbsp; &nbsp;   속</th>
						<td style="padding-left: 10px;">
							<input type="text" style="width: 98%; border: none;"> 
						</td>	
						<th style="text-align: center; height: 50px;">성     &nbsp; &nbsp;   명</th>
						<td style="padding-left: 10px; padding-inline-end: 10px; height: 30px;">
						</td>					
					</tr>
					
					<tr >
						<th style="text-align: center; height: 50px;">종     &nbsp; &nbsp;   류</th>
						<td colspan="3" style="padding-left: 10px; padding-inline-end: 10px; height: 30px;" >
							<input type="checkbox" value="연차">&nbsp;<label>연차</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" value="월차">&nbsp;<label>월차</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" value="경조">&nbsp;<label>경조</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" value="공가">&nbsp;<label>공가</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" value="병가">&nbsp;<label>병가</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" value="포상">&nbsp;<label>포상</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" value="기타">&nbsp;<label>기타</label>&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					
					<tr>
						<th style="width: 20%; text-align: center; height: 50px;">사     &nbsp; &nbsp;   유</th>
						<td colspan="3" style="padding-left: 10px;">
							<input type="text" style="width: 98%; border: none;"> 
						</td>						
					</tr>
					
					<tr>
						<th style="width: 20%; text-align: center; height: 50px;">기     &nbsp; &nbsp;   간</th>
						<td style="padding-left: 10px; " >
							<input type="date" style="width: 98%; border: none;"> 
						</td>						
						<th style="width: 20%; text-align: center;  height: 50px;">비상연락망</th>
						<td style="padding-left: 10px;">
							<input type="text" style="width: 98%; border: none;"> 
						</td>						
					</tr>
					
					<tr>
						<td colspan="4" style="padding-left: 10px;" height="300px">
							<p align="center" style="font-size: 20px;">위와 같이 휴가를 신청하오니 승인하여 주시기 바랍니다.</p>
							<p align="center" style="font-size: 20px;" >2021년 6월 28일</p>
							<p align="right" style="font-size: 20px; margin-right: 250px;" >소   속   :</p>
							<p align="right" style="font-size: 20px; margin-right: 250px;" >성   명   : </p>
							
						</td>						
					</tr>
					
				</table>
				<br>				
				<input type="button" class="btn btn-warning"  value="임시저장" style="position: relative; left: 980px;" >
				<input type="button" class="btn btn-primary"  value="결재" 	 style="position: relative; left: 990px;"  >
				<input type="button"  class="btn btn-info"  value="취소" 	 style="position: relative; left: 1000px;" >
			</form>
		</div>							
	</div>
</div>
