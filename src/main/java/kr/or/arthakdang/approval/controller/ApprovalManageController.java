package kr.or.arthakdang.approval.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.approval.domain.AprldocVO;
import kr.or.arthakdang.approval.domain.AprllnVO;
import kr.or.arthakdang.approval.domain.UsdeaprllnVO;
import kr.or.arthakdang.approval.domain.UsdeaprllndtlVO;
import kr.or.arthakdang.approval.domain.UsdeaprlreflnVO;
import kr.or.arthakdang.approval.service.ApprovalService;
import kr.or.arthakdang.domain.CurspnVO;
import kr.or.arthakdang.domain.MemberDetailInfo;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import kr.or.arthakdang.security.service.CustomUserDetailsService;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@Slf4j
@RequestMapping("/aprl")
public class ApprovalManageController {
	
	@Autowired
	private ApprovalService service;
	
	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	@GetMapping("/main")
	public String documentManage() {
		return "approval/approvalMain";
	}
	
	@GetMapping("/tmpbox")
	public String getTemporaryBox(Model model) {
		
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		List<AprldocVO> tmpList = service.tempAprldocList(username);
		
		model.addAttribute("tmpList", tmpList);
		
		return "approval/temporaryBox";
	}
	
	@GetMapping("/sendbox")
	public String getSendBox(Model model) {
		
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		List<AprldocVO> aprldocList = service.getSendboxList(username);
		
		model.addAttribute("aprldocList", aprldocList);
		
		return "approval/sendBox";
	}
	
	@GetMapping("/receivebox")
	public String getReceiveBox() {
		return "approval/receiveBox";
	}
	
	@GetMapping("/line")
	public String getRegistLine(Model model) {
		
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		CustomUser userDetail = (CustomUser) customUserDetailsService.loadUserByUsername(username);
		MemberDetailInfo member = userDetail.getMemberDetail();
		
		List<EmployeeVO> empList = service.empList(username);
		List<UsdeaprllnVO> aprllnList = service.getAprllnNo(username);
		
		model.addAttribute("empList", empList);
		model.addAttribute("aprllnList", aprllnList);
		model.addAttribute("memInfo", member);
		
		return "approval/registLine";
	}
	
