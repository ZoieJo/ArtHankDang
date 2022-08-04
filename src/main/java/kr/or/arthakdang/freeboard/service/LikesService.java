package kr.or.arthakdang.freeboard.service;

import kr.or.arthakdang.freeboard.domain.LikesVO;

public interface LikesService {
	
	public int selectCountLike(String bdNo);
	
	public int insertLike(LikesVO likesVO);
	
	public int checkLike(LikesVO likesVO);
	
	public int deleteLike(LikesVO likesVO);
	
	public int deleteLikes();
	
}
