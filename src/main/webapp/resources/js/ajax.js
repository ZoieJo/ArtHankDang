/**
 * 
 */


 var f_ajax = function(p_json) {
    var xhr = new XMLHttpRequest();

    if(p_json.async==null) {
        p_json.async = true;
    }

    xhr.open(p_json.method, p_json.url, p_json.async);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            if (p_json.dataType == "json" || p_json.dataType == "JSON") {
                p_json.success(JSON.parse(xhr.responseText));
                return;
            }
            p_json.success(xhr.responseText);
        }
        
        if (xhr.readyState == 4 && p_json.error) {
			if (p_json.dataType == "json") {
                p_json.error(JSON.parse(xhr.responseText));
                return;
            }
            p_json.error(xhr.responseText);
		}
        
    }
    if (p_json.contentType) {
        console.log("Content-Type 설정됨");
        xhr.setRequestHeader("Content-Type", p_json.contentType);
    }

	if (p_json.csrf) {
		console.log("CSRF Token 설정됨");
		if (p_json.csrf==true) {
			p_json.csrf = document.querySelector("input[name=_csrf]").value;
		}
		
		xhr.setRequestHeader("X-CSRF-Token", p_json.csrf);
	}
	
    if (p_json.method == "post" || p_json.method == "POST") {
        // xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        // ajax post 전송 시 리퀘스트 헤더
        console.log("data: " + p_json.data);
        console.log("url: " + p_json.url);
        xhr.send(p_json.data);
    } else {
        xhr.send();
    }
}
