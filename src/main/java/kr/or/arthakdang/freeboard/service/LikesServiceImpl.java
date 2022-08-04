package kr.or.arthakdang.freeboard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.freeboard.domain.LikesVO;
import kr.or.arthakdang.mapper.LikesMapper;

@Service
public class LikesServiceImpl implements LikesService  {
	
	@Autowired
	LikesMapper likesMapper;
	
	@Override
	public int selectCountLike(String bdNo) {
		
		return likesMapper.selectCountLike(bdNo);
	}

	@Override
	public int insertLike(LikesVO likesVO) {
		return likesMapper.insertLike(likesVO);
	}

	@Override
	public int checkLike(LikesVO likesVO) {
		return likesMapper.checkLike(likesVO);
	}

	@Override
	public int deleteLike(LikesVO likesVO) {
		return likesMapper.deleteLike(likesVO);
	}
	
	@Override
	public int deleteLikes() {
		return likesMapper.deleteLikes();
	}

}
