<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<input type = "text" id = "message"/>
	<input type = "button" id = "sendBtn" value = "전송"/>
</div>

<script type="text/javascript">
$('#sendBtn').click(function(){
	sendMessage();
});
</script>