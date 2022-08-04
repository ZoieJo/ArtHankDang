package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.groupstudy.domain.GroupStudyMemInfoVO;
import kr.or.arthakdang.groupstudy.domain.GroupStudyVO;
import kr.or.arthakdang.groupstudy.domain.InteattchVO;
import kr.or.arthakdang.groupstudy.domain.SubjectVO;

@Mapper
public interface GroupStudyMapper {

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
