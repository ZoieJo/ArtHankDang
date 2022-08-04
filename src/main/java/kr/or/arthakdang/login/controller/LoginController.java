package kr.or.arthakdang.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.domain.QrCodeDTO;
import kr.or.arthakdang.qrcode.service.QrCodeService;
import kr.or.arthakdang.security.service.CustomUserDetailsService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {

	@Autowired
	private QrCodeService qrCodeService;

	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	@GetMapping("/login")
	public String login(String error, Model model) {

		if (error != null) {
			model.addAttribute("msg", "아이디나 비밀번호가 일치하지 않습니다.");
		}

		return "login/loginForm.root";
	}

	@ResponseBody
	@PostMapping(value = "/qrLogin", produces = "application/json; charset=utf-8")
	public String qrLogin(@RequestBody QrCodeDTO dto) {

		boolean validation = qrCodeService.isValidData(dto);

		if (validation) {
			try {
				String username = dto.getUserid();
				UserDetails user = customUserDetailsService.loadUserByUsername(username);
				log.info(username);
				Authentication authentication = new UsernamePasswordAuthenticationToken(
													user, user.getPassword(), user.getAuthorities());
				SecurityContextHolder.getContext().setAuthentication(authentication);

				return "";
			} catch (Exception e) {
				return "유효한 QR코드가 아닙니다. 다시 시도해 주세요.";
			}
		}

		return "유효한 QR코드가 아닙니다. 다시 시도해 주세요.";
	}

}
