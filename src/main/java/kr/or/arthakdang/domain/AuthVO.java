package kr.or.arthakdang.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author Hyeonseo
 * 권한명, 회원id, 권한취득일을 가지는 VO
 * 
 */
@Getter
@Setter
@ToString
public class AuthVO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String authNm;
	private String memId;
	private Date authCreDt;
	
}