	@PostMapping(value = "/mkLine", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String postMkLine(@RequestBody Map<String, Object> map) {
		
		UsdeaprllnVO usdeaprllnVO = new UsdeaprllnVO();
		usdeaprllnVO.setUsdeaprllnTl((String)map.get("usdeaprllnTl"));
		usdeaprllnVO.setMemId((String)map.get("memId"));
		
		List<UsdeaprllndtlVO> detailList = (List<UsdeaprllndtlVO>)map.get("usdeaprllndtl");
		List<UsdeaprlreflnVO> refList = (List<UsdeaprlreflnVO>)map.get("usdeaprlrefln");
		
		log.info("사용자 정의 결재 라인 상세  >>>>>>>>>>>>>>>>> " + detailList.toString());
		log.info("사용자 정의 결재 참조 라인 >>>>>>>>>>>>>>>>>> " + refList.toString());
		
		
		// 전자결재 사용자 정의 결재 라인 insert
		int mkCnt = service.insertUsdeaprlln(usdeaprllnVO);
		
		if(mkCnt > 0) {
			
			// 사용자 정의 결재라인 상세 insert
			int detailCnt = service.insertUsdeaprllndtl(map);
			
			if(detailCnt < 1) {
				return "결재라인 상세정보를 등록하는 중 오류가 발생하였습니다.";
			}
			
			if(refList.size() != 0) {
				int refCnt = service.insertUsdeaprlrefln(map);
				
				if(refCnt < 1) {
					return "참조 정보를 등록하는 중 오류가 발생하였습니다.";
				}
			}
			
		}else {
			return "결재 라인을 생성하는 중 오류가 발생하였습니다.";
		}
		
		
		return "결재선 등록을 완료하였습니다.";
	}
	
	@PostMapping(value = "/aprllnInfo", produces = "application/json; charset=utf-8")
	@ResponseBody
	public UsdeaprllnVO postAprllnInfo(@RequestBody UsdeaprllnVO vo) {
		log.info("확인하고 싶은 결재정보 >>>>>>>>>>>> " + vo.toString());
		log.info("" + service.getAprlln(vo));
		return service.getAprlln(vo);
	}
	
	@PostMapping(value = "/aprllnDelete", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteAprlLine(String usdeaprllnNo) {
		
		log.info("삭제하고 싶은 결재선 번호 >>>>>>>>>>>> " + usdeaprllnNo);
		
		// 결재참조라인에서 해당하는 번호에 대한 참조 삭제
		service.deleteAprlrefln(usdeaprllnNo);
		
		// 결재라인상세에서 해당하는 번호에 대한 상세정보 삭제
		service.deleteAprllndtl(usdeaprllnNo);
		
		// 결재라인 삭제
		int cnt = service.deleteAprlln(usdeaprllnNo);
		
		// delete의 성공여부를 저장할 변수
		String result = "";
		
		if(cnt > 0) {
			result = "삭제 성공";
		}else {
			result = "삭제 실패";
		}
		
		return result;
	}
	
	
	//기안문 작성 : 강의관련 결재 양식폼
	@GetMapping("/draftinPaper")
	public String draftinPaper(String aprldocNo, Model model) {
		
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		log.info("문서번호 >>>>>>>>>>> " + aprldocNo);
		
		AprldocVO aprldocInfo = new AprldocVO();
		
		if(aprldocNo != null) {
			aprldocInfo = service.aprldocInfo(aprldocNo);
		}
		
		EmployeeVO userInfo = service.userInfo(username);
		List<EmployeeVO> empList = service.empList(username);
		List<UsdeaprllnVO> aprllnList = service.getAprllnNo(username);
		List<CurspnVO> curspnList = service.getCurspnList();
		
		log.info(curspnList.toString());
		
		model.addAttribute("empList", empList);
		model.addAttribute("aprllnList", aprllnList);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("aprldocInfo", aprldocInfo);
		model.addAttribute("curspnList", curspnList);
		
		return "approval/draftinPaper";
	}
	
	@GetMapping(value = "/getPosition", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getPosition(String empId) {
		
		String empPosiNm = service.getEmpPosition(empId);
		
		return empPosiNm;
	}
	
	@PostMapping(value="/saveAprldocTemp", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String saveAprlDocTemp(@RequestBody AprldocVO vo) {
		
		String result = "";
		
		log.info("임시저장 VO >>>>> " + vo.toString());
		
		
		if(vo.getRefDoc() == null) {
			vo.setRefDoc("");
		}
		
		int cnt = 0;

		// 임시저장하였을 때 결재문서번호가 없을 경우 insert, 문서번호가 있을 경우 update
		if(vo.getAprldocNo() == null || vo.getAprldocNo().equals("")) {
			cnt = service.saveAprlTemp(vo);			
		}else {
			cnt = service.updateAprlTemp(vo);
		}
		
		
		if(cnt > 0) {
			result = "success";
		}else if (cnt == 0) {
			result = "error";
		}
		
		
		return result;
	}
	
	@PostMapping(value="/sendAprldoc", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String postSendAprldoc(@RequestBody AprldocVO vo) {
		
		String result = "";
		
		log.info("vo >>>>>>>>>>>>>> " + vo.toString());
		
		int cnt = 0;
		
		// 결재문서 db에 정보 입력
		if(vo.getAprldocNo() == null || vo.getAprldocNo().equals("")) {
			// 전자결재 번호를 새로 입력해야 함으로 insert 해야함
			cnt = service.insertAprldoc(vo);
		}else {
			// 임시저장했던 결재문서이므로 update를 해서 결재상태를 바꿔줘야 함
		}
		
		
		
		// 결재선 등록
		List<AprllnVO> list = vo.getAprllnList();
		
		// 결재선 insert
		if(cnt > 0 ) {
			cnt = 0;
			for(int i = 0 ; i < list.size() ; i++) {
				cnt = service.insertAprlln(list.get(i));
			}
		}
		
		// 참조문서 상태 변경
		if(vo.getRefDoc() == null) {
			vo.setRefDoc("");
		}else {
			// 강의 계획서 신청상태를 승인중으로 바꿔야 함
		}

		
		return result;
	}
	
	
	//기안문 작성 : 강의관련 결재 양식폼
	@GetMapping("/holidayPaper")
	public String holidayPaper() {
		
		return "approval/holidayPaper";
	}
	
	
	
	
}
