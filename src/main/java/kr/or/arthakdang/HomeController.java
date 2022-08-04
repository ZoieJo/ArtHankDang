package kr.or.arthakdang;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.arthakdang.attendance.domain.AttendanceInfoDTO;
import kr.or.arthakdang.attendance.service.AttendanceManagementService;
import kr.or.arthakdang.cslrg.domain.CslrgPageCondDTO;
import kr.or.arthakdang.cslrg.domain.CslrgVO;
import kr.or.arthakdang.cslrg.service.CslrgService;
import kr.or.arthakdang.mylecture.service.MyLectureService;
import kr.or.arthakdang.note.domain.NoteVO;
import kr.or.arthakdang.note.service.NoteService;
import kr.or.arthakdang.notice.domain.NoticeVO;
import kr.or.arthakdang.notice.domain.PageCondDTO;
import kr.or.arthakdang.notice.service.NoticeService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

/**
 * 아트학당 메인페이지를 담당하는 곳
 */
@Controller
@Slf4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	private NoteService ns;
	
	@Autowired
	private NoticeService notices;
	
	@Autowired
	private CslrgService cslrgS;
	
	@Autowired
	private MyLectureService mylecS;
	
	@Autowired
	private AttendanceManagementService ams;
	@Autowired
	private MyLectureService mls;
	
	// 데이터 담을 변수
	String ckList;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session, @CurrentUser CustomUser user) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		/*로그인 전*/
		// [공지사항] 리스트 뿌려주기 가장 최신으로 5개만
		PageCondDTO rcDTO = new PageCondDTO(1,5,5);
		List<NoticeVO> ntclist = notices.selectBoardPage(rcDTO);
		model.addAttribute("ntclist", ntclist);
		model.addAttribute("ntclistSize", ntclist.size());
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@ " + ntclist.size());
		
		/*로그인 후*/
		if(user!=null) {
			String myId = user.getUsername();
			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + myId);
			
			// [알림] 받은 쪽지 있는지 확인
			List<NoteVO> ckList = ns.justRcvList(myId);
			// log.info("@@@@@@@@@@@@@@@@@@@@@@@@ 길이 "+ ckList.size());
			session.setAttribute("ckList", ckList);
			session.setAttribute("listSize", ckList.size());
			
			
			// [상담신청현황 : 직원]
			List<CslrgVO> allList = cslrgS.cslcdList(new CslrgPageCondDTO());
			log.info("상담 신청 현황 가져온 리스트 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ " + allList);
			List<CslrgVO> cslrglist = new ArrayList<CslrgVO>();
			for (CslrgVO cslrgVO : allList) {
				if(cslrgVO.getCslStCmcd().equals("신청중")) {
					cslrglist.add(cslrgVO);
				}
			}
			log.info(" 진행중 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ " + cslrglist);
			model.addAttribute("cslrglist", cslrglist);
			model.addAttribute("cslrglistSize", cslrglist.size());
			
			// [출석 : 학생]
			log.info(" 학생 내 출석 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ");
			List<AttendanceInfoDTO> atdList = ams.getAllClassAtdInfoListByStudent(myId);
			model.addAttribute("atdList", atdList);
			
			// [강의 : 교원]
			log.info("내 강의 리스트 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			model.addAttribute("myleclist", mylecS.myLectureList(myId));
			model.addAttribute("myleclistSize", mylecS.myLectureList(myId).size());
			
			
		}
		
		return "template.tiles";
	}
	
	@RequestMapping(value = "/root", method = RequestMethod.GET)
	public String rootTemplateTest(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "simple-template.tiles";
	}
	
}
