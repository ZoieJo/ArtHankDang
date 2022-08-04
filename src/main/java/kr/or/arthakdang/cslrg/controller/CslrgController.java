package kr.or.arthakdang.cslrg.controller;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.arthakdang.calender.domain.CalendarVO;
import kr.or.arthakdang.calender.service.CalendarService;
import kr.or.arthakdang.common.service.MemberService;
import kr.or.arthakdang.cslrg.domain.CslrgPageCondDTO;
import kr.or.arthakdang.cslrg.domain.CslrgPageDTO;
import kr.or.arthakdang.cslrg.domain.CslrgVO;
import kr.or.arthakdang.cslrg.service.CslrgService;
import kr.or.arthakdang.domain.MemberDetailInfo;
import kr.or.arthakdang.security.service.CustomUserDetailsService;
import kr.or.arthakdang.security.user.CustomUser;
import kr.or.arthakdang.sens.api.service.SmsService;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
@Slf4j
public class CslrgController {
	
	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	@Autowired
	private CslrgService cslrgService;

	@Autowired
	private CalendarService calendarService;
	
	@Autowired
	private SmsService smsService;
	
	@Autowired
	private MemberService memberService;

	// 상담신청(학생이름 불러오기 설정)
	@GetMapping("/cslrg/write")
	public String Counsel(Model model) {
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		CustomUser userDetail = (CustomUser) customUserDetailsService.loadUserByUsername(username);
		MemberDetailInfo member = userDetail.getMemberDetail();
		String memberCode = userDetail.getMember().getMemCmcd();

		log.info("memCmcd >>>>>>>>>>> " + memberCode);

		model.addAttribute("memStu", memberCode);
		model.addAttribute("member", member);
		return "cslrg/cslrgWrite";
	}

