package kr.or.arthakdang.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.attendance.domain.AttendanceDTO;
import kr.or.arthakdang.attendance.domain.CourseDateDTO;
import kr.or.arthakdang.domain.CourseVO;
import kr.or.arthakdang.mapper.CourseMapper;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CourseUtilService {

	@Autowired
	private CourseMapper courseMapper;

	/**
	 * 현재 로그인 된 사용자가 교직원인지, 컨트롤러에서 보낼 정보에 접근가능한지 검증하는 메서드
	 * 
	 * @param user
	 * @param cursNo
	 * @return boolean
	 */
	public boolean isThisEmployeeCanAccessable(CustomUser user, String cursNo) {

		String username = user.getUsername();
		int memberCode = Integer.parseInt(user.getMember().getMemCmcd());

		log.info("검증 중인 교직원 : " + username);

		switch (memberCode) {
		case 1: // 학생인 경우
			log.info("요청한 회원이 교직원이 아닙니다.");
			break;
		case 2: // 직원인 경우
			// 직원은 전체 출결 내역을 열람할 수 있으므로 true 리턴
			return true;
		case 3: // 교원인 경우
			// 해당 강의의 담당 교원과 요청 중인 사용자 id를 비교해 리턴
			log.info("해당 강의 담당 교원 id : " + courseMapper.selectCourseAssignedTeacher(cursNo));
			return username.equals(courseMapper.selectCourseAssignedTeacher(cursNo));

		default:
			log.info("요청한 회원의 회원코드가 유효하지 않습니다.");
			break;
		}

		return false;
	}

	/**
	 * 현재 로그인 된 사용자가 학생인지, 컨트롤러에서 보낼 정보에 접근가능한지 검증하는 메서드 예) 특정 성적 정보를 열람시도하는 사용자가 해당
	 * 성적 정보의 주인인지?
	 * 
	 * @param user
	 * @param cursNo
	 * @return boolean
	 */
	public boolean isThisStudentCanAccessable(CustomUser user, String cursNo) {

		String username = user.getUsername();
		int memberCode = Integer.parseInt(user.getMember().getMemCmcd());

		log.info("검증 중인 학생 : " + username);
		log.info("검증 중인 강의 : " + cursNo);

		switch (memberCode) {
		case 1: // 학생인 경우
			AttendanceDTO dto = new AttendanceDTO();
			dto.setCursNo(cursNo);
			dto.setStuId(username);
			// 출석 내역이 존재하면 true, 아니면 false 리턴
			return isThisStudentSigned(username, cursNo);
		case 2:
		case 3:
			log.info("요청한 회원이 학생이 아닙니다.");
			break;
		default:
			log.info("요청한 회원의 회원코드가 유효하지 않습니다.");
			break;
		}

		return false;
	}

	/**
	 * 강의 시작 일자, 종료 일자를 구하는 메서드
	 * 
	 * @param cursNo
	 * @return
	 */
	public CourseDateDTO getCourseDateInfo(String cursNo) {
		return courseMapper.selectCourseDateInfo(cursNo);
	}

	/**
	 * 수강 테이블에서 해당 학생의 수강 상태를 조회해 수강 내역이 있는지 검증하는 메서드 수강 상태가 개강 전 취소거나 수강 내역이 없는 경우
	 * false 반환함
	 * 
	 * @param stuId
	 * @param cursNo
	 * @return boolean
	 */
	public boolean isThisStudentSigned(String stuId, String cursNo) {
		String status = courseMapper.selectOneStudentSigningStatus(stuId, cursNo);

		if (status.equals("SU88") || status == null) { // 수강신청 한적이 없거나 개강 전 취소한 경우
			return false;
		}
		return true;
	}

	/**
	 * 강의 아이디로 강의 정보 VO를 조회하는 메서드
	 * 
	 * @param cursNo
	 * @return CourseVO
	 */
	public CourseVO getClassInfo(String cursNo) {
		return courseMapper.selectOneCourse(cursNo);
	}

	/**
	 * 해당 강의에 수강신청 한 학생 리스트를 출력하는 메서드
	 * 
	 * @param cursNo
	 * @return
	 */
	public List<String> selectSignedStudentListByCourse(String cursNo) {
		return courseMapper.selectSignedStudentListByCourse(cursNo);
	}

	/**
	 * 해당 강의가 현재 진행중인 상태인지 검증하는 메서드
	 * 
	 * @param cursNo
	 * @return boolean
	 */
	public boolean isThisCourseOnGoing(String cursNo) {
		return true;

	}

	public List<CourseVO> getTeachersAssignedClass(String tcrId) {
		return courseMapper.selectTeachersAssignedCourse(tcrId);
	}

	/**
	 * 해당 강사, 학생의 진행중인 강의 검색
	 * 
	 * @param user
	 * @return
	 */
	public List<CourseVO> selectCourseInProgress(CustomUser user) {

		int memberCode = Integer.parseInt(user.getMember().getMemCmcd());

		switch (memberCode) {
		case 1:
			return courseMapper.selectStudentsCourseInProgress(user.getUsername());
		case 2:
			break;
		case 3:
			return courseMapper.selectTeachersCourseInProgress(user.getUsername());

		default:
			break;
		}

		return null;
		
	}

	/**
	 * 해당 강사의 종료된 강의 검색
	 * 
	 * @param tcrId
	 * @return
	 */
	public List<CourseVO> selectCourseCompleted(CustomUser user) {

		int memberCode = Integer.parseInt(user.getMember().getMemCmcd());

		switch (memberCode) {
		case 1:
			return courseMapper.selectStudentsCourseCompleted(user.getUsername());
		case 2:
			break;
		case 3:
			return courseMapper.selectTeachersCourseCompleted(user.getUsername());
		default:
			break;
		}

		return null;
		
	}
}
