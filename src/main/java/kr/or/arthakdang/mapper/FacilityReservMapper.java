package kr.or.arthakdang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.arthakdang.facilityreserv.domain.FacilityReservVO;
import kr.or.arthakdang.facilityreserv.domain.TimeVO;

@Mapper
public interface FacilityReservMapper {
	//전체 강의실 예약 리스트 
	public List<FacilityReservVO> facilityReservList(String facirsvDt); 
	//예약 신청
	public int insertFacReserv(FacilityReservVO facilityReservVO);
	//예약 변경
	public int updateFacReserv(FacilityReservVO facilityReservVO);
	//예약 취소 = delete
	public int deleteFacReserv(FacilityReservVO facilityReservVO);
	// 하나의 예약만 가져오기
	public int onePickFacList(String memId);
	//시간
	public List<TimeVO> timeList(TimeVO timevo);
	//전체 강의실 예약 리스트 2
	public List<FacilityReservVO> facilityReservList2(FacilityReservVO facilityReservVO); 
	
}
