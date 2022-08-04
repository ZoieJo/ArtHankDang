package kr.or.arthakdang.mylecture.service;

import java.util.List;

import kr.or.arthakdang.mylecture.domain.MyLectureStudentVO;
import kr.or.arthakdang.mylecture.domain.MyLectureVO;

public interface MyLectureService {

	public List<MyLectureVO> myLectureList(String tcrId);
	public int lectureStuCnt(MyLectureVO myLectureVO);
	public int MyLectureScrAvg(MyLectureVO myLectureVO);
	public List<MyLectureVO> searchMyLecture(MyLectureVO myLectureVO);
	public List<MyLectureVO> MyLectureReview(MyLectureVO myLectureVO);
	public MyLectureVO myLectureInfo(MyLectureVO myLectureVO);
	public List<MyLectureStudentVO> myLectureStudent(MyLectureVO myLectureVO);
	public List<MyLectureStudentVO> myLectureSearchStudent(MyLectureVO myLectureVO);
}
