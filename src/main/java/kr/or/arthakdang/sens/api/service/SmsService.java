package kr.or.arthakdang.sens.api.service;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.arthakdang.sens.api.application.ApplicationNaverSENS;
import kr.or.arthakdang.sens.api.domain.MessagesRequestDto;
import kr.or.arthakdang.sens.api.domain.SendSmsResponseDto;
import kr.or.arthakdang.sens.api.domain.SmsRequestDto;

@Service
public class SmsService {

	@Autowired
    private ApplicationNaverSENS applicationNaverSENS;
    
    /**
     * @param recipientPhoneNumber 수신자 번호
     * @param content 문자메시지 내용
     * @return
     * @throws ParseException
     * @throws JsonProcessingException
     * @throws UnsupportedEncodingException
     * @throws InvalidKeyException
     * @throws NoSuchAlgorithmException
     * @throws URISyntaxException
     */
    public SendSmsResponseDto sendSms(String recipientPhoneNumber, String content) throws ParseException, JsonProcessingException, UnsupportedEncodingException, InvalidKeyException, NoSuchAlgorithmException, URISyntaxException {
        Long time = System.currentTimeMillis();
        List<MessagesRequestDto> messages = new ArrayList<>();
        
        messages.add(new MessagesRequestDto(recipientPhoneNumber,content));

        // 전체 json에 대해 메시지를 만든다.
        SmsRequestDto smsRequestDto = new SmsRequestDto();
        
        smsRequestDto.setType("SMS"); // 메시지 타입 (SMS | MMS | LMS)
        smsRequestDto.setContentType("COMM"); // 메시지 내용 타입 (AD | COMM)
        smsRequestDto.setCountryCode("82"); // 국가 전화번호
        smsRequestDto.setFrom(applicationNaverSENS.getSendFrom()); // 발신인 번호(api에 사전 등록된 발신번호만 사용 가능)
        smsRequestDto.setContent("기본 메시지 내용"); // 기본 메시지 내용
        smsRequestDto.setMessages(messages); // 실제로 전송되는 메시지 내용, 수신인과 내용으로 이루어진 리스트
        
        // 객체를 json으로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonBody = objectMapper.writeValueAsString(smsRequestDto);

        // 요청 헤더에 필요한 값을 지정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("x-ncp-apigw-timestamp", time.toString());
        headers.set("x-ncp-iam-access-key", applicationNaverSENS.getAccessKey());

        // 헤더에 암호화된 서명 지정
        String sign = makeSignature(time);
        headers.set("x-ncp-apigw-signature-v2", sign);

        // 위에서 json으로 변환한 객체와 요청 헤더를 조합해줌
        HttpEntity<String> body = new HttpEntity<>(jsonBody, headers);
        System.out.println(body.getBody());

        String uri = new StringBuilder()
        			.append(applicationNaverSENS.getHostNameUrl())
        			.append(applicationNaverSENS.getRequestUrl())
        			.append(applicationNaverSENS.getServiceId())
        			.append(applicationNaverSENS.getRequestUrlType())
        			.toString();
        
        // restTemplate로 post 요청 전송, 성공 시 202 코드가 반환됨
        RestTemplate restTemplate = new RestTemplate();
        SendSmsResponseDto sendSmsResponseDto = restTemplate.postForObject(
        		new URI(uri), body, SendSmsResponseDto.class);
        System.out.println(sendSmsResponseDto.getStatusCode());
        return sendSmsResponseDto;
    }
    
    /**
     * 
     * 여러건의 메시지를 리스트로 구성해서 전송 할때
     * 
     * @param List<MessagesRequestDto> messages
     * @return SendSmsResponseDto(전송 결과)
     * @throws ParseException
     * @throws JsonProcessingException
     * @throws UnsupportedEncodingException
     * @throws InvalidKeyException
     * @throws NoSuchAlgorithmException
     * @throws URISyntaxException
     */
    public SendSmsResponseDto sendSmsList(List<MessagesRequestDto> messages) throws ParseException, JsonProcessingException, UnsupportedEncodingException, InvalidKeyException, NoSuchAlgorithmException, URISyntaxException {
        Long time = System.currentTimeMillis();
        // 보내는 사람에게 내용을 보냄.
        // 전체 json에 대해 메시지를 만든다.
        SmsRequestDto smsRequestDto = new SmsRequestDto();
        
        smsRequestDto.setType("SMS"); // 메시지 타입 (SMS | MMS | LMS)
        smsRequestDto.setContentType("COMM"); // 메시지 내용 타입 (AD | COMM)
        smsRequestDto.setCountryCode("82"); // 국가 전화번호
        smsRequestDto.setFrom(applicationNaverSENS.getSendFrom()); // 발신인 번호(api에 사전 등록된 발신번호만 사용 가능)
        smsRequestDto.setContent("기본 메시지 내용"); // 기본 메시지 내용
        smsRequestDto.setMessages(messages); // 실제로 전송되는 메시지 내용, 수신인과 내용으로 이루어진 리스트
        
        // 쌓아온 바디를 json 형태로 변환시켜준다.
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonBody = objectMapper.writeValueAsString(smsRequestDto);

        // 헤더에서 여러 설정값들을 잡아준다.
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("x-ncp-apigw-timestamp", time.toString());
        headers.set("x-ncp-iam-access-key", applicationNaverSENS.getAccessKey());

        // 제일 중요한 signature 서명하기.
        String sign = makeSignature(time);
        headers.set("x-ncp-apigw-signature-v2", sign);

        // 위에서 조립한 jsonBody와 헤더를 조립한다.
        HttpEntity<String> body = new HttpEntity<>(jsonBody, headers);
        System.out.println(body.getBody());

        // restTemplate로 post 요청을 보낸다. 별 일 없으면 202 코드 반환된다.
        RestTemplate restTemplate = new RestTemplate();
        SendSmsResponseDto sendSmsResponseDto = restTemplate.postForObject(new URI("https://sens.apigw.ntruss.com/sms/v2/services/"+applicationNaverSENS.getServiceId()+"/messages"), body, SendSmsResponseDto.class);
        System.out.println(sendSmsResponseDto.getStatusCode());
        return sendSmsResponseDto;
    }

    public String makeSignature(Long time) throws UnsupportedEncodingException, InvalidKeyException, NoSuchAlgorithmException {
        String space = " ";					// one space
        String newLine = "\n";					// new line
        String method = "POST";					// method
        String url = "/sms/v2/services/"+applicationNaverSENS.getServiceId()+"/messages";	// url (include query string)
        String timestamp = time.toString();			// current timestamp (epoch)
        String accessKey = applicationNaverSENS.getAccessKey();			// access key id (from portal or Sub Account)
        String secretKey = applicationNaverSENS.getSecretKey();

        String message = new StringBuilder()
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(timestamp)
                .append(newLine)
                .append(accessKey)
                .toString();

        SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(signingKey);

        byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
        String encodeBase64String = Base64.encodeBase64String(rawHmac);

        return encodeBase64String;
    }
    
}