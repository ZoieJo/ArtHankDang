package kr.or.arthakdang.error.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;

/**
 * 예외처리
 * @author jerry
 */
@ControllerAdvice
@Slf4j
public class ErrorController {

	@ExceptionHandler(HttpClientErrorException.class) //  그 외 400대 오류
	public String ErrorCode400s(HttpClientErrorException e) {
		log.info("그 외 400대 오류 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + e.getMessage()); 
		return "error/400";
	}
	
	@ExceptionHandler({RuntimeException.class, NullPointerException.class}) // 505
	public String runTimeError(RuntimeException e) {
		log.info("런타임 에러 및 널포인터 에러 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "+ e.getMessage());
		return "error/505";
	}	
//	@ExceptionHandler(AccessDeniedException.class)
//	public String noAuth(AccessDeniedException  e) {
//		log.info("권한 없음 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + e.getMessage()); // 505
//		return "error/test7";
//	}
	
	@ExceptionHandler(NoHandlerFoundException.class) // 아예 페이지 존재 X
	public String handle404(NoHandlerFoundException e) {
		log.info("헨들러 없음 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ " + e.getMessage()); // 404
		return "error/404(2)";
	}
	
	// 500
	@ExceptionHandler(Exception.class) // 500 AccessDeniedException.class
	public String internalServerError(final Exception e) {
		log.info("내부 서버 예외 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "+ e.getMessage());
		return "error/500(2)";
	}

	
}
