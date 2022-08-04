package kr.or.arthakdang.alarm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/alarm")
public class Alram {
	
	@GetMapping("/echo")
	public String getAlarm() {
		return "alarm/alarm";
	}
}
