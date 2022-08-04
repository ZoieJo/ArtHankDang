package kr.or.arthakdang.groupstudy.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GroupStudyVO {
	private String gpstyNo; // 그룹스터디 번호
	private String dbCmcd; // 게시글 공통 코드
	private String memId; // 아이디
	private String gpstyNm; // 그룹스터디이름
	private int gpstyJnNum; // 가입자수
	private String gpstyHtNm; // 해시태그
	private Date gpstyCreDt; // 생성일
	private String gpstyAttchNo; // 첨부파일번호
	private InteattchVO inteattchVO; // 첨부파일
	private List<GroupStudyMemInfoVO> groupStudyMemInfoVO; // 참여인원정보
}
