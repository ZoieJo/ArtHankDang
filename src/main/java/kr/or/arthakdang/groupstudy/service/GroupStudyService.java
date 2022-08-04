package kr.or.arthakdang.groupstudy.service;

import java.util.List;

import kr.or.arthakdang.groupstudy.domain.GroupStudyMemInfoVO;
import kr.or.arthakdang.groupstudy.domain.GroupStudyVO;
import kr.or.arthakdang.groupstudy.domain.InteattchVO;
import kr.or.arthakdang.groupstudy.domain.SubjectVO;

public interface GroupStudyService {

	public List<SubjectVO> subjectList();
	public int createGroupStudy(GroupStudyVO groupStudyVO);
	public List<GroupStudyVO> groupStudyList();
	public List<GroupStudyVO> groupStudyAndAttchList();
	public int joinGroupStudy(GroupStudyMemInfoVO groupStudyMemInfoVO);
	public int groupStudyPlusOne(GroupStudyMemInfoVO groupStudyMemInfoVO);
	public List<GroupStudyVO> includeGroupStudyList(String memId);
	public List<GroupStudyMemInfoVO> selectGroupStudyNo(String memId);
	public int groupStudyMinusOne(GroupStudyVO groupStudyVO);
	public int outGroupStudy(GroupStudyVO groupStudyVO);
	public int deleteAttchImage(GroupStudyVO groupStudyVO);
	public int uploadFile(InteattchVO inteattchVO);
	public List<InteattchVO> uploadFileList(InteattchVO inteattchVO);
}
