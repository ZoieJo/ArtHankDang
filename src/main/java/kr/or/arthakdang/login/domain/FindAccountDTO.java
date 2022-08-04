package kr.or.arthakdang.login.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FindAccountDTO {
	private String memId;
	private String memPh;
	private String memCmcd;
}
