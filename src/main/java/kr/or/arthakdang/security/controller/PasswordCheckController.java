package kr.or.arthakdang.security.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.common.service.MemberService;
import kr.or.arthakdang.cslrg.service.CslrgService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/check")
public class PasswordCheckController {

	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private CslrgService cslrgService;
	@Autowired
	private MemberService memberService;

	@GetMapping("")
	public String getPasswordCheck(String dir, String cslrgNo, Model model, HttpServletRequest req) {

		model.addAttribute("dir", dir);
		if (cslrgNo != null) {
			model.addAttribute("cslrgNo", cslrgNo);
		}
		return "mypage/passwordCheck.root";
	}

	@PostMapping("")
	public String postPasswordCheck(String password, String dir, String cslrgNo, HttpServletRequest req,
			RedirectAttributes rattr, @CurrentUser CustomUser user) {
		String redirectTo = "";
		boolean result = false;

		System.out.println("input pw : " + password);

		log.info("dir : " + dir);

		switch (dir) {
		case "mypage":
			redirectTo = "/mypage/memberinfo/detail";
			result = memberService.matchPassword(user, password);
			break;
			
		case "cslrg":
			redirectTo = "/newCslrg/detail?cslrgNo=" + cslrgNo;
			result = password.equals(cslrgService.selectCslrg(cslrgNo).getCslPrivateNm());

		default:
			rattr.addAttribute("error", "true");
			break;
		}

		if (!result) {
			redirectTo = req.getHeader("Referer");
			return "redirect:" + redirectTo;
		}
		// req.getSession().setAttribute("pwChecked", true);
		rattr.addFlashAttribute("pwChecked", true);

		return "redirect:" + redirectTo;

	}

}
