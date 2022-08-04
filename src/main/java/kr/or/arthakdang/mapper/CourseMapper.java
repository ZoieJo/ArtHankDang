package kr.or.arthakdang.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.arthakdang.attendance.domain.CourseDateDTO;
import kr.or.arthakdang.domain.CourseTimeDetailVO;
import kr.or.arthakdang.domain.CourseVO;

@Mapper
public interface CourseMapper {
	
	public CourseVO selectOneCourse(String cursNo);
	public List<CourseTimeDetailVO> selectOneCourseTimeDetails(String cursNo);
	public CourseTimeDetailVO selectOneCourseTimeDetailByDay(CourseTimeDetailVO courseTimeDetailVO);
	
	/**
	 * 특정 강의 수강 중인 학생 목록을 출력하는 메서드
	 * @param cursNo
	 * @return
	 */
	public ArrayList<String> selectSignedStudentListByCourse(String cursNo);
	
	/**
	 * 특정 학생의 특정 강의 수강 상태를 조회하는 메서드
	 * @param stuId
	 * @param cursNo
	 * @return
	 */
	public String selectOneStudentSigningStatus(@Param("stuId") String stuId, @Param("cursNo") String cursNo);

	/**
	 * 특정 강의의 담당 교원 아이디를 조회하는 메서드
	 * @param cursNo
	 * @return
	 */
	public String selectCourseAssignedTeacher(String cursNo);

	public CourseDateDTO selectCourseDateInfo(String cursNo);
	
	public List<CourseVO> selectTeachersAssignedCourse(String tcrId);

	public List<CourseVO> selectTeachersCourseInProgress(String tcrId);
	public List<CourseVO> selectTeachersCourseCompleted(String tcrId);
	public List<CourseVO> selectStudentsCourseInProgress(String stuId);
	public List<CourseVO> selectStudentsCourseCompleted(String stuId);

	//public List<CourseVO> selectAllCourseInProgress();
	//public List<CourseVO> selectAllCourseInProgress();
	
}
