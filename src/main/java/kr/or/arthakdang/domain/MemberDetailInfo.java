package kr.or.arthakdang.domain;

/**
 * 
 * 회원 정보를 한 타입 객체로 관리하도록 하는 인터페이스
 * @author Hyeonseo
 * 
 */
public interface MemberDetailInfo {
	
	/**
	 * 회원 유형을 코드로 반환하는 메서드
	 * @author Hyeonseo
	 *
	 * @return 회원(mem) 코드
	 * 
	 * 01-학생 
	 * 02- 교직원
	 */
	public String getMemCmcd();
	
	/**
	 * 회원 이름을 가져오는 메서드
	 * @author Hyeonseo
	 *
	 * @return 회원 이름
	 */
	public String getMemName();
}
