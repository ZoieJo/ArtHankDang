package kr.or.arthakdang.lecturemanagement.service;

import java.util.List;

import kr.or.arthakdang.lecturemanagement.domain.LectureListPageCountVO;
import kr.or.arthakdang.lecturemanagement.domain.LectureStudentVO;
import kr.or.arthakdang.lecturemanagement.domain.LectureVO;

public interface LectureManagementService {
	public List<LectureVO> lectureList();
	public LectureVO choiceLecture(String cursNo);
	public List<LectureStudentVO> lectureStudentList(String cursNo);
	public List<LectureStudentVO> lectureSearchStudent(LectureStudentVO lectureStudentVO);
	public List<LectureVO> searchLecture(String cursNm);
	public List<LectureVO> lectureListPage(LectureListPageCountVO lectureListPageCountVO);
	public List<LectureVO> searchLectureListPage(LectureListPageCountVO lectureListPageCountVO);
	public int lectureCnt();
	public int searchLectureCnt(String cursNm);
}
