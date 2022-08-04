package kr.or.arthakdang.security.interceptor;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PasswordCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("interceptor prehandle");
		String username = SecurityContextHolder.getContext().getAuthentication().getName();
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);

		String q = "";

		if (request.getRequestURI().contains("mypage")) {
			q = "dir=mypage";
		}
		if (request.getRequestURI().contains("newCslrg")) {
			q = "dir=cslrg&cslrgNo="+request.getParameter("cslrgNo");

		}

		if (inputFlashMap == null) {
			log.info("sendRedirect...");
			response.sendRedirect("/arthakdang/check?" + q);
			return false;
		}
		if (inputFlashMap.containsKey("pwChecked")) {
			log.info("pwChecked");
			
			return true;
		}

		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

}
