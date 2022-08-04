package kr.or.arthakdang.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.approval.domain.AprldocVO;
import kr.or.arthakdang.approval.domain.AprllnVO;
import kr.or.arthakdang.approval.domain.UsdeaprllnVO;
import kr.or.arthakdang.domain.CourseVO;
import kr.or.arthakdang.domain.CurspnVO;
import kr.or.arthakdang.employeemanagement.domain.EmployeeVO;

/**
 * 전자결재 Mapper
 */
@Mapper
public interface ApprovalMapper {
	
	/**
	 * 결재 라인을 등록하기 위한 직원 정보를 리스트로 가져옴
	 * @return
	 */
	public List<EmployeeVO> empList(String emp_id);
	
	/**
	 * 사용자 정의 결재라인을 등록하기 위한 메소드
	 * @param vo 사용자 정의 결재라인 정보가 들어있는 vo(사용자 아이디, 결재라인 제목)
	 * @return
	 */
	public int insertUsdeaprlln(UsdeaprllnVO vo);
	
	/**
	 * 사용자 정의 결재 라인 상세 정보를 입력하기 위한 메소드
	 * @param map 현재 로그인한 직원이 아이디와 직원이 입력하려고 하는 결재라인 정보를 담는 map
	 * @return
	 */
	public int insertUsdeaprllndtl(Map<String, Object> map);
	
	/**
	 * 결재라인 등록시 참조자가 있을 경우 참조자 정보를 등록하기 위한 메소드
	 * @param map 참조자의 정보가 담겨있는 map
	 * @return
	 */
	public int insertUsdeaprlrefln(Map<String, Object> map);
	
	/**
	 * 해당하는 사용자 정의 결재라인 번호에 해당하는 결재라인 정보를 가져오는 메소드
	 * @param vo 사용자 정의 결재 라인 번호와 로그인한 회원에 대한 정보가 들어있는 vo
	 * @return
	 */
	public UsdeaprllnVO getAprlln(UsdeaprllnVO vo);
	
	/**
	 * 로그인한 회원이 등록한 결재라인 번호를 불러오는 메소드
	 * @param memId 로그인한 회원의 ID
	 * @return
	 */
	public List<UsdeaprllnVO> getAprllnNo(String memId);
	
	/**
	 * 결재라인을 삭제하는 메소드
	 * @param usdeaprllnNo
	 * @return
	 */
	public int deleteAprlln(String usdeaprllnNo);
	
	/**
	 * 결재라인 상세에서 해당하는 번호에 대한 결재순서를 지우는 메소드
	 * @param usdeaprllnNo
	 * @return
	 */
	public int deleteAprllndtl(String usdeaprllnNo);
	
	/**
	 * 참조에서 해당하는 번호에 대한 참조자를 삭제하는 메소드
	 * @param usdeaprllnNo
	 * @return
	 */
	public int deleteAprlrefln(String usdeaprllnNo);
	
	/**
	 * 로그인한 직원의 정보를 가져오는 메소드(부서 포함)
	 * @param empId
	 * @return
	 */
	public EmployeeVO userInfo(String empId);
	
	/**
	 * 해당 아이디를 가진 직원의 직급을 가져오는 메소드
	 * @param empId
	 * @return
	 */
	public String getEmpPosition(String empId);
	
	/**
	 * 결재 문서를 임시저장하는 메소드
	 * @param aprldocVO
	 * @return
	 */
	public int saveAprlTemp(AprldocVO aprldocVO);
	
	/**
	 * 결재문서 임시저장시 결재번호가 있을경우 저장되어 있는 문서의 정보를 수정하는 메소드
	 * @param aprldocVO
	 * @return
	 */
	public int updateAprlTemp(AprldocVO aprldocVO);
	
	/**
	 * 임시저장한 결재문서 리스트
	 * @param memId
	 * @return
	 */
	public List<AprldocVO> tempAprldocList(String memId);
	
	/**
	 * 문서번호와 일치하는 문서의 상세정보를 가져오는 메소드
	 * @param aprldocNo
	 * @return
	 */
	public AprldocVO aprldocInfo(String aprldocNo);
	
	/**
	 * 강의 계획 정보을 가져오는 메소드
	 * @return
	 */
	public List<CurspnVO> getCurspnList();
	
	/**
	 * 전자결재 문서를 테이블에 insert 하는 메소드
	 * @param vo
	 * @return
	 */
	public int insertAprldoc(AprldocVO vo);
	
	/**
	 * 전자결재 라인 정보 insert
	 * @param vo
	 * @return
	 */
	public int insertAprlln(AprllnVO vo);
	
	public List<AprldocVO> getSendboxList(String memId);
	
	
}
