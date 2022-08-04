package kr.or.arthakdang.crelecture.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.arthakdang.util.AttachFileVO;
import net.coobird.thumbnailator.Thumbnailator;
import kr.or.arthakdang.util.FileUploadUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UploadController {
	private static final Logger logger = 
			LoggerFactory.getLogger(UploadController.class);
	//파일업로드 폼
//	@RequestMapping("/uploadForm")
	@GetMapping("/uploadForm")
	public String uploadForm() {
		logger.info("uploadForm");
		
		return "uploadForm";
	}
	
	//파일업로드 처리
	//RequestMapping(value="/uploadFormAction",method=RequestMethod.POST)
	@PostMapping("/uploadFormAction")
	public String uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "C:\\upload\\thumbnail";
//		= "D:\\A_TeachingMaterial\\6.JspSpring\\springProj\\src\\main\\webapp\\resources\\upload";
		
		
		//파일명을 담아보자
		List<String> list = new ArrayList<String>();
		
		for(MultipartFile multipartFile : uploadFile) {
			logger.info("---------------------");
			logger.info("업로드 파일명 : " + multipartFile.getOriginalFilename());
			logger.info("업로드 파일 크기 : " + multipartFile.getSize());
			//파일 객체를 통해 이렇게 하겠다..
			File saveFile 
			= new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				//transferTo() 메서드의 파라미터 : java.io.File의 객체
				multipartFile.transferTo(saveFile);
				//파일명을 리스트에 담음
				list.add(multipartFile.getOriginalFilename());
			}catch(Exception ex) {
				logger.error(ex.getMessage());
			}//end catch
		}//end for
		//업로드 된 파일 목록을 모델에 담음
		model.addAttribute("list",list);
		return "uploadFormPost";
	}
	
	//아작스 이미지 업로드 폼
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		logger.info("upload ajax");
		// /uploadAjax URI 주소와 uploadAjax.jsp의 위치 및 파일명이 
		// 동일하여 return 생략 가능
	}
	
	//아작스 이미지 업로드 실행
	@ResponseBody
	@PostMapping("/uploadAjaxAction")
	public ResponseEntity<List<AttachFileVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		logger.info("update ajax post.......");
		
		List<AttachFileVO> list = new ArrayList<AttachFileVO>();
		
		String uploadFolder = "C:\\upload\\thumbnail";
