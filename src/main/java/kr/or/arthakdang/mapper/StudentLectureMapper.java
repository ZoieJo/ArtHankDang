package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.studentlecture.domain.StudentLectureVO;

@Mapper
public interface StudentLectureMapper {
	public List<StudentLectureVO> StudentLectureList(StudentLectureVO studentLectureVO);
	public StudentLectureVO lectureInfo(StudentLectureVO studentLectureVO);
	public List<StudentLectureVO> searchLecture(StudentLectureVO studentLectureVO);
}
