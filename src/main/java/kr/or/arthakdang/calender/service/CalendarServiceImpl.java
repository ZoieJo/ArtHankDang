package kr.or.arthakdang.calender.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.calender.domain.CalendarVO;
import kr.or.arthakdang.mapper.CalendarMapper;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarMapper calendarMapper;
	
	@Override
	public int insertCalendar(CalendarVO vo) {
		return calendarMapper.insertCalendar(vo);
	}

	@Override
	public int updateCalendar(CalendarVO vo) {
		return calendarMapper.updateCalendar(vo);
	}

	@Override
	public List<CalendarVO> selectCalendarList() {
		return calendarMapper.selectCalendarList();
	}

	@Override
	public List<CalendarVO> selectCalendarPt(String memId) {
		return calendarMapper.selectCalendarPt(memId);
	}

	@Override
	public CalendarVO selectCalendar(String schdNo) {
		return calendarMapper.selectCalendar(schdNo);
	}

	@Override
	public String selectMem(String memId) {
		return calendarMapper.selectMem(memId);
	}

	@Override
	public int deleteCalendar(String schdNo) {
		return calendarMapper.deleteCalendar(schdNo);
	}
	
	// 상담신청 일정 추가
	@Override
	public int insertcslrgSchd(CalendarVO schdCslrg) {
		return calendarMapper.insertcslrgSchd(schdCslrg);
	}

	// 상담신청 일정 수정
	@Override
	public int updatecslrgSchd(CalendarVO schdCslrg) {		
		return calendarMapper.updatecslrgSchd(schdCslrg);
	}

	// 상담신청 일정 삭제
	@Override
	public int deleteCslrgSchd(String schdNo) {
		return calendarMapper.deleteCslrgSchd(schdNo);
	}



}
