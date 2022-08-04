package kr.or.arthakdang.mylecture.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.mylecture.domain.MyLectureStudentVO;
import kr.or.arthakdang.mylecture.domain.MyLectureVO;
import kr.or.arthakdang.mylecture.service.MyLectureService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MyLectureController {

	@Autowired
	private MyLectureService myLectureService;
	
	@GetMapping("/lecture/mylecture")
	public String getMyLecture(Model model, @CurrentUser CustomUser user) {
		List<MyLectureVO> myLectureList = myLectureService.myLectureList(user.getMember().getMemId());
		
		for(MyLectureVO myLectureVO : myLectureList) {
			int result = myLectureService.lectureStuCnt(myLectureVO);
			int avg = myLectureService.MyLectureScrAvg(myLectureVO);
			myLectureVO.setCursStuCnt(result);
			myLectureVO.setCursevaScrAvg(avg);
		}
		
		model.addAttribute("myLectureList", myLectureList);
		return "lecture/myLecture";
	}
	
	@PostMapping(value = "/lecture/mylecture/search", produces = "application/json")
	@ResponseBody
	public List<MyLectureVO> postSearchMyLecture(@RequestBody Map<String, String> values, MyLectureVO myLectureVO, @CurrentUser CustomUser user) {
		
		myLectureVO.setCursNm(values.get("cursNm"));
		myLectureVO.setTcrId(user.getMember().getMemId());
		log.info("mylecture > " + myLectureVO);
		List<MyLectureVO> searchMyLectureList = myLectureService.searchMyLecture(myLectureVO);
		for(MyLectureVO myLecture : searchMyLectureList) {
			log.info("myLecture 11 > " + myLecture);
			myLecture.setCursStuCnt(myLectureService.lectureStuCnt(myLecture));
			myLecture.setCursevaScrAvg(myLectureService.MyLectureScrAvg(myLecture));
		}
		return searchMyLectureList;
	}
	
	@PostMapping(value = "/lecture/mylecture/review", produces = "application/json")
	@ResponseBody
	public List<MyLectureVO> postMyLectureReview(@RequestBody Map<String, String> value, MyLectureVO myLectureVO, @CurrentUser CustomUser user) {
		myLectureVO.setCursNo(value.get("cursNo"));
		log.info("cursNo > " + value.get("cursNo"));
		myLectureVO.setTcrId(user.getMember().getMemId());
		List<MyLectureVO> myLectureReviewList = myLectureService.MyLectureReview(myLectureVO);
		log.info("reviewList" + myLectureReviewList);
		return myLectureReviewList;
	}
	
	@PostMapping(value = "/lecture/mylecture/info", produces = "application/json")
	@ResponseBody
	public MyLectureVO postMyLectureInfo(MyLectureVO myLectureVO, @RequestBody Map<String, String> values, @CurrentUser CustomUser user) {
		myLectureVO.setCursNo(values.get("cursNo"));
		myLectureVO.setTcrId(user.getMember().getMemId());
		MyLectureVO myLectureInfo = myLectureService.myLectureInfo(myLectureVO);
		return myLectureInfo;
	}
	
	@PostMapping(value = "/lecture/mylecture/studentList", produces = "application/json")
	@ResponseBody
	public List<MyLectureStudentVO> postMyLectureStudentList(MyLectureVO myLectureVO, @RequestBody Map<String, String> values, @CurrentUser CustomUser user) {
		
		myLectureVO.setCursNo(values.get("cursNo"));
		myLectureVO.setTcrId(user.getMember().getMemId());
		List<MyLectureStudentVO> myLectureStudentList = myLectureService.myLectureStudent(myLectureVO);
		
		return myLectureStudentList;
	}
	
	@PostMapping(value = "/lecture/mylecture/searchMyStudent", produces = "application/json")
	@ResponseBody
	public List<MyLectureStudentVO> postSearchMyStudentList(MyLectureVO myLectureVO, @RequestBody Map<String, String> values, @CurrentUser CustomUser user) {
		myLectureVO.setTcrId(user.getMember().getMemId());
		myLectureVO.setCursNo(values.get("cursNo"));
		myLectureVO.setStuNm(values.get("stuNm"));
		List<MyLectureStudentVO> myLectureSearchStudent = myLectureService.myLectureSearchStudent(myLectureVO);
		return myLectureSearchStudent;
	}
}