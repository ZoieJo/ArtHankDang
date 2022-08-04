package kr.or.arthakdang.mapper;

import java.util.List;

import kr.or.arthakdang.domain.MemberVO;

public interface MemberMapper {
	
	public int insertMember(MemberVO memberVO);
	public int updateMember(MemberVO memberVO);
	public int deleteMember(String memId);

	public int updateMemPw(MemberVO memberVO);
	
	/**
	 * @author Hyeonseo
	 * 
	 * 회원 id로 해당 회원의 id, pw, 공통코드, 소유 권한을 가져오는 메서드
	 * 
	 * @param memId
	 * @return
	 */
	public MemberVO read(String memId);
	public int withdraw(String memId);
	public List<MemberVO> selectAllMember();

}
