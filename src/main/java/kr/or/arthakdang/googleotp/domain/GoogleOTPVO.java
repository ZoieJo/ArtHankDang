package kr.or.arthakdang.googleotp.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GoogleOTPVO {
	private String userid;
	private String secretKey;

}
