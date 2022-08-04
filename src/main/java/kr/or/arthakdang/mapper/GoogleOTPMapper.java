package kr.or.arthakdang.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.googleotp.domain.GoogleOTPVO;

@Mapper
public interface GoogleOTPMapper {
	public int insertKey(GoogleOTPVO vo);
	public String selectKey(String userId);
	public int checkKey(String userId);
}
