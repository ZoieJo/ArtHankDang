package kr.or.arthakdang.signup.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.common.service.MemberService;
import kr.or.arthakdang.domain.MemberDetailInfo;
import kr.or.arthakdang.signup.domain.CartVO;
import kr.or.arthakdang.signup.domain.CourseDetailVO;
import kr.or.arthakdang.signup.domain.CursPageCondDTO;
import kr.or.arthakdang.signup.domain.CursPageDTO;
import kr.or.arthakdang.signup.domain.OrderDetailVO;
import kr.or.arthakdang.signup.domain.OrderVO;
import kr.or.arthakdang.signup.domain.PaymentVO;
import kr.or.arthakdang.signup.service.SignupService;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/stdSignup")
@Slf4j
public class StdSignupController {

	// 수강신청 service
	@Autowired
	private SignupService service;
	
	// 마이페이지 service -> 수강신청 학생 정보를 불러오기
	@Autowired
	private MemberService memberService;
	

	// 수강신청 메인
	@GetMapping("/main")
	public String getSignup() {

		return "signup/stdMain";
	}

	// 강의 목록 화면
	@GetMapping("/list")
	public String getSignupList() {
		return "signup/stdsignuplist";
	}

	// 강의 목록 페이징
	@GetMapping("/curslist")
	public String getCourseList(CursPageCondDTO pageCondDTO, Model model) {

		// 현재 시큐리티 컨텍스트 정보 불러오기
		SecurityContext secContext = SecurityContextHolder.getContext();
		// 해당 컨텍스트의 인증정보에서 username(스프링의 username 개념으로 현재 mem_id에 해당)가져오기
		String username = secContext.getAuthentication().getName();

		pageCondDTO.setMemId(username);

		CursPageDTO pageDTO = new CursPageDTO(pageCondDTO, service.countCourseList(pageCondDTO));
		List<CourseDetailVO> cursList = service.getCourseListPage(pageCondDTO);

		log.info("ck >>>>>>>>>>>>> " + cursList.toString());

		model.addAttribute("cursList", cursList);
		model.addAttribute("pageDTO", pageDTO);

		return "signup/stdcourselist";
	}

	// 장바구니 목록 화면
	@GetMapping("/cartlist")
	public String getCartList(CursPageCondDTO pageCondDTO, Model model) {

		// 현재 시큐리티 컨텍스트 정보 불러오기
		SecurityContext secContext = SecurityContextHolder.getContext();
		// 해당 컨텍스트의 인증정보에서 username(스프링의 username 개념으로 현재 mem_id에 해당)가져오기
		String username = secContext.getAuthentication().getName();

		List<String> cursList = service.showCartCursNo(username);
		pageCondDTO.setCursList(cursList);
		pageCondDTO.setMemId(username);

		CursPageDTO pageDTO = new CursPageDTO(pageCondDTO, service.countCourseList(pageCondDTO));
		List<CourseDetailVO> cartList = service.showCartCursList(pageCondDTO);

		log.info("cartList >>>>>>>>>>>>>>>>>>>>>> " + cartList.toString());

		model.addAttribute("cartList", cartList);
		model.addAttribute("pageDTO", pageDTO);

		return "signup/stdCart";
	}

