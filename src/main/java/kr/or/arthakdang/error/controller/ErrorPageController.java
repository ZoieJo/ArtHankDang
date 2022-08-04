package kr.or.arthakdang.error.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorPageController {

	@GetMapping("/errorpage")
	public String getNoAuth() {
		return "error/403";
	}
	
}
