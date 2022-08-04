package kr.or.arthakdang.groupstudy.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GroupStudyMemInfoVO {
	private String memId; // 회원 아이디
	private String gpstyNo; // 참여한 스터디 넘버
	private Date jnDt; // 참여일
}
