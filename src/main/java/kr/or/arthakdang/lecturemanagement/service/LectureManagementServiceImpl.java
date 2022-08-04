package kr.or.arthakdang.lecturemanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.lecturemanagement.domain.LectureListPageCountVO;
import kr.or.arthakdang.lecturemanagement.domain.LectureStudentVO;
import kr.or.arthakdang.lecturemanagement.domain.LectureVO;
import kr.or.arthakdang.mapper.LectureManagementMapper;

@Service
public class LectureManagementServiceImpl implements LectureManagementService {

	@Autowired
	private LectureManagementMapper lectureManagementMapper;

	@Override
	public List<LectureVO> lectureList() {
		return lectureManagementMapper.lectureList();
	}

	@Override
	public LectureVO choiceLecture(String cursNo) {
		return lectureManagementMapper.choiceLecture(cursNo);
	}

	@Override
	public List<LectureStudentVO> lectureStudentList(String cursNo) {
		return lectureManagementMapper.lectureStudentList(cursNo);
	}

	@Override
	public List<LectureStudentVO> lectureSearchStudent(LectureStudentVO lectureStudentVO) {
		return lectureManagementMapper.lectureSearchStudent(lectureStudentVO);
	}

	@Override
	public List<LectureVO> searchLecture(String cursNm) {
		return lectureManagementMapper.searchLecture(cursNm);
	}

	@Override
	public List<LectureVO> lectureListPage(LectureListPageCountVO lectureListPageCountVO) {
		return lectureManagementMapper.lectureListPage(lectureListPageCountVO);
	}

	@Override
	public int lectureCnt() {
		return lectureManagementMapper.lectureCnt();
	}

	@Override
	public int searchLectureCnt(String cursNm) {
		return lectureManagementMapper.searchLectureCnt(cursNm);
	}

	@Override
	public List<LectureVO> searchLectureListPage(LectureListPageCountVO lectureListPageCountVO) {
		return lectureManagementMapper.searchLectureListPage(lectureListPageCountVO);
	}
	
}
