package kr.or.arthakdang.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.domain.MemberDetailInfo;
import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import kr.or.arthakdang.mapper.EmployeeManagementMapper;
import kr.or.arthakdang.mapper.MemberMapper;
import kr.or.arthakdang.mapper.StudentManagementMapper;
import kr.or.arthakdang.security.service.CustomUserDetailsService;
import kr.or.arthakdang.security.user.CustomUser;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;
import kr.or.arthakdang.studentmanagement.service.StudentManagementService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private StudentManagementMapper studentManagementMapper;
	@Autowired
	private EmployeeManagementMapper employeeManagementMapper;
	@Autowired
	private MemberMapper memberMapper;

	@Override
	public MemberDetailInfo getMemberDetail(CustomUser user) {

		MemberDetailInfo member = user.getMemberDetail();

		return member;
	}

	/**
	 * 현재 로그인 된 사용자 정보를 바탕으로 회원구분코드를 int형으로 반환하는 메서드
	 *
	 * @param CustomUser user
	 * @return int 회원구분코드
	 * 
	 */
	@Override
	public int getMemberCode(CustomUser user) {

		String memberCode = user.getMember().getMemCmcd();
		return Integer.parseInt(memberCode);

	}

	@Override
	public boolean matchPassword(CustomUser user, String inputPw) {

		String encodedPw = memberMapper.read(user.getUsername()).getMemPw();
		return passwordEncoder.matches(inputPw, encodedPw);

	}

	@Override
	public StudentVO getOneStudentById(String stuId) {
		return studentManagementMapper.selectOneStudent(stuId);
	}

	@Override
	public EmployeeVO getOneEmployeeById(String empId) {
		return employeeManagementMapper.selectOneEmployee(empId);
	}

	@Override
	public boolean withdrawMember(CustomUser user) {

		int result = memberMapper.withdraw(user.getUsername());

		if (result > 0) {
			return true;
		}

		return false;
	}

	@Override
	public boolean memberInformationCheck(CustomUser user) {
		String str = "";
		try {
			if(getMemberCode(user)>1) {
				str = employeeManagementMapper.employeeInfoCheck(user.getUsername());
			} else {
				str = studentManagementMapper.studentInfoCheck(user.getUsername());
			}
		} catch (Exception e) {
			
		}
		
		
		if(str==null) {
			return false;
		}
		 
		return true;
	}
	

	@Override
	public int passwordResetService(CustomUser user, String currentPw, String newPw) {
		
		MemberVO vo = memberMapper.read(user.getUsername());
		log.info("비밀번호 변경 전 기존 비밀번호를 체크중...");
		
		
		if(!passwordEncoder.matches(currentPw, vo.getMemPw())) {
			return 0; // 비밀번호 불일치
		}
		
		vo.setMemPw(passwordEncoder.encode(newPw));
		
		if(memberMapper.updateMemPw(vo)>0) {
			return 2; // 변경 성공
		}
		
		return 1; // 변경 실패
	}
}