	// 학생-상담신청 Ajax방식
	@PostMapping(value = "/cslrg/applyWrite", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int CslrgApply(@RequestBody CslrgVO vo) {
		log.info(">>>>>>상담예약 확인" + vo.toString());
		return cslrgService.insertCslrg(vo);
	}

	// 날짜별 예약시간 가져오기
	@PostMapping(value = "/cslrg/timeList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<String> DateTimeList(String r_date) {
		log.info("확인>>>>>>" + r_date);
		List<String> cslTimeList = cslrgService.cslTimeList(r_date);
		log.info("오나?>>>>" + cslTimeList);
		return cslTimeList;
	}


	// 상담내역에서 상세보기
	@GetMapping("/cslrg/detail")
	public String counseListDetail(String cslrgNo, Model model) {
		SecurityContext secContext = SecurityContextHolder.getContext();
		String stuId = secContext.getAuthentication().getName();
		CustomUser userDetail = (CustomUser) customUserDetailsService.loadUserByUsername(stuId);
		MemberDetailInfo member = userDetail.getMemberDetail();
		String memberCode = userDetail.getMember().getMemCmcd();
		log.info("member >>>>>>>> " + member.toString());
		CslrgVO detailNo = cslrgService.selectCslrg(cslrgNo);
		model.addAttribute("detailNo", detailNo);
		model.addAttribute("memStu", memberCode);
		model.addAttribute("member", member);

		return "cslrg/cslrgDetail";
	}
	// 신규상담내역에서 상세보기
	@GetMapping("/newCslrg/detail")
	public String counseListNewDetail(String cslrgNo, Model model) {
		CslrgVO detailNo = cslrgService.selectCslrg(cslrgNo);
		model.addAttribute("detailNo", detailNo);
		return "newCslrg/cslrgNewDetail";
	}

	// 상담신청 수정하기
	@PostMapping(value = "/cslrg/updateCslrg", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int counselUpdate(@RequestBody CslrgVO vo) {
		log.info("수정>>>>>>>" + vo);
		return cslrgService.updateCslrg(vo);
	}

	// 상담신청 삭제하기
	@PostMapping(value = "/cslrg/deleteCslrg", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int counselDelete(String cslrgNo) {
		log.info("삭제>>>>>" + cslrgNo);

		return cslrgService.deleteCslrg(cslrgNo);
	}
	
//상담내역관리 페이징----------------------------------------------------------------------		
	// 상담내역 목록 가져오기
	@GetMapping("/cslrg/cslList")
	public String CounselList(CslrgPageCondDTO pageCondDTO, Model model) {
		SecurityContext secContext = SecurityContextHolder.getContext();
		String stuId = secContext.getAuthentication().getName();
		CustomUser userDetail = (CustomUser) customUserDetailsService.loadUserByUsername(stuId);
		String memberCode = userDetail.getMember().getMemCmcd();

		
		pageCondDTO.setMemId(stuId);
		log.info("확인>>>>>>>>" + pageCondDTO.getMemId());
		
		CslrgPageDTO pageDTO = new CslrgPageDTO(pageCondDTO, cslrgService.countCslrgNm(pageCondDTO.getKeyword()));
		List<CslrgVO> cslList = cslrgService.getCountCslrgListPage(pageCondDTO);
		
		log.info("page>>>>" + cslList.toString());
		
		model.addAttribute("memStu", memberCode);
		model.addAttribute("cslList", cslList);
		model.addAttribute("pageDTO", pageDTO);
		return "cslrg/cslrgList";
	}
	


	
	

//상담내역관리 관련----------------------------------------------------------------------	

	// 상담 신청현황 관리
	@GetMapping("/cslrcd/cslrcdList")
	public String CslrcdList(CslrgPageCondDTO pageCondDTO,Model model) {
		
		CslrgPageDTO pageDTO = new CslrgPageDTO(pageCondDTO, cslrgService.countCslrdCnt(pageCondDTO.getKeyword()));
		List<CslrgVO> allList = cslrgService.cslcdList(pageCondDTO);		
		
		model.addAttribute("allList", allList);
		model.addAttribute("pageDTO", pageDTO);
		return "cslrcd/cslrcdList";
	}
	
	//상담결과 입력 수정
	@PostMapping("/cslrcd/cslrgResultCnt")
	@ResponseBody
	public int counselResultCnt(@RequestBody CslrgVO vo) {
		log.info("상담결과 입력!! >>>>" + vo);
		return cslrgService.cslrgResultCnt(vo);
		
	}

	// 상담신청 현황 관리 - 상담배정
	@PostMapping(value = "/cslrcd/updateCslrcd", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String cslrcdUpdate(@RequestBody List<CslrgVO> lsVO) {
		log.info("수정되고 있나?? 확인>>>>>" + lsVO);
		int cnt = 0;
		String rsltMSG = "Fail";
	
		List<CalendarVO> cslrgSchd = new ArrayList<CalendarVO>();
		List<HashMap<String, String>> smsRecieverMapList = new ArrayList<HashMap<String, String>>();
		
		for (CslrgVO cslrgVO : lsVO) {
			HashMap<String, String> smsReciverMap = new HashMap<String, String>();
			CslrgVO selectedVO = cslrgService.selectCslrg(cslrgVO.getCslrgNo());
			
			log.info("merong: " + cslrgVO);
			cnt += cslrgService.updateCslrcd(cslrgVO);

			CalendarVO cslcaledar2 = new CalendarVO();
			cslcaledar2.setSchdNo(cslrgVO.getCslrgNo());
			cslcaledar2.setSchdTl(cslrgVO.getCslrgNo()+"상담  " + cslrgVO.getCslStCmcd());
			cslcaledar2.setSchdCnt("상담 "+cslrgVO.getCslrgNo());
			cslcaledar2.setSchdSttDt(cslrgVO.getCslrgRsvDt());
			cslcaledar2.setSchdEndDt(cslrgVO.getCslrgRsvDt());
			cslcaledar2.setMemId(cslrgVO.getEmpId());
			calendarService.insertcslrgSchd(cslcaledar2);

			
			if (cslrgVO.getCslFdCmcd().equals("신규")) {
				log.info("신규상담 감지됨!! 맵에 추가한 전화번호 :  " + selectedVO.getCslrgPhNo());
				smsReciverMap.put("phone", selectedVO.getCslrgPhNo());
				smsRecieverMapList.add(smsReciverMap);
				continue;
			}
			
			smsReciverMap.put("phone", memberService.getOneStudentById(selectedVO.getStuId()).getStuPhNo());
			
			// 학생 캘린더에 일정 추가하는 방식
			CalendarVO cslcaledar = new CalendarVO();
			cslcaledar.setSchdNo(cslrgVO.getCslrgNo());
			cslcaledar.setSchdTl("상담"+cslrgVO.getCslStCmcd());
			cslcaledar.setSchdCnt("상담 "+cslrgVO.getCslStCmcd());
			cslcaledar.setSchdSttDt(cslrgVO.getCslrgRsvDt());
			cslcaledar.setSchdEndDt(cslrgVO.getCslrgRsvDt());
			cslcaledar.setMemId(selectedVO.getStuId());
			calendarService.insertcslrgSchd(cslcaledar);
			
			smsRecieverMapList.add(smsReciverMap);

		}
		log.info("LIST SIZE : " + lsVO.size() + ", CNT : " + cnt);
		if (lsVO.size() == cnt) {
			
			log.info("문자 전송 시작!!");
			log.info("map list : " + smsRecieverMapList);
			for (HashMap<String, String> map : smsRecieverMapList) {
				try {
					log.info("메세지 전송 중... 수신자 : " + map.get("phone"));
					smsService.sendSms(map.get("phone"), "[아트학당] 상담 신청이 승인되었습니다. 상담일정은 확인해 주세요.");
				} catch (Exception e) {
					throw new RuntimeException("상담 처리 중 오류가 발생했습니다.");
				}
			}

			rsltMSG = "Success";					
			log.info("진예인 바보>>>>>>" + cslrgSchd.toString());	
		}

		return rsltMSG;
	}
	
	//상담신청 수정
	@PostMapping(value = "/cslrcd/updateDetailCslrcd", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String cslrcdDetailUpdate(@RequestBody CslrgVO cslrgVO) {
		log.info("수정되고 있나?? 확인>>>>>" + cslrgVO);
		String rsltMSG = "Fail";
		log.info("merong: " + cslrgVO);
		
		int cnt = cslrgService.updateCslrg(cslrgVO);
		if (cnt == 1) {			
			rsltMSG = "Success";
			
			CalendarVO cslcaledar = new CalendarVO();
			cslcaledar.setSchdNo(cslrgVO.getCslrgNo());
			cslcaledar.setSchdTl(cslrgVO.getCslrgCnt());
			cslcaledar.setSchdCnt(cslrgVO.getCslrgCnt());
			cslcaledar.setSchdSttDt(cslrgVO.getCslrgRsvDt());
			cslcaledar.setSchdEndDt(cslrgVO.getCslrgRsvDt());			
			cslcaledar.setMemId(cslrgVO.getStuId());			
			calendarService.updatecslrgSchd(cslcaledar);	
			cslcaledar.setMemId(cslrgVO.getEmpId());
			calendarService.updatecslrgSchd(cslcaledar);	
		}
		return rsltMSG;
	}
	// 상담신청 삭제하기
		@PostMapping(value = "/cslrg/deleteCslrgSchd", produces = "application/json;charset=utf-8")
		@ResponseBody
		public String cslrcdDelete(String cslrgNo) {
			log.info("삭제>>>>>" + cslrgNo);
			String myMSG = "Fail";
			int delte = cslrgService.deleteCslrg(cslrgNo);
			if(delte == 1 ) {
				myMSG = "Success";
				calendarService.deleteCslrgSchd(cslrgNo);
			}
			return myMSG;			
		}	

	//목록 가져오기
		@GetMapping("/cslrcd/cslrcdSub")
		public String CslrcdSubList(CslrgPageCondDTO pageCondDTO, Model model) {	
			CslrgPageDTO pageDTO = new CslrgPageDTO(pageCondDTO, cslrgService.countSubList(pageCondDTO.getKeyword()));
			List<CslrgVO> allList = cslrgService.cslcdSubList(pageCondDTO);
			model.addAttribute("allList", allList); 
			model.addAttribute("pageDTO", pageDTO);
			return "cslrcd/cslrcdSub";
		}
		
	//신규 상담신청 view 
		@GetMapping("newCslrg/write")
		public String CounselNewWrite() {
			return "cslrg/newCslrgWrite";
		}
		
	//신규상담신청
		@PostMapping("newCslrg/applyWrite")
		@ResponseBody
		public int NewCslrgApply(@RequestBody CslrgVO vo) {
			log.info("신규 추가>>>>" + vo);
			return cslrgService.newCslrgInsert(vo);
		}

	//신규상담신청 내역
		@GetMapping("newCslrg/cslrdList")
		public String NewCslrgList(CslrgPageCondDTO pageCondDTO, Model model) {			
			CslrgPageDTO pageDTO = new CslrgPageDTO(pageCondDTO, cslrgService.countNewCslrgNm(pageCondDTO.getKeyword()));
			List<CslrgVO> cslrgList = cslrgService.newCslrgList(pageCondDTO);
			model.addAttribute("cslrgList",cslrgList);			
			model.addAttribute("pageDTO", pageDTO);
			return "cslrg/newCslrgList";
		}
		
		// 신규상담 날짜별 예약시간 가져오기
		@PostMapping(value = "/newCslrg/timeList", produces = "application/json;charset=utf-8")
		@ResponseBody
		public List<String> NewTimeList(String r_date) {
			log.info("확인>>>>>>" + r_date);
			List<String> cslTimeList = cslrgService.NewCslTimeList(r_date);
			log.info("오나?>>>>" + cslTimeList);
			return cslTimeList;
		}
		
		// 신규상담신청 수정하기
		@PostMapping(value = "/newCslrg/update", produces = "application/json;charset=utf-8")
		@ResponseBody
		public int newUpdate(@RequestBody CslrgVO vo) {
			log.info("수정>>>>>>>" + vo);
			return cslrgService.updateNewCslrg(vo);
		}

		
			
	
	//신규상담내역 삭제
		@PostMapping(value = "newCslrg/deleteCslrg", produces = "application/json;charset=utf-8" )
		public int deleteNew (String cslrgNo) {
			log.info("목록 삭제>>>" + cslrgNo);
			return cslrgService.deleteNewCslrg(cslrgNo);
		}

}
