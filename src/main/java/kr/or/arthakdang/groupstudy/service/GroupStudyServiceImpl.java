package kr.or.arthakdang.groupstudy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.groupstudy.domain.GroupStudyMemInfoVO;
import kr.or.arthakdang.groupstudy.domain.GroupStudyVO;
import kr.or.arthakdang.groupstudy.domain.InteattchVO;
import kr.or.arthakdang.groupstudy.domain.SubjectVO;
import kr.or.arthakdang.mapper.GroupStudyMapper;

@Service
public class GroupStudyServiceImpl implements GroupStudyService {

	@Autowired
	private GroupStudyMapper groupStudyMapper;
		
	@Override
	public List<SubjectVO> subjectList() {
		return groupStudyMapper.subjectList();
	}

	@Override
	public int createGroupStudy(GroupStudyVO groupStudyVO) {
		return groupStudyMapper.createGroupStudy(groupStudyVO);
	}

	@Override
	public List<GroupStudyVO> groupStudyList() {
		return groupStudyMapper.groupStudyList();
	}

	@Override
	public List<GroupStudyVO> groupStudyAndAttchList() {
		return groupStudyMapper.groupStudyAndAttchList();
	}

	@Override
	public int joinGroupStudy(GroupStudyMemInfoVO groupStudyMemInfoVO) {
		return groupStudyMapper.joinGroupStudy(groupStudyMemInfoVO);
	}

	@Override
	public int groupStudyPlusOne(GroupStudyMemInfoVO groupStudyMemInfoVO) {
		return groupStudyMapper.groupStudyPlusOne(groupStudyMemInfoVO);
	}

	@Override
	public List<GroupStudyVO> includeGroupStudyList(String memId) {
		return groupStudyMapper.includeGroupStudyList(memId);
	}

	@Override
	public List<GroupStudyMemInfoVO> selectGroupStudyNo(String memId) {
		return groupStudyMapper.selectGroupStudyNo(memId);
	}

	@Override
	public int groupStudyMinusOne(GroupStudyVO groupStudyVO) {
		return groupStudyMapper.groupStudyMinusOne(groupStudyVO);
	}

	@Override
	public int outGroupStudy(GroupStudyVO groupStudyVO) {
		return groupStudyMapper.outGroupStudy(groupStudyVO);
	}

	@Override
	public int deleteAttchImage(GroupStudyVO groupStudyVO) {
		return groupStudyMapper.deleteAttchImage(groupStudyVO);
	}

	@Override
	public int uploadFile(InteattchVO inteattchVO) {
		return groupStudyMapper.uploadFile(inteattchVO);
	}

	@Override
	public List<InteattchVO> uploadFileList(InteattchVO inteattchVO) {
		return groupStudyMapper.uploadFileList(inteattchVO);
	}
}
