package kr.or.arthakdang.security.service;

import org.springframework.security.crypto.password.PasswordEncoder;

// 오류 방지용 임시 인코더
public class CustomPasswordEncoder implements PasswordEncoder{

	@Override
	public String encode(CharSequence rawPassword) {

		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {

		// 단순 문자열 비교
		return rawPassword.toString().equals(encodedPassword);
	}

	
}
