package kr.or.arthakdang.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.freeboard.domain.LikesVO;


@Mapper
public interface LikesMapper {

	public int selectCountLike(String bdNo);
	
	public int insertLike(LikesVO likesVO);
	
	public int checkLike(LikesVO likesVO);
	
	public int deleteLike(LikesVO likesVO);

	public int deleteLikes();
}
