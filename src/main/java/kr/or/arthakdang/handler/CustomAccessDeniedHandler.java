package kr.or.arthakdang.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException ade) throws IOException, ServletException {
		log.info("왔어요 왔다구요~~");
		log.info("Error : "+ ade.getMessage());
		response.sendRedirect(request.getContextPath() + "/error/errorpage");

	}

}
