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

	// ????????????(???????????? ???????????? ??????)
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

	// ??????-???????????? Ajax??????
	@PostMapping(value = "/cslrg/applyWrite", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int CslrgApply(@RequestBody CslrgVO vo) {
		log.info(">>>>>>???????????? ??????" + vo.toString());
		return cslrgService.insertCslrg(vo);
	}

	// ????????? ???????????? ????????????
	@PostMapping(value = "/cslrg/timeList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<String> DateTimeList(String r_date) {
		log.info("??????>>>>>>" + r_date);
		List<String> cslTimeList = cslrgService.cslTimeList(r_date);
		log.info("???????>>>>" + cslTimeList);
		return cslTimeList;
	}


	// ?????????????????? ????????????
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
	// ???????????????????????? ????????????
	@GetMapping("/newCslrg/detail")
	public String counseListNewDetail(String cslrgNo, Model model) {
		CslrgVO detailNo = cslrgService.selectCslrg(cslrgNo);
		model.addAttribute("detailNo", detailNo);
		return "newCslrg/cslrgNewDetail";
	}

	// ???????????? ????????????
	@PostMapping(value = "/cslrg/updateCslrg", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int counselUpdate(@RequestBody CslrgVO vo) {
		log.info("??????>>>>>>>" + vo);
		return cslrgService.updateCslrg(vo);
	}

	// ???????????? ????????????
	@PostMapping(value = "/cslrg/deleteCslrg", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int counselDelete(String cslrgNo) {
		log.info("??????>>>>>" + cslrgNo);

		return cslrgService.deleteCslrg(cslrgNo);
	}
	
//?????????????????? ?????????----------------------------------------------------------------------		
	// ???????????? ?????? ????????????
	@GetMapping("/cslrg/cslList")
	public String CounselList(CslrgPageCondDTO pageCondDTO, Model model) {
		SecurityContext secContext = SecurityContextHolder.getContext();
		String stuId = secContext.getAuthentication().getName();
		CustomUser userDetail = (CustomUser) customUserDetailsService.loadUserByUsername(stuId);
		String memberCode = userDetail.getMember().getMemCmcd();

		
		pageCondDTO.setMemId(stuId);
		log.info("??????>>>>>>>>" + pageCondDTO.getMemId());
		
		CslrgPageDTO pageDTO = new CslrgPageDTO(pageCondDTO, cslrgService.countCslrgNm(pageCondDTO.getKeyword()));
		List<CslrgVO> cslList = cslrgService.getCountCslrgListPage(pageCondDTO);
		
		log.info("page>>>>" + cslList.toString());
		
		model.addAttribute("memStu", memberCode);
		model.addAttribute("cslList", cslList);
		model.addAttribute("pageDTO", pageDTO);
		return "cslrg/cslrgList";
	}
	


	
	

//?????????????????? ??????----------------------------------------------------------------------	

	// ?????? ???????????? ??????
	@GetMapping("/cslrcd/cslrcdList")
	public String CslrcdList(CslrgPageCondDTO pageCondDTO,Model model) {
		
		CslrgPageDTO pageDTO = new CslrgPageDTO(pageCondDTO, cslrgService.countCslrdCnt(pageCondDTO.getKeyword()));
		List<CslrgVO> allList = cslrgService.cslcdList(pageCondDTO);		
		
		model.addAttribute("allList", allList);
		model.addAttribute("pageDTO", pageDTO);
		return "cslrcd/cslrcdList";
	}
	
	//???????????? ?????? ??????
	@PostMapping("/cslrcd/cslrgResultCnt")
	@ResponseBody
	public int counselResultCnt(@RequestBody CslrgVO vo) {
		log.info("???????????? ??????!! >>>>" + vo);
		return cslrgService.cslrgResultCnt(vo);
		
	}

	// ???????????? ?????? ?????? - ????????????
	@PostMapping(value = "/cslrcd/updateCslrcd", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String cslrcdUpdate(@RequestBody List<CslrgVO> lsVO) {
		log.info("???????????? ???????? ??????>>>>>" + lsVO);
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
			cslcaledar2.setSchdTl(cslrgVO.getCslrgNo()+"??????  " + cslrgVO.getCslStCmcd());
			cslcaledar2.setSchdCnt("?????? "+cslrgVO.getCslrgNo());
			cslcaledar2.setSchdSttDt(cslrgVO.getCslrgRsvDt());
			cslcaledar2.setSchdEndDt(cslrgVO.getCslrgRsvDt());
			cslcaledar2.setMemId(cslrgVO.getEmpId());
			calendarService.insertcslrgSchd(cslcaledar2);

			
			if (cslrgVO.getCslFdCmcd().equals("??????")) {
				log.info("???????????? ?????????!! ?????? ????????? ???????????? :  " + selectedVO.getCslrgPhNo());
				smsReciverMap.put("phone", selectedVO.getCslrgPhNo());
				smsRecieverMapList.add(smsReciverMap);
				continue;
			}
			
			smsReciverMap.put("phone", memberService.getOneStudentById(selectedVO.getStuId()).getStuPhNo());
			
			// ?????? ???????????? ?????? ???????????? ??????
			CalendarVO cslcaledar = new CalendarVO();
			cslcaledar.setSchdNo(cslrgVO.getCslrgNo());
			cslcaledar.setSchdTl("??????"+cslrgVO.getCslStCmcd());
			cslcaledar.setSchdCnt("?????? "+cslrgVO.getCslStCmcd());
			cslcaledar.setSchdSttDt(cslrgVO.getCslrgRsvDt());
			cslcaledar.setSchdEndDt(cslrgVO.getCslrgRsvDt());
			cslcaledar.setMemId(selectedVO.getStuId());
			calendarService.insertcslrgSchd(cslcaledar);
			
			smsRecieverMapList.add(smsReciverMap);

		}
		log.info("LIST SIZE : " + lsVO.size() + ", CNT : " + cnt);
		if (lsVO.size() == cnt) {
			
			log.info("?????? ?????? ??????!!");
			log.info("map list : " + smsRecieverMapList);
			for (HashMap<String, String> map : smsRecieverMapList) {
				try {
					log.info("????????? ?????? ???... ????????? : " + map.get("phone"));
					smsService.sendSms(map.get("phone"), "[????????????] ?????? ????????? ?????????????????????. ??????????????? ????????? ?????????.");
				} catch (Exception e) {
					throw new RuntimeException("?????? ?????? ??? ????????? ??????????????????.");
				}
			}

			rsltMSG = "Success";					
			log.info("????????? ??????>>>>>>" + cslrgSchd.toString());	
		}

		return rsltMSG;
	}
	
	//???????????? ??????
	@PostMapping(value = "/cslrcd/updateDetailCslrcd", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String cslrcdDetailUpdate(@RequestBody CslrgVO cslrgVO) {
		log.info("???????????? ???????? ??????>>>>>" + cslrgVO);
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
	// ???????????? ????????????
		@PostMapping(value = "/cslrg/deleteCslrgSchd", produces = "application/json;charset=utf-8")
		@ResponseBody
		public String cslrcdDelete(String cslrgNo) {
			log.info("??????>>>>>" + cslrgNo);
			String myMSG = "Fail";
			int delte = cslrgService.deleteCslrg(cslrgNo);
			if(delte == 1 ) {
				myMSG = "Success";
				calendarService.deleteCslrgSchd(cslrgNo);
			}
			return myMSG;			
		}	

	//?????? ????????????
		@GetMapping("/cslrcd/cslrcdSub")
		public String CslrcdSubList(CslrgPageCondDTO pageCondDTO, Model model) {	
			CslrgPageDTO pageDTO = new CslrgPageDTO(pageCondDTO, cslrgService.countSubList(pageCondDTO.getKeyword()));
			List<CslrgVO> allList = cslrgService.cslcdSubList(pageCondDTO);
			model.addAttribute("allList", allList); 
			model.addAttribute("pageDTO", pageDTO);
			return "cslrcd/cslrcdSub";
		}
		
	//?????? ???????????? view 
		@GetMapping("newCslrg/write")
		public String CounselNewWrite() {
			return "cslrg/newCslrgWrite";
		}
		
	//??????????????????
		@PostMapping("newCslrg/applyWrite")
		@ResponseBody
		public int NewCslrgApply(@RequestBody CslrgVO vo) {
			log.info("?????? ??????>>>>" + vo);
			return cslrgService.newCslrgInsert(vo);
		}

	//?????????????????? ??????
		@GetMapping("newCslrg/cslrdList")
		public String NewCslrgList(CslrgPageCondDTO pageCondDTO, Model model) {			
			CslrgPageDTO pageDTO = new CslrgPageDTO(pageCondDTO, cslrgService.countNewCslrgNm(pageCondDTO.getKeyword()));
			List<CslrgVO> cslrgList = cslrgService.newCslrgList(pageCondDTO);
			model.addAttribute("cslrgList",cslrgList);			
			model.addAttribute("pageDTO", pageDTO);
			return "cslrg/newCslrgList";
		}
		
		// ???????????? ????????? ???????????? ????????????
		@PostMapping(value = "/newCslrg/timeList", produces = "application/json;charset=utf-8")
		@ResponseBody
		public List<String> NewTimeList(String r_date) {
			log.info("??????>>>>>>" + r_date);
			List<String> cslTimeList = cslrgService.NewCslTimeList(r_date);
			log.info("???????>>>>" + cslTimeList);
			return cslTimeList;
		}
		
		// ?????????????????? ????????????
		@PostMapping(value = "/newCslrg/update", produces = "application/json;charset=utf-8")
		@ResponseBody
		public int newUpdate(@RequestBody CslrgVO vo) {
			log.info("??????>>>>>>>" + vo);
			return cslrgService.updateNewCslrg(vo);
		}

		
			
	
	//?????????????????? ??????
		@PostMapping(value = "newCslrg/deleteCslrg", produces = "application/json;charset=utf-8" )
		public int deleteNew (String cslrgNo) {
			log.info("?????? ??????>>>" + cslrgNo);
			return cslrgService.deleteNewCslrg(cslrgNo);
		}

}
