package kr.or.arthakdang.lecturemanagement.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchLecturePageVO {
	
private PageVO pageVO;
private List<LectureVO> lectureList;
}
