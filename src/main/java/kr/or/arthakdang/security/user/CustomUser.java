package kr.or.arthakdang.security.user;



import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.userdetails.User;

import kr.or.arthakdang.domain.MemberDetailInfo;
import kr.or.arthakdang.domain.MemberVO;
import kr.or.arthakdang.studentmanagement.domain.StudentVO;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Getter
@Slf4j
public class CustomUser extends User {
	private static final long serialVersionUID = 1L;

	private MemberVO member;
	private MemberDetailInfo memberDetail;

	
	// 상속받은 부모 생성자 호출
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	// VO를 UserDetails로 만들어주는 생성자
	public CustomUser(MemberVO vo) {
		super(vo.getMemId(), vo.getMemPw(), vo.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthNm())).collect(Collectors.toList()));
//		List<SimpleGrantedAuthority> ckList =  vo.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthNm())).collect(Collectors.toList());
//		
//		log.info("stream result : " + ckList);
		this.member = vo;	
		// 회원 정보(VO)의 아이디, 비밀번호, 소유 권한들(SimpleGrantedAuthority의 컬렉션으로 변환)을 매개변수로 받고 멤버VO를 갖도록 함
	}
	
	// 세부적인 회원정보 VO를 붙여주는 생성자
	public CustomUser(MemberVO vo, MemberDetailInfo detailVO) {
		super(vo.getMemId(), vo.getMemPw(), vo.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthNm())).collect(Collectors.toList()));
		
//		List<SimpleGrantedAuthority> ckList =  vo.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthNm())).collect(Collectors.toList());
//		log.info("stream result : " + ckList);
	
		this.member = vo;
		this.memberDetail = detailVO;
		
	}
}