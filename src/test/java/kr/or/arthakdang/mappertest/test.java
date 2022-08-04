package kr.or.arthakdang.mappertest;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import kr.or.arthakdang.freeboard.domain.FreeboardVO;
import kr.or.arthakdang.mapper.FreeboardMapper;
import kr.or.arthakdang.mapper.NoticeMapper;
import kr.or.arthakdang.notice.domain.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration("classpath:config/spring/root-context.xml")
public class test {

	@Autowired
	private NoticeMapper noticeMapper;
	
	@Test
	public void insertBoard() {
		
		int result = 0;
		
		for (int i = 0; i < 50; i++) {
			NoticeVO noticeVO = new NoticeVO();
			noticeVO.setBdWTR("employee" + i);
			noticeVO.setBdCNT(("중요한 " + i + "번째 공지사항입니다."));
			noticeVO.setBdTL(("공지사항 " + i));
			
			result += noticeMapper.insertNotice(noticeVO);
		}
		
		Assertions.assertEquals(50, result);
		log.info("실행된 쿼리 수 : " + result);
	}
}
