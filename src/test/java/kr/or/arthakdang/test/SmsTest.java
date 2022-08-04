package kr.or.arthakdang.test;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import org.apache.tomcat.util.json.ParseException;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.fasterxml.jackson.core.JsonProcessingException;

import kr.or.arthakdang.sens.api.service.SmsService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration("classpath:config/spring/root-context.xml")
public class SmsTest {

	@Autowired
	private SmsService smsService;
	
	@Test
	public void test() throws JsonProcessingException, InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException, ParseException, URISyntaxException {
    	Assertions.assertNotNull(smsService);
		//smsService.sendSms("01064093043", "잘가니");
    	
    	
	}
}
