package kr.or.arthakdang.attendance.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.xml.crypto.Data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.attendance.domain.AttendanceDTO;
import kr.or.arthakdang.attendance.domain.AttendanceInfoDTO;
import kr.or.arthakdang.attendance.domain.ClassAttendanceListDTO;
import kr.or.arthakdang.attendance.domain.CourseDateDTO;
import kr.or.arthakdang.attendance.domain.StudentAttendanceListDTO;
import kr.or.arthakdang.mapper.AttendanceMapper;
import kr.or.arthakdang.mapper.CourseMapper;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AttendanceManagementService {

	@Autowired
	private AttendanceMapper attendanceMapper;
	@Autowired
	private CourseMapper courseMapper;
	
	/**
	 * 특정 수업의 오늘자 출석 리스트 출력
	 * @param cursNo
	 * @return
	 */
	public List<AttendanceDTO> selectTodaysAttendanceListbyClass(String cursNo) {
		
		AttendanceDTO searchDto = new AttendanceDTO();
		searchDto.setAtdDt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))); // =2022-06-18
		searchDto.setCursNo(cursNo);
		return attendanceMapper.selectAttendanceListByStudentAndClass(searchDto);
	}
	
	/**
	 * 특정 수업의 오늘자 출석 리스트 출력
	 * @param cursNo
	 * @return
	 */
	public List<AttendanceDTO> selectAttendanceListbyClassAndDate(String cursNo, String atdDt) {
		
		AttendanceDTO searchDto = new AttendanceDTO();
		searchDto.setAtdDt(atdDt); // =2022-06-18
		searchDto.setCursNo(cursNo);
		return attendanceMapper.selectAttendanceListByStudentAndClass(searchDto);
	}
	
	/**
	 * 특정 수업을 수강중인 학생들의 출석 리스트 출력
	 * @param cursNo
	 * @return
	 */
	public List<StudentAttendanceListDTO> selectStudentAttendanceListbyClass(String cursNo) {
		AttendanceDTO dto = new AttendanceDTO();
		dto.setCursNo(cursNo);
		return attendanceMapper.selectAllStudentsAttendanceListByClass(cursNo);
	}
	
	/**
	 * 특정 학생의 특정 수업 출석 리스트 출력
	 * @param stuId
	 * @param cursNo
	 * @return
	 */
	public List<AttendanceDTO> selectClassAttendanceListOfStudent(String stuId, String cursNo) {
		AttendanceDTO dto = new AttendanceDTO();
		dto.setCursNo(cursNo);
		dto.setStuId(stuId);
		return attendanceMapper.selectAttendanceListByStudentAndClass(dto);
	}
	
	/**
	 * 특정 학생의 전체 수업 출석 리스트 출력
	 * @param stuId
	 * @return
	 */
	public List<ClassAttendanceListDTO> selectAllAttendanceListOfStudent(String stuId) {
		AttendanceDTO dto = new AttendanceDTO();
		dto.setStuId(stuId);
		return attendanceMapper.selectAllClassAttendanceListOfStudent(stuId);
	}
	




	public List<AttendanceInfoDTO> getAllStudentAtdInfoListByClass(String cursNo) {
		List<AttendanceInfoDTO> list = attendanceMapper.selectAllStudentsAtdInfoListByClass(cursNo);
		log.info("생성된 list의 길이 : " + list.size());
		return list;
	}
	

	
	// 교직원 임의의 단일 출석 내역 입력, 수정, 삭제
	public int insertAttendance(AttendanceDTO attendanceDTO) {
		return attendanceMapper.insertAttendance(attendanceDTO);
	};
	
	public int updateAttendance(AttendanceDTO attendanceDTO) {
		return attendanceMapper.updateAttendance(attendanceDTO);
	};
	
	public int deleteAttendance(AttendanceDTO attendanceDTO) {
		return attendanceMapper.deleteAttendance(attendanceDTO);
	};
	
	/**
	 * 학생 아이디로 해당 학생의 강의별 출결 조회
	 * @param stuId
	 * @return
	 */
	public List<AttendanceInfoDTO> getAllClassAtdInfoListByStudent(String stuId) {
		List<AttendanceInfoDTO> list = attendanceMapper.selectClassAtdInfoListByStudent(stuId);
		log.info("생성된 list의 길이 : " + list.size());
		return list;
	}
}
