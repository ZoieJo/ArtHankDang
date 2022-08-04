package kr.or.arthakdang.lecturemanagement.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.lecturemanagement.domain.LectureListPageCountVO;
import kr.or.arthakdang.lecturemanagement.domain.LectureStudentVO;
import kr.or.arthakdang.lecturemanagement.domain.LectureVO;
import kr.or.arthakdang.lecturemanagement.domain.PageVO;
import kr.or.arthakdang.lecturemanagement.domain.SearchLecturePageVO;
import kr.or.arthakdang.lecturemanagement.service.LectureManagementService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LectureManagementController {

	@Autowired
	private LectureManagementService lectureManagementService;
	
	@GetMapping("/lecture/management")
	public String getLectureManagement(Model model, LectureListPageCountVO lectureListPageCountVO) {
		PageVO pageVO = new PageVO(lectureListPageCountVO, lectureManagementService.lectureCnt());
		List<LectureVO> lectureList = lectureManagementService.lectureListPage(lectureListPageCountVO);
		log.info("lecturList > " + lectureList);
		model.addAttribute("lectureList", lectureList);
		model.addAttribute("pageVO", pageVO);
		
		return "lecture/lectureManagement";
	}
	
	@PostMapping(value = "/lecture/management/lectureInfo", produces = "application/json")
	@ResponseBody
	public LectureVO postlectureInfo(@RequestBody Map<String, String> cursNo) {
		log.info("cusrsNo > " + cursNo.get("cursNo"));
		
		LectureVO choiceLecture = lectureManagementService.choiceLecture(cursNo.get("cursNo"));
        
		log.info("cursLec" + choiceLecture);
		
		return choiceLecture;
	}
	
	@PostMapping(value = "/lecture/management/studentList", produces = "application/json")
	@ResponseBody
	public List<LectureStudentVO> postStudentList(Model model, @RequestBody Map<String, String> cursNo) {
		
		List<LectureStudentVO> studentList = lectureManagementService.lectureStudentList(cursNo.get("cursNo"));
		model.addAttribute("studentList", studentList);
		return studentList;
	}
	
	@PostMapping(value = "/lecture/management/searchStudent", produces = "application/json")
	@ResponseBody
	public List<LectureStudentVO> postSearchStudent(@RequestBody Map<String, String> values, LectureStudentVO lectureStudentVO) {
		lectureStudentVO.setCursNo(values.get("cursNo"));
		lectureStudentVO.setStuNm(values.get("stuNm"));
		log.info("cursNo > " + values.get("cursNo"));
		log.info("cursNo > " + values.get("stuNm"));
		List<LectureStudentVO> searchStudent = lectureManagementService.lectureSearchStudent(lectureStudentVO);
		
		return searchStudent;
	}
	
	@PostMapping(value = "/lecture/management/searchLecture", produces = "application/json")
	@ResponseBody
	public SearchLecturePageVO postSearchLecture(LectureListPageCountVO lectureListPageCountVO, @RequestBody Map<String, String> cursNm, SearchLecturePageVO searchLecturePageVO) {
		log.info("cursNM > " + cursNm.get("cursNm"));
		lectureListPageCountVO.setCursNm(cursNm.get("cursNm"));
		List<LectureVO> searchLecture = lectureManagementService.searchLectureListPage(lectureListPageCountVO);
		searchLecturePageVO.setLectureList(searchLecture);
		searchLecturePageVO.setPageVO(new PageVO(lectureListPageCountVO, lectureManagementService.searchLectureCnt(cursNm.get("cursNm"))));
		return searchLecturePageVO;
	}
	
	@PostMapping(value = "/lecture/management/page", produces = "application/json")
	@ResponseBody
	public SearchLecturePageVO getLectureListPageCount(SearchLecturePageVO searchLecturePageVO, LectureListPageCountVO lectureListPageCountVO, @RequestBody Map<String, String> values) {
		if(values.get("cursNm") == null || values.get("cursNm") == "") {
		lectureListPageCountVO.setPageNum(Integer.parseInt(values.get("pageNum")));
		log.info("pageNum > " + values.get("pageNum"));
		log.info("cursNm > " + values.get("cursNm"));
		PageVO pageVO = new PageVO(lectureListPageCountVO, lectureManagementService.lectureCnt());
		List<LectureVO> lectureList = lectureManagementService.lectureListPage(lectureListPageCountVO);
		searchLecturePageVO.setLectureList(lectureList);
		searchLecturePageVO.setPageVO(pageVO);
		log.info("lecturList > " + lectureList);
		return searchLecturePageVO;
		} else {
		log.info("cursNM > " + values.get("cursNm"));
		lectureListPageCountVO.setPageNum(Integer.parseInt(values.get("pageNum")));
		lectureListPageCountVO.setCursNm(values.get("cursNm"));
		List<LectureVO> searchLecture = lectureManagementService.searchLectureListPage(lectureListPageCountVO);
		searchLecturePageVO.setLectureList(searchLecture);
		PageVO pageVO = new PageVO(lectureListPageCountVO, lectureManagementService.searchLectureCnt(values.get("cursNm")));
		searchLecturePageVO.setPageVO(pageVO);
		return searchLecturePageVO;
		}
	}
}
 