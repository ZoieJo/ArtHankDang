package kr.or.arthakdang.crelecture.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class LectureFileDownController {

	/* 계획서 양식 다운로드 */
	@GetMapping("/crelecture/download")
	public void download(HttpServletResponse response, HttpServletRequest request, String path) throws Exception {
		try {
			log.info("path 확인 : "+ path);
			if(path==null) {
				path = "C:\\upload\\download\\[ArtHakDang]lecturePlan.docx";
//				path = "C:\\upload\\download\\[ArtHakDang]아트학당.docx";
				
				log.info("path : " + path);
			}
			// 그외에는 경로정보 받아온것
			File file = new File(path);
			log.info("file name check : " + file.getName());
			// 다운로드 되거나 로컬에 저장되는 용도로 쓰이는지를 알려주는 헤더, 크롬에서 다운받을때, 한글변경
			response.setHeader("Content-Disposition", "attachment;filename=" + new String(file.getName().getBytes("UTF-8"), "ISO-8859-1")); 
			log.info("file path check : " + path);
			// 파일 읽어오기
			FileInputStream fis = new FileInputStream(path); 
			OutputStream out = response.getOutputStream();
			int read = 0;
			byte[] buffer = new byte[1024];
			while ((read = fis.read(buffer)) != -1) { // 1024바이트씩 계속 읽으면서 outputStream에 저장, -1이 나오면 더이상 읽을 파일이 없음
				out.write(buffer, 0, read);
			}
			fis.close();
		} catch (Exception e) {
			throw new Exception("download error");
		}
	}
	
	/* 계획서 다운로드 */
	@PostMapping("/crelecture/download2")
	public void download2(HttpServletResponse response, HttpServletRequest request, String path) throws Exception {
		try {
			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Post 다운로드 진입 : " + path);
			File file = new File(path);
			// 한글화
			response.setHeader("Content-Disposition", "attachment;filename=" + new String(file.getName().getBytes("UTF-8"), "ISO-8859-1")); 
			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 한글화된 경로는 : " + path);
			
			// 파일 읽어오기
			FileInputStream fis = new FileInputStream(path); 
			OutputStream out = response.getOutputStream();
			int read = 0;
			byte[] buffer = new byte[1024];
			while ((read = fis.read(buffer)) != -1) { // 1024바이트씩 계속 읽으면서 outputStream에 저장, -1이 나오면 더이상 읽을 파일이 없음
				out.write(buffer, 0, read);
			}
			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("download error");
		}
	}
	
	
}

