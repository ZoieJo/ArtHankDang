package kr.or.arthakdang.freeboard.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CkUploadController {

	@PostMapping(value="/gUpload",produces = "text/html;charset=utf-8" )
	@ResponseBody
	public String gUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) throws Exception {

		String realPath = req.getServletContext().getRealPath("/resources/ckUpLoad");
		log.info("realPath: " + realPath);

		UUID uid = UUID.randomUUID(); 

		String fileName = upload.getOriginalFilename();
		String ckUploadPath = realPath + "\\" + uid + "_" + fileName;
		log.info("hiyaho: " + ckUploadPath);
		

		String fileUrl = req.getContextPath() + "/resources/ckUpLoad/" + uid + "_" + fileName;
		upload.transferTo(new File(ckUploadPath)); /* 파일 업로드 끝 */
		log.info("fileUrl===>" + fileUrl); // 이것 확인이 중요
        //ckEditor가 아닌 경우는 그냥 파일의 경로만 리턴하면 됨
		String scriptStr = "<script type='text/javascript'>" + "window.parent.CKEDITOR.tools.callFunction(1"
				+ ",'" + fileUrl + "','이미지 파일이 등록되었습니다.')" + "</script>";

		return scriptStr;
	}

}