//		= "D:\\A_TeachingMaterial\\6.JspSpring\\springProj\\src\\main\\webapp\\resources\\upload";
		
		//날짜 계층형 폴더 생성 시작 -----------------
		File uploadPath = new File(uploadFolder, getFolder());
		//...webapp_resources_upload_2021_11_02
		logger.info("uploadPath : " + uploadPath);
		//생성될 폴더가 존재하지 않으면
		if(uploadPath.exists() == false) {
			//해당 폴더들을 생성 => 연도 > 월 > 일 
			uploadPath.mkdirs();
		}
		//날짜 계층형 폴더 생성 끝 -----------------
		
		for(MultipartFile multipartFile : uploadFile) {
			AttachFileVO attachFileVo = new AttachFileVO();
			
			logger.info("------------------------");
			//IE에서는 파일명 : C:\Users\SEM-PC\Pictures\개똥이.jpg
			logger.info("파일명 : " + multipartFile.getOriginalFilename());
			logger.info("파일크기 : " + multipartFile.getSize());
			//실제 파일명
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE에서의 파일명의 경로를 처리 => 개똥이.jpg
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			logger.info("IE를 위해 처리한 파일명 : " + uploadFileName);
			//1) vo에 파일명 setting
			attachFileVo.setFileName(uploadFileName);
			
			//java.util.UUID 를 통해 파일 중복 방지
			//randomUUID() : 임의의 값을 생성
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;			
			
			//1) 목적지? 2) 파일명?
			//File saveFile = new File(uploadFolder, uploadFileName);
			File saveFile = new File(uploadPath, uploadFileName);
			
			//파일을 목적지로 복사하려면 파라미터가 File객체여야 함
			try {
				//파일 복사 실행
				multipartFile.transferTo(saveFile);
				
				logger.info("uploadPath.getAbsolutePath() : " 
						+ uploadPath.getAbsolutePath());
				//2) vo객체의 저장 경로 setting
				attachFileVo.setUploadPath(uploadPath.getAbsolutePath());
				//3) vo객체의 uuid setting
				attachFileVo.setUuid(uuid.toString());
				
				//섬네일 만들기 시작 ------------
				// /uploadAjax를 통해 이미지를 업로드 하면 
				// 1) 원본이미지 파일 저장
				// 2) 섬네일(s_원본이미지 파일) 파일 생성
				// but) 일반 파일은 원본 파일 저장
				//이미지인지 체킹
				if(checkImageType(saveFile)) {	//이미지인 경우
					//4) vo객체의 이미지 여부 setting
					attachFileVo.setImage(true);
					//썸네일 => s_이미지파일명(바이너리 파일 생성)
					FileOutputStream thumbnail = 
							new FileOutputStream(
								new File(uploadPath, "s_" + uploadFileName)
									);
					//InputStream과 java.io.File 객체를 이용하여 
					//썸네일 파일 생성. width:100px, height:100px;
					Thumbnailator.createThumbnail(
							multipartFile.getInputStream(),thumbnail,100,100
							);
					thumbnail.close();
					
				}
				//썸네일 만들기 끝 ------------
				
				list.add(attachFileVo);
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
		}//end for
		//JSON 데이터를 반환
//		return new ResponseEntity<>(list,HttpStatus.OK);
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	//날짜 계층형 폴더
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		//str : 2021-11-02
		String str = sdf.format(date);
		//2021폴더 > 11폴더 > 02폴더
		return str.replace("-", File.separator);
	}
	
	//이미지의 경우에만 섬네일 제작
	private boolean checkImageType(File file) {
		//MIME 타입을 통해 이미지 여부 확인
		//file.toPath() : 파일 객체를 path객체로 변환
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			logger.info("contentType : " + contentType);
			//MIME 타입 정보가 image로 시작하는지 여부를 return
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//이 파일은 이미지가 아니다.
		return false;
	}
	
	//첨부파일을 다운로드는 MIME 타입을 다운로드 타입으로 지정.
	//APPLICATION_OCTET_STREAM_VALUE : 다운로드할 수 있는 MIME타입
	//한글 이름 다운로드 시 IE는 Content-Disposition의 값을 처리하는
	//방식이 Chrome과 달라 따로 처리를 더 해줘야 함
	//User-Agent : HTTP 헤더 메시지 중에서 디바이스의 정보를 제공
	//			(웹브라우저의 종류, 모바일, 데스크톱..)
	@ResponseBody
	@RequestMapping(value="/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile( @RequestHeader("User-Agent") String userAgent, String fileName) {
		logger.info("download file : " + fileName);
		
		//파일이 있는 윈도 경로
		String uploadFolder = FileUploadUtil.uploadFolder;
		
		//...resources_upload_2021_11_05_개똥이.jpg
		Resource resource  = new FileSystemResource(uploadFolder + "\\" + fileName);
		
		//해당 파일이 없을때..
		if(resource.exists()==false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		logger.info("resource : " + resource);
		//파일명 가져오기
		String resourceName = resource.getFilename();
		
		//파일명이 한글이면 HttpHeaders 객체를 통해 처리
		HttpHeaders headers =  new HttpHeaders();
		try {
			String downloadName = null;
			
			if(userAgent.contains("Trident")) {//IE11
				log.info("IE browser");
				downloadName  = URLEncoder.encode(resourceName,"UTF-8").replaceAll("\\+", " ");
			}else if(userAgent.contains("Edge")) {//Edge
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceName,"UTF-8");
			}else {
				log.info("Chrome browser");
				downloadName = new String(resourceName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			//Content-disposition : 다운로드 시 저장되는 이름을 처리해줌
			headers.add("Content-disposition", "attachment;filename="+downloadName);
		}catch(UnsupportedEncodingException ex) {
			ex.printStackTrace();
		}
		//resource : 첨부파일 객체
		//headers : 파일명 처리 정보
		//...OK : 200(성공)
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
}
