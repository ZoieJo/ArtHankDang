package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.mylecture.domain.MyLectureStudentVO;
import kr.or.arthakdang.mylecture.domain.MyLectureVO;


@Mapper
public interface MyLectureMapper {
	public List<MyLectureVO> myLectureList(String tcrId);
	public int lectureStuCnt(MyLectureVO myLectureVO);
	public int MyLectureScrAvg(MyLectureVO myLectureVO);
	public List<MyLectureVO> searchMyLecture(MyLectureVO myLectureVO);
	public List<MyLectureVO> MyLectureReview(MyLectureVO myLectureVO);
	public MyLectureVO myLectureInfo(MyLectureVO myLectureVO);
	public List<MyLectureStudentVO> myLectureStudent(MyLectureVO myLectureVO);
	public List<MyLectureStudentVO> myLectureSearchStudent(MyLectureVO myLectureVO);
}
