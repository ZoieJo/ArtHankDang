package kr.or.arthakdang.studentlecture.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.mapper.StudentLectureMapper;
import kr.or.arthakdang.studentlecture.domain.StudentLectureVO;

@Service
public class StudentLectureServiceImpl implements StudentLectureService {

	@Autowired
	private StudentLectureMapper studentLectureMapper;
	
	@Override
	public List<StudentLectureVO> StudentLectureList(StudentLectureVO studentLectureVO) {
		return studentLectureMapper.StudentLectureList(studentLectureVO);
	}

	@Override
	public StudentLectureVO lectureInfo(StudentLectureVO studentLectureVO) {
		return studentLectureMapper.lectureInfo(studentLectureVO);
	}

	@Override
	public List<StudentLectureVO> searchLecture(StudentLectureVO studentLectureVO) {
		return studentLectureMapper.searchLecture(studentLectureVO);
	}
	
}
