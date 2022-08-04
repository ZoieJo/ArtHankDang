package kr.or.arthakdang.attendance.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.attendance.domain.AttendanceDTO;
import kr.or.arthakdang.attendance.domain.CheckInQrDTO;
import kr.or.arthakdang.domain.CourseTimeDetailVO;
import kr.or.arthakdang.domain.CourseVO;
import kr.or.arthakdang.domain.QrCodeDTO;
import kr.or.arthakdang.mapper.AttendanceMapper;
import kr.or.arthakdang.mapper.CourseMapper;
import lombok.extern.slf4j.Slf4j;

/**
 * 출석 체크 관련 서비스
 * 
 * @author hs
 *
 */
@Slf4j
@Service
public class CheckInService {

	@Autowired
	private AttendanceMapper attendanceMapper;
	@Autowired
	private CourseMapper courseMapper;

	/**
	 * 수업 출석을 시작 시 전체 수강생들의 출결에 일괄적으로 초기값 결석을 입력하는 메서드
	 * 
	 * @param cursNo 수업코드
	 * @return
	 */
	public boolean initStudentCheckIn(String cursNo) {
		List<String> stuList = courseMapper.selectSignedStudentListByCourse(cursNo);
		AttendanceDTO dto = new AttendanceDTO();
		dto.setAtdDt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"))); // =20220618
		dto.setCursNo(cursNo);

		try {

			for (String stuId : stuList) {

				dto.setStuId(stuId);
				attendanceMapper.insertAbsent(dto);
			}

			return true;

		} catch (Exception e) {
			log.info("출석 초기값 입력 중 오류가 발생했습니다.");
		}
		return false;
	}

	/**
	 * 해당 수업이 현재 진행중인지 수업시간 상세정보를 통해 검증하는 메서드
	 * 
	 * @param cursNo 수업코드
	 * @return
	 */
	public boolean isValidClass(String cursNo) {
		
		LocalDate dateOfNow = LocalDate.now();
		LocalTime timeOfNow = LocalTime.now();
		int day = dateOfNow.getDayOfWeek().getValue();
		log.info("now is : " + dateOfNow + " // " + timeOfNow);

		List<CourseTimeDetailVO> classTimeList = courseMapper.selectOneCourseTimeDetails(cursNo);

		for (CourseTimeDetailVO vo : classTimeList) {

			LocalTime startTime = LocalTime.of(vo.getCursSttHh(), vo.getCursSttMm());
			LocalTime endTime = LocalTime.of(vo.getCursEndHh(), vo.getCursEndMm());

			log.info("trying... ");
			log.info("day : " + vo.getCursDay());
			log.info("startTime : " + startTime);
			log.info("endTime : " + endTime);

			if (vo.getCursDay() == day && timeOfNow.isBefore(endTime) && timeOfNow.isAfter(startTime)) {

				log.info("TIME MATCHED!!");

				log.info("matching time detail is : " + vo.getCursDay() + " day " + startTime + " ~ " + endTime);
				log.info("now is : " + dateOfNow + " // " + timeOfNow);

				return true;
			}
		}
		
		return false;
	}


	public int insertCheckin(String stuId, String cursNo) {

		LocalTime timeOfNow = LocalTime.now();
		int day = LocalDate.now().getDayOfWeek().getValue();

		CourseTimeDetailVO condition = new CourseTimeDetailVO();
		condition.setCursDay(day);
		condition.setCursNo(cursNo);
		CourseTimeDetailVO classTimeInfo = courseMapper.selectOneCourseTimeDetailByDay(condition);

		LocalTime classStartTime = LocalTime.of(classTimeInfo.getCursSttHh(), classTimeInfo.getCursSttMm());

		AttendanceDTO dto = new AttendanceDTO();
		dto.setStuId(stuId);
		dto.setCursNo(cursNo);
		
		try {
			// 수업 시작 시간 10분 전보다 이전 시간에 출석을 시도하는 경우
			if (timeOfNow.isBefore(classStartTime.minusMinutes(10))) {
				return -1; // -1 리턴
			}
			
			// 수업 시작 10분 전 ~ 수업 시작 후 10분 사이에 출석하는 경우 : 정상 출석
			if (timeOfNow.isBefore(classStartTime.plusMinutes(10))) {
				return attendanceMapper.updateCheckIn(dto); // 출석 입력
			}

			// 수업 시작 10분 후 출석 : 지각
			if (timeOfNow.isAfter(classStartTime.plusMinutes(10))) {
				return attendanceMapper.updateLate(dto); // 지각 입력
			}

		} catch (Exception e) {
			// 시간 검증이나 데이터베이스에 입력 중 예외가 발생하는 경우
			log.info("출석 입력 중 예외가 발생했습니다. 정상적으로 출석이 입력되지 않았습니다.");
		}

		return 0; // 출석이 제대로 입력되지 않아 함수가 중간에 리턴되지 않았을 때
	}
	
	

	public int insertCheckout(String stuId, String cursNo) {

		LocalTime timeOfNow = LocalTime.now();
		int day = LocalDate.now().getDayOfWeek().getValue();

		CourseTimeDetailVO condition = new CourseTimeDetailVO();
		condition.setCursDay(day);
		condition.setCursNo(cursNo);
		CourseTimeDetailVO classTimeInfo = courseMapper.selectOneCourseTimeDetailByDay(condition);

		LocalTime classEndTime = LocalTime.of(classTimeInfo.getCursEndHh(), classTimeInfo.getCursEndMm());

		AttendanceDTO dto = new AttendanceDTO();
		dto.setStuId(stuId);
		dto.setCursNo(cursNo);
		
		try {
			// 수업 종료 시간 10분 전보다 이전 시간에 퇴실을 시도하는 경우
			if (timeOfNow.isBefore(classEndTime.minusMinutes(10))) {
				return attendanceMapper.updateEarlyDepart(dto); // 조퇴 입력 
			}
			
			// 수업 종료 시간 10분 전 이후에 퇴실을 시도하는 경우
			if (timeOfNow.isAfter(classEndTime.minusMinutes(10))) {
				return attendanceMapper.updateCheckOut(dto); // 정상 퇴실 입력
			}

		} catch (Exception e) {
			// 시간 검증이나 데이터베이스에 입력 중 예외가 발생하는 경우
			log.info("출석 입력 중 예외가 발생했습니다. 정상적으로 출석이 입력되지 않았습니다.");
		}

		return 0; // 출석이 제대로 입력되지 않아 함수가 중간에 리턴되지 않았을 때
	}
	
	
	public boolean isThisStudentSigned(String stuId, String cursNo) {
		if (courseMapper.selectOneStudentSigningStatus(stuId, cursNo)!=null) {
			return true;
		}
		return false;
	}
	

}
