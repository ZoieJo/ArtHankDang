package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.attendance.domain.AttendanceDTO;
import kr.or.arthakdang.attendance.domain.AttendanceInfoDTO;
import kr.or.arthakdang.attendance.domain.ClassAttendanceListDTO;
import kr.or.arthakdang.attendance.domain.StudentAttendanceListDTO;

@Mapper
public interface AttendanceMapper {
	
	// 오늘 날짜 수업 시작 시 기본값으로 수강생 결석 입력
	public int insertAbsent(AttendanceDTO attendanceDTO);
	
	// 오늘 날짜의 출석, 지각, 조퇴 입력(입력된 결석에서 update 하는 방식)
	public int updateCheckIn(AttendanceDTO attendanceDTO);
	public int updateLate(AttendanceDTO attendanceDTO);
	public int updateEarlyDepart(AttendanceDTO attendanceDTO);
	public int updateCheckOut(AttendanceDTO attendanceDTO);
	
	// 교직원 임의의 단일 출석 내역 입력, 수정, 삭제
	public int insertAttendance(AttendanceDTO attendanceDTO);
	public int updateAttendance(AttendanceDTO attendanceDTO);
	public int deleteAttendance(AttendanceDTO attendanceDTO);
	
	// 단일 출석 내역 선택
	public AttendanceDTO selectOneAttendance(AttendanceDTO attendanceDTO);
	
	// 강의ID와 학생ID로 출석 내역 조회
	public List<AttendanceDTO> selectAttendanceListByStudentAndClass(AttendanceDTO attendanceDTO);

	// 강의ID로 수강생 전체 출석 조회
	public List<StudentAttendanceListDTO> selectAllStudentsAttendanceListByClass(String cursNo);
	
	// 학생ID로 해당 학생의 전체 수강강의 성적 조회
	public List<ClassAttendanceListDTO> selectAllClassAttendanceListOfStudent(String stuId);
	
	// 특정 학생의 해당 강의 지각/조퇴/결석/출석 회수 조회
	public int selectCountCheckinByStatus(AttendanceDTO attendanceDTO);
	
	// 특정 학생의 총 이수 시간 조회
	public double selectTotalTimesTakenByStudent(AttendanceDTO attendanceDTO);
	
	// 특정 강의 수강생들의 출석 정보 조회
	public List<AttendanceInfoDTO> selectAllStudentsAtdInfoListByClass(String cursNo);

	// 특정 강의 수강생들의 특정 날 출석 내역 조회
	public List<AttendanceDTO> selectAttendanceListByClassAndDate(AttendanceDTO attendanceDTO);
	
	// 해당 학생의 현재 출결 통계 조회
	public List<AttendanceInfoDTO> selectClassAtdInfoListByStudent(String cursNo);


}
