package kr.or.arthakdang.sens.api.application;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

/**
 * 네이버 sens api 이용 정보를 담을 bean 객체
 * @author hs
 *
 */

@Slf4j
@Setter
@Getter
@ToString
public class ApplicationNaverSENS {
	ApplicationNaverSENS() {
		log.info("application bean init");
	}

	private String hostNameUrl; 	// 호스트 URL
	private String requestUrl; 		// 요청 URL
	private String requestUrlType; 	// 요청 URL 타입
	private String accessKey; 	// 네이버 클라우드 플랫폼 회원에게 발급되는 개인 인증키 // Access Key :
								// https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
	private String secretKey; 	// 2차 인증을 위해 서비스마다 할당되는 service secret key // Service Key :
								// https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
	private String serviceId; 	// 프로젝트에 할당된 SMS 서비스 ID // service ID : https://console.ncloud.com/sens/project
								// > Simple & ... > Project > 서비스 ID
	private String method;		// 전송 방법(항상 POST로 고정)
	private String sendFrom;	// 발신인 번호
}
