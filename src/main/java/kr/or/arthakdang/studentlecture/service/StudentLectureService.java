package kr.or.arthakdang.studentlecture.service;

import java.util.List;

import kr.or.arthakdang.studentlecture.domain.StudentLectureVO;

public interface StudentLectureService {
	
	public List<StudentLectureVO> StudentLectureList(StudentLectureVO studentLectureVO);
	public StudentLectureVO lectureInfo(StudentLectureVO studentLectureVO);
	public List<StudentLectureVO> searchLecture(StudentLectureVO studentLectureVO);
	
}
