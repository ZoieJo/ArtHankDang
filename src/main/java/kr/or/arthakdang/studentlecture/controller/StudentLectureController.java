package kr.or.arthakdang.studentlecture.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import kr.or.arthakdang.studentlecture.domain.StudentLectureVO;
import kr.or.arthakdang.studentlecture.service.StudentLectureService;

@Controller
public class StudentLectureController {

	@Autowired
	private StudentLectureService studentLectureService;
	
	@GetMapping("/lecture/studentLecture")
	public String getStudentLecture(Model model, StudentLectureVO studentLectureVO, @CurrentUser CustomUser user) {
		studentLectureVO.setStuId(user.getMember().getMemId());
		List<StudentLectureVO> studentLectureList = studentLectureService.StudentLectureList(studentLectureVO);
		model.addAttribute("studentLectureList", studentLectureList);
		return "lecture/studentLecture";
	}
	
	@PostMapping(value = "/lecture/studentLecture/Info", produces = "application/json")
	@ResponseBody
	public StudentLectureVO lectureInfo(StudentLectureVO studentLectureVO, @RequestBody Map<String, String> values, @CurrentUser CustomUser user) {
		studentLectureVO.setStuId(user.getMember().getMemId());
		studentLectureVO.setCursNo(values.get("cursNo"));
		StudentLectureVO lectureInfo = studentLectureService.lectureInfo(studentLectureVO);
		return lectureInfo;
	}
	
	@PostMapping(value = "/lecture/studentLecture/searchLecture", produces = "application/json")
	@ResponseBody
	public List<StudentLectureVO> searchLecture(StudentLectureVO studentLectureVO, @RequestBody Map<String, String> values, @CurrentUser CustomUser user) {
		studentLectureVO.setStuId(user.getMember().getMemId());
		studentLectureVO.setCursNm(values.get("cursNm"));
		List<StudentLectureVO> searchLectureList = studentLectureService.searchLecture(studentLectureVO);
		
		return searchLectureList;
	}
}
