package kr.or.arthakdang.signup.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.domain.CourseVO;
import kr.or.arthakdang.mapper.SignupMapper;
import kr.or.arthakdang.signup.domain.CartVO;
import kr.or.arthakdang.signup.domain.CourseDetailVO;
import kr.or.arthakdang.signup.domain.CursPageCondDTO;
import kr.or.arthakdang.signup.domain.OrderDetailVO;
import kr.or.arthakdang.signup.domain.OrderVO;
import kr.or.arthakdang.signup.domain.PaymentVO;

@Service
public class SignupServiceImpl implements SignupService{

	@Autowired
	private SignupMapper mapper;
	
	@Override
	public List<CourseVO> getCourseList() {
		
		return mapper.getCourseList();
	}

	@Override
	public List<CourseDetailVO> getCourseListPage(CursPageCondDTO cursPageCondDTO) {
		return mapper.getCourseListPage(cursPageCondDTO);
	}

	@Override
	public int countCourseList(CursPageCondDTO cursPageCondDTO) {
		return mapper.countCourseList(cursPageCondDTO);
	}

	@Override
	public List<CourseDetailVO> getCourseDetail(String cursNo) {
		return mapper.getCourseDetail(cursNo);
	}

	@Override
	public int insertCart(CartVO cartVO) {
		return mapper.insertCart(cartVO);
	}

	@Override
	public int checkCart(CartVO cartVO) {
		return mapper.checkCart(cartVO);
	}

	@Override
	public List<String> showCartCursNo(String memId) {
		return mapper.showCartCursNo(memId);
	}

	@Override
	public List<CourseDetailVO> showCartCursList(CursPageCondDTO cursPageCondDTO) {
		return mapper.showCartCursList(cursPageCondDTO);
	}

	@Override
	public int deleteCursCart(String cartNo) {
		return mapper.deleteCursCart(cartNo);
	}

	@Override
	public List<CourseDetailVO> getOrderInfo(List<String> cursNo) {
		return mapper.getOrderInfo(cursNo);
	}

	@Override
	public int insertOrder(OrderVO orderVO) {
		return mapper.insertOrder(orderVO);
	}

	@Override
	public int insertOrderDetail(List<OrderDetailVO> odv) {
		return mapper.insertOrderDetail(odv);
	}

	@Override
	public String getOrderNo(String memId) {
		return mapper.getOrderNo(memId);
	}

	@Override
	public int deleteOrder(String ordNo) {
		return mapper.deleteOrder(ordNo);
	}

	@Override
	public int deleteOrderDetail(String ordNo) {
		return mapper.deleteOrderDetail(ordNo);
	}

	@Override
	public int insertPaymentInfo(PaymentVO paymentVO) {
		return mapper.insertPaymentInfo(paymentVO);
	}

	@Override
	public OrderVO selectOrderInfo(String ordNo) {
		return mapper.selectOrderInfo(ordNo);
	}

	@Override
	public int insertSu(OrderVO orderVO) {
		return mapper.insertSu(orderVO);
	}

	@Override
	public int afterOrderCart(OrderVO orderVO) {
		return mapper.afterOrderCart(orderVO);
	}

	@Override
	public PaymentVO selectCompInfo(Map<String, String> map) {
		return mapper.selectCompInfo(map);
	}

	@Override
	public List<PaymentVO> studentPaymentHistory(String stuId) {
		return mapper.studentPaymentHistory(stuId);
	}

	@Override
	public List<PaymentVO> empPaymentHistory() {
		return mapper.empPaymentHistory();
	}

	
}