	// 강의 목록 장바구니에 담기
	@GetMapping(value = "/putCart", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String postPutCart(String cursNo) {

		// 현재 시큐리티 컨텍스트 정보 불러오기
		SecurityContext secContext = SecurityContextHolder.getContext();
		// 해당 컨텍스트의 인증정보에서 username(스프링의 username 개념으로 현재 mem_id에 해당)가져오기
		String username = secContext.getAuthentication().getName();

		CartVO cartVO = new CartVO();
		cartVO.setStuId(username);
		cartVO.setCursNo(cursNo);

		if (service.checkCart(cartVO) == 1) {
			return "이미 장바구니에 담겨진 강의입니다.";
		}

		int cnt = service.insertCart(cartVO);

		String result = "등록이 완료되었습니다.";

		log.info("cursNo >>>>> " + cursNo);
		return result;
	}

	// 강의에 대한 상세정보 조회
	@GetMapping("/detail")
	public String getDetail(String cursNo, Model model) {
		log.info("cursNo >>>>>>>>>>" + cursNo);

		List<CourseDetailVO> list = service.getCourseDetail(cursNo);
		log.info("list >>>>> " + list);

		model.addAttribute("cursInfo", list);

		return "signup/stdCourseDetail.root";
	}

	// 장바구니에 담긴 강의 삭제
	@PostMapping(value = "/deleteCurs", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String cursDeleteFromCart(String cartNo) {

		log.info("강의 번호 >>>>>>>>>>>>>>>>> " + cartNo);

		int cnt = service.deleteCursCart(cartNo);
		String result = "";

		if (cnt > 0) {
			result = "강의가 정상적으로 삭제되었습니다.";
		} else {
			result = "강의를 삭제하는데 실패하였습니다.";
		}

		return result;

	}
	

	// 강의 주문 화면
	@PostMapping(value = "/order", produces = "application/json;charset=utf-8")
	public String postCursOrder(@RequestParam("cursNo") List<String> cursNo, @RequestParam("totalPrice") int totalPrice, Model model) {

		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		MemberDetailInfo member = memberService.getOneStudentById(username);
		log.info(username + "의 정보 >>>>>>>>>>>> " + member.toString());
		log.info("cursNoList 정보 확인 >>>>>>> " + cursNo.toString());
		
		List<CourseDetailVO> cursInfo = service.getOrderInfo(cursNo);
		
		OrderVO orderVO = new OrderVO();
		orderVO.setStuId(username);
		orderVO.setTolAmt(totalPrice);
		
		List<OrderDetailVO> orderDetailList = new ArrayList<OrderDetailVO>();
		for (CourseDetailVO vo : cursInfo) {
			OrderDetailVO odv = new OrderDetailVO();
			odv.setCursNo(vo.getCursNo());
			odv.setOrdAmt(vo.getCursSuPri());
			odv.setStuId(username);
			orderDetailList.add(odv);
		}
		
		// 주문화면으로 넘어가기 전에 주문테이블에 데이터 insert
		service.insertOrder(orderVO);
		// 수강주문 테이블에 데이터 insert
		service.insertOrderDetail(orderDetailList);
		
		String orderNo = service.getOrderNo(username);
		
		model.addAttribute("member", member);
		model.addAttribute("cursNo", cursNo);
		model.addAttribute("cursInfo", cursInfo);
		model.addAttribute("orderNo", orderNo);
		
		return "signup/stdCourseOrder";
	}
	
	@PostMapping(value = "/cancelOrder", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String postCancelOrder(String ordNo) {
		
		log.info("ordNo >>>>>> " + ordNo);
		
		int cnt = service.deleteOrderDetail(ordNo);
		if(cnt <= 0) {
			return "수강주문상세 테이블에서 데이터 삭제에 실패했습니다.";
		}
		cnt = service.deleteOrder(ordNo);
		if(cnt <= 0) {
			return "수강 테이블에서 데이터 삭제에 실패했습니다.";
		}
		
		
		return "주문을 성공적으로 취소하였습니다.";
		
	}
	
	@PostMapping("/completeOrder")
	@ResponseBody
	public String postCompleteOrder(@RequestBody PaymentVO paymentVO) {
		
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		log.info("paymentVO >>>>>>>>>>>>> " + paymentVO.toString());
		
		String ordNo = paymentVO.getOrdNo();
		
		// 주문 정보와 상세정보를 담는 리스트
		OrderVO orderVO = service.selectOrderInfo(ordNo);
		
		log.info("orderVo >>>>>>>>>>> " + orderVO.toString() );
		log.info("suOrdDtl >>>>>>>>>>>>>>> " + orderVO.getSuOrdDtl().toString());
		
		
		// 결제 정보를 결제 테이블에 저장
		service.insertPaymentInfo(paymentVO);
		
		// 결제한 강의의 정보를 토대로 수강 테이블에 데이터 저장
		service.insertSu(orderVO);
		
		// 장바구니 항목 수정
		service.afterOrderCart(orderVO);
		
		// 이동할 화면의 URL 리턴
		return "stdSignup/compleOrder";
	}
	
	@GetMapping("/completeOrder")
	public String getCompleteOrder() {
		return "signup/completeOrder";
	}
	
	@PostMapping("/compleOrder")
	public String postComplete(String ordNo, String stuId, Model model) {
		
		log.info("ordNo >>>>>>>>>>>> " + ordNo);
		log.info("stuId >>>>>>>>>>>> " + stuId);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("stuId", stuId);
		map.put("ordNo", ordNo);
		
		PaymentVO paymentVO = service.selectCompInfo(map);
		
		model.addAttribute("paymentVO",	paymentVO);
		
		return "signup/completeOrder";
	}
	
	@GetMapping("/paymentHistory")
	public String getPaymentHistory(Model model) {
		
		return "signup/stdPaymentHistory";
	}
	
	@PostMapping(value = "/paymentHistory", produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<PaymentVO> postPaymentHistory() {
		
		SecurityContext secContext = SecurityContextHolder.getContext();
		String username = secContext.getAuthentication().getName();
		
		List<PaymentVO> paymentVO = service.studentPaymentHistory(username);
		
		return paymentVO;
	}

}
