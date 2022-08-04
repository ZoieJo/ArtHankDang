package kr.or.arthakdang.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.login.domain.FindAccountDTO;

@Mapper
public interface FindAccountMapper {
	
	public String FindAccountByIdPh(FindAccountDTO dto);
	public String FindIdByPh(FindAccountDTO dto);


}
