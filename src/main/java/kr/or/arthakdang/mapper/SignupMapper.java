package kr.or.arthakdang.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.domain.CourseVO;
import kr.or.arthakdang.signup.domain.CartVO;
import kr.or.arthakdang.signup.domain.CourseDetailVO;
import kr.or.arthakdang.signup.domain.CursPageCondDTO;
import kr.or.arthakdang.signup.domain.OrderDetailVO;
import kr.or.arthakdang.signup.domain.OrderVO;
import kr.or.arthakdang.signup.domain.PaymentVO;

@Mapper
public interface SignupMapper {

	/**
	 * 모든 강의 정보를 리스트로 불러오는 메소드
	 */
	public List<CourseVO> getCourseList();
	
	/**
	 * 페이지별 강의 정보를 리스트로 불러오는 메소드
	 */
	public List<CourseDetailVO> getCourseListPage(CursPageCondDTO cursPageCondDTO);
	
	/**
	 * 전체 강의 수를 구하는 메소드
	 */
	public int countCourseList(CursPageCondDTO cursPageCondDTO);
	
	/**
	 * 해당하는 강의 번호에 대한 상세정보를 가져오는 메소드
	 * @param cursNo 강의번호
	 * @return
	 */
	public List<CourseDetailVO> getCourseDetail(String cursNo);
	
	/**
	 * 장바구니에 강의를 추가해주는 메소드
	 * @param cartVO 강의 정보가 들어있는 cartVO
	 * @return
	 */
	public int insertCart(CartVO cartVO);
	
	/**
	 * 학생의 아이디와 강의 번호를 이용하여 학생이 해당 강의를 장바구니에 담았는지 확인하는 메소드
	 * @param cartVO
	 * @return
	 */
	public int checkCart(CartVO cartVO);
	
	/**
	 * 로그인한 학생이 장바구니에 담은 강의에 대한 번호를 리스트로 반환하는 메소드
	 * @param memId 로그인한 학생의 아이디
	 * @return
	 */
	public List<String> showCartCursNo(String memId);
	
	/**
	 * 장바구니 목록을 페이징처리하여 보여주는 메소드
	 * @param cursPageCondDTO
	 * @return
	 */
	public List<CourseDetailVO> showCartCursList(CursPageCondDTO cursPageCondDTO);
	
	/**
	 * 장바구니에서 강의를 삭제하는 메서드
	 * @param cartNo
	 * @return
	 */
	public int deleteCursCart(String cartNo);
	
	/**
	 * 장바구니 및 강의목록에서 수강/결제를 클릭할시 결제화면으로 넘어가는 강의 정보를 출력하는 메소드
	 * @param cursNo	강의 번호가 담겨 있는 리스트
	 * @return
	 */
	public List<CourseDetailVO> getOrderInfo(List<String> cursNo);
	
	/**
	 * 주문 테이블에 주문정보를 저장하는 메소드
	 * @param orderVO 저장할 주문정보
	 * @return
	 */
	public int insertOrder(OrderVO orderVO);
	
	/**
	 * 수강주문상세 테이블에 상세 정보를 저장하는 메소드
	 * @param odv 수강주문상세 정보를 담은 리스트
	 * @return
	 */
	public int insertOrderDetail(List<OrderDetailVO> odv);
	
	/**
	 * 주문번호를 가져오는 메소드
	 * @param memId
	 * @return
	 */
	public String getOrderNo(String memId);
	
	/**
	 * 주문 테이블에서 해당 주문번호에 대한 정보를 삭제하는 메소드
	 * @param ordNo 삭제하려는 주문번호
	 * @return
	 */
	public int deleteOrder(String ordNo);
	
	/**
	 * 수강주문상세 테이블에서 해당 주문번호에 대한 정보를 삭제하는 메소드
	 * @param ordNo 삭제하려는 주문번호
	 * @return
	 */
	public int deleteOrderDetail(String ordNo);
	
	/**
	 * 강의 결제 정보를 저장하는 메소드
	 * @param paymentVO	결제 정보를 담는 객체
	 * @return
	 */
	public int insertPaymentInfo(PaymentVO paymentVO);
	
	/**
	 * 주문 정보와 주문에 대한 상세정보를 불러오는 메소드
	 * @param ordNo	정보를 가져올 주문번호
	 * @return
	 */
	public OrderVO selectOrderInfo(String ordNo);
	
	/**
	 * 수강신청 후 수강테이블에 수강 테이블에 데이터 추가
	 * @param orderVO 수강 정보를 담는 객체
	 * @return
	 */
	public int insertSu(OrderVO orderVO);
	
	/**
	 * 수강 신청 후 장바구니에 들어있는 항목 처리
	 * @param orderVO
	 * @return
	 */
	public int afterOrderCart(OrderVO orderVO);
	
	/**
	 * 결제 완료 시 결제완료화면에서 보여주는 정보의 데이터를 가져오는 메소드
	 * @param map 학생아이디와 주문번호가 담겨있는 map
	 * @return
	 */
	public PaymentVO selectCompInfo(Map<String, String> map);
	
	/**
	 * 결제 내역 정보를 가져오는 메소드
	 * @param stuId 결제 내역을 보려는 학생의 아이디
	 * @return
	 */
	public List<PaymentVO> studentPaymentHistory(String stuId);
	
	/**
	 * 직원을 위한 결제 내역 정보 조회
	 * @return
	 */
	public List<PaymentVO> empPaymentHistory();
}
