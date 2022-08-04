package kr.or.arthakdang.intro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/intro")
public class IntroController {
	
	@GetMapping("/greet")
	public String getGreet() {
		return "intro/greet";
	}
	@GetMapping("/group")
	public String getGroup() {
		return "intro/group";
	}
	@GetMapping("/map")
	public String getMap() {
		return "intro/map";
	}
}
