package kr.or.arthakdang.handler;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * 실시간 알림
 * @author jerry
 */
@Slf4j
public class EchoHandler extends TextWebSocketHandler{
	
	// 특정 아이디의 웹소켓 아이디 저장한 리스트
	Map<String, WebSocketSession> userlist = new ConcurrentHashMap<String, WebSocketSession>();


	/* 서버에 접속이 성공 했을때 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("로그한 모든 유저들 인터셉터로 오십쇼~");
		// 키값으로 사용할 아이디 가져오기
		String myId = session.getPrincipal().getName();
		userlist.put(myId, session);
		
		// users.add(session);
		
		log.info(session.getPrincipal().getName() + "님 연결 됐음 @@@@@@@@@@@@@@@@@@@@@@@@@@@@");
	}

	/* 메시지 핸들 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		String msg = message.getPayload();
		log.info(session.getId() + "로부터 \"" + msg + "\"  받음");
		String ssss = null;
		String mmmm = null;

		// 특정인물에게 보내기
		if(msg.contains(",")) {
			log.info("특정인물에게 보내는 공지군");
			ssss = msg.split(",")[0]; // 받는 사람 아이디
			log.info(ssss);
			mmmm = msg.split(",")[1]; // 보낸는 메시지
			String str = ssss + mmmm;
			WebSocketSession targetSession = userlist.get(ssss);
			targetSession.sendMessage(new TextMessage(session.getAcceptedProtocol() + str));
			
		}
		// 전체한테 뿌려주기
		else {
			log.info("현재 로그인한 모든 사람에게 뿌려준다.");
			for (WebSocketSession webSocketSession : userlist.values() ) {
				webSocketSession.sendMessage(new TextMessage(session.getAcceptedProtocol() + msg));
			}
		}
		
	} // 메시지 보낸는 메소드 끝

	
	// 연결 해제될때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		userlist.remove(session.getPrincipal().getName());
		log.info(session.getPrincipal().getName() + "님이 로그아웃해서 세션 지움~~!");
	}


}