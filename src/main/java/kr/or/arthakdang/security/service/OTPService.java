package kr.or.arthakdang.security.service;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

/**
 * 인증용 시간 기반 난수발생기
 * @author hs
 *
 */
@Slf4j
@Service
public class OTPService {

	private static final long DISTANCE = 30000; // 30 sec
	private static final String ALGORITHM = "HmacSHA1";
	private static final byte[] SECRET_KEY = "a33221".getBytes();


	// 특정 시간 값으로 생성하는 메서드는 클래스 내에서만 사용할 수 있도록 막아둠
	private long create(long time) throws NoSuchAlgorithmException, InvalidKeyException {
		byte[] data = new byte[8];

		long value = time;
		for (int i = 8; i-- > 0; value >>>= 8) {
			data[i] = (byte) value;
		}

		Mac mac = Mac.getInstance(ALGORITHM);
		mac.init(new SecretKeySpec(SECRET_KEY, ALGORITHM));

		byte[] hash = mac.doFinal(data);
		int offset = hash[20 - 1] & 0xF;

		long truncatedHash = 0;
		for (int i = 0; i < 4; ++i) {
			truncatedHash <<= 8;
			truncatedHash |= hash[offset + i] & 0xFF;
		}

		truncatedHash &= 0x7FFFFFFF;
		truncatedHash %= 1000000;

		return truncatedHash;
	}

	public String create() throws Exception {
		return String.format("%06d", create(new Date().getTime() / DISTANCE));
	}

	public boolean verify(String inputCode) throws Exception {
		
		// 단위시간으로 나눈 시간(=해당 시간 범위에서 같은 키를 생성하도록 함)
		long time = (new Date().getTime() / DISTANCE);
		
		log.info("verifying...");
		for (int i=-2; i<=2; i++) { // 앞뒤 범주에서 검증
			
			String code = String.format("%06d", create(time+i));
			log.info("tryed code : " + code);
			if(code.equals(inputCode)) {
				log.info("correct!!");
				return true;
			}
		}
		
		return false;
	}

}
