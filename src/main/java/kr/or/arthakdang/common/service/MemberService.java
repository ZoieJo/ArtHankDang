package kr.or.arthakdang.common.service;

import kr.or.arthakdang.domain.MemberDetailInfo;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;
import kr.or.arthakdang.security.user.CustomUser;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;

public interface MemberService {
	public int getMemberCode(CustomUser user);
	public boolean matchPassword(CustomUser user, String inputPw);
	public MemberDetailInfo getMemberDetail(CustomUser user);
	public StudentVO getOneStudentById(String stuId);
	public EmployeeVO getOneEmployeeById(String empId);
	boolean withdrawMember(CustomUser user);
	boolean memberInformationCheck(CustomUser user);
	int passwordResetService(CustomUser user, String currentPw, String newPw);
}
