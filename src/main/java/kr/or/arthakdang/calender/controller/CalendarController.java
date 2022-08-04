package kr.or.arthakdang.calender.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.calender.domain.CalendarVO;
import kr.or.arthakdang.calender.service.CalendarService;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@Controller
@RequestMapping("/schd")
public class CalendarController {
	
	@Autowired
	CalendarService calendarService;
	
	@RequestMapping("/calendar")
	public String CalenderScheduler(Model model) {
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();		
		List<CalendarVO> calPt = calendarService.selectCalendarPt(username);
		model.addAttribute("calPt",calPt);
		return "calender/mainCalendar";
	}	

	@GetMapping(value = "/callist",produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<CalendarVO> CalenderList() {
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();		
		List<CalendarVO> calPt = calendarService.selectCalendarPt(username);		
		for(CalendarVO vo : calPt) {
			log.info("vo : " + vo.toString());
		}
		return calPt;
	}	

//작성 관련 window창 연결
	@RequestMapping("/calendar/write")
	public String CalenderWrite(String username, Model model) {
		model.addAttribute("USERNAME", username);
		model.addAttribute("memAcc", calendarService.selectMem(username));
		return "calender/write.root";
	}
	
//수정 관련 window창 연결
	@RequestMapping("/calendar/update")
	public String CalenderUpdate(String username, String schdNo ,Model model) {
		log.info(">>>>>>>>>>"+username+schdNo);
		CalendarVO vo = calendarService.selectCalendar(schdNo);
		model.addAttribute("vo", vo);
		model.addAttribute("memAcc", calendarService.selectMem(username));
		return "calender/update.root";
	}
	
//일정추가 Controller - Ajax방식
	@PostMapping(value = "/write", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int calendarWrite(@RequestBody CalendarVO vo) {
		log.info(">>>>>>>>>추가" + vo.toString());
		return calendarService.insertCalendar(vo);
	}
	
//일정삭제
	@PostMapping(value = "/delete", produces = "application/json;charset=utf-8")	 
	@ResponseBody 
	public int calendarDelete(String schdNo) {
		log.info("삭제>>>>>>>>" + schdNo);
		return calendarService.deleteCalendar(schdNo);
	}
	
//일정수정	
	@PostMapping(value = "/update", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int calendarUpdate(@RequestBody CalendarVO vo) {
		log.info("수정>>>>>>>>>>" + vo);
		return calendarService.updateCalendar(vo);
	}	
	
	
}
