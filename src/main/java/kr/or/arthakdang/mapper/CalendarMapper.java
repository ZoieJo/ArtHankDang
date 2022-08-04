package kr.or.arthakdang.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.calender.domain.CalendarVO;

@Mapper
public interface CalendarMapper {
	public int insertCalendar(CalendarVO vo);
	public int updateCalendar(CalendarVO vo);
	public int deleteCalendar(String schdNo);
	public CalendarVO selectCalendar(String schdNo);
	public List<CalendarVO> selectCalendarList();
	public List<CalendarVO> selectCalendarPt(String memId);
	public String selectMem(String memId);
	
	
	// 상담신청 일정 추가
	public int insertcslrgSchd(CalendarVO schdCslrg);
	
	// 상담신청 일정 수정
	public int updatecslrgSchd(CalendarVO schdCslrg);
	
	// 상담신청 일정 삭제
	public int deleteCslrgSchd(String schdNo);

	
	
}
