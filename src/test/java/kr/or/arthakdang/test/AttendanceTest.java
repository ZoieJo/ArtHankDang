package kr.or.arthakdang.test;

import java.util.List;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import kr.or.arthakdang.attendance.domain.AttendanceDTO;
import kr.or.arthakdang.attendance.domain.StudentAttendanceListDTO;
import kr.or.arthakdang.attendance.service.CheckInService;
import kr.or.arthakdang.domain.CourseVO;
import kr.or.arthakdang.mapper.AttendanceMapper;
import kr.or.arthakdang.mapper.CourseMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration("classpath:config/spring/root-context.xml")
public class AttendanceTest {
	
	@Autowired
	private AttendanceMapper attendanceMapper;
	
	@Autowired
	private CourseMapper courseMapper;
	
	@Autowired
	private CheckInService checkInService;
	
	private AttendanceDTO dto = new AttendanceDTO();
	
	@Test
	public void insertTest() {
		
		List<StudentAttendanceListDTO> result = attendanceMapper.selectAllStudentsAttendanceListByClass("CURS00001");
		log.info(result.toString());
		Assertions.assertEquals(2, result.size());;
	}

}
