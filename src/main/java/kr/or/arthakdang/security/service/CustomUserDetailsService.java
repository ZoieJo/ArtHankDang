package kr.or.arthakdang.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import kr.or.arthakdang.mapper.EmployeeManagementMapper;
import kr.or.arthakdang.mapper.MemberMapper;
import kr.or.arthakdang.mapper.StudentManagementMapper;
import kr.or.arthakdang.security.user.CustomUser;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private StudentManagementMapper studentManagementMapper;
	
	@Autowired
	private EmployeeManagementMapper employeeManagementMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// return타입이 UserDetails라서 memberVO를 Userdetails로 바꿔야함
		// UserDetails를 구현한 스프링 내장의 User 클래스를 상속받아 만들면 됨
		
		log.info("ckk : " + username);
		MemberVO memberVO = memberMapper.read(username); //security에서 username이라고 하는 것, 테이블의 userid임
		
		if(memberVO == null) {
			return null;
		}
		
		String memberCode = memberVO.getMemCmcd();
		
		if(memberCode.equals("01")) {
			log.info("이용자가 학생입니다.");
			StudentVO studentVO = studentManagementMapper.selectOneStudent(username);
			return new CustomUser(memberVO, studentVO);
		}
		
		if(memberCode.equals("02") || memberCode.equals("03")) {
			log.info("이용자가 교직원입니다.");
			EmployeeVO employeeVO  = employeeManagementMapper.selectOneEmployee(username);
			return new CustomUser(memberVO, employeeVO);
		}
		
		return new CustomUser(memberVO); // UserDetail 인터페이스에 해당할 User 구현체 상속 객체

	}

}
