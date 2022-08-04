package kr.or.arthakdang.domain;

import java.io.Serializable;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author Hyeonseo
 * 회원id, pw, 회원공통코드, 소유권한(리스트)을 가지는 VO
 *
 */
@Getter
@Setter
@ToString
public class MemberVO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String memId;
	private String memPw;
	private String memCmcd;
	
	private List<AuthVO> authList;
}
