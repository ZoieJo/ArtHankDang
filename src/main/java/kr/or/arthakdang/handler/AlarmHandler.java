package kr.or.arthakdang.handler;
/*

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class AlarmHandler extends TextWebSocketHandler {

	private static List<WebSocketSession> list = new ArrayList<WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String user_name = searchUserName(session);
		System.out.println("접속");
		list.add(session);
		session.sendMessage(new TextMessage("recMs :" + (user_name)));
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String user_name = searchUserName(session);

		// 사용자가 접속중인지 아닌지
//      WebSocketSession chatwritingSession =users.get("user_name");
//      if(chatwritingSession != null) {
//          TextMessage textMessage = new TextMessage(user_name+ " 님이 메세지를 보냈습니다.");
//          chatwritingSession.sendMessage(textMessage);
//      }

		for (WebSocketSession sess : list) {
			sess.sendMessage(new TextMessage(user_name + ": " + message.getPayload()));
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String user_name = searchUserName(session);
		System.out.println("연결 끊어짐");
		for (WebSocketSession sess : list) {
			sess.sendMessage(new TextMessage(user_name + "님의 연결이 끊어졌습니다."));
		}
		list.remove(session);
	}

	public String searchUserName(WebSocketSession session) throws Exception {
		String user_name;
		Map<String, Object> map;
		map = session.getAttributes();
		user_name = (String) map.get("user_name");
		return user_name;
	}
}
*/