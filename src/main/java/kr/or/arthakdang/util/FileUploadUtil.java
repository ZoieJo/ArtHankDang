package kr.or.arthakdang.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileUploadUtil {
	private static final Logger logger =  LoggerFactory.getLogger(FileUploadUtil.class);
	
//	public static String uploadFolder = "D:\\A_TeachingMaterial\\6.JspSpring\\springProj\\src\\main\\webapp\\resources\\upload";
	public static String uploadFolder =  "C:\\upload\\thumbnail";
	
	//날짜 계층형 폴더
	public static String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		//str : 2021-11-02
		String str = sdf.format(date);
		//2021폴더 > 11폴더 > 02폴더
		return str.replace("-", File.separator);
	}
	
	//이미지의 경우에만 섬네일 제작
	public static boolean checkImageType(File file) {
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
}
