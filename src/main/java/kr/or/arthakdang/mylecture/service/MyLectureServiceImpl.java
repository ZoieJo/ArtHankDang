package kr.or.arthakdang.mylecture.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.mapper.MyLectureMapper;
import kr.or.arthakdang.mylecture.domain.MyLectureStudentVO;
import kr.or.arthakdang.mylecture.domain.MyLectureVO;

@Service
public class MyLectureServiceImpl implements MyLectureService {
	
	@Autowired
	private MyLectureMapper myLectureMapper;

	@Override
	public List<MyLectureVO> myLectureList(String tcrId) {
		return myLectureMapper.myLectureList(tcrId);
	}

	@Override
	public int lectureStuCnt(MyLectureVO myLectureVO) {
		return myLectureMapper.lectureStuCnt(myLectureVO);
	}

	@Override
	public List<MyLectureVO> searchMyLecture(MyLectureVO myLectureVO) {
		return myLectureMapper.searchMyLecture(myLectureVO);
	}

	@Override
	public int MyLectureScrAvg(MyLectureVO myLectureVO) {
		return myLectureMapper.MyLectureScrAvg(myLectureVO);
	}

	@Override
	public List<MyLectureVO> MyLectureReview(MyLectureVO myLectureVO) {
		return myLectureMapper.MyLectureReview(myLectureVO);
	}

	@Override
	public MyLectureVO myLectureInfo(MyLectureVO myLectureVO) {
		return myLectureMapper.myLectureInfo(myLectureVO);
	}

	@Override
	public List<MyLectureStudentVO> myLectureStudent(MyLectureVO myLectureVO) {
		return myLectureMapper.myLectureStudent(myLectureVO);
	}

	@Override
	public List<MyLectureStudentVO> myLectureSearchStudent(MyLectureVO myLectureVO) {
		return myLectureMapper.myLectureSearchStudent(myLectureVO);
	}


}
